# Options Flow: ComputeConditionalExpectations.wl and ParamQuadSolve.wl

This document traces how options flow through functions in the ComputationalEngine files `ComputeConditionalExpectations.wl` and `ParamQuadSolve.wl`.

---

## File: ComputeConditionalExpectations.wl

**Location**: `/Kernel/ComputationalEngine/ComputeConditionalExpectations.wl`

### Public Functions

The public functions `ev`, `var`, `cov`, and `corr` do **not** accept options. They are defined with fixed signatures:

- `ev[expr_, conditionalTime_, model_]`
- `var[expr_, conditionalTime_, model_]`
- `cov[expr1_, expr2_, conditionalTime_, model_]`
- `corr[expr1_, expr2_, conditionalTime_, model_]`

These functions internally call `lagStateVarst` without passing any options, so the helper function uses its default option values.

---

### Function: `lagStateVarst` (Private)

**Signature**: `lagStateVarst[expr_, conditionalTime_, model_, OptionsPattern[]]`

**Options accepted**:
| Option | Default | Description |
|--------|---------|-------------|
| `"MaxIterations"` | `100` | Maximum iterations for `FixedPointList` convergence |
| `"TimeConstraint"` | `30` | Timeout in seconds for `TimeConstrained` |

**Options flow**:

```
lagStateVarst[..., opts]
    |
    +-- "MaxIterations" -> used directly in FixedPointList[..., maxIter]
    |                      (TERMINAL: controls iteration limit)
    |
    +-- "TimeConstraint" -> used directly in TimeConstrained[..., timeLimit]
                           (TERMINAL: controls timeout)
```

**Details**:
- `"MaxIterations"` is retrieved via `OptionValue["MaxIterations"]` and passed to `FixedPointList` as its iteration limit
- `"TimeConstraint"` is retrieved via `OptionValue["TimeConstraint"]` and passed to `TimeConstrained` as the timeout

**Callers**:
- `ev` (same file) - calls without options, uses defaults
- `ComputeUnconditionalExpectations.wl` - calls via `cond\`Private\`lagStateVarst` without options

**Note**: The public functions `ev`, `var`, `cov`, `corr` do not expose these options to users. To use non-default values, one would need to call `lagStateVarst` directly from Private context.

---

## File: ParamQuadSolve.wl

**Location**: `/Kernel/ComputationalEngine/ParamQuadSolve.wl`

### Function: `paramQuadSolve` (Public)

**Signature**: `paramQuadSolve[eqns_List, vars_List, opts : OptionsPattern[{paramQuadSolve}]]`

**Options accepted**:
| Option | Default | Description |
|--------|---------|-------------|
| `"DomainOption"` | `Reals` | Domain for solutions |
| `"Assumptions"` | `Automatic` | User assumptions (combined with defaults) |
| `"Method"` | `Automatic` | Solver method: `Automatic`, `"Sequential"`, or `"SequentialWithGroebner"` |
| `"MonomialOrder"` | `Automatic` | Monomial order for GroebnerBasis |
| `"ValidationOption"` | `True` | Whether to validate solutions |
| `"ReturnOption"` | `"All"` | Which keys to return in result |
| `"TimeoutOption"` | `600` | Overall timeout in seconds |
| `"SimplifyTimeout"` | `Automatic` | Timeout for individual Simplify calls |
| `"DiagnosticsOption"` | `False` | Whether to include diagnostics |
| `"OnlyQuadTerms"` | `False` | Whether to only solve quadratic variables |
| `"SignSymbol"` | `signA` | Symbol head for sign parameters |
| `"GroebnerMemoryFraction"` | `0.5` | Fraction of available memory for Groebner |
| `"GroebnerMemoryFloor"` | `1*1024^3` | Minimum memory limit (1 GB) |
| `"GroebnerMemoryCap"` | `16*1024^3` | Maximum memory limit (16 GB) |

**Options flow**:

