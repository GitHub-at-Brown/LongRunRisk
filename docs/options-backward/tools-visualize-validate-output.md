# Options Flow: VisualizeCoeffs.wl, ValidateModels.wl, NiceOutput.wl

This document traces how options flow through functions in the Tools subsystem of the LongRunRisk package.

---

## File: VisualizeCoeffs.wl

**Location**: `/Kernel/Tools/VisualizeCoeffs.wl`

### Function: `visualizeCoeffs`

**Signature**: `visualizeCoeffs[results_List, opts : OptionsPattern[]]`

- **Options accepted**:
  - `"ShowSelector"` (default: `True`) - Controls whether the interactive coefficient selector panel is displayed
  - `"ShowDetails"` (default: `True`) - Controls whether collapsible bundle details are shown

- **Options flow**:
  - `"ShowSelector"` -> used directly in `visualizeCoeffs` via `OptionValue["ShowSelector"]` to conditionally call `coeffSelector[bundles, numStocks]` (line 786)
  - `"ShowDetails"` -> used directly in `visualizeCoeffs` via `OptionValue["ShowDetails"]` to conditionally call `bundleDetails[results]` (line 794)

- **Terminal use**: Both options are consumed directly by `visualizeCoeffs` to control UI element visibility. They are not passed to any inner functions.

### Other Functions (No Options)

The following helper functions in this file do **not** use options:

- `formatValue[val_]` - Formats numeric values to 2 decimal places
- `formatCoeffName[coeff_]` - Formats coefficient names without context
- `extractBundles[results_List]` - Extracts bundles using `flattenCoeffsBundles`
- `getCoeffValue[bundle_List, ...]` - Gets coefficient value from a bundle
- `getNumStocks[results_List]` - Counts number of stocks from results
- `getMaxAIndex[bundle_List]` - Gets max coefficient index for A
- `getMaxBIndex[bundle_List, jVal_Integer]` - Gets max coefficient index for B
- `getMaxRIndex[bundle_List]` - Gets max bond maturity from bundle
- `getBondYields[bundle_List]` - Extracts bond yields from bundle
- `getMaxPIndex[bundle_List]` - Gets max nominal bond maturity
- `getNomBondYields[bundle_List]` - Extracts nominal bond yields
- `inlineBar[val_, minVal_, maxVal_, color_]` - Creates inline bar indicator
- `keyCoeffsGrid[bundles_List, numStocks_Integer]` - Creates key coefficients grid
- `formatSolutionIndices[indices_List]` - Formats solution indices compactly
- `coeffChart[bundles_List, coeff_, chartColor_]` - Builds chart for a single coefficient
- `bondYieldChart[bundles_List]` - Creates bond yield curve chart
- `nomBondYieldChart[bundles_List]` - Creates nominal bond yield curve chart
- `panelDivider[]` - Creates horizontal divider for panel sections
- `coeffSelector[bundles_List, numStocks_Integer]` - Creates coefficient selector UI
- `bundleDetails[results_List]` - Creates bundle details section
- `formatBundleDetail[bundle_List, results_List, bundleIdx_Integer]` - Formats bundle detail
- `bColor[j_Integer]` - Returns color for stock index

---

## File: ValidateModels.wl

**Location**: `/Kernel/Tools/ValidateModels.wl`

### Options Analysis

**This file contains NO options-related code.**

None of the functions in this file use `OptionsPattern[]`, `OptionValue`, `FilterRules`, or define `Options[...]`.

### Public Functions

- `validateModel[model_Association]` - Validates a single model Association against the schema
- `validateCatalog[catalog_Association]` - Validates all models in a catalog Association

### Private Helper Functions

All helper functions are purely functional without options:

