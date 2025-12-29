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