```
paramQuadSolve[eqns, vars, opts]
    |
    +-- "DomainOption" -> used directly to determine radicandConditions
    |                     (TERMINAL: controls whether >= 0 conditions are generated)
    |
    +-- "Assumptions" -> buildAssumptions[] -> combined with defaultAssumptions[]
    |       |
    |       +-> passed to Simplify[..., Assumptions -> ass] for coeffMap
    |       +-> passed to sequentialSolve as `ass` parameter
    |       |       |
    |       |       +-> passed to solveLinearFor, quadraticSolveParam, quarticSolveParam
    |       |               |
    |       |               +-> used in PossibleZeroQ[..., Assumptions -> ass]
    |       |               +-> used in Simplify[..., Assumptions -> ass]
    |       |                   (TERMINAL: controls simplification assumptions)
    |       |
    |       +-> expandPatternAssumptions[eqns, ass && signAssumptions] -> fullAss
    |               |
    |               +-> passed to simplifySignMap
    |               +-> passed to simplifyWithDummySubstitution
    |               +-> used in verification (PossibleZeroQ, Simplify)
    |
    +-- "Method" -> determines methodTag and allowGroebner
    |               |
    |               +-> allowGroebner passed to sequentialSolve
    |                   (TERMINAL: controls whether GroebnerBasis is attempted)
    |
    +-- "MonomialOrder" -> gbOrderUsed (defaults to Lexicographic)
    |                       |
    |                       +-> passed to sequentialSolve -> GroebnerBasis
    |                           (TERMINAL: MonomialOrder option of GroebnerBasis)
    |
    +-- "ValidationOption" -> controls whether verification block runs
    |                          (TERMINAL: boolean flag)
    |
    +-- "ReturnOption" -> controls which keys are in final output
    |                      (TERMINAL: filters result Association)
    |
    +-- "TimeoutOption" -> timeout
    |       |
    |       +-> TimeConstrained[sequentialSolve[...], N@timeout]
    |       +-> TimeConstrained[FixedPoint[...], N@timeout]
    |       +-> TimeConstrained[verification[...], N@timeout]
    |       +-> derives simpBudget if "SimplifyTimeout" is Automatic
    |           (TERMINAL: controls overall time limits)
    |
    +-- "SimplifyTimeout" -> simpBudget (derived if Automatic)
    |       |
    |       +-> passed to sequentialSolve as simplifyTC parameter
    |       |       |
    |       |       +-> passed to solveLinearFor, quadraticSolveParam, quarticSolveParam
    |       |               |
    |       |               +-> Simplify[..., TimeConstraint -> simplifyTC]
    |       |                   (TERMINAL: TimeConstraint for Simplify)
    |       |
    |       +-> Simplify[coeffMap, TimeConstraint -> simpBudget]
    |       +-> simplifyWithDummySubstitution[..., TimeConstraint -> simpBudget]
    |       +-> Simplify[radicandConditions, TimeConstraint -> simpBudget]
    |       +-> verification Simplify calls
    |
    +-- "DiagnosticsOption" -> diagnosticsQ
    |                           (TERMINAL: currently unused in main flow)
    |
    +-- "OnlyQuadTerms" -> onlyQuadQ
    |                       |
    |                       +-> selectQuadraticSubset[...] if True
    |                           (TERMINAL: controls equation selection)
    |
    +-- "SignSymbol" -> signHead
    |                    |
    |                    +-> passed to sequentialSolve -> makeSignGenerator[signHead]
    |                        (TERMINAL: determines symbol head for sign variables)
    |
    +-- "GroebnerMemoryFraction" -> gbMemFraction
    |       |
    |       +-> Clip[Round[gbMemFraction * MemoryAvailable[]], ...] -> gbMemLimit
    |           |
    |           +-> passed to sequentialSolve -> MemoryConstrained[GroebnerBasis[...], gbMemLimit]
    |               (TERMINAL: memory limit for GroebnerBasis)
    |
    +-- "GroebnerMemoryFloor" -> gbMemFloor
    |                            |
    |                            +-> used in Clip to set minimum memory limit
    |
    +-- "GroebnerMemoryCap" -> gbMemCap
                               |
                               +-> used in Clip to set maximum memory limit
```

