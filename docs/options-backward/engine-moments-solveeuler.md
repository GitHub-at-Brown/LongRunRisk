# Options Flow: CreateMomentsDatabase.wl and SolveEulerEq.wl

This document traces how options flow through functions in these two computational engine files.

---

## File: CreateMomentsDatabase.wl

**Location**: `/Kernel/ComputationalEngine/CreateMomentsDatabase.wl`

This file provides functions for computing unconditional covariances and creating moment databases for model solving.

---

### Function: `uncondCovLongExo`

```wolfram
uncondCovLongExo[model_, expression1_, expression2_, covfun_, opts : OptionsPattern[{uncondCovLongExo}]]
```

**Options accepted**:
- `"IterationLimit"` -> `$IterationLimit/4` (default)

**Options flow**:
- `"IterationLimit"` -> **used directly** in `Block[{$IterationLimit = OptionValue["IterationLimit"]}, ...]` to limit iteration depth when computing covariances (line 198)

**Called by**:
- `uncondVarLongExo` (passes all options through)
- `uncondCovLong` (private function, passes all options through)
- `uncondVarLong` (private function, passes all options through)
- `totCovLong` (passes all options through)

---

### Function: `uncondVarLongExo`

```wolfram
uncondVarLongExo[model_, expression_, covfun_, opts : OptionsPattern[{uncondCovLongExo}]]
```

**Options accepted**:
- Inherits from `uncondCovLongExo`: `"IterationLimit"`

**Options flow**:
- All options -> passed to `uncondCovLongExo[model, expression, expression, covfun, opts]`

---

### Function: `createDatabase`

```wolfram
createDatabase[model_Association, covLongFilename_String, opts : OptionsPattern[{createDatabase, uncondCovLongExo}]]
```

**Options accepted**:
- `"maxMomentsLagsToCreate"` -> `8` (default)
- `"startSequenceAtLag"` -> `3` (default)
- `"simplifyDownValues"` -> `False` (default)
- Inherits from `uncondCovLongExo`: `"IterationLimit"`

**Options flow**:
- `"maxMomentsLagsToCreate"` -> **used directly** as `maxLag` to determine range of lags computed (lines 354-355, 393-394, 425-426)
- `"startSequenceAtLag"` -> **used directly** as `seqStart` to determine where sequence function patterns begin (lines 359-367, 395-404, 427-436)
- `"simplifyDownValues"` -> **used directly** to control whether `DownValues` are simplified with `Simplify` (line 593)
- `uncondCovLongExo` options -> extracted via `FilterRules[Flatten[{opts}], Options[uncondCovLongExo]]` and stored in `uncondCovLongExoOpts`, then passed to `totCovLong` when creating memoized rules (line 588)

**Internal option forwarding chain**:
```
createDatabase
  |-> uncondCovLongExoOpts (filtered)
        |-> totCovLong[..., opts]
              |-> uncondCovLong[..., opts]
                    |-> uncondCovLongExo[..., opts]
                          |-> OptionValue["IterationLimit"] (terminal use)
```

---

### Function: `totCovLong` (Private)

```wolfram
totCovLong[x_, y_, s_, model_Association, fun_, opts : OptionsPattern[{uncondCovLongExo}]]
```

**Options accepted**:
- Inherits from `uncondCovLongExo`: `"IterationLimit"`

**Options flow**:
- All options -> passed to `uncondCovLong[..., opts]`

**Calls (no options)**:
- `uncondE[...]` (from `ComputeUnconditionalExpectations`) - **no options**
- `cov[...]` (from `ComputeConditionalExpectations`) - **no options**
- `ev[...]` (from `ComputeConditionalExpectations`) - **no options**

---

### Function: `uncondCovLong` (Private)

```wolfram
uncondCovLong[model_, expr1_, expr2_, covfun_, opts : OptionsPattern[{uncondCovLongExo}]]
```

**Options accepted**:
- Inherits from `uncondCovLongExo`: `"IterationLimit"`

**Options flow**:
- All options -> passed directly to `uncondCovLongExo[..., opts]`

---

### Function: `uncondVarLong` (Private)

```wolfram
uncondVarLong[model_, expr_, covfun_, opts : OptionsPattern[{uncondCovLongExo}]]
```

**Options accepted**:
- Inherits from `uncondCovLongExo`: `"IterationLimit"`

**Options flow**:
- All options -> passed directly to `uncondVarLongExo[..., opts]`

---

### Functions Without Options

