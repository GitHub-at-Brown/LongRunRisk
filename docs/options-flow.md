# Options Flow Across LongRunRisk Package

This document provides a comprehensive overview of how options flow across functions in all 27 `.wl` files in the LongRunRisk package's Kernel directory.

For detailed analysis of individual files, see the documentation in [`docs/options/`](./options/).

---

## Executive Summary

The LongRunRisk package uses Wolfram Language's `OptionsPattern[]`/`OptionValue`/`FilterRules` system extensively for configuration. Options flow through several layers:

1. **Entry Points**: User-facing functions like `BuildModels`, `YieldCurve`, `ToNum`
2. **Configuration System**: `OptionsConfig.wl` normalizes and distributes options
3. **Computational Functions**: Options are filtered and forwarded to solver functions
4. **Terminal Functions**: Options are consumed by Wolfram built-ins (`FindRoot`, `RecurrenceTable`, `Simplify`, etc.)

---

## Files Overview by Category

### Model Definition Files (No Options)

| File | Functions | Options |
|------|-----------|---------|
| `Shocks.wl` | `rulesE`, `eps` | None |
| `ExogenousEq.wl` | `xeq`, `pieq`, `pibareq`, `dceq`, `sgeq`, `sxeq`, `sceq`, `speq`, `ddeq` | None |
| `Parameters.wl` | `paramList`, `paramAssumptions` | None |
| `EndogenousEq.wl` | `wceq`, `pdeq`, `bondeq`, `sdfeq`, etc. (24 functions) | None |
| `Catalog.wl` | `models`, `modelsExtraInfo` | None |

These files define pure mathematical equations using global parameters. No options handling.

### Computational Engine Files

| File | Key Functions with Options | Options Pattern |
|------|---------------------------|-----------------|
| `ProcessModels.wl` | `processModels`, `solveCoeffsSystem`, `addCoeffsSolution` | Complex inheritance from multiple functions |
| `ParamQuadSolve.wl` | `paramQuadSolve`, `simplifyWithDummySubstitution` | 14+ options for solver control |
| `SolveEulerEq.wl` | `updateCoeffs`, `updateCoeffsSol`, `solveCoeffRoots` | Inherits from `FindRoot`, `RecurrenceTable` |
| `ComputeConditionalExpectations.wl` | `lagStateVarst` (private) | `"MaxIterations"`, `"TimeConstraint"` (not exposed publicly) |
| `ComputeUnconditionalExpectations.wl` | None | None |
| `CreateEulerEq.wl` | None | None |
| `CreateMomentsDatabase.wl` | `createDatabase`, `uncondCovLongExo` | `"IterationLimit"`, `"maxMomentsLagsToCreate"` |

### Tools Files

| File | Key Functions with Options | Options |
|------|---------------------------|---------|
| `FindRootOptim.wl` | `buildKernel`, `fastRoot`, `scanAndSolve`, etc. | 20+ options for compilation and root-finding |
| `ManageResources.wl` | `buildModels`, `buildModelsInternal` | 9 top-level options + nested config |
| `OptionsConfig.wl` | `normalizeConfig`, `splitConfig` | Central config system |
| `TimeAggregation.wl` | `growth`, `g`, `timeSeriesVector`, `gt` | 5 options for time aggregation |
| `NicePlots.wl` | `yieldCurve`, `plotCoeffs` | Inherits from `updateCoeffs`, `FindRoot` |
| `ToNumber.wl` | `toNumRules` (internal) | Inherits from `updateCoeffs` |
| `VisualizeCoeffs.wl` | `visualizeCoeffs` | `"ShowSelector"`, `"ShowDetails"` |
| `PipelineMonitor.wl` | `checkModels` | `"AutoBuild"` |
| `NiceOutput.wl` | `numberFormattingTemplate` | Inherits from `ToString` |
| `ValidateModels.wl` | None | None |
| `CopyDefinitions.wl` | None | None |
| `CompoundScope.wl` | None | None |
| `Dependencies.wl` | None | None |
| `ReExport.wl` | None | None |

### Main Package File

| File | Re-exported Functions with Options |
|------|-----------------------------------|
| `LongRunRisk.wl` | `BuildModels`, `YieldCurve`, `PlotCoeffs`, `Growth`, `ToNum`, `VisualizeCoeffs`, `CheckModels` |

---

## Primary Options Flow Chains

### Chain: BuildModels Pipeline

```
BuildModels[opts...]
    |
    v
normalizeConfig[{opts}]  (OptionsConfig.wl)
    |
    v
buildModelsInternal[config]  (ManageResources.wl)
    |
    +-- Phase 1 (Symbolic):
    |   splitConfig[config, "Symbolic"]
    |       |
    |       v
    |   processModels[..., symbolicOpts]  (ProcessModels.wl)
    |       |
    |       +-> solveCoeffsSystem -> paramQuadSolve (ParamQuadSolve.wl)
    |       |       Options: "SimplifyOptions", "paramQuadSolveOptions", "PdEquations"
    |       |       Terminal: Simplify, FullSimplify, GroebnerBasis
    |       |
    |       +-> addCoeffsSolution -> RecurrenceTable (Wolfram built-in)
    |               Options: "MaxMaturity", "RecurrenceTableOptions"
    |
    +-- Phase 2 (Compile):
    |   splitConfig[config, "Compile"]
    |       |
    |       v
    |   createCompiledEq[..., compileOpts]  (FindRootOptim.wl)
    |       |
    |       v
    |   buildKernel[...]
    |       Options: "CoeffName", "SignSymbol", "PerformanceGoal", "CompileMode", "Compiler"
    |       Terminal: Compile, FunctionCompile (Wolfram built-ins)
    |
    +-- Phase 3 (Numerical):
    |   addCoeffsSolutionN[model]  (SolveEulerEq.wl)
    |       |
    |       v
    |   updateCoeffs -> updateCoeffsSol -> solveCoeffRoots
    |       Options: "initialGuess", "FindRootOptions", "RootSigns", "MaxMaturity"
    |       |
    |       v
    |   fastRoot -> scanAndSolve  (FindRootOptim.wl)
    |       Terminal: FindRoot, NMinimize (Wolfram built-ins)
    |
    +-- Phase 4 (Moments):
        splitConfig[config, "Moments"]
            |
            v
        createDatabase[..., momentsOpts]  (CreateMomentsDatabase.wl)
            Options: "maxMomentsLagsToCreate", "startSequenceAtLag", "IterationLimit"
            Terminal: Block[{$IterationLimit = ...}, ...]
```

