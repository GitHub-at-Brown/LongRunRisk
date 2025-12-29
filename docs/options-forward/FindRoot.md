# FindRoot Options

**Location in config:** `config["Numerical"]["FindRoot"]`
**Default value:** Nested Association (see below)
**Flattened as:** `"FindRootOptions"` when extracted via splitConfig

## Default Structure

```wolfram
"FindRoot" -> <|
  "MaxIterations" -> 100,
  "PrecisionGoal" -> Automatic,
  "AccuracyGoal" -> Automatic,
  "WorkingPrecision" -> MachinePrecision,
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
└─ updateCoeffs[model, kernels, "FindRootOptions" -> {...}, ...]

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]
   │
   └─ Flattens nested FindRoot to "FindRootOptions" → [...]
      │
      └─ (options not directly forwarded from buildModelsInternal)

NUMERICAL SOLVING PATH
│
└─ updateCoeffs[model, kernels, newParams, opts...]
   │
   └─ updateCoeffsSol[model, kernels, newParams, opts...]
      │
      └─ solveCoeffRoots[quadSol, kernel, paramsBase, signs, extraParams, opts...]
         │
         ├─ FilterRules extracts FindRoot-compatible options
         │
         ├─ findRootInterval[conds, paramsAll, opts...]
         │
         └─ scanAndSolve[f, {min, max}, opts...]
            │
            └─ fastRoot[f, spec, opts...]  ◄── TERMINAL CONSUMER
               │
               ├─ tryNewton1D[...] → FindRoot[...]
               ├─ tryNewtonND[...] → FindRoot[...]
               ├─ tryBrent1D[...] → FindRoot[...]
               ├─ trySecant1D[...] → FindRoot[...]
               └─ tryDefaultFindRoot[...] → FindRoot[...]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 104-112 | Default nested structure inside "Numerical" |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Lines 322-337 | Flattens FindRoot to "FindRootOptions" |

**Flattening logic:**
```wolfram
"FindRootOptions" -> Join[
  {"MaxIterations" -> config["Numerical"]["FindRoot"]["MaxIterations"]},
  If[config["Numerical"]["FindRoot"]["PrecisionGoal"] =!= Automatic,
    {"PrecisionGoal" -> config["Numerical"]["FindRoot"]["PrecisionGoal"]},
    {}
  ],
  If[config["Numerical"]["FindRoot"]["AccuracyGoal"] =!= Automatic,
    {"AccuracyGoal" -> config["Numerical"]["FindRoot"]["AccuracyGoal"]},
    {}
  ],
  If[config["Numerical"]["FindRoot"]["WorkingPrecision"] =!= MachinePrecision,
    {"WorkingPrecision" -> config["Numerical"]["FindRoot"]["WorkingPrecision"]},
    {}
  ],
  config["Numerical"]["FindRoot"]["Options"]
]
```

## Intermediate Forwarders

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 335 | `"FindRootOptions" -> {}` default |
| Lines 575-690 | Function implementation |
| Line 617 | FilterRules extracts options |

**How received:** Via `OptionsPattern[{updateCoeffsSol, solveCoeffRoots, checks, FindRoot, RecurrenceTable}]`
**How forwarded:** To `solveCoeffRoots` via FilterRules

### `solveCoeffRoots` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 803-904 | Function definition |
| Line 809 | Receives opts via OptionsPattern |
| Line 832 | `findOpts = FilterRules[Flatten@{opts}, Options[findRootInterval]]` |
| Lines 834-837 | `scanOpts = FilterRules[..., Join[Options[scanAndSolve], Options[FindRoot], Options[fastRoot]]]` |
| Line 862 | Passes `findOpts` to `findRootInterval` |
| Lines 867-870 | Passes `scanOpts` to `scanAndSolve` |

**How received:** Via opts parameter
**How forwarded:** Via FilterRules to downstream functions

### `scanAndSolve` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1015-1179 | Function definition |
| Line 1019 | `"FindRootOptions" -> Automatic` |
| Line 1033 | `frSpec = OptionValue["FindRootOptions"]` |
| Lines 1039-1043 | Builds `frOpts` based on frSpec |
| Lines 1047-1060 | Merges FilterRules of FindRoot options |
| Lines 1095-1096 | Passes to `fastRoot` |

**How received:** Via `OptionsPattern[{scanAndSolve}]`
**How forwarded:** To `fastRoot` via `fastOpts`

## Terminal Consumers

### `fastRoot` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 517-525 | Option declarations |
| Line 521 | `"FindRootOptions" -> Automatic` |
| Line 810 | `frSpec = OptionValue["FindRootOptions"]` |
| Lines 848-858 | Builds `findRootOpts` from frSpec and FilterRules |

**Options built:**
```wolfram
findRootOpts = Join[
  FilterRules[Flatten@{opts}, Options[FindRoot]],
  frOpts  (* from "FindRootOptions" specification *)
]
```

### Internal FindRoot Callers

| Function | File | Lines | Call Pattern |
|----------|------|-------|--------------|
| `tryNewton1D` | FindRootOptim.wl | 675-676 | `FindRoot[..., Evaluate[Sequence @@ findRootOpts]]` |
| `tryNewtonND` | FindRootOptim.wl | 691-692 | `FindRoot[..., Evaluate[Sequence @@ findRootOpts]]` |
| `tryBrent1D` | FindRootOptim.wl | 700-701 | `FindRoot[..., Evaluate[Sequence @@ findRootOpts]]` |
| `trySecant1D` | FindRootOptim.wl | 716-717 | `FindRoot[..., Evaluate[Sequence @@ findRootOpts]]` |
| `tryDefaultFindRoot` | FindRootOptim.wl | 777, 783 | `FindRoot[..., Evaluate[Sequence @@ findRootOpts]]` |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 104-112 | Default nested structure |
| Config | `splitConfig` | OptionsConfig.wl | 322-337 | Flattens to "FindRootOptions" |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| Forwarder | `updateCoeffsSol` | SolveEulerEq.wl | 333-690 | Option declaration, FilterRules |
| Forwarder | `solveCoeffRoots` | SolveEulerEq.wl | 803-904 | Extracts findOpts, scanOpts |
| Forwarder | `scanAndSolve` | FindRootOptim.wl | 1015-1179 | Builds frOpts |
| **Consumer** | `fastRoot` | FindRootOptim.wl | 517-858 | Builds findRootOpts |
| Internal | `tryNewton1D` | FindRootOptim.wl | 675-676 | Calls FindRoot |
| Internal | `tryNewtonND` | FindRootOptim.wl | 691-692 | Calls FindRoot |
| Internal | `tryBrent1D` | FindRootOptim.wl | 700-701 | Calls FindRoot |
| Internal | `trySecant1D` | FindRootOptim.wl | 716-717 | Calls FindRoot |
| Internal | `tryDefaultFindRoot` | FindRootOptim.wl | 777, 783 | Calls FindRoot |
| Built-in | `FindRoot` | (System) | N/A | Ultimate consumer |

## Propagation Paths

### Path A: Configuration-driven
```
buildModels[<|"Numerical" -> <|"FindRoot" -> <|"MaxIterations" -> 200|>|>|>]
  → normalizeConfig → merges with defaults
  → splitConfig[config, "Numerical"]
  → "FindRootOptions" -> {"MaxIterations" -> 200}
  → (stored in config but not directly forwarded to numerical phase)
```

### Path B: Direct Option Passing
```
updateCoeffs[model, kernels, params, "FindRootOptions" -> {MaxIterations -> 200}]
  → updateCoeffsSol[..., opts]
  → FilterRules extracts FindRoot options
  → solveCoeffRoots[..., opts]
  → scanAndSolve[..., opts] or findRootInterval[..., opts]
  → fastRoot[..., opts]
  → FindRoot[..., MaxIterations -> 200, ...]
```

### Path C: Default (no options)
```
addCoeffsSolutionN[model]
  → updateCoeffs (no FindRootOptions)
  → Uses defaults: MaxIterations -> 100, etc.
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase |
| Nested structure | Yes - Association inside "Numerical" |
| Flattening | splitConfig converts to flat "FindRootOptions" list |
| Default MaxIterations | 100 |
| Conditional options | PrecisionGoal, AccuracyGoal, WorkingPrecision only included if non-default |
| Terminal consumers | `fastRoot` and internal try* functions |
| Ultimate consumer | Wolfram `FindRoot` built-in |