The following functions in this file do **not** accept options:
- `validArgsQ[components_]`
- `powerToProduct[expr_, t_]`
- `plusToList[expr_]`
- `split[expr_]`
- `epsQ[x_]`
- `modelVarQ[x_]`
- `covLongToUncondCov[components_]`
- `ap[expr_, {pos_, q_}]`
- `rp[expr_, {pos_, i_}]`
- `partitionConditions[expr_]`
- `partitionBy[expr_]`
- `categorize[expr_]`
- `splitAndFindSequenceFunction[expr_, q_]`
- `seqfun[list_, q_, v1_, v2_]`

---

## File: SolveEulerEq.wl

**Location**: `/Kernel/ComputationalEngine/SolveEulerEq.wl`

This file provides functions for solving Euler equations to find model coefficients.

---

### Function: `updateCoeffs`

```wolfram
updateCoeffs[args__]
```

**Options accepted** (inherited from `updateCoeffsSol` and `checks`):
- `"initialGuess"` -> `<|"Ewc"->{4},"Epd"->{{4}}|>`
- `"FindRootOptions"` -> `{}`
- `"RecurrenceTableOptions"` -> `{"DependentVariables"->Automatic}`
- `"UpdatePd"` -> `False`
- `"UpdateBond"` -> `False`
- `"UpdateNomBond"` -> `False`
- `"UpdateBonds"` -> `False`
- `"MaxMaturity"` -> `12`
- `"RootSigns"` -> `Automatic`
- `"PrintResidualsNorm"` -> `False`
- `"CheckResiduals"` -> `False`
- `"Tol"` -> `10.^-16`

**Options flow**:
- All options -> parsed via `ArgumentsOptions` with `"ExtraOptions"->{checks, FindRoot, RecurrenceTable}`, then passed to `updateCoeffsSol`

---

### Function: `updateCoeffsSol`

```wolfram
updateCoeffsSol[model_Association, savedKernels_Association, newParameters_List, guessCoeffsSolution_List,
  opts : OptionsPattern[{updateCoeffsSol, solveCoeffRoots, checks, FindRoot, RecurrenceTable}]]
```

**Options accepted**:
- `"initialGuess"` -> `<|"Ewc"->{4},"Epd"->{{4}}|>`
- `"FindRootOptions"` -> `{}`
- `"RecurrenceTableOptions"` -> `{"DependentVariables"->Automatic}`
- `"UpdatePd"` -> `False`
- `"UpdateBond"` -> `False`
- `"UpdateNomBond"` -> `False`
- `"UpdateBonds"` -> `False`
- `"MaxMaturity"` -> `12`
- `"RootSigns"` -> `Automatic`
- Inherits from `solveCoeffRoots` (via `OptionsPattern`)
- Inherits from `checks`: `"PrintResidualsNorm"`, `"CheckResiduals"`, `"Tol"`
- Inherits from `FindRoot`: `MaxIterations`, `AccuracyGoal`, `PrecisionGoal`, etc.
- Inherits from `RecurrenceTable`: `"DependentVariables"`, etc.

**Options flow**:
- `"MaxMaturity"` -> **used directly** for bond computation range
- `"RootSigns"` -> passed to `normalizeRootSigns` then to `updateCoeffsWcPd`
- `"UpdatePd"`, `"UpdateBond"`, `"UpdateNomBond"`, `"UpdateBonds"` -> **used directly** to control what gets computed
- `"PrintResidualsNorm"`, `"CheckResiduals"` -> **used directly** to determine if checks run
- `solveOpts` = `FilterRules[{opts}, Options[updateCoeffsSol]]` -> passed to `computeWcCoeffs` and `computePdCoeffs`
- `checkOpts` = `FilterRules[{opts}, Options[checks]]` -> passed to `checkCoeffs` -> `checks`
- `recurrenceOpts` = `FilterRules[{opts}, Options[RecurrenceTable]]` + `OptionValue["RecurrenceTableOptions"]` -> passed to `updateCoeffsBond`

**Internal option forwarding chain**:
```
updateCoeffsSol
  |-> computeWcCoeffs[..., solveOpts]
  |     |-> updateCoeffsWcPd[..., solveOpts]
  |           |-> solveCoeffRoots[..., solveOpts] (see below)
  |
  |-> computePdCoeffs[..., solveOpts]
  |     |-> updateCoeffsWcPd[..., solveOpts]
  |           |-> solveCoeffRoots[..., solveOpts]
  |
  |-> updateCoeffsBond[..., recurrenceOpts]
  |     |-> RecurrenceTable (via FilterRules)
  |
  |-> checkCoeffs[..., checkOpts]
        |-> checks[..., checkOpts]
              |-> OptionValue["CheckResiduals"] (terminal)
              |-> OptionValue["PrintResidualsNorm"] (terminal)
              |-> OptionValue["Tol"] (terminal)
```