### Chain: Numerical Evaluation (ToNum, YieldCurve)

```
ToNum[model, newParams, opts...]  or  YieldCurve[model, newParams, opts...]
    |
    v
toNumRules / yieldCurve  (ToNumber.wl / NicePlots.wl)
    |
    v
FilterRules[{opts}, Options[updateCoeffs]]
    |
    v
updateCoeffs[model, kernels, params, guess, updateOpts]  (SolveEulerEq.wl)
    |
    +-> updateCoeffsSol
    |       Options: "UpdatePd", "UpdateBond", "UpdateBonds", "MaxMaturity", "RootSigns"
    |       |
    |       +-> solveCoeffRoots -> fastRoot -> FindRoot (terminal)
    |       |
    |       +-> updateCoeffsBond -> RecurrenceTable (terminal)
    |       |
    |       +-> checks
    |               Options: "PrintResidualsNorm", "CheckResiduals", "Tol"
    |               Terminal: Direct value comparison
    |
    v
FilterRules[{opts}, Options[RecurrenceTable]]
    |
    v
RecurrenceTable[..., recurrenceOpts]  (Wolfram built-in, terminal)
```

### Chain: Time Aggregation (Growth)

```
Growth[v, t, opts...]  (TimeAggregation.wl)
    |
    +-> Own options: "v0", "Order" (terminal)
    |
    +-> FilterRules[{opts}, Except[Options[growth]]]
            |
            v
        gt[v, t, im, optsgt]
            |
            +-> FilterRules -> timeSeriesVector
            |       Options: "TimeAggregation", "numPeriods" (terminal)
            |
            +-> FilterRules -> g
                    Option: "Variable" (terminal)
```

### Chain: Root Finding (fastRoot)

```
fastRoot[f, spec, opts...]  (FindRootOptim.wl)
    |
    +-> Own options:
    |       Jacobian (terminal: passed to FindRoot)
    |       Method (terminal: controls algorithm selection)
    |       "SecantBlend" (terminal: blend factor)
    |       "Return" (terminal: output format)
    |
    +-> "FindRootOptions" (if Automatic, generates StepMonitor)
    |
    +-> FilterRules[{opts}, Options[FindRoot]]
            |
            v
        tryNewton1D / tryBrent1D / trySecant1D / tryDefaultFindRoot
            |
            v
        FindRoot[..., findRootOpts]  (Wolfram built-in, terminal)
```

---

## Key Option Categories

### Solver Options (ParamQuadSolve.wl)

| Option | Default | Purpose |
|--------|---------|---------|
| `"DomainOption"` | `Reals` | Solution domain |
| `"Assumptions"` | `Automatic` | Assumptions for simplification |
| `"Method"` | `Automatic` | Solver method selection |
| `"MonomialOrder"` | `Automatic` | GroebnerBasis ordering |
| `"TimeoutOption"` | `600` | Overall timeout (seconds) |
| `"SimplifyTimeout"` | `Automatic` | Per-Simplify timeout |
| `"SignSymbol"` | `signA` | Symbol for sign parameters |
| `"GroebnerMemory*"` | Various | Memory limits for Groebner |

### Compilation Options (FindRootOptim.wl)

| Option | Default | Purpose |
|--------|---------|---------|
| `"CoeffName"` | `"A"` | Coefficient symbol name |
| `"SignSymbol"` | `"signA"` | Sign symbol name |
| `"PerformanceGoal"` | `"Speed"` | Optimization level |
| `"CompileMode"` | `"FunctionOnly"` | Compile function/Jacobian/both |
| `"Compiler"` | `"Compile"` | Compile vs FunctionCompile |
| `"FlattenExpressions"` | `Automatic` | Flatten before compile |

### Numerical Options (SolveEulerEq.wl)

| Option | Default | Purpose |
|--------|---------|---------|
| `"initialGuess"` | `<\|"Ewc"->{4},"Epd"->{{4}}\|>` | Starting values |
| `"FindRootOptions"` | `{}` | Options for FindRoot |
| `"RecurrenceTableOptions"` | `{"DependentVariables"->Automatic}` | Options for RecurrenceTable |
| `"MaxMaturity"` | `12` | Bond maturity limit |
| `"RootSigns"` | `Automatic` | Sign selection for roots |
| `"UpdatePd"` / `"UpdateBond"` / `"UpdateBonds"` | `False` | What to update |

### Moments Options (CreateMomentsDatabase.wl)

| Option | Default | Purpose |
|--------|---------|---------|
| `"maxMomentsLagsToCreate"` | `8` | Maximum lags to compute |
| `"startSequenceAtLag"` | `3` | Sequence function start |
| `"simplifyDownValues"` | `False` | Simplify computed moments |
| `"IterationLimit"` | `$IterationLimit/4` | Iteration limit for computations |

---

## Terminal Destinations

All option chains ultimately terminate at:

