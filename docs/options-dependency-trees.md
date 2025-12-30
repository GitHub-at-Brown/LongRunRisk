# Options Dependency Trees

Complete dependency trees for all options in `defaultConfig[]` from `Kernel/Tools/OptionsConfig.wl`.

Root nodes are functions that consume an option without receiving it from another function. Child nodes are functions called by the parent that forward the option.

---

# Symbolic Subsystem

## PdEquations

**Default**: `"B"` | **Source**: `OptionsConfig.wl:76`

### Tree

- `buildModels` → `normalizeConfig` → `buildModelsInternal`
  - `splitConfig["Symbolic"]` → `processModels` → `solveCoeffsSystem` (uses `OptionValue["PdEquations"]`)

### Notes

- Downstream data dependency: `pdMode` stored in `model["coeffsParamQuadSolve"]["pd"]["pdMode"]` and read by `buildEqMapFromModel` during compilation.

---

## SimplifyOptions

**Default**: `{TimeConstraint -> {5, 300}}` | **Source**: `OptionsConfig.wl:77`

### Tree

- `buildModels` → `normalizeConfig` → `buildModelsInternal`
  - `splitConfig["Symbolic"]` → `processModels` (**does NOT forward**)
- `solveCoeffsSystem` (direct) → `tryTransforms` (uses `OptionValue["SimplifyOptions"]`)

### Gap Analysis

**GAP**: `processModels` does not forward `SimplifyOptions` to `simplifyCoeffsSystem` or `solveCoeffsSystem`. Both use their own defaults.

---

## paramQuadSolveOptions

**Default**: Nested Association with 14 sub-options | **Source**: `OptionsConfig.wl:78-93`

### Tree

- `buildModels` → `normalizeConfig` → `buildModelsInternal`
  - `splitConfig["Symbolic"]` → `processModels` (**does NOT forward**)
- `solveCoeffsSystem` (direct) → `paramQuadSolve` (uses `OptionValue["paramQuadSolveOptions"]`)

### Gap Analysis

**GAP**: Similar to SimplifyOptions, `processModels` does not forward this option. The nested sub-options (DomainOption, Assumptions, Method, etc.) are consumed by `paramQuadSolve` when called directly but not when called through the build pipeline.

---

# Compile Subsystem

## CoeffName

**Default**: `"A"` | **Source**: `OptionsConfig.wl:96`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Compile"]` → `createCompiledEq` → `buildKernel` (uses `OptionValue["CoeffName"]`)

### Gap Analysis

**Dead Code**: The config value is extracted but `buildEqMapFromModel` derives `coeffName` from the model's `coeffsSolution` keys, ignoring the config value entirely.

---

## SignSymbol (Compile)

**Default**: `"signA"` | **Source**: `OptionsConfig.wl:97`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Compile"]` → `createCompiledEq` → `buildKernel` (has default)

### Gap Analysis

**Dead Code**: Similar to CoeffName, the config value is ignored. `buildEqMapFromModel` derives `signSymbol` from the model.

---

## PerformanceGoal

**Default**: `"Quality"` | **Source**: `OptionsConfig.wl:98`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Compile"]` → `createCompiledEq` → `buildKernel` (uses `OptionValue["PerformanceGoal"]`)
  - Passed to `Compile` or `FunctionCompile`

### Gap Analysis

**Default Mismatch**: `defaultConfig` has `"Quality"`, but `buildKernel` declares `"Speed"`. No runtime issue since config value takes precedence.

---

## CompileMode

**Default**: `"Both"` | **Source**: `OptionsConfig.wl:99`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Compile"]` → `createCompiledEq` → `buildKernel`
  - Controls whether fC (function), dfC (Jacobian), or both are compiled

### Gap Analysis

No gaps in pipeline flow. Config value correctly forwarded via `splitConfig`.

**Note**: `buildKernel` declares `"CompileMode" -> "FunctionOnly"` as its default. This only affects **standalone usage** of `buildKernel` outside the pipeline.

---

## Compiler

**Default**: `"Compile"` | **Source**: `OptionsConfig.wl:100`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Compile"]` → `createCompiledEq` → `buildKernel`
  - Values: `"Compile"`, `"FunctionCompile"`, `"None"`

