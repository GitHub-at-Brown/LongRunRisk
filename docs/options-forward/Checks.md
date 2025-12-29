# Checks Option

**Location in config:** `config["Numerical"]["Checks"]`
**Default value:** Nested Association (see below)
**Subsystem:** Numerical

## Default Structure

```wolfram
"Checks" -> <|
  "PrintResidualsNorm" -> False,
  "CheckResiduals" -> False,
  "Tol" -> 10.^-16
|>
```

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ updateCoeffs[model, kernels, opts...]
   └─ Direct option forwarding

CONFIGURATION LAYER
│
└─ defaultConfig[]
   └─ "Checks" defined in "Numerical" subsystem (lines 125-129)

NOTE: Checks options are NOT extracted via splitConfig["Numerical"]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ doChecks = OptionValue["PrintResidualsNorm"] || OptionValue["CheckResiduals"]
   ├─ checkOpts = FilterRules[opts, Options[checks]]
   │
   └─ If[doChecks, checkCoeffs[type, model, sol, params, newParams, maxMaturity, numStocks, checkOpts]]
      │
      └─ checks[eqs, sol, params, newParams, opts]  ◄── TERMINAL CONSUMER
         │
         ├─ If CheckResiduals && residualsNorm >= Tol: Abort[]
         └─ If PrintResidualsNorm: Print residual info
```

## Configuration Gap

**Important:** The `addCoeffsSolutionN` function (lines 1036-1046 in SolveEulerEq.wl) does NOT forward configuration options to `updateCoeffs`. It only passes the model. This means Checks options from buildModels configuration are NOT propagated to the numerical solving phase.

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 125-129 | Default nested structure defined |

### Terminal Consumer: `checks` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 719-744 | Function definition |
| Line 722 | Options: `"PrintResidualsNorm"->False, "CheckResiduals"->False, "Tol"->10.^-16` |
| Line 731 | Computes `residualsNorm` |
| Lines 733-738 | Uses `CheckResiduals` and `Tol` for validation |
| Line 740 | Uses `PrintResidualsNorm` for output |

**Validation logic:**
```wolfram
If[OptionValue["CheckResiduals"],
  If[residualsNorm >= OptionValue["Tol"],
    Message[checks::largeresid, residualsNorm, OptionValue["Tol"]];
    Abort[],
    Message[checks::smallresid, residualsNorm, OptionValue["Tol"]]
  ],
  If[OptionValue["PrintResidualsNorm"],
    Message[checks::norm, residualsNorm]
  ]
]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 125-129 | Defines defaults |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| Forwarder | `updateCoeffsSol` | SolveEulerEq.wl | 575-690 | Extracts and filters options |
| Dispatcher | `checkCoeffs` | SolveEulerEq.wl | 500-514 | Routes to checks |
| **Consumer** | `checks` | SolveEulerEq.wl | 719-744 | **Terminal consumer** |

## Sub-Option Descriptions

| Option | Default | Purpose |
|--------|---------|---------|
| PrintResidualsNorm | False | Print residual norm (informational) |
| CheckResiduals | False | Validate residuals against Tol |
| Tol | 10^-16 | Tolerance threshold for validation |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - validation |
| Nested structure | Yes - Association with 3 keys |
| Configuration gap | addCoeffsSolutionN does not forward options |
| Error handling | Abort[] when CheckResiduals fails |
| Mutual exclusivity | PrintResidualsNorm only runs if CheckResiduals is False |
