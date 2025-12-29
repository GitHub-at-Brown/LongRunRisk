# UpdateManifest Option

**Location in config:** `config["Build"]["UpdateManifest"]`
**Default value:** `True`
**Legacy mapping:** `"UpdateManifest" -> {"Build", "UpdateManifest"}` in OptionsConfig.wl:182

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   ├─ Filters OUT UpdateManifest from user options (line 1189)
   ├─ Forces "UpdateManifest" -> False in parallel workers (line 1198)
   └─ Unconditionally calls updateModelManifest[] after merge (line 1239)

CONFIGURATION LAYER
│
└─ splitConfig[config, "Build"]  ◄── EXTRACTS "UpdateManifest"
   │
   └─ "UpdateManifest" -> config["Build"]["UpdateManifest"]

BUILD ORCHESTRATION
│
└─ buildModelsInternal[config_Association]
   │
   ├─ updateManifest = config["Build"]["UpdateManifest"]  (line 838)
   │
   └─ If[TrueQ[updateManifest] && fileSuffix === "",
        updateModelManifest[]
      ]  ◄── TERMINAL CONSUMER (line 1129)
         │
         └─ updateModelManifest[]  (lines 184-216)
            │
            ├─ getCatalogModels[]
            ├─ getCanonicalHash[catalogModels]
            ├─ getVersion[root]
            └─ Put[manifestData, manifestFile]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 152 | Default: `"UpdateManifest" -> True` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 368-377 | `splitConfig[config, "Build"]` definition |
| Line 376 | Extracts: `"UpdateManifest" -> config["Build"]["UpdateManifest"]` |

## Entry Points

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration: `"UpdateManifest" -> True` |
| Lines 821-826 | Entry patterns (config or legacy options) |

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Does NOT declare UpdateManifest |
| Lines 1188-1189 | Filters OUT UpdateManifest from user options |
| Line 1198 | Forces `"UpdateManifest" -> False` for parallel workers |
| Line 1239 | Unconditionally calls `updateModelManifest[]` after merge |

**Filter pattern:**
```wolfram
filteredOpts = FilterRules[{opts},
  Except["FileSuffix" | "UpdateManifest" | "CreateMoments" | "FromScratch" | "Models"]]
```

## Terminal Consumer

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 838 | `updateManifest = config["Build"]["UpdateManifest"]` |
| Line 1129 | Conditional manifest update |

**Manifest update gate:**
```wolfram
If[TrueQ[updateManifest] && fileSuffix === "", updateModelManifest[]]
```

Two conditions must be met:
1. `updateManifest` is True (user setting)
2. `fileSuffix === ""` (canonical file, not checkpoint)

## Helper Function

### `updateModelManifest` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 184-216 | Manifest generation |

**Implementation:**
```wolfram
updateModelManifest[] := Module[
  {root, manifestFile, catalogModels, catalogHash, modelHashes, version, manifestData},

  root = findPacletRoot[];
  manifestFile = FileNameJoin[{root, "Resources", "ModelManifest.wl"}];
  catalogModels = getCatalogModels[];
  catalogHash = getCanonicalHash[catalogModels];
  modelHashes = Map[getCanonicalHash, catalogModels];
  version = getVersion[root];

  manifestData = <|
    "PacletVersion" -> version,
    "CatalogHash" -> catalogHash,
    "Models" -> modelHashes,
    "Date" -> DateString["ISODateTime"]
  |>;

  Put[manifestData, manifestFile];
  manifestData
]
```

**Output file:** `Resources/ModelManifest.wl`

## Parallel Build Strategy

| Phase | UpdateManifest Behavior |
|-------|-------------------------|
| Parallel workers | Forced to False (line 1198) |
| After merge | Unconditionally True (line 1239) |

```
buildModelsParallel
│
├─ Filter out user's UpdateManifest option
│
├─ For each model in parallel:
│  └─ buildModels[..., "UpdateManifest" -> False, ...]
│     └─ Does NOT call updateModelManifest[]
│
├─ Merge results
│
└─ updateModelManifest[]  ← ALWAYS CALLED (unconditional)
```

**Key insight:** In parallel builds, the option is ignored and manifest is ALWAYS updated once after all models merge.

## NOT Forwarded

UpdateManifest is NOT forwarded to any downstream functions:
- Not passed to `processModels` (Phase 1)
- Not passed to `createCompiledEq` (Phase 2)
- Not passed to `addCoeffsSolutionN` (Phase 3)
- Not passed to `createDatabase` (Phase 4)

**Rationale:** UpdateManifest is a build-orchestration control, not a computational parameter.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 152 | Default True |
| Config | `splitConfig` | OptionsConfig.wl | 368-377 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 568-578, 821-826 | Public API |
| Entry | `buildModelsParallel` | ManageResources.wl | 1145, 1188-1189, 1198, 1239 | Parallel orchestrator |
| **Consumer** | `buildModelsInternal` | ManageResources.wl | 838, 1129 | **Conditional update** |
| Helper | `updateModelManifest` | ManageResources.wl | 184-216 | Manifest generation |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Build phase - manifest regeneration |
| Default | `True` |
| When True | Regenerates `ModelManifest.wl` after build |
| When False | Skips manifest update (partial builds) |
| Gate condition | Also requires `fileSuffix === ""` |
| Parallel behavior | Forced False in workers, unconditional after merge |
| NOT forwarded | Option only used at orchestration level |
| Consumer count | Single terminal consumer |