### Gap Analysis

No gaps detected.

---

## RuntimeOptions

**Default**: `Automatic` | **Source**: `OptionsConfig.wl:101`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Compile"]` → `createCompiledEq` → `buildKernel`
  - Forwarded to `Compile` via `FilterRules`

### Gap Analysis

No gaps detected. Works via `FilterRules` mechanism.

---

## CompilationTarget

**Default**: `"C"` | **Source**: `OptionsConfig.wl:102`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Compile"]` → `createCompiledEq` → `buildKernel` → `Compile`

### Gap Analysis

Minor gap in Jacobian compilation path where this option is not explicitly forwarded, but defaults to `"C"`.

---

# Numerical Subsystem

## initialGuess

**Default**: `<|"Ewc" -> {4}, "Epd" -> {{4}}|>` | **Source**: `OptionsConfig.wl:105`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Numerical"]` → `toNumRules` → `updateCoeffs` → `updateCoeffsSol`
  - Used to construct initial guess for `FindRoot`

### Gap Analysis

No gaps detected. Flows correctly.

---

## FindRoot Options

**Default**: Nested Association with MaxIterations, PrecisionGoal, AccuracyGoal, WorkingPrecision, Options | **Source**: `OptionsConfig.wl:106-112`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Numerical"]` → `updateCoeffs` → `updateCoeffsSol` → `solveCoeffRoots` → `FindRoot`

### Gap Analysis

No gaps detected. Options correctly forwarded via `FilterRules[..., Options[FindRoot]]`.

---

## RecurrenceTable Options

**Default**: `<|"DependentVariables" -> Automatic, "Options" -> {}|>` | **Source**: `OptionsConfig.wl:113-116`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Numerical"]` → `updateCoeffs` → `updateCoeffsSol` → `updateCoeffsBond` → `RecurrenceTable`

### Gap Analysis

Minor gap: `yieldCurve` in NicePlots.wl calls `RecurrenceTable` without forwarding options.

---

## MaxMaturity (Numerical)

**Default**: `12` | **Source**: `OptionsConfig.wl:117`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Numerical"]` → `updateCoeffs` → `updateCoeffsSol` (uses `OptionValue["MaxMaturity"]`)
  - Controls bond term structure iteration depth

### Gap Analysis

**GAP**: `addCoeffsSolutionN` hard-codes `"MaxMaturity" -> 12` instead of accepting it as an option.

---

## RootSigns

**Default**: `Automatic` | **Source**: `OptionsConfig.wl:118`

### Tree

- `updateCoeffs` → `updateCoeffsSol` → `normalizeRootSigns` → `updateCoeffsWcPd` → `solveCoeffRoots`
- Generates sign combinations for multi-root equations

### Gap Analysis

No gaps detected.

---

## Scan Options

**Default**: `<|"FastRootOptions" -> {}, "UnboundedPad" -> 1000, "ScanMethod" -> "Grid"|>` | **Source**: `OptionsConfig.wl:119-123`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Numerical"]` → (Scan sub-association NOT extracted)

### Gap Analysis

**GAP - Dead Config**: `splitConfig["Numerical"]` does NOT extract the Scan sub-association. These options are never forwarded to downstream functions.

**Evidence**:
- `extractIntervalsFromReduce` hardcodes `"UnboundedPad" -> 1.*^5` (100,000) vs config's 1000
- `findRootInterval` and `scanAndSolve` use their own defaults, ignoring central config

**Severity**: Medium - config values completely ignored.

---

## Signs

**Default**: `{}` | **Source**: `OptionsConfig.wl:124`

### Tree

- `splitConfig["Numerical"]` → (not consumed by `updateCoeffs`)
- `bindUnary`, `findRootInterval` (direct calls)

### Gap Analysis

**GAP**: Extracted by `splitConfig` but not consumed in the main pipeline. `RootSigns` is used instead for sign iteration.

---

## Checks Options

**Default**: `<|"PrintResidualsNorm" -> False, "CheckResiduals" -> False, "Tol" -> 10.^-16|>` | **Source**: `OptionsConfig.wl:125-129`

### Tree

- `updateCoeffs` → `updateCoeffsSol` → `checks`
- Uses `OptionValue["PrintResidualsNorm"]`, `OptionValue["CheckResiduals"]`, `OptionValue["Tol"]`

