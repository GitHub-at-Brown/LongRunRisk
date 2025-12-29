# Options Flow: Catalog.wl and ProcessModels.wl

This document traces how options flow through functions in the `Catalog.wl` and `ProcessModels.wl` files.

---

## File: Catalog.wl

**Location**: `/Kernel/Model/Catalog.wl`

### Overview

The `Catalog.wl` file defines the public symbols `models` and `modelsExtraInfo`. These are pure data structures (Associations) containing model definitions and extra information.

**This file contains NO functions that use options.** It only defines:
- `models`: An Association mapping model names to their properties (parameters, state variables, etc.)
- `modelsExtraInfo`: An Association with additional model information (closed-form coefficients, initial guesses)

No `OptionsPattern[]`, `OptionValue`, or `FilterRules` are used in this file.

---

## File: ProcessModels.wl

**Location**: `/Kernel/Model/ProcessModels.wl`

### Function: `processModels`

```wolfram
processModels[
    modelsCatalog_Association,
    opts:OptionsPattern[{solveCoeffsSystem, updateCoeffs, getStartingValues, FindRoot, RecurrenceTable}]
]
```

- **Options accepted**: Inherits from `solveCoeffsSystem`, `updateCoeffs`, `getStartingValues`, `FindRoot`, `RecurrenceTable`
- **Options flow**:
  - `"PdEquations"` -> extracted via `OptionValue[solveCoeffsSystem, Flatten@{opts}, "PdEquations"]` -> passed to `solveCoeffsSystem`
  - Options for `addCoeffsSolution` -> extracted via `FilterRules[Flatten@{opts}, Options[addCoeffsSolution]]` -> passed to `addCoeffsSolution`
  - Remaining options flow implicitly through the OptionsPattern mechanism

---

### Function: `simplifyCoeffsSystem`

```wolfram
simplifyCoeffsSystem // Options = {
    "SimplifyOptions" -> {TimeConstraint -> {5, 300}}
};

simplifyCoeffsSystem[model_, opts : OptionsPattern[{solveCoeffsSystem, Simplify}]]
```

- **Options accepted**:
  - `"SimplifyOptions"` (own option, default: `{TimeConstraint -> {5, 300}}`)
  - All `Simplify` options (forwarded)
  - All `solveCoeffsSystem` options (for compatibility)

- **Options flow**:
  - `simplifyOpts` constructed from:
    - `FilterRules[Flatten@{opts}, Options[Simplify]]` (Simplify options)
    - `OptionValue["SimplifyOptions"]` (custom simplify options)
  - `simplifyOpts` -> passed to `FullSimplify[e, Sequence @@ simplifyOpts]`
  - **Terminal use**: Options are consumed directly by `FullSimplify` calls

---

### Function: `solveCoeffsSystem`

```wolfram
solveCoeffsSystem // Options = {
    "SimplifyOptions" -> {TimeConstraint -> {5, 300}},
    "paramQuadSolveOptions" -> {},
    "PdEquations" -> "B"  (* "B" | "AB" | "Both" *)
};

solveCoeffsSystem[model_, opts : OptionsPattern[{solveCoeffsSystem, Simplify}]]
```

- **Options accepted**:
  - `"SimplifyOptions"` (default: `{TimeConstraint -> {5, 300}}`)
  - `"paramQuadSolveOptions"` (default: `{}`)
  - `"PdEquations"` (default: `"B"`)
  - All `Simplify` options

- **Options flow**:
  - `simplifyOpts` -> constructed same as `simplifyCoeffsSystem` -> passed to `FullSimplify`, `Simplify`
  - `paramQuadSolveOpts` -> `OptionValue["paramQuadSolveOptions"]` -> passed to `paramQuadSolve` (in ParamQuadSolve.wl)
  - `pdMode` -> `OptionValue["PdEquations"]` -> controls which pd equations to compute

- **Downstream calls**:
  - `paramQuadSolve[sysA, varsA, ..., Sequence @@ paramQuadSolveOpts]` -> **ParamQuadSolve.wl**
  - `simplifyWithDummySubstitution[..., Sequence @@ simplifyOpts]` -> **ParamQuadSolve.wl**
  - `tryTransforms[#, assumeA, Sequence @@ simplifyOpts]` -> internal helper

---

### Function: `tryTransforms`

```wolfram
tryTransforms // Options = {
    "SimplifyOptions" -> {TimeConstraint -> {5,300}}
};

tryTransforms[
    expr_,
    ass : Except[_List] : True,
    transforms : _List | Automatic : Automatic,
    opts : OptionsPattern[{tryTransforms, Simplify}]
]
```

- **Options accepted**:
  - `"SimplifyOptions"` (default: `{TimeConstraint -> {5, 300}}`)
  - All `Simplify` options

- **Options flow**:
  - `simplifyOpts` constructed from:
    - `FilterRules[Flatten@{opts}, Options[Simplify]]`
    - `OptionValue["SimplifyOptions"]`
  - **Terminal use**: `Simplify[expr /. tr, Sequence @@ simplifyOpts]`

---

### Function: `addCoeffsSolution`

```wolfram
Options[addCoeffsSolution] = {
    "MaxMaturity" -> 12,
    "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
    "RootSigns" -> Automatic,
    "FindRootOptions" -> {},
    "RecurrenceTableOptions" -> {},
    "DependentVariables" -> Automatic
};

addCoeffsSolution[
    model_,
    ratio: "bond" | "nombond",
    opts : OptionsPattern[{addCoeffsSolution, updateCoeffs, RecurrenceTable}]
]
```

