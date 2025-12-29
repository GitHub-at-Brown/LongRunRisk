# Known Issues with Options System

This document tracks known problems, inconsistencies, and areas for improvement in the options configuration system.

## Default Value Inconsistencies

### `PerformanceGoal` Mismatch
*   **Central Config**: `PerformanceGoal -> "Quality"`
*   **`buildKernel`**: `PerformanceGoal -> "Speed"` (in `Options[buildKernel]`)
*   **Impact**: When `buildKernel` is called without explicit options (or with empty options), it might default to "Speed" if not properly funneling the central config. However, the build pipeline does extract options from `config`, so "Quality" generally prevails. But standalone usage differs.

### `CompileMode` Mismatch (Standalone Only)
*   **Central Config**: `CompileMode -> "Both"`
*   **`buildKernel`**: `CompileMode -> "FunctionOnly"`
*   **Impact**: Only affects **standalone** `buildKernel` usage. The full pipeline correctly forwards the config value via `splitConfig[config, "Compile"]` (ManageResources.wl:995-998), so `"Both"` prevails when using `buildModels`.

### `CompileJacobians` Mismatch
*   **Central Config** (`OptionsConfig.wl`): `CompileJacobians -> True`
*   **`buildModels` internal default** (`ManageResources.wl`): `CompileJacobians -> False`
*   **Impact**: The `buildModels` function uses `normalizeConfig` which favors the passed-in options (if any) or falls back to `defaultConfig`. The central config in `OptionsConfig` is authoritative, so `True` generally prevails when using the full pipeline.

### `UnboundedPad` Mismatch
*   **Central Config**: `UnboundedPad -> 1000`
*   **`extractIntervalsFromReduce`**: `UnboundedPad -> 1.*^5` (100000)
*   **Impact**: Standalone usage uses a much larger pad than the central config specifies. The function default is more permissive.

## Missing from Central Configuration

### `buildKernel` Options
The following options exist in `buildKernel` but are not in `OptionsConfig.wl`:
*   `FlattenExpressions` (Default: `Automatic`)
*   `AllowCompileDuringCoverage` (Default: `False`)

**Impact**: These cannot be controlled via the main `config` object passed to `buildModels`. They rely on `buildKernel`'s internal defaults.

### `Measure` Option
*   `solveCoeffRoots` uses a `Measure` option in `solveset`, but it is not exposed in the central config.

## Unused or Dead Options

### `Numerical` Subsystem Split
*   `splitConfig` has a definition for `"Numerical"`, but the build pipeline manually constructs the numerical options (`FindRootOptions`, `RecurrenceTableOptions`, etc.) directly from the main keys in `solveND` / `updateCoeffsSol`.
*   **Result**: The structural separation in `OptionsConfig` for "Numerical" is partially ignored or flattened differently in usage.

### `Scan` Subsystem (Dead Config)
*   `defaultConfig` has a `"Scan"` section with `FastRootOptions`, `UnboundedPad` (1000), and `ScanMethod`.
*   **Issue**: `splitConfig["Numerical"]` does NOT extract the Scan sub-association. These options are never forwarded to `findRootInterval` or `extractIntervalsFromReduce`.
*   **Evidence**: `extractIntervalsFromReduce` hardcodes `UnboundedPad -> 1.*^5` (100,000) - a 100x difference from the config value.
*   **Severity**: Medium - config values are completely ignored.

### `CoeffName` and `SignSymbol` (Compile) Dead Code
*   **Central Config**: `Compile.CoeffName -> "A"`, `Compile.SignSymbol -> "signA"`
*   **Issue**: `buildEqMapFromModel` in `FindRootOptim.wl` derives both values from the model data, ignoring config:
    ```mathematica
    wcCoeffName = SymbolName @ Head @ wcCoeffs[[1]]
    pdCoeffName = SymbolName @ Head @ Head @ pdSys[[2, 1]]
    "SignSymbol" -> If[wcSigns === {}, "sign" <> SymbolName[...], SymbolName @ Head @ First @ wcSigns]
    ```
*   **Location**: FindRootOptim.wl lines 1425-1449
*   **Severity**: Low - the derived values are correct for the use case.

### `Checks` Sub-association (Config Bypassed)
*   **Central Config**: `Numerical.Checks` contains `PrintResidualsNorm`, `CheckResiduals`, `Tol`
*   **Issue**: `splitConfig["Numerical"]` does NOT extract the Checks sub-association. The `checks` function in `SolveEulerEq.wl` declares its own `Options[]`, bypassing the central config.
*   **Severity**: Medium - users cannot control these via `buildModels` config.

### `MaxMaturity` (Build) - CRITICAL Dead Variable
*   **Central Config**: `Build.MaxMaturity -> 120`
*   **Issue**: This value is extracted at ManageResources.wl:835 but **never used**:
    ```mathematica
    maxMaturity = config["Build"]["MaxMaturity"],  (* extracted but unused *)
    ```