---

### Function: `solveCoeffRoots`

```wolfram
solveCoeffRoots[quadSol_Association, savedKernel_Association, paramsBase_Association,
  signs : ({} | {_Integer ..}) : {}, extraParams_Association : <||>,
  opts : OptionsPattern[{solveCoeffRoots, findRootInterval, extractIntervalsFromReduce, scanAndSolve, fastRoot, FindRoot}]]
```

**Options accepted** (all inherited via `OptionsPattern`):
- From `findRootInterval`: `"CoeffName"`, `"SignSymbol"`, `"Signs"`
- From `extractIntervalsFromReduce`: `"InteriorShrink"`, `"RootUpperBound"`, `"UnboundedPad"`
- From `scanAndSolve`: `"BracketGrid"`, `"Tolerance"`, `"FastRootOptions"`, `"FindRootOptions"`
- From `fastRoot`: `Jacobian`, `Method`, `"SecantBlend"`, `"Return"`, `"FindRootOptions"`
- From `FindRoot`: `MaxIterations`, `AccuracyGoal`, `PrecisionGoal`, `WorkingPrecision`, `StepMonitor`, etc.

**Options flow**:
- `findOpts` = `FilterRules[{opts}, Options[findRootInterval]]` -> passed to `findRootInterval`
- `extractOpts` = `FilterRules[{opts}, Options[extractIntervalsFromReduce]]` -> passed to `extractIntervalsFromReduce`
- `scanOpts` = `FilterRules[{opts}, Join[Options[scanAndSolve], Options[FindRoot], Options[fastRoot]]]` -> passed to `scanAndSolve`

**For 1D case**:
```
solveCoeffRoots (1D)
  |-> findRootInterval[conds, paramsAll, "Signs"->signs, "CoeffName"->cName, "SignSymbol"->sName, findOpts...]
  |     |-> OptionValue["CoeffName"] (terminal)
  |     |-> OptionValue["SignSymbol"] (terminal)
  |     |-> OptionValue["Signs"] (terminal)
  |
  |-> extractIntervalsFromReduce[reduceExpr, coefList, extractOpts...]
  |     |-> OptionValue["InteriorShrink"] (terminal)
  |     |-> OptionValue["RootUpperBound"] (terminal)
  |     |-> OptionValue["UnboundedPad"] (terminal)
  |
  |-> scanAndSolve[f, df, interval, scanOpts...]
        |-> fastRoot[f, interval, Jacobian->df, scanOpts...]
              |-> FindRoot[..., FindRoot options]
```

**For nD case** (Length[coefList] > 1):
```
solveCoeffRoots (nD)
  |-> solveND[f, df, conds, paramsAll, signs, coefList, cName, sName,
              findOpts, extractOpts, scanOpts, quadSol["Solution"], "ReduceTimeLimit"->5.]
        |-> safeReduceCall[..., findOpts, timeout]
        |     |-> findRootInterval[..., findOpts] (with TimeConstrained)
        |
        |-> trySmartIntervals[f, df, reduceExpr, coefList, extractOpts, scanOpts, ...]
        |     |-> extractIntervalsFromReduce[..., extractOpts]
        |     |-> fastRoot[f, {x0, aFinite, bFinite}, Jacobian->df, scanOpts...]
        |
        |-> tryArtificialBox[f, df, coefList, scanOpts, ...]
        |     |-> fastRoot[..., scanOpts]
        |
        |-> nMinimizeFallback[f, coefList, reduceExpr, ...]
              |-> NMinimize[..., Method->"NelderMead"]
```

---

### Function: `solveND`

```wolfram
solveND[f_, df_, conds_, paramsAll_, signs_, coefList_, cName_, sName_,
        findOpts_, extractOpts_, scanOpts_, solTemplate_,
        opts : OptionsPattern[{solveND}]]
```

**Options accepted**:
- `"ReduceTimeLimit"` -> `5.` (default)

**Options flow**:
- `"ReduceTimeLimit"` -> **used directly** as timeout for `safeReduceCall`
- `rub` = `Lookup[extractOpts, "RootUpperBound", 15.]` -> used for bounds
- `pad` = `Lookup[extractOpts, "UnboundedPad", 1.*^5]` -> used for padding
- `acc` = `AccuracyGoal /. scanOpts /. AccuracyGoal -> 8` -> used for tolerance computation

