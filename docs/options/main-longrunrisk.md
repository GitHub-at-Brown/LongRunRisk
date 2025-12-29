# Options Flow: LongRunRisk.wl (Main Package File)

This document traces how options flow through functions defined or re-exported in the main package file `/Kernel/LongRunRisk.wl`.

## Overview

The main package file `LongRunRisk.wl` serves primarily as an orchestrator that:
1. Loads dependencies via `Needs` statements
2. Re-exports functions from sub-packages using `reExport`
3. Defines a few wrapper functions (like `UncondCov`, `UncondVar`, `UncondCorr`, `Info`)

Most functions with complex options are defined in the sub-packages and re-exported to the main `FernandoDuarte`LongRunRisk`` context.

---

## File: LongRunRisk.wl

### Functions Defined Directly in This File

#### Function: `UncondCov`
- **Options accepted**: None (no `OptionsPattern[]`)
- **Signature**: `UncondCov[x_, y_, model_]`
- **Options flow**:
  - No options accepted
  - Calls `FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`uncondCovLongExo[model, x, y, covLong]` without passing options

#### Function: `UncondVar`
- **Options accepted**: None
- **Signature**: `UncondVar[x_, model_]`
- **Options flow**:
  - Wrapper that calls `UncondCov[x, x, model]`
  - No options involved

#### Function: `UncondCorr`
- **Options accepted**: None
- **Signature**: `UncondCorr[x_, y_, model_]`
- **Options flow**:
  - Wrapper that calls `UncondCov` and `UncondVar`
  - No options involved

#### Function: `Info`
- **Options accepted**: None
- **Signature**: `Info[models_Association]`
- **Options flow**:
  - Wraps `FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[models]`
  - No options passed

---

### Re-Exported Functions (via `reExport`)

The following functions are re-exported from sub-packages. Their options are defined in the source files and are available when called from the main package context.

#### From `ComputationalEngine`ComputeConditionalExpectations`

Re-exported via: `reExport[#]&/@{"FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"}`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `ev` | `Ev` | None |
| `var` | `Var` | None |
| `cov` | `Cov` | None |
| `corr` | `Corr` | None |

**Note**: The internal helper `lagStateVarst` has options (`"MaxIterations"` and `"TimeConstraint"`), but these are not exposed to the public API.

---

#### From `ComputationalEngine`ComputeUnconditionalExpectations`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `uncondE` | `UncondE` | See source file |

---

#### From `Tools`ManageResources`

Re-exported via: `reExport[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels, FernandoDuarte`LongRunRisk`BuildModels]`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `buildModels` | `BuildModels` | Complex nested config (see below) |

##### `BuildModels` Options Flow

**Options accepted** (from `ManageResources.wl`):
```mathematica
Options[buildModels] = {
    "FromScratch" -> False,
    "CompileJacobians" -> False,
    "CreateMoments" -> True,
    "NumKernels" -> Automatic,
    "MaxMaturity" -> 120,
    "Models" -> All,
    "PdEquations" -> "B",
    "FileSuffix" -> "",
    "UpdateManifest" -> True
};
```

**Options flow**:
- `"FromScratch"` -> Controls whether to clean all outputs first
- `"CompileJacobians"` -> Passed to `determineModelStatus` and `createCompiledEq`
- `"CreateMoments"` -> Controls whether to run moments phase
- `"NumKernels"` -> Passed to `setupParallelKernels`
- `"MaxMaturity"` -> Passed to moments database creation via config
- `"Models"` -> Used to filter which models to process
- `"PdEquations"` -> Passed to symbolic/compile phases via `splitConfig`
- `"FileSuffix"` -> Used for checkpoint file naming
- `"UpdateManifest"` -> Controls manifest update at end

The options are normalized via `OptionsConfig`normalizeConfig` and then distributed to various phases via `OptionsConfig`splitConfig`.

---

#### From `Tools`NicePlots`

Re-exported via: `reExport[#]&/@{"FernandoDuarte`LongRunRisk`Tools`NicePlots`"}`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `yieldCurve` | `YieldCurve` | See below |
| `plotCoeffs` | `PlotCoeffs` | See below |