**Called from**:
- `ProcessModels.wl` - `solveCoeffsSystem` calls `paramQuadSolve` with options via `"paramQuadSolveOptions"`

---

### Function: `simplifyWithDummySubstitution` (Public)

**Signature**: `simplifyWithDummySubstitution[expr_, opts:OptionsPattern[{simplifyWithDummySubstitution, Simplify}]]`

**Options accepted**:

Custom options:
| Option | Default | Description |
|--------|---------|-------------|
| `"Assumptions"` | `Automatic` | User assumptions (`Automatic` -> `defaultAssumptions[]`, `True` -> `$Assumptions`) |
| `"Level0Pattern"` | `_Symbol[0] \| _Symbol[_][0]` | Pattern for level-0 symbols to transform |
| `"SimplifyFunction"` | `Simplify` | Function to use (`Simplify` or `FullSimplify`) |

Also accepts all `Simplify` options (passed through via `FilterRules`).

**Options flow**:

```
simplifyWithDummySubstitution[expr, opts]
    |
    +-- "Assumptions" -> ass (after Replace: Automatic -> defaultAssumptions[], True -> $Assumptions)
    |       |
    |       +-> combined with dummyPositiveAss -> augmentedAss
    |           |
    |           +-> Assuming[augmentedAss, simplifyFn[...]]
    |               (TERMINAL: assumptions context for simplification)
    |
    +-- "Level0Pattern" -> level0Pattern
    |                       |
    |                       +-> Cases[expr, level0Pattern, Infinity]
    |                           (TERMINAL: pattern matching for exp transforms)
    |
    +-- "SimplifyFunction" -> simplifyFn
    |                          |
    |                          +-> simplifyFn[expr /. allTransformRules, ...]
    |                              (TERMINAL: determines Simplify vs FullSimplify)
    |
    +-- Simplify options (via FilterRules) -> simplifyOpts
                                               |
                                               +-> simplifyFn[..., Sequence @@ simplifyOpts]
                                                   (TERMINAL: passed to Simplify/FullSimplify)
```

**Called from**:
- `paramQuadSolve` (same file) - with `"Assumptions" -> fullAss`, `TimeConstraint -> simpBudget`
- `ProcessModels.wl` - `solveCoeffsSystem` calls with `"Assumptions" -> True`, `"SimplifyFunction" -> FullSimplify`

---

### Function: `expandPatternAssumptions` (Public)

**Signature**: `expandPatternAssumptions[expr_, ass_]`

**Options accepted**: None (not an options-based function)

This function takes two positional arguments and expands pattern-based assumptions by finding matching instances in the expression.

**Called from**:
- `paramQuadSolve` (same file)
- `ProcessModels.wl` - `solveCoeffsSystem`

---

### Private Helper Functions

The following private helper functions use options indirectly through parameters:

#### `sequentialSolve`
**Signature**: `sequentialSolve[polys_List, vars_List, ass_, signHead_, gbOrder_, allowGroebner_, gbMemLimit_, simplifyTC_: 5]`

Receives option values as positional parameters from `paramQuadSolve`:
- `ass` <- from `"Assumptions"`
- `signHead` <- from `"SignSymbol"`
- `gbOrder` <- from `"MonomialOrder"`
- `allowGroebner` <- from `"Method"`
- `gbMemLimit` <- from `"GroebnerMemory*"` options
- `simplifyTC` <- from `"SimplifyTimeout"`

#### `solveLinearFor`
**Signature**: `solveLinearFor[poly_, v_, ass_, simplifyTC_: 5]`

Uses `ass` for `Simplify[..., Assumptions -> ass, TimeConstraint -> simplifyTC]`