---

### Function: `updateCoeffsBond`

```wolfram
updateCoeffsBond[modelCoeffsSolution_, modelParameters_, newParameters_, maxMaturity_, coeffsWc_,
  opts : OptionsPattern[{RecurrenceTable}]]
```

**Options accepted**:
- All `RecurrenceTable` options

**Options flow**:
- `FilterRules[{opts}, Options[RecurrenceTable]]` -> passed to `RecurrenceTable` calls within the model's coefficient solution expressions

---

### Function: `checks`

```wolfram
checks[eqs_, sol_, params_, newParams_, opts : OptionsPattern[]]
```

**Options accepted**:
- `"PrintResidualsNorm"` -> `False`
- `"CheckResiduals"` -> `False`
- `"Tol"` -> `10.^-16`

**Options flow**:
- `"CheckResiduals"` -> **used directly** to determine whether to abort on large residuals
- `"PrintResidualsNorm"` -> **used directly** to determine whether to print residual norms
- `"Tol"` -> **used directly** as tolerance threshold for residual checking

---

### Function: `solveWcPdRoots`

```wolfram
solveWcPdRoots[model_Association, savedKernelWc_Association, savedKernelPd_Association,
  signsWc_, signsPd_, extraParams_Association : <||>,
  opts : OptionsPattern[solveCoeffRoots]]
```

**Options accepted**:
- All `solveCoeffRoots` options (via inheritance)

**Options flow**:
- `optSeq = FilterRules[{opts}, Options[solveCoeffRoots]]` -> passed to `solveCoeffRoots` for both wc and pd

---

### Function: `getStartingValues`

```wolfram
getStartingValues[ratio_String, infoModel_Association : <||>, opts : OptionsPattern[{getStartingValues}]]
```

**Options accepted**:
- `"initialGuess"` -> `<|"Ewc" -> {4}, "Epd" -> {{4}}|>`

**Options flow**:
- `"initialGuess"` -> **used directly** to extract starting values for root finding

---

### Function: `addCoeffsSolutionN`

```wolfram
addCoeffsSolutionN[model_]
```

**Options accepted**: None (hardcoded options)

**Internal calls with hardcoded options**:
```wolfram
updateCoeffs[model, k,
  "UpdatePd"->True,
  "UpdateBonds"->True,
  "MaxMaturity"->12,
  "RootSigns" -> All
]
```

---

### Function: `flattenCoeffs`

**Options accepted**: None

---

### Function: `flattenCoeffsBundles`

**Options accepted**: None

---

### Functions in FindRootOptim.wl (Called by SolveEulerEq.wl)

These functions are defined in `/Kernel/Tools/FindRootOptim.wl` and are called by `solveCoeffRoots`:

#### `findRootInterval`

```wolfram
findRootInterval[conds_, paramValues_Association, opts : OptionsPattern[{findRootInterval}]]
```

**Options accepted**:
- `"CoeffName"` -> `"A"`
- `"SignSymbol"` -> `"signA"`
- `"Signs"` -> `{}`

**Options flow**:
- All options -> **used directly** for Reduce-based interval computation

---

#### `extractIntervalsFromReduce`

```wolfram
extractIntervalsFromReduce[reduceExpr_, rootVars_, opts : OptionsPattern[{extractIntervalsFromReduce}]]
```

**Options accepted**:
- `"InteriorShrink"` -> `0.001`
- `"RootUpperBound"` -> `15`
- `"UnboundedPad"` -> `1.*^5`

**Options flow**:
- All options -> **used directly** for interval extraction and padding

---

#### `scanAndSolve`

```wolfram
scanAndSolve[f_, df_, {a_, b_}, opts : OptionsPattern[{scanAndSolve, FindRoot, fastRoot}]]
scanAndSolve[f_, {a_, b_}, opts : OptionsPattern[{scanAndSolve, FindRoot, fastRoot}]]
```

**Options accepted**:
- `"BracketGrid"` -> `32`
- `"Tolerance"` -> `Automatic`
- `"FastRootOptions"` -> `{}`
- `"FindRootOptions"` -> `Automatic`
- All `FindRoot` options
- All `fastRoot` options

