# UpdateNomBond Option

**Location in config:** `config["Numerical"]["UpdateNomBond"]`
**Default value:** `False`
**Legacy mapping:** `"UpdateNomBond" -> {"Numerical", "UpdateNomBond"}` in OptionsConfig.wl:188

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ updateCoeffs[model, kernels, "UpdateNomBond" -> True, ...]

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "UpdateNomBond"
   │
   └─ "UpdateNomBond" -> config["Numerical"]["UpdateNomBond"]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ If[OptionValue["UpdateNomBond"] || OptionValue["UpdateBonds"], ...]
   │
   └─ updateCoeffsBond[model["coeffsSolution"]["nombond"], params, newParams,
                       maxMaturity, wcCoeffsList, recurrenceOpts]
      │  ◄── TERMINAL CONSUMER
      └─ RecurrenceTable[...] for nominal bond coefficients
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 132 | Default: `"UpdateNomBond" -> False` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 347 | Extracts: `"UpdateNomBond" -> config["Numerical"]["UpdateNomBond"]` |

## Terminal Consumer

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 339 | `"UpdateNomBond" -> False` |
| Line 642 | `If[OptionValue["UpdateNomBond"] \|\| OptionValue["UpdateBonds"], ...]` |
| Lines 643-644 | `solNomBond = updateCoeffsBond[...]` |

**Decision logic:**
```wolfram
If[OptionValue["UpdateNomBond"] || OptionValue["UpdateBonds"],
  solNomBond = updateCoeffsBond[model["coeffsSolution"]["nombond"], params, newParams,
                                maxMaturity, wcCoeffsList, recurrenceOpts]
]
```

### `updateCoeffsBond` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 697-712 | Function definition |
| Line 707 | `(#[maxMaturity]& /@ modelCoeffsSolution)` |

Uses `RecurrenceTable` to solve nominal bond recursion equations.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 132 | Default False |
| Config | `splitConfig` | OptionsConfig.wl | 347 | Extraction |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| **Consumer** | `updateCoeffsSol` | SolveEulerEq.wl | 642-644 | Decision point |
| Terminal | `updateCoeffsBond` | SolveEulerEq.wl | 697-712 | RecurrenceTable execution |

## Relationship with UpdateBonds

| Option | Scope | Effect |
|--------|-------|--------|
| `UpdateNomBond` | Nominal bonds only | Computes nominal bond coefficients |
| `UpdateBonds` | Both types | Enables both UpdateBond and UpdateNomBond |

**OR logic:**
```wolfram
If[OptionValue["UpdateNomBond"] || OptionValue["UpdateBonds"], ...]
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - nominal bond coefficients |
| Default | `False` |
| Umbrella option | `UpdateBonds` enables this |
| Dependency | Requires WC coefficients (computed first) |
| Output location | Stored in result["NomBond"] |
