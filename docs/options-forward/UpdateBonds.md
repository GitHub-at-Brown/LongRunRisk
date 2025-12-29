# UpdateBonds Option

**Location in config:** `config["Numerical"]["UpdateBonds"]`
**Default value:** `False`
**Legacy mapping:** `"UpdateBonds" -> {"Numerical", "UpdateBonds"}` in OptionsConfig.wl:189

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
├─ addCoeffsSolutionN[model]
│  └─ Hard-coded: "UpdateBonds" -> True
│
└─ toNumRules[model, ...]
   └─ Hard-coded: "UpdateBonds" -> True

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "UpdateBonds"
   │
   └─ "UpdateBonds" -> config["Numerical"]["UpdateBonds"]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ If[OptionValue["UpdateBond"] || OptionValue["UpdateBonds"], ...]
   │  └─ updateCoeffsBond[..., "bond", ...]  ◄── Real bonds
   │
   └─ If[OptionValue["UpdateNomBond"] || OptionValue["UpdateBonds"], ...]
      └─ updateCoeffsBond[..., "nombond", ...]  ◄── Nominal bonds
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 133 | Default: `"UpdateBonds" -> False` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 348 | Extracts: `"UpdateBonds" -> config["Numerical"]["UpdateBonds"]` |

## Terminal Consumer

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 340 | `"UpdateBonds" -> False` |
| Line 638 | `If[OptionValue["UpdateBond"] \|\| OptionValue["UpdateBonds"], ...]` |
| Line 642 | `If[OptionValue["UpdateNomBond"] \|\| OptionValue["UpdateBonds"], ...]` |

**Umbrella behavior:**
```wolfram
(* Real bonds *)
If[OptionValue["UpdateBond"] || OptionValue["UpdateBonds"],
  solBond = updateCoeffsBond[model["coeffsSolution"]["bond"], ...]
]

(* Nominal bonds *)
If[OptionValue["UpdateNomBond"] || OptionValue["UpdateBonds"],
  solNomBond = updateCoeffsBond[model["coeffsSolution"]["nombond"], ...]
]
```

## Hard-Coded Consumers

### `addCoeffsSolutionN` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 1036-1046 | Function definition |
| Line 1042 | Hard-coded: `"UpdateBonds" -> True` |

### `toNumRules` in `Kernel/Tools/ToNumber.wl`

| Location | What happens |
|----------|--------------|
| Lines 77-113 | Function definition |
| Line 95 | Hard-coded: `"UpdateBonds" -> True` |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 133 | Default False |
| Config | `splitConfig` | OptionsConfig.wl | 348 | Extraction |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| **Consumer** | `updateCoeffsSol` | SolveEulerEq.wl | 638, 642 | Decision points |
| Hard-coded | `addCoeffsSolutionN` | SolveEulerEq.wl | 1042 | Always True |
| Hard-coded | `toNumRules` | ToNumber.wl | 95 | Always True |

## Relationship with Individual Options

| UpdateBonds | UpdateBond | UpdateNomBond | Real Bonds | Nominal Bonds |
|-------------|------------|---------------|------------|---------------|
| False | False | False | No | No |
| False | True | False | Yes | No |
| False | False | True | No | Yes |
| True | * | * | Yes | Yes |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - all bond coefficients |
| Default | `False` |
| Umbrella role | Enables both UpdateBond and UpdateNomBond |
| Hard-coded overrides | addCoeffsSolutionN and toNumRules always set True |
| Dependency | Requires WC coefficients (computed first) |