**Options flow**:
- `"BracketGrid"` -> **used directly** for grid subdivision count
- `"Tolerance"` -> **used directly** for zero-detection tolerance
- `"FindRootOptions"` -> passed to `fastRoot`
- `FilterRules[{opts}, Options[FindRoot]]` -> combined with `"FindRootOptions"` and passed to `fastRoot`
- `FilterRules[{opts}, Options[fastRoot]]` -> passed to `fastRoot`

---

#### `fastRoot`

```wolfram
fastRoot[f_, spec_, opts : OptionsPattern[{fastRoot, FindRoot}]]
```

**Options accepted**:
- `Jacobian` -> `None`
- `Method` -> `Automatic`
- `"SecantBlend"` -> `0.5`
- `"Return"` -> `"Value"`
- `"FindRootOptions"` -> `Automatic`
- All `FindRoot` options

**Options flow**:
- `Jacobian` -> **used directly** to provide derivative function
- `Method` -> **used directly** to select solving method (`"Newton"`, `"Brent"`, `"Secant"`, or `Automatic`)
- `"SecantBlend"` -> **used directly** for initial guess blending
- `"Return"` -> **used directly** to control output format
- `"FindRootOptions"` + `FilterRules[{opts}, Options[FindRoot]]` -> passed to internal `FindRoot` calls

---

## Summary: Complete Option Flow Diagram

```
updateCoeffs (entry point)
  |
  +-> updateCoeffsSol
        |
        +-> [Direct use] "MaxMaturity", "UpdatePd", "UpdateBond", "UpdateNomBond",
        |                "UpdateBonds", "RootSigns", "PrintResidualsNorm", "CheckResiduals"
        |
        +-> computeWcCoeffs/computePdCoeffs -> updateCoeffsWcPd -> solveCoeffRoots
        |     |
        |     +-> findRootInterval (FindRootOptim.wl)
        |     |     +-> [Direct use] "CoeffName", "SignSymbol", "Signs"
        |     |
        |     +-> extractIntervalsFromReduce (FindRootOptim.wl)
        |     |     +-> [Direct use] "InteriorShrink", "RootUpperBound", "UnboundedPad"
        |     |
        |     +-> scanAndSolve (FindRootOptim.wl)
        |           +-> [Direct use] "BracketGrid", "Tolerance"
        |           +-> fastRoot (FindRootOptim.wl)
        |                 +-> [Direct use] Jacobian, Method, "SecantBlend", "Return"
        |                 +-> FindRoot (built-in)
        |                       +-> [Direct use] MaxIterations, AccuracyGoal,
        |                                        PrecisionGoal, StepMonitor, etc.
        |
        +-> updateCoeffsBond
        |     +-> RecurrenceTable (built-in)
        |           +-> [Direct use] "DependentVariables", etc.
        |
        +-> checks
              +-> [Direct use] "PrintResidualsNorm", "CheckResiduals", "Tol"


createDatabase
  |
  +-> [Direct use] "maxMomentsLagsToCreate", "startSequenceAtLag", "simplifyDownValues"
  |
  +-> totCovLong -> uncondCovLong -> uncondCovLongExo
        +-> [Direct use] "IterationLimit"
```

---

## Functions Without Options

### CreateMomentsDatabase.wl
- `validArgsQ`, `powerToProduct`, `plusToList`, `split`, `epsQ`, `modelVarQ`
- `covLongToUncondCov`, `ap`, `rp`, `partitionConditions`, `partitionBy`
- `categorize`, `splitAndFindSequenceFunction`, `seqfun`

### SolveEulerEq.wl
- `signHeadFromExpr`, `safeReduceCall` (options passed through)
- `convertInfinityBounds`, `trySmartIntervals`, `tryArtificialBox`, `nMinimizeFallback`
- `loadModelKernels`, `clearKernelCache`
- `normalizeRootSigns`, `filterSolutions`, `extractSignIndex`
- `computeWcCoeffs`, `computePdCoeffs`, `checkCoeffs` (these forward options but don't declare their own)
- `flattenCoeffs`, `flattenCoeffsBundles`, `flattenCoeffsBundlesForA`

### ComputeConditionalExpectations.wl (called by CreateMomentsDatabase.wl)
- `ev`, `var`, `cov`, `corr` - **no options**
- `lagStateVarst` - has internal options (`"MaxIterations"`, `"TimeConstraint"`) but they are **not exposed** to callers

### ComputeUnconditionalExpectations.wl (called by CreateMomentsDatabase.wl)
- `uncondE`, `uncondVar`, `uncondCov`, `uncondCorr` - **no options**