- `getExpectedIndexedParamNames[]` - Gets expected indexed parameter names
- `getParamAssumptions[]` - Gets parameter assumptions as a list of conditions
- `getAssumptionParamName[cond_]` - Extracts parameter name from an assumption
- `getAllowedStateVarSymbols[]` - Gets allowed symbol names in state variables
- `extractStateVarSymbols[expr_]` - Extracts all symbol names from state variable expression
- `containsTimeDependency[expr_]` - Checks if expression contains t-dependency
- `numericValueQ[val_]` - Checks if a value is numeric or evaluates to numeric
- `validParamNameQ[name_]` - Checks if parameter name is valid
- `stripParamIndex[sym_]` - Strips index from parameter name
- `getExpectedParamNames[]` - Gets canonical parameter names from `$parameters`
- `validateStructure[model_, modelName_]` - Validates structure against schema
- `validateStateVars[stateVars_, modelName_]` - Validates stateVars list
- `validateParameters[params_, modelName_]` - Validates parameters list
- `issueMessage[error_Association]` - Issues appropriate message for error type

---

## File: NiceOutput.wl

**Location**: `/Kernel/Tools/NiceOutput.wl`

### Function: `numberFormattingTemplate`

**Signature**: `numberFormattingTemplate[num_, opts:OptionsPattern[]]`

- **Options accepted**: Any options compatible with `ToString` (inherited via `OptionsPattern[]` without explicit `Options[numberFormattingTemplate]` definition)

- **Options flow**:
  - All options -> `FilterRules[{opts}, Options[ToString]]` -> passed to `ToString[N@num, InputForm, ..., NumberMarks->False]`

- **Terminal use**: `ToString` (Wolfram Language built-in) - Options are filtered to those valid for `ToString` and passed directly. This is the terminal destination.

- **Note**: This function uses the implicit `OptionsPattern[]` pattern without defining its own `Options[numberFormattingTemplate]`. This means it can accept any options, but only those compatible with `ToString` will have any effect due to `FilterRules`.

### Public Functions (No Options)

- `info[m_Association]` - Displays a table with information for each model
- `formatModels[m_Association]` - Re-writes an association of models as a Cell object
- `toCatalog[m_Association, keysToKeep_List]` - Re-writes an association of models with selected keys

### Private Helper Functions (No Options)

- `createEqTables[m_]` - Adds nicely formatted tables with exogenous equations to each model
- `infoTable[m_]` - Creates OpenerView with model information
- `paramTable[m_]` - Creates table of parameters in a model
- `allParamTable[m_]` - Creates table of all parameters
- `iToNum[s_String]` - Replaces `i` placeholder with integers
- `iToNum[s_String, numStocks_Integer]` - Table version of iToNum
- `modelFormattingTemplate[model_Association, ...]` - Creates Cell object with nice formatting
- `stringFormattingTemplate[str_String, lineLength_Number]` - Formats strings with line breaks
- `normalizeWhitespace[str_String]` - Normalizes whitespace before formatting
- `stripContext[x_]` - Strips context from symbols
- `separator[lineLength_Number]` - Creates separator RowBox

### Associations (No Options)

- `modelToTeX` - Association between Mathematica variables and LaTeX representation
- `TeXToModel` - Reverse of modelToTeX
- `modelToTeXStocks` - Stock-specific parameters mapping
- `modelToTeXNoStocks` - Non-stock parameters mapping

---

## Summary

| File | Functions with Options | Options Pattern |
|------|------------------------|-----------------|
| VisualizeCoeffs.wl | 1 (`visualizeCoeffs`) | Custom options: `"ShowSelector"`, `"ShowDetails"` |
| ValidateModels.wl | 0 | N/A |
| NiceOutput.wl | 1 (`numberFormattingTemplate`) | Implicit (passes to `ToString`) |

### Option Flow Diagrams

#### VisualizeCoeffs.wl
```
visualizeCoeffs
    |
    +-- "ShowSelector" --> [TERMINAL] controls coeffSelector[] call
    |
    +-- "ShowDetails" --> [TERMINAL] controls bundleDetails[] call
```

#### NiceOutput.wl
```
numberFormattingTemplate
    |
    +-- opts --> FilterRules[{opts}, Options[ToString]]
                     |
                     +-- ToString (Wolfram built-in) [TERMINAL]
```