### Gap Analysis

**GAP**: `splitConfig["Numerical"]` does NOT extract the Checks sub-association. The `checks` function declares its own Options, bypassing the config system.

---

## UpdatePd

**Default**: `False` | **Source**: `OptionsConfig.wl:130`

### Tree

- `updateCoeffs` → `updateCoeffsSol` (uses `OptionValue["UpdatePd"]`)
- Controls whether price-dividend coefficients are computed

### Gap Analysis

No gaps detected.

---

## UpdateBond

**Default**: `False` | **Source**: `OptionsConfig.wl:131`

### Tree

- `updateCoeffs` → `updateCoeffsSol` (uses `OptionValue["UpdateBond"]`)
- Controls whether real bond coefficients are computed

### Gap Analysis

No gaps detected.

---

## UpdateNomBond

**Default**: `False` | **Source**: `OptionsConfig.wl:132`

### Tree

- `updateCoeffs` → `updateCoeffsSol` (uses `OptionValue["UpdateNomBond"]`)
- Controls whether nominal bond coefficients are computed

### Gap Analysis

No gaps detected.

---

## UpdateBonds

**Default**: `False` | **Source**: `OptionsConfig.wl:133`

### Tree

- `updateCoeffs` → `updateCoeffsSol` (uses `OptionValue["UpdateBonds"]`)
- Umbrella option: enables both `UpdateBond` and `UpdateNomBond`

### Gap Analysis

No gaps detected.

---

## ReduceTimeLimit

**Default**: `5.` | **Source**: `OptionsConfig.wl:134`

### Tree

- `splitConfig["Numerical"]` → (should flow to) `solveND` → `safeReduceCall` → `TimeConstrained`

### Gap Analysis

**GAP**: `solveCoeffRoots` hard-codes `"ReduceTimeLimit" -> 5.` instead of forwarding from options. Config value is ignored.

---

# Moments Subsystem

## maxMomentsLagsToCreate

**Default**: `8` | **Source**: `OptionsConfig.wl:137`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Moments"]` → `createDatabase` (uses `OptionValue["maxMomentsLagsToCreate"]`)
  - Controls Table iteration ranges for covariance computation

### Gap Analysis

No gaps detected.

---

## startSequenceAtLag

**Default**: `3` | **Source**: `OptionsConfig.wl:138`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Moments"]` → `createDatabase` (uses `OptionValue["startSequenceAtLag"]`)
  - Threshold for `FindSequenceFunction` extrapolation

### Gap Analysis

No gaps detected.

---

## simplifyDownValues

**Default**: `False` | **Source**: `OptionsConfig.wl:139`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Moments"]` → `createDatabase` (uses `OptionValue["simplifyDownValues"]`)
  - Controls whether to run `Simplify` on stored DownValues

### Gap Analysis

No gaps detected.

---

## IterationLimit

**Default**: `$IterationLimit/4` | **Source**: `OptionsConfig.wl:140`

### Tree

- `buildModels` → `buildModelsInternal`
  - `splitConfig["Moments"]` → `createDatabase` → `uncondCovLongExo`
  - Uses `Block[{$IterationLimit = OptionValue["IterationLimit"]}, ...]`

### Gap Analysis

- **Missing Legacy Mapping**: Not in `legacyOptionMap`, so flat option syntax is ignored.
- **UncondCov API**: Does not forward options to `uncondCovLongExo`.

---

# Parallel Subsystem

## NumKernels

**Default**: `Automatic` | **Source**: `OptionsConfig.wl:143`

### Tree

- `buildModels` → `buildModelsInternal`
  - Extracted at line 834: `numKernels = config["Parallel"]["NumKernels"]`
  - `setupParallelKernels[numKernels]` → `LaunchKernels[n]`
- `buildModelsParallel` (uses own `OptionValue["NumKernels"]`)

### Gap Analysis

No gaps detected. `splitConfig["Parallel"]` exists but not used (direct extraction is cleaner for single-option subsystem).

---

# Build Subsystem

## Models

**Default**: `All` | **Source**: `OptionsConfig.wl:146`

### Tree

