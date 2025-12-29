# Options Flow: ComputeUnconditionalExpectations.wl and CreateEulerEq.wl

This document traces how options flow through functions in the computational engine files for unconditional expectations and Euler equations.

## File: ComputeUnconditionalExpectations.wl

**Location**: `./Kernel/ComputationalEngine/ComputeUnconditionalExpectations.wl`

### Summary

This file contains **no functions that use options** (`OptionsPattern[]`, `OptionValue`, `FilterRules`, etc.). All functions in this file use positional arguments only.

### Functions Analyzed

#### `uncondE[x_, model_]`
- **Options accepted**: None
- **Signature**: `uncondE[x_, model_]`
- **Calls**: `uncondEStep` (no options)
- **Notes**: Public function for unconditional expectations

#### `uncondEStep[expr_, model_]`
- **Options accepted**: None
- **Signature**: `uncondEStep[expr_, model_]`
- **Calls**:
  - `evNoEpsStateVarsProduct` (no options)
  - `cond`Private`lagStateVarst` (from ComputeConditionalExpectations.wl - **has options but not passed here**)
- **Notes**: Internal function that processes expressions through state variable rules. When calling `lagStateVarst`, it uses default options since no options are passed.

#### `evNoEpsStateVarsProduct[expr_, model_, variablesToLag_]`
- **Options accepted**: None
- **Signature**: `evNoEpsStateVarsProduct[expr_, model_, variablesToLag_]`
- **Calls**:
  - `lagStateVarsProduct` (no options)
  - `evNoEps` (no options)
- **Notes**: Internal function for processing products of state variables

#### `evNoEps[model_, variablesToLag_]`
- **Options accepted**: None
- **Signature**: `evNoEps[model_, variablesToLag_]`
- **Returns**: A pattern rule (not a direct function)
- **Notes**: Creates replacement rules for epsilon terms

#### `lagStateVarsProduct[model_, variablesToLag_]`
- **Options accepted**: None
- **Signature**: `lagStateVarsProduct[model_, variablesToLag_]`
- **Returns**: A pattern rule
- **Notes**: Creates replacement rules for lagging state variable products

#### `uncondVar[x_, model_]`
- **Options accepted**: None
- **Signature**: `uncondVar[x_, model_]`
- **Calls**: `uncondE` twice (no options)

#### `uncondCov[x_, y_, model_]`
- **Options accepted**: None
- **Signature**: `uncondCov[x_, y_, model_]`
- **Calls**: `uncondE` three times (no options)

#### `uncondCorr[x_, y_, model_]`
- **Options accepted**: None
- **Signature**: `uncondCorr[x_, y_, model_]`
- **Calls**: `uncondCov`, `uncondVar` (no options)

#### `createSystem[n_, model_]`
- **Options accepted**: None
- **Signature**: `createSystem[n_, model_]`
- **Calls**: `uncondEStep` (no options)
- **Notes**: Creates system of equations for unconditional moments

#### `solveSystem[n_Integer, model_Association, Optional[maxSolveTime_?NumberQ, 60], sys_List:{}]`
- **Options accepted**: None (uses Optional positional argument for maxSolveTime)
- **Signature**: Uses positional argument with default `maxSolveTime = 60`
- **Calls**: `createSystem`, `sol` (no options)
- **Notes**: Solves system with time constraint via positional argument

#### `sol[2, model_, sys_:{}]` and `sol[n_Integer?((#>2) &), model_, sys_]`
- **Options accepted**: None
- **Signature**: Pattern-matched positional arguments
- **Calls**: `createSystem` (no options)
- **Notes**: Recursive solver for moment equations

---

## File: CreateEulerEq.wl

**Location**: `./Kernel/ComputationalEngine/CreateEulerEq.wl`

### Summary

This file contains **no functions that use options** (`OptionsPattern[]`, `OptionValue`, `FilterRules`, etc.). All functions use positional arguments only. However, functions in this file call `lagStateVarst` from ComputeConditionalExpectations.wl indirectly (via `ev`, `var`, `cov`), which does have options.

### Functions Analyzed

#### `eulereq[x_[t_, i___], s_, model_]`
- **Options accepted**: None
- **Signature**: `eulereq[x_[t_, i___], s_, model_]`
- **Calls** (from ComputeConditionalExpectations.wl):
  - `ev[sdf[t], s, model]` - no options passed
  - `var[sdf[t], s, model]` - no options passed
  - `ev[x[t,i], s, model]` - no options passed
  - `var[x[t,i], s, model]` - no options passed
  - `cov[sdf[t], x[t,i], s, model]` - no options passed
- **Options flow**:
  - `ev` -> `lagStateVarst` (uses default options: `"MaxIterations" -> 100`, `"TimeConstraint" -> 30`)
  - `var` -> `ev` -> `lagStateVarst` (uses default options)
  - `cov` -> `ev` -> `lagStateVarst` (uses default options)
