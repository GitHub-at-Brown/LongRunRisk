# RecurrenceTable Options

**Location in config:** `config["Numerical"]["RecurrenceTable"]`
**Default value:** Nested Association (see below)
**Flattened as:** `"RecurrenceTableOptions"` when extracted via splitConfig
**Legacy mapping:** `"RecurrenceTableOptions" -> {"Numerical", "RecurrenceTable", "Options"}` in OptionsConfig.wl:164

## Default Structure

```wolfram
"RecurrenceTable" -> <|
  "DependentVariables" -> Automatic,
  "Options" -> {}
|>
```

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ updateCoeffs[model, kernels, "RecurrenceTableOptions" -> {...}, ...]

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]
   │
   └─ Flattens: "RecurrenceTableOptions" -> Join[
        {"DependentVariables" -> ...},
        config["Numerical"]["RecurrenceTable"]["Options"]
      ]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ recurrenceOpts = Flatten[{FilterRules[opts, Options[RecurrenceTable]],
   │                            OptionValue["RecurrenceTableOptions"]}]
   │
   └─ updateCoeffsBond[..., maxMaturity, coeffsWc, opts...]  ◄── TERMINAL CONSUMER
      │
      └─ Activate[... /. RecurrenceTableOptions -> FilterRules[opts, Options[RecurrenceTable]]]
         │
         └─ RecurrenceTable[...]  (Wolfram built-in)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 113-116 | Default nested structure |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 338-341 | Flattens RecurrenceTable to "RecurrenceTableOptions" |

**Flattening logic:**
```wolfram
"RecurrenceTableOptions" -> Join[
  {"DependentVariables" -> config["Numerical"]["RecurrenceTable"]["DependentVariables"]},
  config["Numerical"]["RecurrenceTable"]["Options"]
]
```

## Intermediate Forwarders

### `addCoeffsSolution` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 904-911 | Option declarations |
| Line 909 | `"RecurrenceTableOptions" -> {}` |
| Lines 1029-1032 | Combines options via FilterRules and OptionValue |

**Option combination:**
```wolfram
recurrenceTableOpts = Flatten[{
  Evaluate[FilterRules[Flatten@{opts}, Options[RecurrenceTable]]],
  Evaluate[First@OptionValue[addCoeffsSolution, {"RecurrenceTableOptions"}]]
}]
```

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 336 | `"RecurrenceTableOptions" -> {"DependentVariables" -> Automatic}` |
| Lines 619-622 | Extracts and combines options |

**Option extraction:**
```wolfram
recurrenceOpts = Flatten[{
  FilterRules[Flatten @ {opts}, Options[RecurrenceTable]],
  OptionValue["RecurrenceTableOptions"]
}]
```

## Terminal Consumer

### `updateCoeffsBond` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 697-712 | Function definition |
| Line 707 | Applies options to Inactive[RecurrenceTable] |

**Usage pattern:**
```wolfram
Activate[
  (#[maxMaturity]& /@ modelCoeffsSolution) //.
    ... /.
    (x_Symbol?(MatchQ[SymbolName[#], "RecurrenceTableOptions"]&) ->
      FilterRules[Flatten@{opts}, Options[RecurrenceTable]])
]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 113-116 | Default nested structure |
| Config | `splitConfig` | OptionsConfig.wl | 338-341 | Flattens to "RecurrenceTableOptions" |
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Forwarder | `addCoeffsSolution` | ProcessModels.wl | 904-1032 | Declares and combines options |
| Forwarder | `updateCoeffsSol` | SolveEulerEq.wl | 333-622 | Extracts and forwards |
| **Consumer** | `updateCoeffsBond` | SolveEulerEq.wl | 697-712 | **Terminal consumer** |
| Built-in | `RecurrenceTable` | (System) | N/A | Ultimate consumer |

## Propagation Paths

### Path A: Configuration-driven
```
buildModels[<|"Numerical" -> <|"RecurrenceTable" -> <|"DependentVariables" -> {...}|>|>|>]
  → normalizeConfig → merges with defaults
  → splitConfig[config, "Numerical"]
  → "RecurrenceTableOptions" -> {"DependentVariables" -> {...}}
  → (flows through options system)
```

### Path B: Direct Option Passing
```
updateCoeffs[model, kernels, params, "RecurrenceTableOptions" -> {...}]
  → updateCoeffsSol[..., opts]
  → FilterRules extracts RecurrenceTable options
  → updateCoeffsBond[..., opts]
  → Activate[Inactive[RecurrenceTable][...]]
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - bond computations |
| Nested structure | Yes - Association with "DependentVariables" and "Options" |
| Conditional activation | Only when UpdateBond/UpdateBonds = True |
| Inactive/Activate pattern | Uses Inactive[RecurrenceTable] for deferred evaluation |
| Primary sub-option | DependentVariables controls symbol resolution |