*   **Evidence**: `addCoeffsSolutionN` is called without options (ManageResources.wl:1043-1044) and hardcodes `"MaxMaturity"->12` (SolveEulerEq.wl:1043).
*   **Severity**: **CRITICAL** - the config value of 120 is completely dead. Users cannot control MaxMaturity via config.

### `MaxMaturity` (Numerical) - Correctly Forwarded
*   **Central Config**: `Numerical.MaxMaturity -> 12`
*   **Status**: This value IS correctly forwarded via `splitConfig["Numerical"]` to functions like `updateCoeffsSol`.
*   **Note**: The dual `MaxMaturity` options (Build: 120, Numerical: 12) exist for different purposes, but Build.MaxMaturity is dead.

## Propagation Issues

### `SimplifyOptions` Not Forwarded - HIGH
*   **Central Config**: `Symbolic.SimplifyOptions -> {TimeConstraint -> {5, 300}}`
*   **Issue**: `processModels` does NOT forward this option to `solveCoeffsSystem`. At ProcessModels.wl:246-247:
    ```mathematica
    solveCoeffsSystem[#,
        "PdEquations" -> OptionValue[solveCoeffsSystem, Flatten@{opts}, "PdEquations"]
    ```
    Only `PdEquations` is forwarded; `SimplifyOptions` is omitted.
*   **Result**: `solveCoeffsSystem` uses its own default `{TimeConstraint -> {5, 300}}` regardless of config.
*   **Severity**: Medium - fortunately defaults match, but config changes would be ignored.

### `paramQuadSolveOptions` Not Forwarded - HIGH
*   **Central Config**: `Symbolic.paramQuadSolveOptions` contains 12 sub-options
*   **Issue**: Same as `SimplifyOptions` - `processModels` only forwards `PdEquations`, not `paramQuadSolveOptions`.
*   **Result**: `solveCoeffsSystem` uses its own default `{}` for `paramQuadSolveOptions`, ignoring all 12 configured sub-options.
*   **Severity**: High - users cannot configure solver behavior (DomainOption, Method, TimeoutOption, etc.) via `buildModels`.

### `ReduceTimeLimit` Hardcoded - HIGH
*   **Central Config**: `Numerical.ReduceTimeLimit -> 5.`
*   **Issue**: `solveCoeffRoots` in SolveEulerEq.wl:856 hardcodes this value instead of forwarding from options:
    ```mathematica
    solveND[f, df, conds, paramsAll, signs, coefList, cName, sName,
            findOpts, extractOpts, scanOpts, quadSol["Solution"],
            "ReduceTimeLimit" -> 5.],  (* HARDCODED *)
    ```
*   **Severity**: High - config value is ignored; users cannot adjust timeout.

### `buildModelsParallel`
*   `buildModelsParallel` has its own `Options` definition:
    ```mathematica
    Options[buildModelsParallel] = {
        "CreateMoments" -> True,
        "NumKernels" -> Automatic,
        "FromScratch" -> False,
        "PdEquations" -> "B"
    }
    ```
*   **Issue**: It accepts `opts___` but explicitly filters them for `buildModels`. It does **not** query `OptionsConfig`. If `defaultConfig` changes defaults (e.g., `PdEquations`), `buildModelsParallel` might not reflect them if it relies on its own hardcoded defaults.

### `ParamQuadSolve` Options (Type Expectation)
*   The `paramQuadSolveOptions` are passed as a specialized sub-association.
*   **Note**: `solveCoeffsSystem` expects `paramQuadSolveOptions` as a single option containing a list/association. This is correctly structured in `defaultConfig` but see propagation gap above.

## Type Mismatches

### `SignSymbol` (Intentional Dual Type)
*   **Symbolic context** (`Symbolic.paramQuadSolveOptions.SignSymbol`): `Symbol["signA"]` - actual Symbol for algebraic manipulation
*   **Compile context** (`Compile.SignSymbol`): `"signA"` - String for code generation
*   **Design Note**: This is **intentional**. The `ambiguousOptions` map in `OptionsConfig.wl` (lines 200-203) explicitly handles this duality. The Symbolic context needs a Symbol for pattern matching, while the Compile context needs a String for `SymbolName` operations.
*   **Caveat**: When using legacy flat options, `SignSymbol` defaults to the Symbolic context. Use nested config for explicit control.

## Legacy and Structural Issues

### Flat vs Nested Options
*   The system supports both flat options (legacy) and nested association config.
*   **Risk**: `normalizeConfig` attempts to merge them, but complex nested overrides (like `FindRoot -> {MaxIterations -> ...}`) via flat options are tricky and potentially buggy.

### Discovery
*   There is no easy way for a user to query "What are all the options available for the Numerical phase?". `Options[updateCoeffsSol]` gives some, but not those injected from `OptionsConfig`.

## Fixed Issues
*   **Jacobian Compilation**: Previously, `CompileMode` was not properly splitting Jacobian and Function compilation. Fixed by explicit `CompileMode` handling in pipeline.
*   **Hash Validation**: Documentation previously didn't reflect that `Hash` includes option values. Fixed in code, documentation updated.
