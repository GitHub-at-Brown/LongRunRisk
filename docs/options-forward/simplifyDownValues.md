# simplifyDownValues Option

**Location in config:** `config["Moments"]["simplifyDownValues"]`
**Default value:** `False`
**Legacy mapping:** `"simplifyDownValues" -> {"Moments", "simplifyDownValues"}` in OptionsConfig.wl:176

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

CONFIGURATION LAYER
│
└─ splitConfig[config, "Moments"]  ◄── EXTRACTS "simplifyDownValues"
   │
   └─ "simplifyDownValues" -> config["Moments"]["simplifyDownValues"]

MOMENTS CREATION PATH
│
└─ buildModelsInternal[config_Association]
   │
   └─ Phase 4: Moments (if createMoments = True)
      │
      └─ createDatabase[model, momentsFile, splitConfig[config, "Moments"]]
         │  ◄── TERMINAL CONSUMER
         │
         └─ If[OptionValue["simplifyDownValues"],
              (* Simplify all DownValues of covLong *)
              ParallelMap[Simplify[#, model["modelAssumptions"]]&, ...]
            ]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 139 | Default: `"simplifyDownValues" -> False` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 354-359 | `splitConfig[config, "Moments"]` definition |
| Line 357 | Extracts: `"simplifyDownValues" -> config["Moments"]["simplifyDownValues"]` |

## Terminal Consumer

### `createDatabase` in `Kernel/ComputationalEngine/CreateMomentsDatabase.wl`

| Location | What happens |
|----------|--------------|
| Lines 314-318 | Option declarations |
| Line 317 | `"simplifyDownValues" -> False` |
| Lines 591-614 | Conditional simplification logic |

**Implementation:**
```wolfram
If[OptionValue["simplifyDownValues"],
  With[{dv = DownValues[Evaluate@covLong]},
    With[{vals = Values@dv, keys = Keys@dv},
      With[{dvValuesSimplify = ParallelMap[
          Simplify[#, model["modelAssumptions"]]&,
          vals,
          DistributedContexts -> All
        ]},
        DownValues[Evaluate@covLong] = Thread[keys -> dvValuesSimplify]
      ]
    ]
  ]
]
```

## Behavior

| simplifyDownValues | Effect |
|--------------------|--------|
| False (default) | DownValues cached as-is (faster creation) |
| True | DownValues simplified with model assumptions (slower, more compact) |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 139 | Default False |
| Config | `splitConfig` | OptionsConfig.wl | 354-359 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Forwarder | `buildModelsInternal` | ManageResources.wl | 1097-1101 | Forwards to createDatabase |
| **Consumer** | `createDatabase` | CreateMomentsDatabase.wl | 591-614 | **Terminal consumer** |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Moments phase - DownValues simplification |
| Default | False |
| When True | ParallelMap[Simplify[...]] on all DownValues |
| Performance | True = slower creation, potentially smaller storage |
| Parallel execution | Uses ParallelMap with DistributedContexts -> All |
| Consumer count | Single terminal consumer |
