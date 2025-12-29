# Options Flow: OptionsConfig.wl, ManageResources.wl, PipelineMonitor.wl

This document traces how options flow through the three Tools files and into the broader codebase.

---

## File: OptionsConfig.wl

This file is the **central options configuration system**. It defines the nested config structure and provides utilities for normalizing legacy options and extracting subsystem-specific options.

### Function: defaultConfig

- **Options accepted**: None (returns default configuration)
- **Options flow**: Terminal function - creates the default nested configuration Association with all subsystems (Symbolic, Compile, Numerical, Moments, Parallel, Build)

### Function: normalizeConfig

- **Options accepted**:
  - Already-normalized config Association
  - Legacy flat options list
  - Single rules or sequence of rules
- **Options flow**:
  - If config is already normalized -> merges with `defaultConfig[]` using `mergeNested`
  - If legacy flat options -> translates via `legacyOptionMap` to nested paths, returns merged config
  - Terminal function - produces normalized config for downstream use

### Function: splitConfig

- **Options accepted**:
  - `config` (normalized Association)
  - `subsystem` ("Symbolic", "Compile", "Numerical", "Moments", "Parallel", "Build")
- **Options flow**:
  - Extracts subsystem-specific options as a Sequence of Rules
  - **splitConfig[config, "Symbolic"]** -> Returns: PdEquations, SimplifyOptions, paramQuadSolveOptions
    - Passed to `processModels` (ProcessModels.wl)
  - **splitConfig[config, "Compile"]** -> Returns: CoeffName, SignSymbol, PerformanceGoal, CompileMode, Compiler, RuntimeOptions, CompilationTarget
    - Passed to `createCompiledEq` (FindRootOptim.wl)
  - **splitConfig[config, "Numerical"]** -> Returns: initialGuess, FindRootOptions, RecurrenceTableOptions, MaxMaturity, RootSigns, Signs, UpdatePd, UpdateBond, UpdateNomBond, UpdateBonds, ReduceTimeLimit
    - Extracted but NOT currently used in buildModels pipeline (numerical phase uses default parameters)
  - **splitConfig[config, "Moments"]** -> Returns: maxMomentsLagsToCreate, startSequenceAtLag, simplifyDownValues, IterationLimit
    - Passed to `createDatabase` (CreateMomentsDatabase.wl)
  - **splitConfig[config, "Parallel"]** -> Returns: NumKernels
    - Extracted but config["Parallel"]["NumKernels"] accessed directly
  - **splitConfig[config, "Build"]** -> Returns: Models, FromScratch, CompileJacobians, CreateMoments, MaxMaturity, FileSuffix, UpdateManifest
    - Used directly by buildModelsInternal (values extracted from config)

### Function: validateConfig

- **Options accepted**: config (Association)
- **Options flow**: Terminal function - validates config structure, returns True/False

### Function: isNormalized

- **Options accepted**: config (any)
- **Options flow**: Terminal function - checks if config has required subsystem keys

### Function: generateMigrationReport

- **Options accepted**: None
- **Options flow**: Terminal function - returns report of deprecated options used during session

---

## File: ManageResources.wl

This file orchestrates the model building pipeline, using OptionsConfig for configuration management.

### Function: buildModels

- **Options accepted** (declared):
  - `"FromScratch"` -> False
  - `"CompileJacobians"` -> False
  - `"CreateMoments"` -> True
  - `"NumKernels"` -> Automatic
  - `"MaxMaturity"` -> 120
  - `"Models"` -> All
  - `"PdEquations"` -> "B"
  - `"FileSuffix"` -> ""
  - `"UpdateManifest"` -> True
- **Options flow**:
  - **Pattern 1**: `buildModels[config_Association]` -> normalizes via `normalizeConfig[config]` -> calls `buildModelsInternal`
  - **Pattern 2**: `buildModels[opts___?OptionQ]` -> normalizes via `normalizeConfig[{opts}]` -> calls `buildModelsInternal`