1. **Wolfram Built-in Functions**:
   - `FindRoot` - numerical root finding
   - `RecurrenceTable` - coefficient recursions
   - `Simplify` / `FullSimplify` - expression simplification
   - `Compile` / `FunctionCompile` - code compilation
   - `GroebnerBasis` - polynomial solving
   - `NMinimize` / `FindMinimum` - optimization fallback

2. **Package-Internal Terminal Uses**:
   - Direct value comparisons (tolerance checks)
   - UI control flags (`"ShowSelector"`, `"ShowDetails"`)
   - Loop control (`"MaxMaturity"`, `"maxMomentsLagsToCreate"`)
   - Block scoping (`Block[{$IterationLimit = ...}]`)

---

## Cross-File Dependencies Summary

```
User Entry Points
    |
    +-> ManageResources.wl (buildModels)
    |       |
    |       +-> OptionsConfig.wl (normalizeConfig, splitConfig)
    |       +-> ProcessModels.wl (processModels, solveCoeffsSystem)
    |       |       +-> ParamQuadSolve.wl (paramQuadSolve)
    |       +-> FindRootOptim.wl (createCompiledEq, buildKernel)
    |       +-> SolveEulerEq.wl (updateCoeffs, solveCoeffRoots)
    |       |       +-> FindRootOptim.wl (fastRoot, scanAndSolve)
    |       +-> CreateMomentsDatabase.wl (createDatabase)
    |
    +-> NicePlots.wl (yieldCurve)
    |       +-> SolveEulerEq.wl (updateCoeffs)
    |
    +-> ToNumber.wl (toNum)
    |       +-> SolveEulerEq.wl (updateCoeffs)
    |
    +-> TimeAggregation.wl (growth)
            +-> (self-contained)
```

---

## Individual File Documentation

For detailed options flow in each file, see:

- [`model-shocks-exogenous.md`](./options/model-shocks-exogenous.md) - Shocks.wl, ExogenousEq.wl
- [`model-parameters-endogenous.md`](./options/model-parameters-endogenous.md) - Parameters.wl, EndogenousEq.wl
- [`model-catalog-processmodels.md`](./options/model-catalog-processmodels.md) - Catalog.wl, ProcessModels.wl
- [`engine-unconditional-euler.md`](./options/engine-unconditional-euler.md) - ComputeUnconditionalExpectations.wl, CreateEulerEq.wl
- [`engine-conditional-quadsolve.md`](./options/engine-conditional-quadsolve.md) - ComputeConditionalExpectations.wl, ParamQuadSolve.wl
- [`engine-moments-solveeuler.md`](./options/engine-moments-solveeuler.md) - CreateMomentsDatabase.wl, SolveEulerEq.wl
- [`tools-visualize-validate-output.md`](./options/tools-visualize-validate-output.md) - VisualizeCoeffs.wl, ValidateModels.wl, NiceOutput.wl
- [`tools-time-copy-compound.md`](./options/tools-time-copy-compound.md) - TimeAggregation.wl, CopyDefinitions.wl, CompoundScope.wl
- [`tools-number-plots-reexport.md`](./options/tools-number-plots-reexport.md) - ToNumber.wl, NicePlots.wl, ReExport.wl
- [`tools-findroot-dependencies.md`](./options/tools-findroot-dependencies.md) - FindRootOptim.wl, Dependencies.wl
- [`tools-options-resources-pipeline.md`](./options/tools-options-resources-pipeline.md) - OptionsConfig.wl, ManageResources.wl, PipelineMonitor.wl
- [`main-longrunrisk.md`](./options/main-longrunrisk.md) - LongRunRisk.wl (main package file)

---

## Bottom-Up Options Flow Chains

This section shows option flow from the bottom up: starting from each individual option and tracing upward through the functions that consume it, then the functions that pass it, up to the user-facing entry points.

### Solver Options (ParamQuadSolve.wl)

#### Option: "DomainOption"

```
"DomainOption"
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl, terminal consumer)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, passes via "paramQuadSolveOptions")
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "Assumptions"

```
"Assumptions"
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl, terminal consumer)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, passes via "paramQuadSolveOptions")
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "Method" (Solver)

```
"Method"
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl, terminal consumer)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, passes via "paramQuadSolveOptions")
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "MonomialOrder"

```
"MonomialOrder"
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl, terminal consumer -> GroebnerBasis)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, passes via "paramQuadSolveOptions")
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "TimeoutOption"

```
"TimeoutOption"
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl, terminal consumer)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, passes via "paramQuadSolveOptions")
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "SimplifyTimeout"

```
"SimplifyTimeout"
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl, terminal consumer -> Simplify/FullSimplify)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, passes via "paramQuadSolveOptions")
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "SimplifyOptions"

```
"SimplifyOptions"
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, terminal consumer -> Simplify)
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "paramQuadSolveOptions"

```
"paramQuadSolveOptions"
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, unpacks and forwards to paramQuadSolve)
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "PdEquations"

```
"PdEquations"
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, terminal consumer)
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "ValidationOption"

```
"ValidationOption"
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl, terminal consumer - validates solutions)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, passes via "paramQuadSolveOptions")
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "ReturnOption"

```
"ReturnOption"
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl, terminal consumer - controls output format)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, passes via "paramQuadSolveOptions")
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "DiagnosticsOption"

```
"DiagnosticsOption"
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl, terminal consumer - enables diagnostics output)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, passes via "paramQuadSolveOptions")
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "OnlyQuadTerms"

```
"OnlyQuadTerms"
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl, terminal consumer - restricts to quadratic terms)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, passes via "paramQuadSolveOptions")
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "GroebnerMemoryFraction"

```
"GroebnerMemoryFraction"
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl, terminal consumer -> GroebnerBasis memory allocation)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, passes via "paramQuadSolveOptions")
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "GroebnerMemoryFloor"

