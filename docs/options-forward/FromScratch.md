# FromScratch Option

**Location in config:** `config["Build"]["FromScratch"]`
**Default value:** `False`
**Legacy mapping:** `"FromScratch" -> {"Build", "FromScratch"}` in OptionsConfig.wl:177

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   ├─ fromScratch = OptionValue["FromScratch"]
   ├─ If[fromScratch, cleanAllOutputs[root]]
   └─ buildModels[..., "FromScratch" -> False, ...]  (forced False)

CONFIGURATION LAYER
│
└─ splitConfig[config, "Build"]  ◄── EXTRACTS "FromScratch"
   │
   └─ "FromScratch" -> config["Build"]["FromScratch"]

BUILD ORCHESTRATION
│
└─ buildModelsInternal[config_Association]
   │
   ├─ fromScratch = config["Build"]["FromScratch"]  (line 831)
   │
   └─ If[fromScratch,
        cleanAllOutputs[root];
        savedModels = <||>;
        manifest = $Failed
      ]  ◄── TERMINAL CONSUMER
      │
      └─ cleanAllOutputs[root]  ◄── CLEANUP HELPER
         │
         ├─ DeleteFile @ Resources/CompiledFunctions/**/*.mx
         ├─ DeleteFile @ Resources/MomentsLookupTables/covLong*.mx|wl
         ├─ DeleteFile @ Resources/Models.wl
         ├─ DeleteFile @ Resources/ModelManifest.wl
         └─ DeleteFile @ Resources/Models_*.wl (suffixed checkpoints)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 147 | Default: `"FromScratch" -> False` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 368-377 | `splitConfig[config, "Build"]` definition |
| Line 371 | Extracts: `"FromScratch" -> config["Build"]["FromScratch"]` |

## Entry Points

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration: `"FromScratch" -> False` |
| Lines 821-826 | Entry patterns (config or legacy options) |

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Option declaration: `"FromScratch" -> False` |
| Line 1155 | `fromScratch = OptionValue["FromScratch"]` |
| Lines 1169-1172 | `If[fromScratch, cleanAllOutputs[root]]` |
| Line 1197 | Forces `"FromScratch" -> False` in parallel workers |

## Terminal Consumers

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 831 | `fromScratch = config["Build"]["FromScratch"]` (With clause) |
| Lines 896-901 | Cleanup trigger |

**Cleanup logic:**
```wolfram
If[fromScratch,
  cleanAllOutputs[root];
  savedModels = <||>;
  manifest = $Failed;
]
```

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 1155 | `fromScratch = OptionValue["FromScratch"]` |
| Lines 1169-1172 | `If[fromScratch, cleanAllOutputs[root]]` |

### `cleanAllOutputs` Helper in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 586-610 | Actual deletion logic |

**Deleted artifacts:**
- All `.mx` files in `Resources/CompiledFunctions/` and platform subfolders
- All `covLong*.mx` and `covLong*.wl` files in `Resources/MomentsLookupTables/`
- `Resources/Models.wl` (processed models)
- `Resources/ModelManifest.wl` (catalog hash manifest)
- All `Resources/Models_*.wl` suffixed checkpoint files

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 147 | Default False |
| Config | `splitConfig` | OptionsConfig.wl | 368-377 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 568-578, 821-826 | Public API |
| Entry | `buildModelsParallel` | ManageResources.wl | 1138-1275 | Parallel orchestrator |
| **Consumer** | `buildModelsInternal` | ManageResources.wl | 831, 896-901 | **Cleanup trigger** |
| **Consumer** | `buildModelsParallel` | ManageResources.wl | 1155, 1169-1172 | **Cleanup trigger** |
| Helper | `cleanAllOutputs` | ManageResources.wl | 586-610 | Deletion logic |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Build phase - clean slate rebuild |
| Default | `False` |
| When True | Deletes all cached outputs before rebuilding |
| Parallel handling | Cleanup once at orchestrator, forced False in workers |
| Effects | Clears savedModels cache, forces manifest rebuild |
| Consumer count | Two terminal consumers (buildModelsInternal, buildModelsParallel) |
