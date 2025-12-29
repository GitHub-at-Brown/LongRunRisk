# MaxMaturity Option (Numerical Subsystem)

**Location in config:** `config["Numerical"]["MaxMaturity"]`
**Default value:** `12`
**Legacy mapping:** `"MaxMaturity" -> {"Numerical", "MaxMaturity"}` in OptionsConfig.wl:186
**Note:** Different from Build subsystem's MaxMaturity (default 120)

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
├─ updateCoeffs[model, kernels, "MaxMaturity" -> n, ...]
│
└─ addCoeffsSolutionN[model]
   └─ updateCoeffs[..., "MaxMaturity" -> 12, ...]

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "MaxMaturity"
   │
   └─ "MaxMaturity" -> config["Numerical"]["MaxMaturity"]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ maxMaturity = OptionValue["MaxMaturity"]
   │
   ├─ updateCoeffsBond[..., maxMaturity, coeffsWc, opts...]  ◄── TERMINAL CONSUMER
   │  └─ #[maxMaturity]& /@ modelCoeffsSolution
   │
   └─ checkCoeffs[..., maxMaturity, ...]  ◄── TERMINAL CONSUMER
      └─ Table[..., {n, 1, maxMaturity}]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 117 | Default: `"MaxMaturity" -> 12` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 342 | Extracts: `"MaxMaturity" -> config["Numerical"]["MaxMaturity"]` |

## Intermediate Forwarders

### `updateCoeffs` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 765-796 | Wrapper function |
| Lines 765-771 | Inherits options from `updateCoeffsSol` |

**How received:** Via `OptionsPattern[{updateCoeffsSol, checks, ...}]`
**How forwarded:** To `updateCoeffsSol` via argument propagation

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 341 | `"MaxMaturity" -> 12` |
| Line 602 | `maxMaturity = OptionValue["MaxMaturity"]` |
| Lines 639-645 | Forward to `updateCoeffsBond` |

### `addCoeffsSolution` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 904-911 | Option declarations |
| Line 905 | `"MaxMaturity" -> 12` |
| Lines 1047-1062 | Uses in parameterized functions |

### `yieldCurve` in `Kernel/Tools/NicePlots.wl`

| Location | What happens |
|----------|--------------|
| Lines 46-49 | Option declarations |
| Line 61 | `maxMaturity = OptionValue[yieldCurve, "MaxMaturity"]` |
| Line 105 | `Table[{m, yE} /. m -> mm, {mm, maxMaturity}]` |

## Terminal Consumers

### `updateCoeffsBond` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 697-712 | Function definition |
| Line 707 | `(#[maxMaturity]& /@ modelCoeffsSolution)` |

Applies the recurrence table solution function with specific maturity value.

### `checkCoeffs` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 500-514 | Function definition |
| Lines 509, 512 | `Flatten @ Table[..., {n, 1, maxMaturity}]` |

Generates validation equations for bonds up to maxMaturity.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 117 | Default value 12 |
| Config | `splitConfig` | OptionsConfig.wl | 342 | Extracts from config |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| Forwarder | `updateCoeffsSol` | SolveEulerEq.wl | 341, 602 | Main extraction |
| Forwarder | `addCoeffsSolution` | ProcessModels.wl | 905, 1047-1062 | Parameterized functions |
| Forwarder | `yieldCurve` | NicePlots.wl | 46-105 | Visualization |
| **Consumer** | `updateCoeffsBond` | SolveEulerEq.wl | 697-712 | Bond computation |
| **Consumer** | `checkCoeffs` | SolveEulerEq.wl | 500-514 | Validation |

## Propagation Paths

### Path A: Configuration-driven
```
buildModels[<|"Numerical" -> <|"MaxMaturity" -> 24|>|>]
  → normalizeConfig → merges with defaults
  → splitConfig[config, "Numerical"] → "MaxMaturity" -> 24
  → (flows to numerical phase)
```

### Path B: Direct Option Passing
```
updateCoeffs[model, kernels, params, "MaxMaturity" -> 24]
  → updateCoeffsSol[..., opts]
  → maxMaturity = OptionValue["MaxMaturity"] → 24
  → updateCoeffsBond[..., 24, ...]
  → Computes bond coefficients for maturities 0-24
```

### Path C: Default (addCoeffsSolutionN)
```
addCoeffsSolutionN[model]
  → updateCoeffs[..., "MaxMaturity" -> 12, ...]
  → Uses default 12
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - bond computations |
| Default | 12 (different from Build's 120) |
| Impact | Number of bond coefficient values computed (0 to maxMaturity) |
| Downstream effects | Yield curve length, validation scope |
| Ambiguity | Handled by normalizeConfig (line 264 in OptionsConfig.wl) |
