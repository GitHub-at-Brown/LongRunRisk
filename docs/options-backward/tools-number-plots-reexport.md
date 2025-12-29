# Options Flow: ToNumber.wl, NicePlots.wl, ReExport.wl

This document traces how options flow through functions in these three tool files.

---

## File: ToNumber.wl

**Location**: `/Kernel/Tools/ToNumber.wl`

### Function: `toNumRules`

This is the core internal function that handles options.

- **Options accepted**: `OptionsPattern[{updateCoeffs}]`
  - Inherits all options from `updateCoeffs` (defined in `SolveEulerEq.wl`)

- **Options flow**:
  ```
  opts : OptionsPattern[{updateCoeffs}]
    |
    +-> FilterRules[Flatten@{opts}, Flatten[Options/@{updateCoeffs}]]
    |     |
    |     +-> optsUpdateCoeffs (local variable)
    |           |
    |           +-> updateCoeffs[model, kernels, allParams, guessCoeffsSolution,
    |                            "UpdatePd"->True, "UpdateBond"->True, optsUpdateCoeffs]
    |                 |
    |                 +-> (SolveEulerEq.wl) updateCoeffs -> updateCoeffsSol
    |                       |
    |                       +-> Options forwarded to FindRoot, RecurrenceTable, checks
    |                             |
    |                             +-> Terminal uses in Wolfram built-in functions
  ```

- **Terminal destinations**:
  - `updateCoeffs` options -> `updateCoeffsSol` -> various internal functions:
    - `"initialGuess"` -> used directly in `updateCoeffsSol` to set initial FindRoot values
    - `"FindRootOptions"` -> forwarded to `FindRoot` (built-in, terminal)
    - `"RecurrenceTableOptions"` -> forwarded to `RecurrenceTable` (built-in, terminal)
    - `"UpdatePd"`, `"UpdateBond"`, `"UpdateNomBond"`, `"UpdateBonds"` -> used directly in `updateCoeffsSol` to control computation
    - `"MaxMaturity"` -> used directly to control bond recursion depth
    - `"RootSigns"` -> used directly to control sign selection in quadratic solutions
    - `"PrintResidualsNorm"`, `"CheckResiduals"`, `"Tol"` -> used directly in `checks` function

### Function: `toNum` (public wrappers)

Multiple overloads exist but none use OptionsPattern directly. They call `toNumRules` internally.

- **Options accepted**: None directly - these are wrapper functions
- **Options flow**: Delegated to `toNumRules` via `rest__` arguments

### Functions without options

The following functions in ToNumber.wl do NOT use options:
- `toEquation` - No OptionsPattern
- `toExogenousVars` - No OptionsPattern
- `toStateVars` - No OptionsPattern
- `processNewParameters` - No OptionsPattern
- `GlobalProperties` - No OptionsPattern
- `clone` - No OptionsPattern
- `withUserDefs` - No OptionsPattern
- `moms` - No OptionsPattern
- `modelEval` - No OptionsPattern

---

## File: NicePlots.wl

**Location**: `/Kernel/Tools/NicePlots.wl`

### Function: `yieldCurve`

- **Options accepted**: `OptionsPattern[{yieldCurve, updateCoeffs, FindRoot, RecurrenceTable}]`
  - Own options defined: `"MaxMaturity" -> 12`, `"MomentFunction" -> uncondE`
  - Inherits from: `updateCoeffs`, `FindRoot`, `RecurrenceTable`

- **Options flow**:
  ```
  opts : OptionsPattern[{yieldCurve, updateCoeffs, FindRoot, RecurrenceTable}]
    |
    +-> OptionValue[yieldCurve, "MaxMaturity"]
    |     +-> Used directly: controls loop iterations (Table[..., {mm, maxMaturity}])
    |
    +-> OptionValue[yieldCurve, "MomentFunction"]
    |     +-> Used directly: selects moment function (uncondE by default)
    |
    +-> FilterRules[Flatten@{opts}, Join[Options[updateCoeffs], Options[FindRoot], Options[RecurrenceTable]]]
    |     +-> updateOpts
    |           +-> updateCoeffs[model, newParams, {}, Sequence @@ updateOpts]
    |                 +-> (SolveEulerEq.wl) -> updateCoeffsSol
    |                       +-> FindRoot, RecurrenceTable (built-in, terminal)
    |
    +-> FilterRules[Flatten@{opts}, Options[RecurrenceTable]]
          +-> recurrenceOpts
                +-> updateCoeffsBond[..., Sequence @@ recurrenceOpts]
                      +-> RecurrenceTable (built-in, terminal)
  ```

