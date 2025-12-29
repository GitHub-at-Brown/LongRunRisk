# CompileJacobians Option

**Location in config:** `config["Build"]["CompileJacobians"]`
**Default value:** `True`
**Legacy mapping:** `"CompileJacobians" -> {"Build", "CompileJacobians"}` in OptionsConfig.wl:178

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ Forwards via filteredOpts to buildModels

CONFIGURATION LAYER
│
└─ splitConfig[config, "Build"]  ◄── EXTRACTS "CompileJacobians"
   │
   └─ "CompileJacobians" -> config["Build"]["CompileJacobians"]

BUILD ORCHESTRATION
│
└─ buildModelsInternal[config_Association]
   │
   ├─ compileJacobians = config["Build"]["CompileJacobians"]  (line 832)
   │
   ├─ determineModelStatus[..., compileJacobians, ...]  (line 912-914)
   │  │  ◄── INTERMEDIATE FORWARDER
   │  │
   │  └─ Returns "NeedsJacobians" -> compileJacobians
   │     in model status dictionary
   │
   └─ If[compileJacobians && Length[modelsNeedingJacobians] > 0,
        Do[
          createCompiledEq[model, compiledDir,
            "CompileMode" -> "JacobianOnly", ...]
        , {modelKey, modelsNeedingJacobians}]
      ]  ◄── TERMINAL CONSUMER (lines 1005-1020)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 148 | Default: `"CompileJacobians" -> True` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 368-377 | `splitConfig[config, "Build"]` definition |
| Line 372 | Extracts: `"CompileJacobians" -> config["Build"]["CompileJacobians"]` |

## Entry Points

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration: `"CompileJacobians" -> False` |
| Lines 821-826 | Entry patterns (config or legacy options) |

**Note:** Option default in buildModels (False) differs from defaultConfig (True). The config value takes precedence.

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Does NOT declare CompileJacobians |
| Lines 1188-1189 | Passes through via filteredOpts |
| Lines 1191-1210 | Forwards to each parallel buildModels call |

## Intermediate Forwarder

### `determineModelStatus` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 712-772 | Function definition |
| Line 713 | Receives `compileJacobians_` as 7th parameter |
| Lines 723, 730, 738, 744, 754 | Returns `"NeedsJacobians" -> compileJacobians` |
| Lines 761-769 | Validates existing jacobian files if True |

**Usage in determineModelStatus:**
```wolfram
If[compileJacobians,
  With[{jacFile = resolveCompiledMxFile[compiledDir, shortname, "_jacobians"]},
    validation = validateCompiledFile[jacFile, savedModel, "JacobianOnly", ...];
    If[!validation["Valid"],
      Return[<|"MainStage" -> "UpToDate", "NeedsJacobians" -> True, ...|>]
    ]
  ]
]
```

## Terminal Consumer

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 832 | `compileJacobians = config["Build"]["CompileJacobians"]` |
| Lines 1005-1020 | Jacobian compilation phase |

**Jacobian compilation phase:**
```wolfram
If[compileJacobians && Length[modelsNeedingJacobians] > 0,
  Do[
    shortname = catalogModels[modelKey]["shortname"];
    createCompiledEq[
      processedModels[shortname],
      compiledDir,
      "CompileMode" -> "JacobianOnly",
      "Compiler" -> compilerChoice
    ];
  , {modelKey, modelsNeedingJacobians}
  ]
]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 148 | Default True |
| Config | `splitConfig` | OptionsConfig.wl | 368-377 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 568-578, 821-826 | Public API |
| Entry | `buildModelsParallel` | ManageResources.wl | 1145, 1188-1189 | Parallel orchestrator |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 832 | Extracts from config |
| Forwarder | `buildModelsInternal` | ManageResources.wl | 912-914 | Passes to determineModelStatus |
| Forwarder | `determineModelStatus` | ManageResources.wl | 712-772 | Validates and returns status |
| **Consumer** | `buildModelsInternal` | ManageResources.wl | 1005-1020 | **Jacobian compilation** |

## Output Files

When True, creates jacobian-only compiled function files:
- `Resources/CompiledFunctions/$SystemID/{shortname}_jacobians.mx`

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Build phase - jacobian function compilation |
| Default | `True` |
| When True | Creates separate compiled jacobian functions |
| When False | Skips jacobian compilation entirely |
| Status key | `"NeedsJacobians"` in model status dictionary |
| Called function | `createCompiledEq` with `"CompileMode" -> "JacobianOnly"` |
| Consumer count | Single terminal consumer with one forwarder |
