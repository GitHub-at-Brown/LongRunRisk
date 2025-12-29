# UpdateBond Option

**Location in config:** `config["Numerical"]["UpdateBond"]`
**Default value:** `False`
**Legacy mapping:** `"UpdateBond" -> {"Numerical", "UpdateBond"}` in OptionsConfig.wl:187

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ updateCoeffs[model, kernels, "UpdateBond" -> True, ...]

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "UpdateBond"
   │
   └─ "UpdateBond" -> config["Numerical"]["UpdateBond"]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ If[OptionValue["UpdateBond"] || OptionValue["UpdateBonds"], ...]
   │
   └─ updateCoeffsBond[model["coeffsSolution"]["bond"], params, newParams,
                       maxMaturity, wcCoeffsList, recurrenceOpts]
      │  ◄── TERMINAL CONSUMER
      └─ RecurrenceTable[...] for real bond coefficients
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 131 | Default: `"UpdateBond" -> False` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 346 | Extracts: `"UpdateBond" -> config["Numerical"]["UpdateBond"]` |

## Terminal Consumer

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 338 | `"UpdateBond" -> False` |
| Line 638 | `If[OptionValue["UpdateBond"] \|\| OptionValue["UpdateBonds"], ...]` |
| Lines 639-640 | `solBond = updateCoeffsBond[...]` |

**Decision logic:**
```wolfram
If[OptionValue["UpdateBond"] || OptionValue["UpdateBonds"],
  solBond = updateCoeffsBond[model["coeffsSolution"]["bond"], params, newParams,
                             maxMaturity, wcCoeffsList, recurrenceOpts]
]
```

### `updateCoeffsBond` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 697-712 | Function definition |
| Line 707 | `(#[maxMaturity]& /@ modelCoeffsSolution)` |

Uses `RecurrenceTable` to solve bond recursion equations.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 131 | Default False |
| Config | `splitConfig` | OptionsConfig.wl | 346 | Extraction |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| **Consumer** | `updateCoeffsSol` | SolveEulerEq.wl | 638-640 | Decision point |
| Terminal | `updateCoeffsBond` | SolveEulerEq.wl | 697-712 | RecurrenceTable execution |

## Relationship with UpdateBonds

| Option | Scope | Effect |
|--------|-------|--------|
| `UpdateBond` | Real bonds only | Computes bond coefficients |
| `UpdateBonds` | Both types | Enables both UpdateBond and UpdateNomBond |

**OR logic:**
```wolfram
If[OptionValue["UpdateBond"] || OptionValue["UpdateBonds"], ...]
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - real bond coefficients |
| Default | `False` |
| Umbrella option | `UpdateBonds` enables this |
| Dependency | Requires WC coefficients (computed first) |
| Terminal operation | `RecurrenceTable` for term structure |