- `buildModels` → `buildModelsInternal`
  - Extracted at line 836: `modelFilter = config["Build"]["Models"]`
  - Applied via `KeyTake` + `Select` to filter enabled models

### Gap Analysis

No gaps detected. Filtering happens before any pipeline phase execution.

---

## FromScratch

**Default**: `False` | **Source**: `OptionsConfig.wl:147`

### Tree

- `buildModels` → `buildModelsInternal`
  - Extracted at line 831: `fromScratch = config["Build"]["FromScratch"]`
  - When True: `cleanAllOutputs[root]`, resets `savedModels` and `manifest`
- `buildModelsParallel` (cleans once at parent level)

### Gap Analysis

No gaps detected.

---

## CompileJacobians

**Default**: `True` | **Source**: `OptionsConfig.wl:148`

### Tree

- `buildModels` → `buildModelsInternal`
  - Extracted at line 832: `compileJacobians = config["Build"]["CompileJacobians"]`
  - Passed to `determineModelStatus` as positional argument
  - Gates Jacobian compilation track (lines 1005-1020)

### Gap Analysis

**Default Mismatch**: `buildModels // Options` declares `"CompileJacobians" -> False` but `defaultConfig` has `True`. No runtime issue since config is used.

---

## CreateMoments

**Default**: `True` | **Source**: `OptionsConfig.wl:149`

### Tree

- `buildModels` → `buildModelsInternal`
  - Extracted at line 833: `createMoments = config["Build"]["CreateMoments"]`
  - Gates Phase 4 (Moments): `If[createMoments, ...]`
- `buildModelsParallel` (disables during parallel phase, enables for sequential moments)

### Gap Analysis

No gaps detected.

---

## MaxMaturity (Build)

**Default**: `120` | **Source**: `OptionsConfig.wl:150`

### Tree

- `buildModels` → `buildModelsInternal`
  - Extracted at line 835: `maxMaturity = config["Build"]["MaxMaturity"]`
  - **NEVER USED** in function body

### Gap Analysis

**CRITICAL GAP - Dead Variable**: Extracted but never passed to any downstream function. `addCoeffsSolutionN` hard-codes `"MaxMaturity" -> 12`.

---

## FileSuffix

**Default**: `""` | **Source**: `OptionsConfig.wl:151`

### Tree

- `buildModels` → `buildModelsInternal`
  - Extracted at line 837: `fileSuffix = config["Build"]["FileSuffix"]`
  - Used in: `modelsFileCheckpoint = ... "Models" <> fileSuffix <> ".wl"`
- `buildModelsParallel` (sets `"_" <> modelName` for each parallel worker)

### Gap Analysis

No gaps detected. Well-contained purpose for parallel build orchestration.

---

## UpdateManifest

**Default**: `True` | **Source**: `OptionsConfig.wl:152`

### Tree

- `buildModels` → `buildModelsInternal`
  - Extracted at line 838: `updateManifest = config["Build"]["UpdateManifest"]`
  - Consumed at line 1129: `If[TrueQ[updateManifest] && fileSuffix === "", updateModelManifest[]]`
- `buildModelsParallel` (always calls `updateModelManifest[]` after merge)

### Gap Analysis

Minor inconsistency: `buildModelsParallel` ignores this option and always updates manifest.

---

# Summary of Gaps

| Option | Subsystem | Gap Type | Severity |
|--------|-----------|----------|----------|
| SimplifyOptions | Symbolic | Not forwarded by processModels | Medium |
| paramQuadSolveOptions | Symbolic | Not forwarded by processModels | High |
| CoeffName | Compile | Dead code - model-derived | Low |
| SignSymbol (Compile) | Compile | Dead code - model-derived | Low |
| MaxMaturity (Numerical) | Numerical | Hard-coded in addCoeffsSolutionN (but splitConfig does forward it) | Medium |
| Scan Options | Numerical | Dead config - not extracted by splitConfig | Medium |
| Signs | Numerical | Extracted but not consumed | Low |
| Checks | Numerical | Config bypassed, own Options used | Medium |
| ReduceTimeLimit | Numerical | Hard-coded in solveCoeffRoots | High |
| IterationLimit | Moments | Missing legacy mapping | Medium |
| MaxMaturity (Build) | Build | Dead variable - never used | Critical |