- **Terminal destinations**:
  - `"MaxMaturity"` -> used directly in `yieldCurve` for Table iteration and passed to `updateCoeffsBond`
  - `"MomentFunction"` -> used directly in `yieldCurve` to select moment computation function
  - All `updateCoeffs` options -> forwarded to `updateCoeffs` (see ToNumber.wl documentation above)
  - All `FindRoot` options -> forwarded to `FindRoot` (built-in, terminal)
  - All `RecurrenceTable` options -> forwarded to `RecurrenceTable` (built-in, terminal)

### Function: `plotCoeffs`

- **Options accepted**: `opts: OptionsPattern[]` (bare OptionsPattern with no specification)
  - Accepts any options

- **Options flow**:
  ```
  opts : OptionsPattern[]
    |
    +-> Flatten @ {opts}
          +-> ResourceFunction["FindRootPlot"][Last@eq0, ic0, Flatten @ {opts}]
                +-> (ResourceFunction, external)
                      +-> Terminal: passed to FindRootPlot resource function
  ```

- **Terminal destinations**:
  - All options -> forwarded to `ResourceFunction["FindRootPlot"]` (external resource function, terminal)
  - This resource function likely forwards relevant options to `FindRoot` internally

---

## File: ReExport.wl

**Location**: `/Kernel/Tools/ReExport.wl`

### Summary

**This file contains NO options-related code.**

### Function: `reExport[f_Symbol, g_Symbol]`

- **Options accepted**: None
- **Options flow**: N/A - no options used
- **Description**: Copies definitions from symbol `f` to symbol `g` using `copyDefinitions`

### Function: `reExport[oldContext_String, Optional[newContext_String, ...]]`

- **Options accepted**: None
- **Options flow**: N/A - no options used
- **Description**: Exports all public symbols from one context to another with capitalized names

---

## Summary Table

| File | Function | Has Options | Options Inherited From | Terminal Destinations |
|------|----------|-------------|----------------------|----------------------|
| ToNumber.wl | `toNumRules` | Yes | `updateCoeffs` | `FindRoot`, `RecurrenceTable`, `checks` (internal) |
| ToNumber.wl | `toNum` | No (delegates) | - | Via `toNumRules` |
| ToNumber.wl | Other functions | No | - | - |
| NicePlots.wl | `yieldCurve` | Yes | `yieldCurve`, `updateCoeffs`, `FindRoot`, `RecurrenceTable` | `FindRoot`, `RecurrenceTable`, `updateCoeffsBond` |
| NicePlots.wl | `plotCoeffs` | Yes | (bare OptionsPattern) | `ResourceFunction["FindRootPlot"]` |
| ReExport.wl | `reExport` | No | - | - |

---

## Option Inheritance Chain

```
yieldCurve / toNumRules
    |
    +-> updateCoeffs (SolveEulerEq.wl)
          |
          +-> updateCoeffsSol
          |     +-> "initialGuess" (used directly)
          |     +-> "FindRootOptions" -> FindRoot (built-in)
          |     +-> "RecurrenceTableOptions" -> RecurrenceTable (built-in)
          |     +-> "UpdatePd", "UpdateBond", etc. (used directly)
          |     +-> "MaxMaturity" (used directly)
          |     +-> "RootSigns" (used directly)
          |
          +-> checks
                +-> "PrintResidualsNorm" (used directly)
                +-> "CheckResiduals" (used directly)
                +-> "Tol" (used directly)
```

---

## Cross-File Dependencies

| From File | Function | Calls | In File |
|-----------|----------|-------|---------|
| ToNumber.wl | `toNumRules` | `updateCoeffs` | SolveEulerEq.wl |
| NicePlots.wl | `yieldCurve` | `updateCoeffs` | SolveEulerEq.wl |
| NicePlots.wl | `yieldCurve` | `updateCoeffsBond` | SolveEulerEq.wl |
| NicePlots.wl | `yieldCurve` | `processNewParameters` | ToNumber.wl |
| NicePlots.wl | `plotCoeffs` | `processNewParameters` | ToNumber.wl |
| ReExport.wl | `reExport` | `copyDefinitions` | CopyDefinitions.wl |
| ReExport.wl | `reExport` | `compoundScope` | CompoundScope.wl |