```
"GroebnerMemoryFloor"
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl, terminal consumer -> GroebnerBasis minimum memory)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, passes via "paramQuadSolveOptions")
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "GroebnerMemoryCap"

```
"GroebnerMemoryCap"
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl, terminal consumer -> GroebnerBasis maximum memory)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl, passes via "paramQuadSolveOptions")
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

### Compilation Options (FindRootOptim.wl)

#### Option: "CoeffName"

```
"CoeffName"
    ^
    |
buildKernel  (FindRootOptim.wl, terminal consumer -> Compile/FunctionCompile)
    ^
    |
createCompiledEq  (FindRootOptim.wl)
    ^
    |
buildModelsInternal [Phase 2: Compile]  (ManageResources.wl)
    ^
    |
splitConfig[config, "Compile"]  (OptionsConfig.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "SignSymbol"

```
"SignSymbol"
    ^
    |
+-- buildKernel  (FindRootOptim.wl, terminal consumer)
|       ^
|       |
|   createCompiledEq  (FindRootOptim.wl)
|       ^
|       |
|   buildModelsInternal [Phase 2: Compile]  (ManageResources.wl)
|
+-- paramQuadSolve  (ParamQuadSolve.wl, terminal consumer)
        ^
        |
    solveCoeffsSystem  (ProcessModels.wl)
        ^
        |
    buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
        ^
        |
    splitConfig  (OptionsConfig.wl)
        ^
        |
    normalizeConfig  (OptionsConfig.wl)
        ^
        |
    BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "PerformanceGoal"

```
"PerformanceGoal"
    ^
    |
buildKernel  (FindRootOptim.wl, terminal consumer -> Compile/FunctionCompile)
    ^
    |
createCompiledEq  (FindRootOptim.wl)
    ^
    |
buildModelsInternal [Phase 2: Compile]  (ManageResources.wl)
    ^
    |
splitConfig[config, "Compile"]  (OptionsConfig.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "CompileMode"

```
"CompileMode"
    ^
    |
buildKernel  (FindRootOptim.wl, terminal consumer)
    ^
    |
createCompiledEq  (FindRootOptim.wl)
    ^
    |
buildModelsInternal [Phase 2: Compile]  (ManageResources.wl)
    ^
    |
