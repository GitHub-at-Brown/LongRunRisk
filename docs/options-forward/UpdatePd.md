# UpdatePd Option

**Location in config:** `config["Numerical"]["UpdatePd"]`
**Default value:** `False`
**Legacy mapping:** `"UpdatePd" -> {"Numerical", "UpdatePd"}` in OptionsConfig.wl:186

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
├─ addCoeffsSolutionN[model]
│  └─ Hard-coded: "UpdatePd" -> True
│
└─ toNumRules[model, ...]
   └─ Hard-coded: "UpdatePd" -> True

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "UpdatePd"
   │
   └─ "UpdatePd" -> config["Numerical"]["UpdatePd"]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ needsPd = stockFreeQ || TrueQ[OptionValue["UpdatePd"]]
   │
   └─ If[needsPd, computePdCoeffs[...]]  ◄── TERMINAL CONSUMER
      │
      └─ Populates result["Stocks"] with B-coefficient solutions
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 130 | Default: `"UpdatePd" -> False` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 345 | Extracts: `"UpdatePd" -> config["Numerical"]["UpdatePd"]` |

## Terminal Consumer

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 337 | `"UpdatePd" -> False` |
| Line 625 | `needsPd = stockFreeQ \|\| TrueQ[OptionValue["UpdatePd"]]` |
| Lines 631-634 | Conditional: `If[needsPd, solPd = computePdCoeffs[...]]` |

**Decision logic:**
```wolfram
needsPd = stockFreeQ || TrueQ[OptionValue["UpdatePd"]]
```

- `stockFreeQ = True`: No stock indices in new parameters → auto-compute Pd
- `TrueQ[OptionValue["UpdatePd"]] = True`: Explicit request → compute Pd
- Both False: Skip Pd computation

## Hard-Coded Consumers

### `addCoeffsSolutionN` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 1036-1046 | Function definition |
| Line 1041 | Hard-coded: `"UpdatePd" -> True` |

### `toNumRules` in `Kernel/Tools/ToNumber.wl`

| Location | What happens |
|----------|--------------|
| Lines 77-113 | Function definition |
| Line 95 | Hard-coded: `"UpdatePd" -> True` |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 130 | Default False |
| Config | `splitConfig` | OptionsConfig.wl | 345 | Extraction |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| **Consumer** | `updateCoeffsSol` | SolveEulerEq.wl | 625, 631-634 | Uses needsPd logic |
| Hard-coded | `addCoeffsSolutionN` | SolveEulerEq.wl | 1041 | Always True |
| Hard-coded | `toNumRules` | ToNumber.wl | 95 | Always True |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - Pd coefficients |
| Default | `False` |
| Dual-path logic | Works with `stockFreeQ` condition |
| Impact | Controls whether result["Stocks"] is populated |
| Hard-coded overrides | addCoeffsSolutionN and toNumRules always set True |