- **Options accepted**:
  - `"MaxMaturity"` (default: 12)
  - `"initialGuess"` (default: `<|"Ewc" -> {4}, "Epd" -> {{4}}|>`)
  - `"RootSigns"` (default: Automatic)
  - `"FindRootOptions"` (default: `{}`)
  - `"RecurrenceTableOptions"` (default: `{}`)
  - `"DependentVariables"` (default: Automatic)
  - All `updateCoeffs` options
  - All `RecurrenceTable` options

- **Options flow**:
  - `recurrenceTableOpts` constructed from:
    - `FilterRules[Flatten@{opts}, Options[RecurrenceTable]]`
    - `OptionValue[addCoeffsSolution, {"RecurrenceTableOptions"}]`
  - `recurrenceTableOpts` -> embedded into `Inactive[RecurrenceTable][..., recurrenceTableOpts]`
  - **Terminal use**: When `RecurrenceTable` is activated, options are consumed

---

### Helper Functions (No Options)

The following functions in ProcessModels.wl do NOT accept options:

- `safeRest[list_List]` - utility for safe list extraction
- `safeVerification[...]` - converts verification results to boolean list
- `createExogenous[m_]` - adds exogenous variables/equations to models
- `createExogenousNonZero[m_]` - filters out zero exogenous equations
- `createEndogenous[mod_]` - adds endogenous variables/equations
- `addToStateVars[model_]` - creates mapping to state variables
- `addCoeffsSystem[model_]` - creates Euler equations (calls external functions but passes no options)

---

## Options Flow Diagram

```
processModels
    |
    +-- "PdEquations" ---------> solveCoeffsSystem
    |                                |
    |                                +-- "SimplifyOptions" --> FullSimplify (terminal)
    |                                |
    |                                +-- "paramQuadSolveOptions" --> paramQuadSolve (ParamQuadSolve.wl)
    |                                |                                   |
    |                                |                                   +-- (many internal options)
    |                                |
    |                                +-- tryTransforms
    |                                        |
    |                                        +-- "SimplifyOptions" --> Simplify (terminal)
    |
    +-- FilterRules[..., Options[addCoeffsSolution]]
            |
            +-- addCoeffsSolution
                    |
                    +-- "RecurrenceTableOptions" --> RecurrenceTable (terminal)
                    +-- "MaxMaturity" --> used directly
                    +-- "initialGuess" --> used directly (not consumed here)
```

---

## Cross-File Option Dependencies

### ProcessModels.wl -> ParamQuadSolve.wl

The `solveCoeffsSystem` function calls:

```wolfram
paramQuadSolve[sysA, varsA,
    "SignSymbol" -> Symbol["sign"<>SymbolName[coefwc]],
    Assumptions -> assumeA,
    Sequence @@ paramQuadSolveOpts
]
```

`paramQuadSolve` accepts these options (defined in ParamQuadSolve.wl):
- `"DomainOption"` -> Reals
- `"Assumptions"` -> Automatic
- `"Method"` -> Automatic
- `"MonomialOrder"` -> Automatic
- `"ValidationOption"` -> True
- `"ReturnOption"` -> "All"
- `"TimeoutOption"` -> 600
- `"SimplifyTimeout"` -> Automatic
- `"DiagnosticsOption"` -> False
- `"OnlyQuadTerms"` -> False
- `"SignSymbol"` -> signA
- `"GroebnerMemoryFraction"` -> 0.5
- `"GroebnerMemoryFloor"` -> 1*1024^3
- `"GroebnerMemoryCap"` -> 16*1024^3

### ProcessModels.wl -> SolveEulerEq.wl

The `processModels` accepts options from `updateCoeffs` (defined in SolveEulerEq.wl), which inherits from:
- `updateCoeffsSol`
- `checks`
- `solveCoeffRoots`
- `FindRoot`
- `RecurrenceTable`

Key options from `updateCoeffsSol`:
- `"initialGuess"` -> <|"Ewc"->{4},"Epd"->{{4}}|>
- `"FindRootOptions"` -> {}
- `"RecurrenceTableOptions"` -> {"DependentVariables"->Automatic}
- `"UpdatePd"` -> False
- `"UpdateBond"` -> False
- `"UpdateNomBond"` -> False
- `"UpdateBonds"` -> False
- `"MaxMaturity"` -> 12
- `"RootSigns"` -> Automatic

### ProcessModels.wl -> FindRootOptim.wl

Options for `getStartingValues` (in FindRootOptim.wl) are accepted but not explicitly used in ProcessModels.wl.

---

## Summary Table

| Function | Options Defined | Options Inherited From | Passes Options To |
|----------|-----------------|------------------------|-------------------|
| `processModels` | none | solveCoeffsSystem, updateCoeffs, getStartingValues, FindRoot, RecurrenceTable | solveCoeffsSystem, addCoeffsSolution |
| `simplifyCoeffsSystem` | SimplifyOptions | solveCoeffsSystem, Simplify | FullSimplify (terminal) |
| `solveCoeffsSystem` | SimplifyOptions, paramQuadSolveOptions, PdEquations | Simplify | paramQuadSolve, simplifyWithDummySubstitution, tryTransforms, FullSimplify |
| `tryTransforms` | SimplifyOptions | Simplify | Simplify (terminal) |
| `addCoeffsSolution` | MaxMaturity, initialGuess, RootSigns, FindRootOptions, RecurrenceTableOptions, DependentVariables | updateCoeffs, RecurrenceTable | RecurrenceTable (terminal) |