- **Notes**: Public function for real Euler equations. Does not expose options for `lagStateVarst` to callers.

#### `nomeulereq[x_[t_, i___], s_, model_]`
- **Options accepted**: None
- **Signature**: `nomeulereq[x_[t_, i___], s_, model_]`
- **Calls** (from ComputeConditionalExpectations.wl):
  - `ev[nomsdf[t], s, model]` - no options passed
  - `var[nomsdf[t], s, model]` - no options passed
  - `ev[x[t,i], s, model]` - no options passed
  - `var[x[t,i], s, model]` - no options passed
  - `cov[nomsdf[t], x[t,i], s, model]` - no options passed
- **Options flow**: Same as `eulereq` - all paths to `lagStateVarst` use default options
- **Notes**: Public function for nominal Euler equations

#### `niceEulerEq[x_[t_, i___], model_, nominalFlag_:False]`
- **Options accepted**: None (uses Optional positional argument for nominalFlag)
- **Signature**: `niceEulerEq[x_[t_, i___], model_, nominalFlag_:False]`
- **Calls**:
  - `eulereq` or `nomeulereq` (based on nominalFlag) - no options
  - `orderingToTarget` - no options
- **Options flow**: Via `eulereq`/`nomeulereq` -> `ev`/`var`/`cov` -> `lagStateVarst` (default options)
- **Notes**: Private function for formatting Euler equations

#### `niceNomEulerEq[x_[t_, i___], model_]`
- **Options accepted**: None
- **Signature**: `niceNomEulerEq[x_[t_, i___], model_]`
- **Calls**: `niceEulerEq[x[t, i], model, True]` - passes `True` for nominalFlag
- **Notes**: Wrapper for nominal Euler equations

#### `orderingToTarget[list_, sourceIds_, targetIds_]`
- **Options accepted**: None
- **Signature**: `orderingToTarget[list_, sourceIds_, targetIds_]`
- **Notes**: Pure utility function for reordering lists

#### `findEulerEqConstants[x_[t_, i___], model_, nominalFlag_:False]`
- **Options accepted**: None (uses Optional positional argument for nominalFlag)
- **Signature**: `findEulerEqConstants[x_[t_, i___], model_, nominalFlag_:False]`
- **Calls**:
  - `niceEulerEq[x[t,i], model, nominalFlag]` - no options
- **Options flow**: Via `niceEulerEq` -> `eulereq`/`nomeulereq` -> `ev`/`var`/`cov` -> `lagStateVarst` (default options)
- **Notes**: Public function for finding Euler equation constants

#### `findBondRecursion[t_, n_, model_]`
- **Options accepted**: None
- **Signature**: `findBondRecursion[t_, n_, model_]`
- **Calls**:
  - `niceEulerEq[bondret[t,n], model]` - no options
  - `niceNomEulerEq[nombondret[t,n], model]` - no options
- **Options flow**: Via `niceEulerEq`/`niceNomEulerEq` -> `eulereq`/`nomeulereq` -> `ev`/`var`/`cov` -> `lagStateVarst` (default options)
- **Notes**: Public function for finding bond recursions

---

## Cross-File Option Dependencies

### Terminal Function with Options

The only function with options that is called (indirectly) from these files is:

#### `lagStateVarst` (ComputeConditionalExpectations.wl)
- **Location**: `./Kernel/ComputationalEngine/ComputeConditionalExpectations.wl`
- **Options**:
  - `"MaxIterations" -> 100` - Maximum iterations for FixedPointList
  - `"TimeConstraint" -> 30` - Timeout in seconds for TimeConstrained
- **Usage**: Controls iteration limits and timeout when converting expressions to state variable form
- **Terminal use**: Uses `OptionValue["MaxIterations"]` and `OptionValue["TimeConstraint"]` directly

### Call Chain Summary

```
ComputeUnconditionalExpectations.wl:
  uncondEStep -> evNoEps -> cond`Private`lagStateVarst (default options)

CreateEulerEq.wl:
  eulereq/nomeulereq -> ev/var/cov -> lagStateVarst (default options)
  niceEulerEq -> eulereq/nomeulereq -> ev/var/cov -> lagStateVarst (default options)
  findEulerEqConstants -> niceEulerEq -> ... -> lagStateVarst (default options)
  findBondRecursion -> niceEulerEq/niceNomEulerEq -> ... -> lagStateVarst (default options)
```

### Note on Option Propagation

Neither file currently propagates options to `lagStateVarst`. This means:
- All calls use default values (`"MaxIterations" -> 100`, `"TimeConstraint" -> 30`)
- Users cannot customize iteration limits or timeouts from the public API of these files
- If customization is needed, it would require adding `OptionsPattern[]` to the call chain
