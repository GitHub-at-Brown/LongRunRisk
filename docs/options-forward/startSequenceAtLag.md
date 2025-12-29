# startSequenceAtLag Option

**Location in config:** `config["Moments"]["startSequenceAtLag"]`
**Default value:** `3`
**Legacy mapping:** `"startSequenceAtLag" -> {"Moments", "startSequenceAtLag"}` in OptionsConfig.wl:175

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
└─ splitConfig[config, "Moments"]  ◄── EXTRACTS "startSequenceAtLag"
   │
   └─ "startSequenceAtLag" -> config["Moments"]["startSequenceAtLag"]

MOMENTS CREATION PATH
│
└─ buildModelsInternal[config_Association]
   │
   └─ Phase 4: Moments (if createMoments = True)
      │
      └─ createDatabase[model, momentsFile, splitConfig[config, "Moments"]]
         │  ◄── TERMINAL CONSUMER
         │
         ├─ seqStart = OptionValue["startSequenceAtLag"]
         │
         ├─ Table[..., {T, -maxLag - 1, -seqStart}]  (negative lags)
         ├─ Table[..., {T, seqStart, maxLag + 1}]    (positive lags)
         ├─ Do[..., {qInd, seqStart - 1}]           (direct computation)
         └─ Pattern: q /; q >= seqStart             (interpolation boundary)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 138 | Default: `"startSequenceAtLag" -> 3` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 354-359 | `splitConfig[config, "Moments"]` definition |
| Line 356 | Extracts: `"startSequenceAtLag" -> config["Moments"]["startSequenceAtLag"]` |

## Terminal Consumer

### `createDatabase` in `Kernel/ComputationalEngine/CreateMomentsDatabase.wl`

| Location | What happens |
|----------|--------------|
| Lines 314-318 | Option declarations |
| Line 316 | `"startSequenceAtLag" -> 3` |
| Line 330 | `seqStart = OptionValue["startSequenceAtLag"]` |
| Lines 354-367 | Table ranges and Do loops |

**Usage pattern:**
```wolfram
(* Negative lags - interpolation zone *)
tempNeg = Table[{T, uncondCov[v1[t], v2[t + T], model]}, {T, -maxLag - 1, -seqStart}]

(* Positive lags - interpolation zone *)
tempPos = Table[{T, uncondCov[v1[t], v2[t + T], model]}, {T, seqStart, maxLag + 1}]

(* Direct computation zone: 1 to seqStart - 1 *)
Do[
  covLong[v1, v2, -qInd] = uncondCov[v1[t], v2[t - qInd], model];
  covLong[v1, v2, qInd] = uncondCov[v1[t], v2[t + qInd], model],
  {qInd, seqStart - 1}
]

(* Pattern for interpolation *)
covLong[v1, v2, q_ /; q >= seqStart] = seqfun[tempPos, q, v1, v2]
```

## Computational Impact

| Zone | Lag Range | Computation Method |
|------|-----------|-------------------|
| Direct | `[-(seqStart-1), ..., -1, 0, 1, ..., seqStart-1]` | Direct uncondCov |
| Interpolation (neg) | `[-maxLag-1, ..., -seqStart]` | Sequence function |
| Interpolation (pos) | `[seqStart, ..., maxLag+1]` | Sequence function |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 138 | Default 3 |
| Config | `splitConfig` | OptionsConfig.wl | 354-359 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Forwarder | `buildModelsInternal` | ManageResources.wl | 1097-1101 | Forwards to createDatabase |
| **Consumer** | `createDatabase` | CreateMomentsDatabase.wl | 314-619 | **Terminal consumer** |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Moments phase - covariance database |
| Default | 3 |
| Purpose | Boundary between direct computation and interpolation |
| Trade-off | Smaller = more interpolation error; Larger = more computation |
| Related option | `maxMomentsLagsToCreate` (maximum lag) |
| Consumer count | Single terminal consumer |