### Function: buildModelsInternal

- **Options accepted**: Normalized config Association (from buildModels)
- **Options flow**:
  - Extracts Build options directly from config: `config["Build"]["FromScratch"]`, `config["Build"]["CompileJacobians"]`, etc.
  - Extracts Parallel options: `config["Parallel"]["NumKernels"]`
  - Extracts Compile options for validation: `config["Compile"]["CompileMode"]`, `config["Compile"]["Compiler"]`

  - **Phase 1 (Symbolic)**:
    - `splitConfig[config, "Symbolic"]` -> passed to `processModels` (ProcessModels.wl)
      - PdEquations -> `solveCoeffsSystem` -> controls which pd equations to compute
      - SimplifyOptions -> `solveCoeffsSystem`, `simplifyCoeffsSystem` -> forwarded to `Simplify`
      - paramQuadSolveOptions -> `paramQuadSolve` (ParamQuadSolve.wl)

  - **Phase 2 (Compile)**:
    - `splitConfig[config, "Compile"]` -> passed to `createCompiledEq` (FindRootOptim.wl)
      - CoeffName -> `buildKernel` -> used for coefficient symbol detection
      - SignSymbol -> `buildKernel` -> used for sign symbol detection
      - PerformanceGoal -> `buildKernel` -> controls optimization level
      - CompileMode -> `buildKernel` -> "FunctionOnly" | "JacobianOnly" | "Both"
      - Compiler -> `buildKernel` -> "Compile" | "FunctionCompile"
      - RuntimeOptions -> `Compile` (Wolfram builtin)
      - CompilationTarget -> `Compile` (Wolfram builtin)

  - **Phase 3 (Numerical)**:
    - Options NOT passed via splitConfig - uses model defaults
    - `addCoeffsSolutionN` called without explicit options (uses defaults from SolveEulerEq.wl)

  - **Phase 4 (Moments)**:
    - `splitConfig[config, "Moments"]` -> passed to `createDatabase` (CreateMomentsDatabase.wl)
      - maxMomentsLagsToCreate -> used directly in moment computation loops
      - startSequenceAtLag -> controls sequence start for moment database
      - simplifyDownValues -> controls whether to simplify computed moments
      - IterationLimit -> forwarded to `uncondCovLongExo` -> used in `Block[{$IterationLimit=...}]`

### Function: buildModelsParallel

- **Options accepted** (declared):
  - `"CreateMoments"` -> True
  - `"NumKernels"` -> Automatic
  - `"FromScratch"` -> False
  - `"PdEquations"` -> "B"
  - Also accepts `buildModels` options via OptionsPattern
- **Options flow**:
  - Filters out options it force-sets: `FileSuffix`, `UpdateManifest`, `CreateMoments`, `FromScratch`, `Models`
  - Remaining options passed to parallel `buildModels` calls
  - Each parallel call uses `"FileSuffix" -> "_" <> modelName` for checkpointing
  - After parallel phase, merges results and optionally runs moments sequentially

### Function: determineModelStatus

- **Options accepted**: compileMode, compilerChoice (passed as arguments, not OptionsPattern)
- **Options flow**:
  - `compileMode`, `compilerChoice` -> passed to `validateCompiledFile` for hash validation
  - Used to determine if models need recompilation

### Function: validateCompiledFile

- **Options accepted**: compileMode (default "FunctionOnly"), compilerChoice (default "Compile"), flattenOpt (default Automatic)
- **Options flow**: Terminal function - validates .mx file against expected hash computed from model and options

### Function: getModelPipelineStatus

- **Options accepted**: None (uses normalizeConfig[{}] internally)
- **Options flow**:
  - Creates default config via `normalizeConfig[{}]`
  - Extracts `config["Compile"]["CompileMode"]` and `config["Compile"]["Compiler"]`
  - Passes to `determineModelStatus` for each model