#### `quadraticSolveParam`
**Signature**: `quadraticSolveParam[poly_, v_, signGen_, ass_, simplifyTC_: 5]`

Uses `ass` and `simplifyTC` for multiple `Simplify` calls

#### `quarticSolveParam`
**Signature**: `quarticSolveParam[poly_, v_, signGen_, ass_, simplifyTC_: 5]`

Uses `ass` and `simplifyTC` for multiple `Simplify` calls

#### `simplifySquareRoot`
**Signature**: `simplifySquareRoot[radicand_, ass : Except[_List] : Automatic, tc_: 5]`

Uses `ass` (defaults to `defaultAssumptions[]`) and `tc` for `FullSimplify`

#### `simplifySignMap`
**Signature**: `simplifySignMap[signMap_Association, radMap_Association, ass : Except[_List] : Automatic]`

Calls `simplifySquareRoot` with `ass`

#### `buildAssumptions`
**Signature**: `buildAssumptions[userAss_]`

Combines user assumptions with `defaultAssumptions[]`

#### `defaultAssumptions`
**Signature**: `defaultAssumptions[]`

No options - returns combined assumptions from `EndogenousEq` and `Parameters` packages

---

## Summary: Option Dependency Graph

```
paramQuadSolve
    |
    +-- "Assumptions" -----> buildAssumptions -> sequentialSolve -> {solveLinearFor, quadraticSolveParam, quarticSolveParam}
    |                   \--> expandPatternAssumptions -> simplifySignMap, simplifyWithDummySubstitution, verification
    |
    +-- "SimplifyTimeout" -> simpBudget -> sequentialSolve -> {solveLinearFor, quadraticSolveParam, quarticSolveParam}
    |                              \----> simplifyWithDummySubstitution, verification Simplify calls
    |
    +-- "Method" ----------> allowGroebner -> sequentialSolve -> GroebnerBasis (conditional)
    |
    +-- "MonomialOrder" ---> gbOrderUsed -> sequentialSolve -> GroebnerBasis
    |
    +-- "SignSymbol" ------> signHead -> sequentialSolve -> makeSignGenerator
    |
    +-- "GroebnerMemory*" -> gbMemLimit -> sequentialSolve -> MemoryConstrained[GroebnerBasis]
    |
    +-- "DomainOption" ----> (TERMINAL: radicand conditions)
    +-- "ValidationOption" -> (TERMINAL: verification toggle)
    +-- "ReturnOption" -----> (TERMINAL: output filtering)
    +-- "TimeoutOption" ----> (TERMINAL: TimeConstrained calls)
    +-- "DiagnosticsOption" -> (TERMINAL: unused)
    +-- "OnlyQuadTerms" ----> (TERMINAL: selectQuadraticSubset toggle)

simplifyWithDummySubstitution
    |
    +-- "Assumptions" -----> augmentedAss -> Assuming[...]
    +-- "Level0Pattern" ---> (TERMINAL: pattern matching)
    +-- "SimplifyFunction" -> (TERMINAL: Simplify vs FullSimplify)
    +-- Simplify options ---> FilterRules -> simplifyFn[..., opts]
```

---

## Cross-File Option Flow

### From ProcessModels.wl to ParamQuadSolve.wl

```
solveCoeffsSystem[model, opts]
    |
    +-- "paramQuadSolveOptions" -> paramQuadSolve[..., Sequence @@ paramQuadSolveOpts]
    |
    +-- calls expandPatternAssumptions[sysA, modelAssumptions]
    |
    +-- calls simplifyWithDummySubstitution[solA["Conditions"],
            "Assumptions" -> True,
            "SimplifyFunction" -> FullSimplify,
            Sequence @@ simplifyOpts
          ]
```

This allows users to pass options through `solveCoeffsSystem` to `paramQuadSolve` via the `"paramQuadSolveOptions"` meta-option.
