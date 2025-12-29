# NumKernels Option

**Location in config:** `config["Parallel"]["NumKernels"]`
**Default value:** `Automatic`
**Legacy mapping:** `"NumKernels" -> {"Parallel", "NumKernels"}` in OptionsConfig.wl:165

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   ├─ numKernels = OptionValue["NumKernels"]
   ├─ LaunchKernels[numKernels]  (for parallel phases)
   └─ Forwards to buildModels

CONFIGURATION LAYER
│
└─ splitConfig[config, "Parallel"]  ◄── EXTRACTS "NumKernels"
   │
   └─ "NumKernels" -> config["Parallel"]["NumKernels"]

MOMENTS PHASE (Phase 4)
│
└─ buildModelsInternal[config_Association]
   │
   ├─ numKernels = config["Parallel"]["NumKernels"]
   │
   └─ setupParallelKernels[numKernels]  ◄── TERMINAL CONSUMER
      │
      ├─ Automatic → $ProcessorCount
      ├─ None → 0 (no parallel kernels)
      ├─ Integer → use specified count
      │
      ├─ CloseKernels[]
      ├─ LaunchKernels[n]
      └─ warmupParallelKernels[] (if n > 0)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 143 | Default: `"NumKernels" -> Automatic` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 363-365 | `splitConfig[config, "Parallel"]` definition |
| Line 364 | Extracts: `"NumKernels" -> config["Parallel"]["NumKernels"]` |

## Entry Points

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration: `"NumKernels" -> Automatic` |
| Lines 821-826 | Entry patterns |

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Option declaration: `"NumKernels" -> Automatic` |
| Line 1156 | Extraction with resolution |
| Line 1176 | `LaunchKernels[numKernels]` |
| Line 1266 | Forwards to buildModels |

## Terminal Consumers

### `setupParallelKernels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 776-790 | Function definition |
| Lines 777-782 | Value resolution |
| Line 786 | `CloseKernels[]` |
| Line 787 | `LaunchKernels[n]` |
| Line 789 | Returns `Length[ParallelKernels[]]` |

**Resolution logic:**
```wolfram
n = Switch[numKernels,
  Automatic, $ProcessorCount,
  None, 0,
  _Integer, numKernels,
  _, $ProcessorCount
]
```

### `warmupParallelKernels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 794-817 | Function definition |
| Lines 810-816 | ParallelEvaluate to load packages on all kernels |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 143 | Default Automatic |
| Config | `splitConfig` | OptionsConfig.wl | 363-365 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 568-578, 821-826 | Public API |
| Entry | `buildModelsParallel` | ManageResources.wl | 1138-1275 | Parallel orchestrator |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 834, 1084 | Extracts and uses |
| **Consumer** | `setupParallelKernels` | ManageResources.wl | 776-790 | Launches kernels |
| Consumer | `warmupParallelKernels` | ManageResources.wl | 794-817 | Initializes kernels |

## Value Resolution

| Input | Resolution |
|-------|------------|
| `Automatic` | `$ProcessorCount` |
| `None` | 0 (serial execution) |
| Integer | Use specified count |
| Invalid | Falls back to `$ProcessorCount` |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Parallel kernel management for Moments phase |
| Default | `Automatic` |
| Applies to | Moments database creation (Phase 4) |
| Phases 1-3 | Always serial (Symbolic, Compile, Numerical) |
| Cleanup | Kernels closed after moments phase |