### Function: checkCatalogChanges

- **Options accepted**: None (or modelsAssoc)
- **Options flow**: Terminal function - no options-related code, computes hashes and validates models

### Function: checkCatalogForUI

- **Options accepted**: None
- **Options flow**: Terminal function - similar to checkCatalogChanges but for UI layer

### Function: updateModelManifest

- **Options accepted**: None (or modelsAssoc)
- **Options flow**: Terminal function - no options-related code

### Function: reformatCatalog

- **Options accepted**: None
- **Options flow**: Terminal function - no options-related code

---

## File: PipelineMonitor.wl

This file provides the user-facing pipeline monitoring UI. It has minimal options handling.

### Function: checkModels

- **Options accepted** (declared):
  - `"AutoBuild"` -> Automatic
- **Options flow**:
  - `"AutoBuild"` -> `resolveAutoBuild` -> determines if auto-build is enabled
    - Checks: Explicit True/False, `LONGRUNRISK_AUTOBUILD` env var, `CI` env var
  - When building, calls `buildModels["Models" -> modelsToBuild]` with no other options
  - Terminal for options - no options forwarded to inner functions

### Function: resolveAutoBuild

- **Options accepted**: opt (the AutoBuild option value)
- **Options flow**: Terminal function - returns True/False based on option value and environment

### Function: loadConfig

- **Options accepted**: None
- **Options flow**: Terminal function - loads user config from file

### Function: showPipelineReport

- **Options accepted**: changes, status, modelsToBuild, autoBuild (passed as arguments)
- **Options flow**:
  - When building, calls `buildModels["Models" -> modelsToBuild]`
  - No additional options forwarded

### Function: showValidationErrors

- **Options accepted**: validation (Association)
- **Options flow**: Terminal function - displays errors, no options

### Function: statusIcon, formatStatusGrid, formatChangeSummary

- **Options accepted**: None
- **Options flow**: Terminal functions - UI formatting only

---

## Complete Options Flow Diagram

```
User calls buildModels[opts...]
    |
    v
normalizeConfig[{opts}] -- merges with defaultConfig[]
    |
    v
buildModelsInternal[config]
    |
    +-- Phase 1: processModels[..., splitConfig[config, "Symbolic"]]
    |       |
    |       +-- PdEquations -> solveCoeffsSystem -> controls which equations
    |       +-- SimplifyOptions -> Simplify (Wolfram builtin)
    |       +-- paramQuadSolveOptions -> paramQuadSolve
    |       +-- addCoeffsSolution uses RecurrenceTableOptions -> RecurrenceTable
    |
    +-- Phase 2: createCompiledEq[..., splitConfig[config, "Compile"]]
    |       |
    |       +-- buildKernel receives all Compile options
    |       +-- Compiler options -> Compile/FunctionCompile (Wolfram builtins)
    |
    +-- Phase 3: addCoeffsSolutionN[model] (NO options passed)
    |       |
    |       +-- Uses defaults from SolveEulerEq.wl
    |       +-- updateCoeffsSol -> FindRoot, RecurrenceTable
    |
    +-- Phase 4: createDatabase[..., splitConfig[config, "Moments"]]
            |
            +-- maxMomentsLagsToCreate -> loop control
            +-- startSequenceAtLag -> sequence start
            +-- simplifyDownValues -> controls simplification
            +-- IterationLimit -> uncondCovLongExo -> Block[$IterationLimit]
```

---

## Notes on Options Gaps

1. **Numerical Phase Gap**: `splitConfig[config, "Numerical"]` exists but is NOT used in `buildModelsInternal`. The numerical phase uses model defaults.

2. **Parallel Phase Gap**: `splitConfig[config, "Parallel"]` exists but `NumKernels` is accessed directly from `config["Parallel"]["NumKernels"]`.

3. **checkModels Simplification**: `checkModels` only passes `"Models"` to `buildModels`, not forwarding other options the user might want to customize.
