# Known Issues with Options System

This document tracks known problems, inconsistencies, and areas for improvement in the options configuration system.

## Default Value Inconsistencies

### `PerformanceGoal` Mismatch
*   **Central Config**: `PerformanceGoal -> "Quality"`
*   **`buildKernel`**: `PerformanceGoal -> "Speed"` (in `Options[buildKernel]`)
*   **Impact**: When `buildKernel` is called without explicit options (or with empty options), it might default to "Speed" if not properly funneling the central config. However, the build pipeline does extract options from `config`, so "Quality" generally prevails. But standalone usage differs.

### `CompileMode` Mismatch
*   **Central Config**: `CompileMode -> "Both"`
*   **`buildKernel`**: `CompileMode -> "FunctionOnly"`
*   **Impact**: Standalone `buildKernel` usage compiles fewer components than the full pipeline.

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

### `Scan` Subsystem
*   `defaultConfig` has a `"Scan"` section.
*   **Issue**: These options are NOT passed to `findRootInterval` or `extractIntervalsFromReduce`. The code scanning for intervals uses hardcoded defaults or its own options, ignoring the central config.

### `MaxMaturity` in Build vs Numerical
*   `defaultConfig` has `MaxMaturity` in both `"Build"` (120) and `"Numerical"` (12).
*   **Issue**: `updateCoeffsSol` uses `MaxMaturity -> 12`. The build pipeline passes `MaxMaturity` from the build config. The intent of the separate "Numerical" `MaxMaturity` is unclear if it's always overridden.

## Propagation Issues

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

### `ParamQuadSolve` Options
*   The `paramQuadSolveOptions` are passed as a specialized sub-association.
*   **Issue**: `solveCoeffsSystem` expects `paramQuadSolveOptions` as a single option containing a list/association.

## Type Mismatches

### `SignSymbol`
*   **Config**: `"SignSymbol" -> "signA"` (String)
*   **`buildKernel`**: Expects String? Used as a Symbol name.
*   **`paramQuadSolve`**: `Options[paramQuadSolve]` has `"SignSymbol" -> signA` (Symbol).
*   **Issue**: Potential for string vs symbol confusion if not carefully converted.

## Legacy and Structural Issues

### Flat vs Nested Options
*   The system supports both flat options (legacy) and nested association config.
*   **Risk**: `normalizeConfig` attempts to merge them, but complex nested overrides (like `FindRoot -> {MaxIterations -> ...}`) via flat options are tricky and potentially buggy.

### Discovery
*   There is no easy way for a user to query "What are all the options available for the Numerical phase?". `Options[updateCoeffsSol]` gives some, but not those injected from `OptionsConfig`.

## Fixed Issues
*   **Jacobian Compilation**: Previously, `CompileMode` was not properly splitting Jacobian and Function compilation. Fixed by explicit `CompileMode` handling in pipeline.
*   **Hash Validation**: Documentation previously didn't reflect that `Hash` includes option values. Fixed in code, documentation updated.