splitConfig[config, "Compile"]  (OptionsConfig.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "Compiler"

```
"Compiler"
    ^
    |
buildKernel  (FindRootOptim.wl, terminal consumer -> selects Compile vs FunctionCompile)
    ^
    |
createCompiledEq  (FindRootOptim.wl)
    ^
    |
buildModelsInternal [Phase 2: Compile]  (ManageResources.wl)
    ^
    |
splitConfig[config, "Compile"]  (OptionsConfig.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "FlattenExpressions"

```
"FlattenExpressions"
    ^
    |
buildKernel  (FindRootOptim.wl, terminal consumer)
    ^
    |
createCompiledEq  (FindRootOptim.wl)
    ^
    |
buildModelsInternal [Phase 2: Compile]  (ManageResources.wl)
    ^
    |
splitConfig[config, "Compile"]  (OptionsConfig.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "RuntimeOptions"

```
"RuntimeOptions"
    ^
    |
buildKernel  (FindRootOptim.wl, terminal consumer -> Compile RuntimeOptions)
    ^
    |
createCompiledEq  (FindRootOptim.wl)
    ^
    |
buildModelsInternal [Phase 2: Compile]  (ManageResources.wl)
    ^
    |
splitConfig[config, "Compile"]  (OptionsConfig.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "CompilationTarget"

```
"CompilationTarget"
    ^
    |
buildKernel  (FindRootOptim.wl, terminal consumer -> Compile/FunctionCompile target)
    ^
    |
createCompiledEq  (FindRootOptim.wl)
    ^
    |
buildModelsInternal [Phase 2: Compile]  (ManageResources.wl)
    ^
    |
splitConfig[config, "Compile"]  (OptionsConfig.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "AllowCompileDuringCoverage"

```
"AllowCompileDuringCoverage"
    ^
    |
buildKernel  (FindRootOptim.wl, terminal consumer - controls coverage mode behavior)
    ^
    |
createCompiledEq  (FindRootOptim.wl)
    ^
    |
buildModelsInternal [Phase 2: Compile]  (ManageResources.wl)
    ^
    |
splitConfig[config, "Compile"]  (OptionsConfig.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

### Numerical Options (SolveEulerEq.wl)

#### Option: "initialGuess"

```
"initialGuess"
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl, provides starting values)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
+-- addCoeffsSolutionN  (SolveEulerEq.wl)
|       ^
|       |
|   buildModelsInternal [Phase 3: Numerical]  (ManageResources.wl)
|       ^
|       |
|   BuildModels  (LongRunRisk.wl, user entry point)
|
+-- toNumRules  (ToNumber.wl)
|       ^
|       |
|   ToNum  (LongRunRisk.wl, user entry point)
|
+-- yieldCurve  (NicePlots.wl)
        ^
        |
    YieldCurve  (LongRunRisk.wl, user entry point)
```

#### Option: "FindRootOptions"

```
"FindRootOptions"
    ^
    |
fastRoot  (FindRootOptim.wl, unpacks and forwards to FindRoot)
    ^
    |
scanAndSolve  (FindRootOptim.wl)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
+-- addCoeffsSolutionN  (SolveEulerEq.wl)
|       ^
|       |
|   buildModelsInternal [Phase 3: Numerical]  (ManageResources.wl)
|       ^
|       |
|   BuildModels  (LongRunRisk.wl, user entry point)
|
+-- toNumRules  (ToNumber.wl)
|       ^
|       |
|   ToNum  (LongRunRisk.wl, user entry point)
|
+-- yieldCurve  (NicePlots.wl)
        ^
        |
    YieldCurve  (LongRunRisk.wl, user entry point)
```

#### Option: "RecurrenceTableOptions"

```
"RecurrenceTableOptions"
    ^
    |
addCoeffsSolution  (ProcessModels.wl, forwards to RecurrenceTable)
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "MaxMaturity"

```
"MaxMaturity"
    ^
    |
+-- addCoeffsSolution  (ProcessModels.wl, loop control)
|       ^
|       |
|   processModels  (ProcessModels.wl)
|       ^
|       |
|   buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
|
+-- updateCoeffsSol  (SolveEulerEq.wl, loop control)
|       ^
|       |
|   updateCoeffs  (SolveEulerEq.wl)
|       ^
|       |
|   +-- addCoeffsSolutionN  (SolveEulerEq.wl)
|   |       ^
|   |       |
|   |   buildModelsInternal [Phase 3: Numerical]  (ManageResources.wl)
|   |
|   +-- toNumRules  (ToNumber.wl)
|   |       ^
|   |       |
|   |   ToNum  (LongRunRisk.wl, user entry point)
|   |
|   +-- yieldCurve  (NicePlots.wl)
|           ^
|           |
|       YieldCurve  (LongRunRisk.wl, user entry point)
|
+-- updateCoeffsBond  (SolveEulerEq.wl, loop control)
        ^
        |
    updateCoeffsSol  (SolveEulerEq.wl)
        ^
        |
    [continues as above]
```

#### Option: "RootSigns"

```
"RootSigns"
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl, sign selection for quadratic roots)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
+-- addCoeffsSolutionN  (SolveEulerEq.wl)
|       ^
|       |
|   buildModelsInternal [Phase 3: Numerical]  (ManageResources.wl)
|       ^
|       |
|   BuildModels  (LongRunRisk.wl, user entry point)
|
+-- toNumRules  (ToNumber.wl)
|       ^
|       |
|   ToNum  (LongRunRisk.wl, user entry point)
|
+-- yieldCurve  (NicePlots.wl)
        ^
        |
    YieldCurve  (LongRunRisk.wl, user entry point)
```

#### Option: "UpdatePd"

```
"UpdatePd"
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl, terminal consumer - controls what to update)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
+-- toNumRules  (ToNumber.wl)
|       ^
|       |
|   ToNum  (LongRunRisk.wl, user entry point)
|
+-- yieldCurve  (NicePlots.wl)
        ^
        |
    YieldCurve  (LongRunRisk.wl, user entry point)
```

#### Option: "UpdateBond"

```
"UpdateBond"
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl, terminal consumer - controls what to update)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
+-- toNumRules  (ToNumber.wl)
|       ^
|       |
|   ToNum  (LongRunRisk.wl, user entry point)
|
+-- yieldCurve  (NicePlots.wl)
        ^
        |
    YieldCurve  (LongRunRisk.wl, user entry point)
```

#### Option: "UpdateBonds"

```
"UpdateBonds"
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl, terminal consumer - controls what to update)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
+-- toNumRules  (ToNumber.wl)
|       ^
|       |
|   ToNum  (LongRunRisk.wl, user entry point)
|
+-- yieldCurve  (NicePlots.wl)
        ^
        |
    YieldCurve  (LongRunRisk.wl, user entry point)
```

#### Option: "UpdateNomBond"

```
"UpdateNomBond"
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl, terminal consumer - controls nominal bond update)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
+-- toNumRules  (ToNumber.wl)
|       ^
|       |
|   ToNum  (LongRunRisk.wl, user entry point)
|
+-- yieldCurve  (NicePlots.wl)
        ^
        |
    YieldCurve  (LongRunRisk.wl, user entry point)
```

#### Option: "Signs"

```
"Signs"
    ^
    |
+-- solveCoeffRoots  (SolveEulerEq.wl, terminal consumer - explicit sign values)
|       ^
|       |
|   updateCoeffsSol  (SolveEulerEq.wl)
|       ^
|       |
|   updateCoeffs  (SolveEulerEq.wl)
|       ^
|       |
|   [multiple entry points: BuildModels, ToNum, YieldCurve]
|
+-- bindUnary  (FindRootOptim.wl, terminal consumer)
|
+-- findRootInterval  (FindRootOptim.wl, terminal consumer)
```

#### Option: "ReduceTimeLimit"

```
"ReduceTimeLimit"
    ^
    |
solveND  (SolveEulerEq.wl, terminal consumer -> TimeConstrained Reduce)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
+-- addCoeffsSolutionN  (SolveEulerEq.wl)
|       ^
|       |
|   buildModelsInternal [Phase 3: Numerical]  (ManageResources.wl)
|       ^
|       |
|   BuildModels  (LongRunRisk.wl, user entry point)
|
+-- toNumRules  (ToNumber.wl)
|       ^
|       |
|   ToNum  (LongRunRisk.wl, user entry point)
|
+-- yieldCurve  (NicePlots.wl)
        ^
        |
    YieldCurve  (LongRunRisk.wl, user entry point)
```

#### Option: "PrintResidualsNorm"

```
"PrintResidualsNorm"
    ^
    |
checks  (SolveEulerEq.wl, terminal consumer - controls output)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
+-- toNumRules  (ToNumber.wl)
|       ^
|       |
|   ToNum  (LongRunRisk.wl, user entry point)
|
+-- yieldCurve  (NicePlots.wl)
        ^
        |
    YieldCurve  (LongRunRisk.wl, user entry point)
```

#### Option: "CheckResiduals"

```
"CheckResiduals"
    ^
    |
checks  (SolveEulerEq.wl, terminal consumer - enables validation)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
+-- toNumRules  (ToNumber.wl)
|       ^
|       |
|   ToNum  (LongRunRisk.wl, user entry point)
|
+-- yieldCurve  (NicePlots.wl)
        ^
        |
    YieldCurve  (LongRunRisk.wl, user entry point)
```

#### Option: "Tol"

```
"Tol"
    ^
    |
checks  (SolveEulerEq.wl, terminal consumer - tolerance threshold)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
+-- toNumRules  (ToNumber.wl)
|       ^
|       |
|   ToNum  (LongRunRisk.wl, user entry point)
|
+-- yieldCurve  (NicePlots.wl)
        ^
        |
    YieldCurve  (LongRunRisk.wl, user entry point)
```

### Root Finding Options (FindRootOptim.wl)

#### Option: Jacobian

```
Jacobian
    ^
    |
fastRoot  (FindRootOptim.wl, passes to FindRoot)
    ^
    |
scanAndSolve  (FindRootOptim.wl)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
[multiple entry points: BuildModels, ToNum, YieldCurve]
```

#### Option: Method (FindRoot)

```
Method  (for FindRoot)
    ^
    |
fastRoot  (FindRootOptim.wl, controls algorithm: Newton/Brent/Secant)
    ^
    |
scanAndSolve  (FindRootOptim.wl)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
[multiple entry points: BuildModels, ToNum, YieldCurve]
```

#### Option: "SecantBlend"

```
"SecantBlend"
    ^
    |
fastRoot  (FindRootOptim.wl, terminal consumer - blend factor)
    ^
    |
scanAndSolve  (FindRootOptim.wl)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
[multiple entry points: BuildModels, ToNum, YieldCurve]
```

#### Option: "Return"

```
"Return"
    ^
    |
fastRoot  (FindRootOptim.wl, terminal consumer - output format)
    ^
    |
scanAndSolve  (FindRootOptim.wl)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
[multiple entry points: BuildModels, ToNum, YieldCurve]
```

### FindRoot Nested Options (config["Numerical"]["FindRoot"])

#### Option: "MaxIterations" (FindRoot)

```
"MaxIterations"
    ^
    |
fastRoot  (FindRootOptim.wl, forwards to FindRoot)
    ^
    |
scanAndSolve  (FindRootOptim.wl)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
+-- addCoeffsSolutionN  (SolveEulerEq.wl)
|       ^
|       |
|   buildModelsInternal [Phase 3: Numerical]  (ManageResources.wl)
|       ^
|       |
|   BuildModels  (LongRunRisk.wl, user entry point)
|
+-- toNumRules  (ToNumber.wl)
|       ^
|       |
|   ToNum  (LongRunRisk.wl, user entry point)
|
+-- yieldCurve  (NicePlots.wl)
        ^
        |
    YieldCurve  (LongRunRisk.wl, user entry point)
```

#### Option: "PrecisionGoal"

```
"PrecisionGoal"
    ^
    |
fastRoot  (FindRootOptim.wl, forwards to FindRoot)
    ^
    |
scanAndSolve  (FindRootOptim.wl)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
[multiple entry points: BuildModels, ToNum, YieldCurve]
```

#### Option: "AccuracyGoal"

```
"AccuracyGoal"
    ^
    |
fastRoot  (FindRootOptim.wl, forwards to FindRoot)
    ^
    |
scanAndSolve  (FindRootOptim.wl)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
[multiple entry points: BuildModels, ToNum, YieldCurve]
```

#### Option: "WorkingPrecision"

```
"WorkingPrecision"
    ^
    |
fastRoot  (FindRootOptim.wl, forwards to FindRoot)
    ^
    |
scanAndSolve  (FindRootOptim.wl)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
[multiple entry points: BuildModels, ToNum, YieldCurve]
```

#### Option: "Options" (FindRoot nested)

```
"Options"  (at config["Numerical"]["FindRoot"]["Options"])
    ^
    |
fastRoot  (FindRootOptim.wl, merged with other FindRoot options)
    ^
    |
scanAndSolve  (FindRootOptim.wl)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
[multiple entry points: BuildModels, ToNum, YieldCurve]
```

### RecurrenceTable Nested Options (config["Numerical"]["RecurrenceTable"])

#### Option: "DependentVariables"

```
"DependentVariables"
    ^
    |
addCoeffsSolution  (ProcessModels.wl, forwards to RecurrenceTable)
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "Options" (RecurrenceTable nested)

```
"Options"  (at config["Numerical"]["RecurrenceTable"]["Options"])
    ^
    |
addCoeffsSolution  (ProcessModels.wl, merged with RecurrenceTable options)
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
normalizeConfig / splitConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

### Scan Nested Options (config["Numerical"]["Scan"])

#### Option: "FastRootOptions"

```
"FastRootOptions"
    ^
    |
scanAndSolve  (FindRootOptim.wl, terminal consumer - passed to fastRoot)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
[multiple entry points: BuildModels, ToNum, YieldCurve]
```

#### Option: "UnboundedPad"

```
"UnboundedPad"
    ^
    |
+-- extractIntervalsFromReduce  (FindRootOptim.wl, terminal consumer)
|       ^
|       |
|   scanAndSolve  (FindRootOptim.wl)
|       ^
|       |
|   solveCoeffRoots  (SolveEulerEq.wl)
|
+-- config["Numerical"]["Scan"]["UnboundedPad"]
        ^
        |
    splitConfig[config, "Numerical"]  (OptionsConfig.wl)
        ^
        |
    normalizeConfig  (OptionsConfig.wl)
        ^
        |
    BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "ScanMethod"

```
"ScanMethod"
    ^
    |
scanAndSolve  (FindRootOptim.wl, terminal consumer - controls scanning algorithm)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
[multiple entry points: BuildModels, ToNum, YieldCurve]
```

### Moments Options (CreateMomentsDatabase.wl)

#### Option: "maxMomentsLagsToCreate"

```
"maxMomentsLagsToCreate"
    ^
    |
createDatabase  (CreateMomentsDatabase.wl, terminal consumer - loop control)
    ^
    |
buildModelsInternal [Phase 4: Moments]  (ManageResources.wl)
    ^
    |
splitConfig[config, "Moments"]  (OptionsConfig.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "startSequenceAtLag"

```
"startSequenceAtLag"
    ^
    |
createDatabase  (CreateMomentsDatabase.wl, terminal consumer)
    ^
    |
buildModelsInternal [Phase 4: Moments]  (ManageResources.wl)
    ^
    |
splitConfig[config, "Moments"]  (OptionsConfig.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "simplifyDownValues"

```
"simplifyDownValues"
    ^
    |
createDatabase  (CreateMomentsDatabase.wl, terminal consumer)
    ^
    |
buildModelsInternal [Phase 4: Moments]  (ManageResources.wl)
    ^
    |
splitConfig[config, "Moments"]  (OptionsConfig.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "IterationLimit"

```
"IterationLimit"
    ^
    |
createDatabase  (CreateMomentsDatabase.wl, terminal consumer -> Block[{$IterationLimit}])
    ^
    |
buildModelsInternal [Phase 4: Moments]  (ManageResources.wl)
    ^
    |
splitConfig[config, "Moments"]  (OptionsConfig.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

### Time Aggregation Options (TimeAggregation.wl)

#### Option: "v0"

```
"v0"
    ^
    |
growth  (TimeAggregation.wl, terminal consumer)
    ^
    |
Growth  (LongRunRisk.wl, user entry point)
```

#### Option: "Order"

```
"Order"
    ^
    |
growth  (TimeAggregation.wl, terminal consumer)
    ^
    |
Growth  (LongRunRisk.wl, user entry point)
```

#### Option: "TimeAggregation"

```
"TimeAggregation"
    ^
    |
timeSeriesVector  (TimeAggregation.wl, terminal consumer)
    ^
    |
gt  (TimeAggregation.wl)
    ^
    |
growth  (TimeAggregation.wl)
    ^
    |
Growth  (LongRunRisk.wl, user entry point)
```

#### Option: "numPeriods"

```
"numPeriods"
    ^
    |
timeSeriesVector  (TimeAggregation.wl, terminal consumer)
    ^
    |
gt  (TimeAggregation.wl)
    ^
    |
growth  (TimeAggregation.wl)
    ^
    |
Growth  (LongRunRisk.wl, user entry point)
```

#### Option: "Variable"

```
"Variable"
    ^
    |
g  (TimeAggregation.wl, terminal consumer)
    ^
    |
gt  (TimeAggregation.wl)
    ^
    |
growth  (TimeAggregation.wl)
    ^
    |
Growth  (LongRunRisk.wl, user entry point)
```

### Parallel Subsystem Options (config["Parallel"])

#### Option: "NumKernels"

```
"NumKernels"
    ^
    |
buildModelsParallel  (ManageResources.wl, terminal consumer - controls parallel kernel count)
    ^
    |
buildModels  (ManageResources.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

### Build Subsystem Options (config["Build"])

#### Option: "Models"

```
"Models"
    ^
    |
buildModelsInternal  (ManageResources.wl, terminal consumer - selects which models to build)
    ^
    |
buildModels  (ManageResources.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "FromScratch"

```
"FromScratch"
    ^
    |
buildModelsInternal  (ManageResources.wl, terminal consumer - forces complete rebuild)
    ^
    |
buildModels  (ManageResources.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "CompileJacobians"

```
"CompileJacobians"
    ^
    |
buildModelsInternal  (ManageResources.wl, terminal consumer - controls Jacobian compilation)
    ^
    |
buildModels  (ManageResources.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "CreateMoments"

```
"CreateMoments"
    ^
    |
buildModelsInternal  (ManageResources.wl, terminal consumer - controls moments database creation)
    ^
    |
buildModels  (ManageResources.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "MaxMaturity" (Build)

```
"MaxMaturity"  (at config["Build"]["MaxMaturity"])
    ^
    |
buildModelsInternal  (ManageResources.wl, currently reserved/unused)
    ^
    |
buildModels  (ManageResources.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)

Note: Build.MaxMaturity (default 120) is distinct from Numerical.MaxMaturity (default 12).
      Currently Build.MaxMaturity is reserved but not actively used in buildModels.
```

#### Option: "FileSuffix"

```
"FileSuffix"
    ^
    |
buildModelsInternal  (ManageResources.wl, terminal consumer - controls checkpoint file naming)
    ^
    |
buildModels  (ManageResources.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "UpdateManifest"

```
"UpdateManifest"
    ^
    |
buildModelsInternal  (ManageResources.wl, terminal consumer - controls manifest file updates)
    ^
    |
buildModels  (ManageResources.wl)
    ^
    |
normalizeConfig  (OptionsConfig.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

### Function-Level Options (Not in Centralized Config)

These options are defined on individual functions and not part of the centralized config system.

#### Option: "MomentFunction"

```
"MomentFunction"
    ^
    |
yieldCurve  (NicePlots.wl, terminal consumer - selects moment function for yield curve)
    ^
    |
YieldCurve  (LongRunRisk.wl, user entry point)
```

#### Option: "MaxIterations" (lagStateVarst)

```
"MaxIterations"  (lagStateVarst-specific, not exposed publicly)
    ^
    |
lagStateVarst  (ComputeConditionalExpectations.wl, terminal consumer - internal function)
    ^
    |
[internal use only - not exposed to user entry points]
```

#### Option: "TimeConstraint" (lagStateVarst)

```
"TimeConstraint"  (lagStateVarst-specific)
    ^
    |
lagStateVarst  (ComputeConditionalExpectations.wl, terminal consumer - internal function)
    ^
    |
[internal use only - not exposed to user entry points]
```

#### Option: "Level0Pattern"

```
"Level0Pattern"
    ^
    |
simplifyWithDummySubstitution  (ParamQuadSolve.wl, terminal consumer)
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl)
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "SimplifyFunction"

```
"SimplifyFunction"
    ^
    |
simplifyWithDummySubstitution  (ParamQuadSolve.wl, terminal consumer - selects Simplify/FullSimplify)
    ^
    |
paramQuadSolve  (ParamQuadSolve.wl)
    ^
    |
solveCoeffsSystem  (ProcessModels.wl)
    ^
    |
processModels  (ProcessModels.wl)
    ^
    |
buildModelsInternal [Phase 1: Symbolic]  (ManageResources.wl)
    ^
    |
BuildModels  (LongRunRisk.wl, user entry point)
```

#### Option: "BracketGrid"

```
"BracketGrid"
    ^
    |
scanAndSolve  (FindRootOptim.wl, terminal consumer - grid size for bracketing)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
[multiple entry points: BuildModels, ToNum, YieldCurve]
```

#### Option: "Tolerance" (scanAndSolve)

```
"Tolerance"
    ^
    |
scanAndSolve  (FindRootOptim.wl, terminal consumer - tolerance for near-zero detection)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
[multiple entry points: BuildModels, ToNum, YieldCurve]
```

#### Option: "InteriorShrink"

```
"InteriorShrink"
    ^
    |
extractIntervalsFromReduce  (FindRootOptim.wl, terminal consumer)
    ^
    |
scanAndSolve  (FindRootOptim.wl)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
[multiple entry points: BuildModels, ToNum, YieldCurve]
```

#### Option: "RootUpperBound"

```
"RootUpperBound"
    ^
    |
extractIntervalsFromReduce  (FindRootOptim.wl, terminal consumer)
    ^
    |
scanAndSolve  (FindRootOptim.wl)
    ^
    |
solveCoeffRoots  (SolveEulerEq.wl)
    ^
    |
updateCoeffsSol  (SolveEulerEq.wl)
    ^
    |
updateCoeffs  (SolveEulerEq.wl)
    ^
    |
[multiple entry points: BuildModels, ToNum, YieldCurve]
```

### Visualization Options

#### Option: "ShowSelector"

```
"ShowSelector"
    ^
    |
visualizeCoeffs  (VisualizeCoeffs.wl, terminal consumer - UI control)
    ^
    |
VisualizeCoeffs  (LongRunRisk.wl, user entry point)
```

#### Option: "ShowDetails"

```
"ShowDetails"
    ^
    |
visualizeCoeffs  (VisualizeCoeffs.wl, terminal consumer - UI control)
    ^
    |
VisualizeCoeffs  (LongRunRisk.wl, user entry point)
```

### Pipeline Options

#### Option: "AutoBuild"

```
"AutoBuild"
    ^
    |
checkModels  (PipelineMonitor.wl, terminal consumer)
    ^
    |
CheckModels  (LongRunRisk.wl, user entry point)
```

---

## Bottom-Up Summary by Entry Point

This table shows which options ultimately flow to each user-facing function:

| Entry Point | Options That Flow to It |
|-------------|------------------------|
| `BuildModels` | **Symbolic**: "PdEquations", "SimplifyOptions", "paramQuadSolveOptions" (including "DomainOption", "Assumptions", "Method", "MonomialOrder", "ValidationOption", "ReturnOption", "TimeoutOption", "SimplifyTimeout", "DiagnosticsOption", "OnlyQuadTerms", "SignSymbol", "GroebnerMemoryFraction", "GroebnerMemoryFloor", "GroebnerMemoryCap"), "Level0Pattern", "SimplifyFunction". **Compile**: "CoeffName", "SignSymbol", "PerformanceGoal", "CompileMode", "Compiler", "RuntimeOptions", "CompilationTarget", "FlattenExpressions", "AllowCompileDuringCoverage". **Numerical**: "initialGuess", "MaxMaturity", "RootSigns", "Signs", "UpdatePd", "UpdateBond", "UpdateNomBond", "UpdateBonds", "ReduceTimeLimit", "FindRootOptions", "RecurrenceTableOptions", nested FindRoot options ("MaxIterations", "PrecisionGoal", "AccuracyGoal", "WorkingPrecision", "Options"), nested RecurrenceTable options ("DependentVariables", "Options"), nested Scan options ("FastRootOptions", "UnboundedPad", "ScanMethod"), nested Checks options ("PrintResidualsNorm", "CheckResiduals", "Tol"). **Moments**: "maxMomentsLagsToCreate", "startSequenceAtLag", "simplifyDownValues", "IterationLimit". **Parallel**: "NumKernels". **Build**: "Models", "FromScratch", "CompileJacobians", "CreateMoments", "MaxMaturity" (Build), "FileSuffix", "UpdateManifest". |
| `ToNum` | "initialGuess", "FindRootOptions", "MaxMaturity", "RootSigns", "Signs", "UpdatePd", "UpdateBond", "UpdateNomBond", "UpdateBonds", "ReduceTimeLimit", "PrintResidualsNorm", "CheckResiduals", "Tol", Jacobian, Method, "SecantBlend", "Return", "BracketGrid", "Tolerance", "InteriorShrink", "RootUpperBound", "FastRootOptions" |
| `YieldCurve` | Same as `ToNum`, plus "MomentFunction" |
| `Growth` | "v0", "Order", "TimeAggregation", "numPeriods", "Variable" |
| `VisualizeCoeffs` | "ShowSelector", "ShowDetails" |
| `CheckModels` | "AutoBuild" |
| `PlotCoeffs` | Inherits from `updateCoeffs` (same as `ToNum`) |