##### `YieldCurve` Options Flow

**Options accepted**:
```mathematica
Options[yieldCurve] = {
    "MaxMaturity" -> 12,
    "MomentFunction" -> uncondE
};
```

**Full signature**: `yieldCurve[model_, newParameters_:{}, coeffsWc_:{}, bondType_:"nombond", opts:OptionsPattern[{yieldCurve, updateCoeffs, FindRoot, RecurrenceTable}]]`

**Options flow**:
- `"MaxMaturity"` -> Used directly to set maturity range for yield curve
- `"MomentFunction"` -> Used directly to compute unconditional expectations
- Options compatible with `updateCoeffs` -> Filtered and passed to `updateCoeffs` via `FilterRules`
- Options compatible with `FindRoot` -> Filtered and passed to `updateCoeffs`
- Options compatible with `RecurrenceTable` -> Filtered and passed to `updateCoeffsBond`

##### `PlotCoeffs` Options Flow

**Options accepted**: `opts: OptionsPattern[]` (passes through to `FindRootPlot`)

**Options flow**:
- All options -> Passed to `ResourceFunction["FindRootPlot"]` via `Flatten @ {opts}`

---

#### From `Tools`TimeAggregation`

Re-exported via: `reExport[#]&/@{"FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"}`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `growth` | `Growth` | See below |

##### `Growth` Options Flow

**Options accepted**:
```mathematica
Options[growth] = {
    "v0" -> Function[{t,j,h,k,v,im}, 0],
    "Order" -> 1
};
```

**Full signature**: `growth[v_Symbol, t_, Optional[im:...], opts:OptionsPattern[{growth, timeSeriesVector, g}]]`

**Options flow**:
- `"v0"` -> Used directly for power series expansion point
- `"Order"` -> Used directly for power series order
- `"TimeAggregation"` (from `timeSeriesVector`) -> Used via `OptionValue`
- `"numPeriods"` (from `timeSeriesVector`) -> Used via `OptionValue`
- `"Variable"` (from `g`) -> Used via `OptionValue` to determine flow/stock/ratio handling

**Internal helper options**:

`timeSeriesVector`:
```mathematica
Options[timeSeriesVector] = {
    "TimeAggregation" -> 1,
    "numPeriods" -> 1
};
```

`g`:
```mathematica
Options[g] = {
    "Variable" -> "Flow"
};
```

Options passed to `gt` are filtered with `FilterRules[{opts}, Except[Options[growth]]]` to separate growth-specific options from those passed downstream.

---

#### From `Tools`ToNumber`

Re-exported via: `reExport[#]&/@{"FernandoDuarte`LongRunRisk`Tools`ToNumber`"}`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `toNum` | `ToNum` | See below |
| `toEquation` | `ToEquation` | None |
| `toExogenousVars` | `ToExogenousVars` | None |
| `toStateVars` | `ToStateVars` | None |

##### `ToNum` Options Flow

**Options accepted**: Inherits from `updateCoeffs`

**Signature variants**:
- `toNum["Rules", model, rest__]`
- `toNum[expr, model, rest__]`
- `toNum[model, rest__]`

**Internal implementation** (`toNumRules`):
```mathematica
toNumRules[
    model_Association,
    Longest[newParameters : {(_Rule)...} : {}, 1],
    Longest[guessCoeffsSolution_List : {}, 2],
    opts : OptionsPattern[{updateCoeffs}]
]
```

**Options flow**:
- Options matching `updateCoeffs` -> Filtered via `FilterRules` and passed to `updateCoeffs`

---

#### From `Tools`VisualizeCoeffs`

Re-exported via: `reExport[#]&/@{"FernandoDuarte`LongRunRisk`Tools`VisualizeCoeffs`"}`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `visualizeCoeffs` | `VisualizeCoeffs` | See below |

##### `VisualizeCoeffs` Options Flow

**Options accepted**:
```mathematica
Options[visualizeCoeffs] = {
    "ShowSelector" -> True,
    "ShowDetails" -> True
};
```

