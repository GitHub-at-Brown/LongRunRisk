# CreateMoments Option

**Location in config:** `config["Build"]["CreateMoments"]`
**Default value:** `True`
**Legacy mapping:** `"CreateMoments" -> {"Build", "CreateMoments"}` in OptionsConfig.wl:179

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   ├─ createMoments = OptionValue["CreateMoments"]
   ├─ buildModels[..., "CreateMoments" -> False, ...]  (parallel phase)
   └─ If[createMoments, buildModels[..., "CreateMoments" -> True, ...]]  (sequential)

CONFIGURATION LAYER
│
└─ splitConfig[config, "Build"]  ◄── EXTRACTS "CreateMoments"
   │
   └─ "CreateMoments" -> config["Build"]["CreateMoments"]

BUILD ORCHESTRATION
│
└─ buildModelsInternal[config_Association]
   │
   ├─ createMoments = config["Build"]["CreateMoments"]  (line 833)
   │
   ├─ determineModelStatus[..., createMoments, ...]  (line 912-914)
   │  │  ◄── INTERMEDIATE FORWARDER
   │  │
   │  └─ If[createMoments,
   │       (* validate moments cache *)
   │       If[!momentsUpToDate[...],
   │         Return[<|"MainStage" -> "Moments", ...|>]
   │       ]
   │     ]  ◄── TERMINAL CONSUMER #1
   │
   └─ If[createMoments,
        (* Phase 4: Moments *)
        Do[
          createDatabase[model, momentsFile,
            splitConfig[config, "Moments"]]
        , {modelKey, momentsModels}]
      ]  ◄── TERMINAL CONSUMER #2 (lines 1072-1122)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 149 | Default: `"CreateMoments" -> True` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 368-377 | `splitConfig[config, "Build"]` definition |
| Line 373 | Extracts: `"CreateMoments" -> config["Build"]["CreateMoments"]` |

## Entry Points

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration: `"CreateMoments" -> True` |
| Lines 821-826 | Entry patterns (config or legacy options) |

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Option declaration: `"CreateMoments" -> True` |
| Line 1154 | `createMoments = OptionValue["CreateMoments"]` |
| Line 1195 | Forces `"CreateMoments" -> False` in parallel workers |
| Lines 1261-1272 | Sequential moments phase if True |

## Intermediate Forwarder

### `buildModelsInternal` → `determineModelStatus`

| Location | What happens |
|----------|--------------|
| Lines 911-916 | Forwards createMoments as 8th positional argument |

```wolfram
modelStatuses = Association @ Table[
  k -> determineModelStatus[k, catalogModels, savedModels, manifest,
    compiledDir, momentsDir, compileJacobians, createMoments,
    compileMode, compilerChoice],
  {k, Keys[enabledModels]}
]
```

## Terminal Consumers

### Terminal Consumer #1: `determineModelStatus` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 712-772 | Function definition |
| Line 713 | Receives `createMoments_` as 8th parameter |
| Lines 748-758 | Moments cache validation |

**Validation logic:**
```wolfram
If[createMoments,
  With[{momentsFile = ..., metaFile = ..., expectedHash = ...},
    If[!momentsUpToDate[momentsFile, metaFile, expectedHash],
      Return[<|"MainStage" -> "Moments", ...|>]
    ]
  ]
]
```

### Terminal Consumer #2: `buildModelsInternal` Phase 4 Gate in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 833 | `createMoments = config["Build"]["CreateMoments"]` |
| Lines 1072-1122 | Phase 4 conditional execution |

**Phase 4 gate:**
```wolfram
If[createMoments,
  Module[{...},
    momentsModels = ...;
    If[Length[momentsModels] > 0,
      numLaunched = setupParallelKernels[numKernels];
      Needs["...CreateMomentsDatabase`"];
      Do[
        createDatabase[
          processedModels[shortname],
          momentsFile,
          splitConfig[config, "Moments"]  (* forwards Moments options, NOT CreateMoments *)
        ],
        {modelKey, momentsModels}
      ];
      If[numLaunched > 0, CloseKernels[]];
    ]
  ]
]
```

### Terminal Consumer #3: `buildModelsParallel` Sequential Phase in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 1154 | `createMoments = OptionValue["CreateMoments"]` |
| Lines 1261-1272 | Sequential moments phase |

**Sequential phase:**
```wolfram
If[createMoments && Length[successModels] > 0,
  Do[
    buildModels[
      "Models" -> {m},
      "CreateMoments" -> True,
      "NumKernels" -> OptionValue["NumKernels"]
    ],
    {m, successModels}
  ]
]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 149 | Default True |
| Config | `splitConfig` | OptionsConfig.wl | 368-377 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 568-578, 821-826 | Public API |
| Entry | `buildModelsParallel` | ManageResources.wl | 1138-1275 | Parallel orchestrator |
| Forwarder | `buildModelsInternal` | ManageResources.wl | 911-916 | Passes to determineModelStatus |
| **Consumer** | `determineModelStatus` | ManageResources.wl | 748-758 | **Cache validation** |
| **Consumer** | `buildModelsInternal` | ManageResources.wl | 1072-1122 | **Phase 4 gate** |
| **Consumer** | `buildModelsParallel` | ManageResources.wl | 1261-1272 | **Sequential moments** |

## Parallel Build Strategy

| Phase | CreateMoments Value | Purpose |
|-------|---------------------|---------|
| Parallel workers | `False` (forced) | Avoid parallel overhead |
| Sequential phase | `True` (if user requested) | Create moments after merge |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Build phase - moments database creation gate |
| Default | `True` |
| When True | Enables Phase 4 (moments database creation) |
| When False | Skips all moments computation |
| NOT forwarded to | `createDatabase` (receives Moments subsystem options instead) |
| Parallel strategy | Disabled in parallel, enabled in sequential phase |
| Consumer count | Three terminal consumers |
