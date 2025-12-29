# ReduceTimeLimit Option

**Location in config:** `config["Numerical"]["ReduceTimeLimit"]`
**Default value:** `5.` (seconds)
**Legacy mapping:** `"ReduceTimeLimit" -> {"Numerical", "ReduceTimeLimit"}` in OptionsConfig.wl:190

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ updateCoeffs[model, kernels, opts...]

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "ReduceTimeLimit"
   │
   └─ "ReduceTimeLimit" -> config["Numerical"]["ReduceTimeLimit"]

NUMERICAL SOLVING PATH (nD only)
│
└─ updateCoeffsSol → solveCoeffRoots → solveND
   │
   ├─ solveND receives "ReduceTimeLimit" -> 5.
   │
   └─ safeReduceCall[conds, paramsAll, signs, cName, sName, findOpts, timeout]
      │  ◄── TERMINAL CONSUMER
      │
      └─ TimeConstrained[
           findRootInterval[...],
           timeout,
           $Failed
         ]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 134 | Default: `"ReduceTimeLimit" -> 5.` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 349 | Extracts: `"ReduceTimeLimit" -> config["Numerical"]["ReduceTimeLimit"]` |

## Intermediate Forwarders

### `solveCoeffRoots` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 803-904 | Function definition |
| Lines 851-858 | For nD case: passes to `solveND` |

**nD delegation:**
```wolfram
If[Length[coefList] > 1,
  Return[
    solveND[f, df, conds, paramsAll, signs, coefList, cName, sName,
            findOpts, extractOpts, scanOpts, quadSol["Solution"],
            "ReduceTimeLimit" -> 5.],
    Module
  ]
]
```

## Terminal Consumer

### `solveND` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 207-261 | Function definition |
| Lines 208-209 | Option declaration: `"ReduceTimeLimit" -> 5.` |
| Line 246 | `reduceExpr = safeReduceCall[..., OptionValue["ReduceTimeLimit"]]` |

### `safeReduceCall` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 84-91 | Function definition |
| Line 86-90 | `TimeConstrained[findRootInterval[...], timeout, $Failed]` |

**Implementation:**
```wolfram
safeReduceCall[conds_, paramsAll_, signs_, cName_, sName_, findOpts_, timeout_] :=
  TimeConstrained[
    findRootInterval[conds, paramsAll,
      "Signs" -> signs, "CoeffName" -> cName,
      "SignSymbol" -> sName, Sequence @@ findOpts],
    timeout,
    $Failed
  ]
```

## Fallback Chain

When `safeReduceCall` times out (returns `$Failed`):

1. **trySmartIntervals**: Uses Infinity padding → returns `$Failed`
2. **tryArtificialBox**: Uses finite bounds → may succeed
3. **nMinimizeFallback**: Optimization-based solving → last resort
4. **Empty result**: If all fail

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 134 | Default 5.0 |
| Config | `splitConfig` | OptionsConfig.wl | 349 | Extraction |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| Forwarder | `solveCoeffRoots` | SolveEulerEq.wl | 851-858 | Delegates to solveND |
| Consumer | `solveND` | SolveEulerEq.wl | 207-261 | Extracts and passes |
| **Terminal** | `safeReduceCall` | SolveEulerEq.wl | 84-91 | TimeConstrained wrapper |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - nD root finding only |
| Default | 5.0 seconds |
| Applies to | Multi-dimensional coefficient systems (Length[coefList] > 1) |
| Does NOT apply to | 1D coefficient systems (direct findRootInterval) |
| Fallback behavior | Graceful degradation through fallback chain |
| Error handling | Returns `$Failed` on timeout, triggers fallbacks |
