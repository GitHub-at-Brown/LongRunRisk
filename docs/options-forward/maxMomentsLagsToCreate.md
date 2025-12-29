# maxMomentsLagsToCreate Option

**Location in config:** `config["Moments"]["maxMomentsLagsToCreate"]`
**Default value:** `8`
**Legacy mapping:** `"maxMomentsLagsToCreate" -> {"Moments", "maxMomentsLagsToCreate"}` in OptionsConfig.wl:174

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
└─ splitConfig[config, "Moments"]  ◄── EXTRACTS "maxMomentsLagsToCreate"
   │
   └─ "maxMomentsLagsToCreate" -> config["Moments"]["maxMomentsLagsToCreate"]

MOMENTS CREATION PATH
│
└─ buildModelsInternal[config_Association]
   │
   └─ Phase 4: Moments (if createMoments = True)
      │
      └─ createDatabase[model, momentsFile, splitConfig[config, "Moments"]]
         │  ◄── TERMINAL CONSUMER
         │
         ├─ maxLag = OptionValue["maxMomentsLagsToCreate"]
         │
         └─ Table[uncondCov[...], {T, -maxLag - 1, -seqStart}]
            Table[uncondCov[...], {T, seqStart, maxLag + 1}]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 137 | Default: `"maxMomentsLagsToCreate" -> 8` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 354-359 | `splitConfig[config, "Moments"]` definition |
| Line 355 | Extracts: `"maxMomentsLagsToCreate" -> config["Moments"]["maxMomentsLagsToCreate"]` |

## Intermediate Forwarder

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1097-1101 | Calls `createDatabase` with `splitConfig[config, "Moments"]` |

## Terminal Consumer

### `createDatabase` in `Kernel/ComputationalEngine/CreateMomentsDatabase.wl`

| Location | What happens |
|----------|--------------|
| Lines 314-318 | Option declarations |
| Line 315 | `"maxMomentsLagsToCreate" -> 8` |
| Line 328 | `maxLag = OptionValue["maxMomentsLagsToCreate"]` |
| Lines 354-355 | Table iterations for lags |

**Usage in Table iterations:**
```wolfram
(* Negative lags *)
tempNeg = Table[{T, uncondCov[v1[t], v2[t + T], model]}, {T, -maxLag - 1, -seqStart}]

(* Positive lags *)
tempPos = Table[{T, uncondCov[v1[t], v2[t + T], model]}, {T, seqStart, maxLag + 1}]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 137 | Default 8 |
| Config | `splitConfig` | OptionsConfig.wl | 354-359 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Forwarder | `buildModelsInternal` | ManageResources.wl | 1097-1101 | Forwards to createDatabase |
| **Consumer** | `createDatabase` | CreateMomentsDatabase.wl | 314-619 | **Terminal consumer** |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Moments phase - covariance database |
| Default | 8 |
| Impact | Controls temporal extent of moments database |
| Lag range | `-maxLag - 1` to `maxLag + 1` |
| Related option | `startSequenceAtLag` (sequence function start) |
| Consumer count | Single terminal consumer |
