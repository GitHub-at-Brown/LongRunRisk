# IterationLimit Option

**Location in config:** `config["Moments"]["IterationLimit"]`
**Default value:** `$IterationLimit/4`
**Legacy mapping:** `"IterationLimit" -> {"Moments", "IterationLimit"}` in OptionsConfig.wl:177

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
└─ splitConfig[config, "Moments"]  ◄── EXTRACTS "IterationLimit"
   │
   └─ "IterationLimit" -> config["Moments"]["IterationLimit"]

MOMENTS CREATION PATH
│
└─ buildModelsInternal[config_Association]
   │
   └─ Phase 4: Moments (if createMoments = True)
      │
      └─ createDatabase[model, momentsFile, splitConfig[config, "Moments"]]
         │
         └─ ... → uncondCovLongExo[..., opts]  ◄── TERMINAL CONSUMER
            │
            └─ Block[{$IterationLimit = OptionValue["IterationLimit"]},
                 Check[computation, fallback, $IterationLimit::itlim]
               ]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 140 | Default: `"IterationLimit" -> $IterationLimit/4` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 354-359 | `splitConfig[config, "Moments"]` definition |
| Line 358 | Extracts: `"IterationLimit" -> config["Moments"]["IterationLimit"]` |

## Propagation Path

### `createDatabase` → Helper Functions

| Function | Role |
|----------|------|
| `totCovLong` | Pure forwarder |
| `uncondCovLong` | Pure forwarder |
| `uncondVarLong` | Pure forwarder |
| `uncondVarLongExo` | Pure forwarder |
| `uncondCovLongExo` | Terminal consumer |

## Terminal Consumer

### `uncondCovLongExo` in `Kernel/ComputationalEngine/CreateMomentsDatabase.wl`

| Location | What happens |
|----------|--------------|
| Lines 122-219 | Function definition |
| Line 130 | Option declaration: `"IterationLimit" -> $IterationLimit/4` |
| Line 145 | `Block[{$IterationLimit = OptionValue["IterationLimit"]}, ...]` |

**Implementation pattern:**
```wolfram
Block[{$IterationLimit = OptionValue["IterationLimit"]},
  Check[
    Trace[symbolic computation],
    fallback,
    $IterationLimit::itlim
  ]
]
```

This provides a "soft timeout" that gracefully degrades to an alternative computation method when the iteration limit is exceeded.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 140 | Default $IterationLimit/4 |
| Config | `splitConfig` | OptionsConfig.wl | 354-359 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Forwarder | `buildModelsInternal` | ManageResources.wl | 1097-1101 | Forwards to createDatabase |
| Forwarder | `createDatabase` | CreateMomentsDatabase.wl | 314-619 | Forwards to helpers |
| Forwarders | `totCovLong`, etc. | CreateMomentsDatabase.wl | Various | Pure forwarders |
| **Consumer** | `uncondCovLongExo` | CreateMomentsDatabase.wl | 122-219 | **Terminal consumer** |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Moments phase - covariance computation |
| Default | `$IterationLimit/4` (typically ~250,000) |
| Purpose | Limits iterations for expensive symbolic computations |
| Mechanism | `Block[{$IterationLimit = ...}, Check[..., fallback, $IterationLimit::itlim]]` |
| Fallback | Graceful degradation to alternative method on limit |
| Consumer count | Single terminal consumer |