**Options flow**:
- `"ShowSelector"` -> Used directly to control whether coefficient selector panel is shown
- `"ShowDetails"` -> Used directly to control whether bundle details section is shown
- Neither option is passed to other functions

---

#### From `Tools`PipelineMonitor`

Re-exported via: `reExport[FernandoDuarte`LongRunRisk`Tools`PipelineMonitor`checkModels, FernandoDuarte`LongRunRisk`CheckModels]`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `checkModels` | `CheckModels` | See below |

##### `CheckModels` Options Flow

**Options accepted**:
```mathematica
Options[checkModels] = {"AutoBuild" -> Automatic};
```

**Options flow**:
- `"AutoBuild"` -> Used via `resolveAutoBuild` to determine if auto-build should occur
  - `True`: Auto-build without prompts
  - `False`: Never auto-build
  - `Automatic`: Auto-build if `LONGRUNRISK_AUTOBUILD` env var is set or in CI environment
- When building, calls `buildModels["Models" -> modelsToBuild]` without forwarding `"AutoBuild"`

---

## Summary: Options Terminal Points

This section identifies where options are ultimately consumed (terminal use) vs. passed to other functions.

| Function | Option | Terminal Use | Passed To |
|----------|--------|--------------|-----------|
| `BuildModels` | `"FromScratch"` | Yes (controls cleanup) | - |
| `BuildModels` | `"CompileJacobians"` | Partial | `determineModelStatus`, `createCompiledEq` |
| `BuildModels` | `"CreateMoments"` | Yes (controls phase) | - |
| `BuildModels` | `"NumKernels"` | Yes (via `setupParallelKernels`) | `buildModels` (recursive) |
| `BuildModels` | `"MaxMaturity"` | - | Config system -> moments |
| `BuildModels` | `"Models"` | Yes (filtering) | - |
| `BuildModels` | `"PdEquations"` | - | `splitConfig` -> symbolic/compile |
| `BuildModels` | `"FileSuffix"` | Yes (file naming) | - |
| `BuildModels` | `"UpdateManifest"` | Yes (controls update) | - |
| `YieldCurve` | `"MaxMaturity"` | Yes (maturity range) | - |
| `YieldCurve` | `"MomentFunction"` | Yes (moment computation) | - |
| `YieldCurve` | `updateCoeffs` opts | - | `updateCoeffs` |
| `YieldCurve` | `FindRoot` opts | - | `updateCoeffs` |
| `YieldCurve` | `RecurrenceTable` opts | - | `updateCoeffsBond` |
| `PlotCoeffs` | All opts | - | `FindRootPlot` |
| `Growth` | `"v0"` | Yes (expansion point) | - |
| `Growth` | `"Order"` | Yes (series order) | - |
| `Growth` | `"TimeAggregation"` | Yes (via `OptionValue`) | - |
| `Growth` | `"numPeriods"` | Yes (via `OptionValue`) | - |
| `Growth` | `"Variable"` | Yes (via `OptionValue`) | - |
| `ToNum` | `updateCoeffs` opts | - | `updateCoeffs` |
| `VisualizeCoeffs` | `"ShowSelector"` | Yes (UI control) | - |
| `VisualizeCoeffs` | `"ShowDetails"` | Yes (UI control) | - |
| `CheckModels` | `"AutoBuild"` | Yes (controls behavior) | - |

---

## Cross-File Dependencies

Many options flow to functions defined in other files. Key destination files:

1. **`SolveEulerEq.wl`**: Receives options via `updateCoeffs` from `YieldCurve`, `ToNum`
2. **`FindRootOptim.wl`**: Receives compile options from `BuildModels` via config
3. **`CreateMomentsDatabase.wl`**: Receives moments options from `BuildModels` via config
4. **`ProcessModels.wl`**: Receives symbolic options from `BuildModels` via config
5. **`OptionsConfig.wl`**: Normalizes and splits options for `BuildModels`

For detailed options flow in these files, see their respective documentation in `/docs/options/`.
