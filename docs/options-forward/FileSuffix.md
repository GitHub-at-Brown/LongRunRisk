# FileSuffix Option

**Location in config:** `config["Build"]["FileSuffix"]`
**Default value:** `""`
**Legacy mapping:** `"FileSuffix" -> {"Build", "FileSuffix"}` in OptionsConfig.wl:181

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   ├─ Filters OUT FileSuffix from user options (line 1189)
   └─ Generates: "FileSuffix" -> "_" <> modelName  (line 1197)

CONFIGURATION LAYER
│
└─ splitConfig[config, "Build"]  ◄── EXTRACTS "FileSuffix"
   │
   └─ "FileSuffix" -> config["Build"]["FileSuffix"]

BUILD ORCHESTRATION
│
└─ buildModelsInternal[config_Association]
   │
   ├─ fileSuffix = config["Build"]["FileSuffix"]  (line 837)
   │
   ├─ modelsFileCheckpoint = FileNameJoin[{
   │    resourcesDir, "Models" <> fileSuffix <> ".wl"
   │  }]  ◄── TERMINAL CONSUMER #1 (line 860)
   │
   ├─ saveModels[..., modelsFileCheckpoint]  (lines 979, 1054, 1125)
   │
   └─ If[TrueQ[updateManifest] && fileSuffix === "",
        updateModelManifest[]
      ]  ◄── TERMINAL CONSUMER #2 (line 1129)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 151 | Default: `"FileSuffix" -> ""` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 368-377 | `splitConfig[config, "Build"]` definition |
| Line 375 | Extracts: `"FileSuffix" -> config["Build"]["FileSuffix"]` |

## Entry Points

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration: `"FileSuffix" -> ""` |
| Lines 821-826 | Entry patterns (config or legacy options) |

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Does NOT declare FileSuffix (not user-accessible) |
| Lines 1188-1189 | Explicitly filters OUT FileSuffix from user options |
| Line 1197 | Auto-generates: `"FileSuffix" -> "_" <> m` for each model |
| Lines 1244-1252 | Deletes temporary checkpoint files after merge |

**Filter pattern:**
```wolfram
filteredOpts = FilterRules[{opts},
  Except["FileSuffix" | "UpdateManifest" | "CreateMoments" | "FromScratch" | "Models"]]
```

## Terminal Consumers

### Terminal Consumer #1: Checkpoint File Path in `buildModelsInternal`

| Location | What happens |
|----------|--------------|
| Line 837 | `fileSuffix = config["Build"]["FileSuffix"]` |
| Line 860 | Creates checkpoint file path |

**Checkpoint file path:**
```wolfram
modelsFileCheckpoint = FileNameJoin[{resourcesDir, "Models" <> fileSuffix <> ".wl"}]
```

| fileSuffix Value | Resulting File |
|------------------|----------------|
| `""` (empty) | `Resources/Models.wl` (canonical) |
| `"_BY"` | `Resources/Models_BY.wl` (checkpoint) |
| `"_NRC"` | `Resources/Models_NRC.wl` (checkpoint) |

**Checkpoint saves:**
- Line 979: After symbolic phase
- Line 1054: After compile phase
- Line 1125: After numerical phase

### Terminal Consumer #2: Manifest Update Gate in `buildModelsInternal`

| Location | What happens |
|----------|--------------|
| Line 1129 | Conditional manifest update |

**Gate logic:**
```wolfram
If[TrueQ[updateManifest] && fileSuffix === "", updateModelManifest[]]
```

Only updates manifest when:
1. `updateManifest` is True, AND
2. `fileSuffix` is empty (canonical file, not checkpoint)

## Helper Function

### `resolveCompiledMxFile` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 699-708 | Resolves compiled .mx file paths |

**Note:** This function accepts an optional `fileSuffix` parameter but is NOT connected to the Build option. It's used for jacobian files with suffix `"_jacobians"`.

## Parallel Build Strategy

```
buildModelsParallel
│
├─ Filter out user's FileSuffix option
│
├─ For each model in parallel:
│  └─ buildModels[..., "FileSuffix" -> "_" <> modelName, ...]
│     └─ Writes: Models_BY.wl, Models_NRC.wl, etc.
│
├─ Merge all checkpoint files into Models.wl
│
└─ Delete temporary checkpoint files (lines 1244-1252)
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 151 | Default "" |
| Config | `splitConfig` | OptionsConfig.wl | 368-377 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 568-578, 821-826 | Public API |
| Entry | `buildModelsParallel` | ManageResources.wl | 1145, 1188-1189, 1197 | Parallel orchestrator |
| **Consumer** | `buildModelsInternal` | ManageResources.wl | 860 | **Checkpoint file path** |
| **Consumer** | `buildModelsInternal` | ManageResources.wl | 1129 | **Manifest update gate** |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Build phase - checkpoint file naming |
| Default | `""` (empty string) |
| When empty | Writes to canonical `Models.wl`, allows manifest update |
| When non-empty | Writes to `Models_{suffix}.wl`, blocks manifest update |
| User control | Filtered out in buildModelsParallel (auto-generated) |
| Purpose | Enables parallel builds with separate checkpoint files |
| Cleanup | Parallel orchestrator deletes temporary checkpoint files |
| Consumer count | Two terminal consumers |
