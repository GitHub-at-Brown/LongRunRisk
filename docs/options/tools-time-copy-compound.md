# Options Flow: TimeAggregation.wl, CopyDefinitions.wl, CompoundScope.wl

## File: TimeAggregation.wl

This file implements time aggregation utilities for computing growth rates of variables over multiple time periods. It contains multiple functions with options.

### Function: `growth`

- **Options accepted**:
  - `"v0"` (default: `Function[{t,j,h,k,v,im},0]`) - function to compute the point around which the power series expansion is performed
  - `"Order"` (default: `1`) - use a power series expansion of this order to compute approximation
  - Also accepts options from `timeSeriesVector` and `g` via `OptionsPattern[{growth,timeSeriesVector,g}]`

- **Options flow**:
  - `"v0"` -> used directly in `growth` to construct `v0args` function for power series expansion point calculation
  - `"Order"` -> used directly in `growth` to control the order of the power series expansion (`O[d]^(n + 1)`)
  - `"TimeAggregation"` -> read via `OptionValue` in `growth`, then passed to `gt` via `optsgt` (filtered to exclude `growth` options)
  - `"numPeriods"` -> read via `OptionValue` in `growth`, then passed to `gt` via `optsgt` (for "Ratio" type, overridden to `1`)
  - `"Variable"` -> read via `OptionValue` in `growth` to determine type ("Flow", "Stock", or "Ratio"), also passed to `gt` via `optsgt`
  - Options flow from `growth` to `gt`:
    - `optsgt = FilterRules[{opts}, Except[Options[growth]]]` (excludes `"v0"` and `"Order"`)
    - `gt[v, t, im, optsgt]` receives filtered options

- **Complete option trace**:
  ```
  growth (accepts options from growth, timeSeriesVector, g)
    |
    +-- "v0" -> TERMINAL: used to compute expansion point in growth
    +-- "Order" -> TERMINAL: used for power series order in growth
    +-- "TimeAggregation" -> passed to gt -> timeSeriesVector -> TERMINAL: controls h parameter
    +-- "numPeriods" -> passed to gt -> timeSeriesVector -> TERMINAL: controls k parameter
    +-- "Variable" -> passed to gt -> g -> TERMINAL: determines variable type handling
  ```

### Function: `g`

- **Options accepted**:
  - `"Variable"` (default: `"Flow"`) - specify if variable is a flow variable, stock variable, or ratio of stock and flow

- **Options flow**:
  - `"Variable"` -> TERMINAL: used directly in `g` via `OptionValue["Variable"]` to determine which calculation to perform:
    - `"Flow"`: computes `s[x1]+f[x2]-f[x3]`
    - `"Stock"`: computes `s[x]` (or recursively calls `g` with truncated input)
    - `"Ratio"`: computes `-f[x2]`
  - When `Length[x]==k*h` and `"Variable"==="Stock"`, returns `s[x]`
  - When `Length[x]==(1+k)*h-1`, uses Switch on type to select computation

### Function: `timeSeriesVector`

- **Options accepted**:
  - `"TimeAggregation"` (default: `1`) - time-aggregate over `h` months
  - `"numPeriods"` (default: `1`) - compute growth rates over `numPeriods` time-aggregated periods

- **Options flow**:
  - `"TimeAggregation"` -> TERMINAL: used directly to compute `h` which determines the time window
  - `"numPeriods"` -> TERMINAL: used directly to compute `k` and subsequently `lastPeriod = (1+k)*h-2` for generating the Table

### Function: `gt`

- **Options accepted**: Options from `timeSeriesVector` and `g` via `OptionsPattern[{timeSeriesVector,g}]`

- **Options flow**:
  - Reads `"TimeAggregation"` and `"numPeriods"` for `h` and `k` parameters
  - `optsTs = FilterRules[{opts}, Options[timeSeriesVector]]` -> passed to `timeSeriesVector`
  - `optsg = FilterRules[{opts}, Options[g]]` -> passed to `g`
  - Calls `g[timeSeriesVector[variable,t,im,optsTs], h, k, optsg]`

- **Complete option trace**:
  ```
  gt (accepts options from timeSeriesVector, g)
    |
    +-- "TimeAggregation" -> read locally AND passed to timeSeriesVector -> TERMINAL
    +-- "numPeriods" -> read locally AND passed to timeSeriesVector -> TERMINAL
    +-- "Variable" -> passed to g -> TERMINAL
  ```

### Function: `f`

- **Options accepted**: None
- This is a helper function that computes a logarithmic sum formula

### Function: `s`

- **Options accepted**: None
- This is a helper function that computes a simple sum (`Plus@@x`)

---

## File: CopyDefinitions.wl

This file provides utilities for copying symbol definitions between symbols or contexts.

### Function: `copyDefinitions`

- **Options accepted**: None
- **Options flow**: N/A

This function uses `SetAttributes[copyDefinitions, HoldAllComplete]` to control evaluation but does not use Wolfram's options pattern. The function operates purely on its positional arguments.

### Function: `symbolQ`

- **Options accepted**: None
- **Options flow**: N/A

This is a helper predicate function with `HoldAllComplete` attribute that checks if an argument is a symbol.

---

## File: CompoundScope.wl

This file implements a compound scoping construct that allows sequential variable assignments where each value can depend on previous values.

### Function: `compoundScope`

- **Options accepted**: None
- **Options flow**: N/A

This function uses `SetAttributes[compoundScope, HoldAll]` to control evaluation but does not use Wolfram's options pattern. It accepts:
- An optional scoping construct (`With`, `Block`, or `Module`, defaulting to `With`)
- A list of assignments or a `CompoundExpression`
- An expression to evaluate

The function processes assignments recursively, wrapping each in the specified scoping construct.

---

## Summary

| File | Functions with Options | Functions without Options |
|------|----------------------|--------------------------|
| TimeAggregation.wl | `growth`, `g`, `timeSeriesVector`, `gt` | `f`, `s` |
| CopyDefinitions.wl | None | `copyDefinitions`, `symbolQ` |
| CompoundScope.wl | None | `compoundScope` |

### Option Dependency Graph for TimeAggregation.wl

```
growth
  |
  +-- owns: "v0", "Order"
  +-- forwards to gt: "TimeAggregation", "numPeriods", "Variable"
        |
        +-- gt
              |
              +-- reads: "TimeAggregation", "numPeriods"
              +-- forwards to timeSeriesVector: "TimeAggregation", "numPeriods"
              |     |
              |     +-- timeSeriesVector (TERMINAL)
              |           uses: "TimeAggregation", "numPeriods"
              |
              +-- forwards to g: "Variable"
                    |
                    +-- g (TERMINAL)
                          uses: "Variable"
```

### Key Observations

- **TimeAggregation.wl** has a well-structured option forwarding pattern where `growth` is the main entry point that accepts all options and forwards appropriate subsets to inner functions using `FilterRules`.

- **CopyDefinitions.wl** and **CompoundScope.wl** do not use the Wolfram Language options pattern (`OptionsPattern[]`, `OptionValue`, etc.). They rely solely on positional arguments and pattern matching.

- All option chains in TimeAggregation.wl terminate within the same file - there are no options passed to functions defined in other files.
