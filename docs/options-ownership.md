# Options Ownership Map

This document assigns each option to a single **owner function** — the terminal consumer that actually uses the option value. Options with multiple owners are flagged.

---

## Summary Statistics

| Category | Count |
|----------|-------|
| Total Package Options | 78 |
| Single Owner | 62 |
| Multiple Owners (⚠️ flagged) | 16 |
| Built-in Symbol Options | 15 |

---

## Ownership by Subsystem

### Symbolic Subsystem

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"PdEquations"` | `solveCoeffsSystem` | ProcessModels.wl | Selects equation variant |
| `"SimplifyOptions"` | `solveCoeffsSystem` | ProcessModels.wl | Passed to Simplify |
| `"paramQuadSolveOptions"` | `solveCoeffsSystem` | ProcessModels.wl | Unpacks to paramQuadSolve |

#### paramQuadSolveOptions (nested)

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"DomainOption"` | `paramQuadSolve` | ParamQuadSolve.wl | Solution domain |
| `"Assumptions"` | `paramQuadSolve` | ParamQuadSolve.wl | Simplification assumptions |
| `"Method"` | `paramQuadSolve` | ParamQuadSolve.wl | Solver method |
| `"MonomialOrder"` | `paramQuadSolve` | ParamQuadSolve.wl | GroebnerBasis ordering |
| `"TimeoutOption"` | `paramQuadSolve` | ParamQuadSolve.wl | Overall timeout |
| `"SimplifyTimeout"` | `paramQuadSolve` | ParamQuadSolve.wl | Per-Simplify timeout |
| `"ValidationOption"` | `paramQuadSolve` | ParamQuadSolve.wl | Solution validation |
| `"ReturnOption"` | `paramQuadSolve` | ParamQuadSolve.wl | Output format |
| `"DiagnosticsOption"` | `paramQuadSolve` | ParamQuadSolve.wl | Diagnostics output |
| `"OnlyQuadTerms"` | `paramQuadSolve` | ParamQuadSolve.wl | Restrict to quadratic |
| `"GroebnerMemoryFraction"` | `paramQuadSolve` | ParamQuadSolve.wl | Memory allocation |
| `"GroebnerMemoryFloor"` | `paramQuadSolve` | ParamQuadSolve.wl | Minimum memory |
| `"GroebnerMemoryCap"` | `paramQuadSolve` | ParamQuadSolve.wl | Maximum memory |
| `"Level0Pattern"` | `simplifyWithDummySubstitution` | ParamQuadSolve.wl | Pattern matching |
| `"SimplifyFunction"` | `simplifyWithDummySubstitution` | ParamQuadSolve.wl | Simplify vs FullSimplify |

---

### Compile Subsystem

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"CoeffName"` | `buildKernel` | FindRootOptim.wl | Coefficient variable name |
| `"PerformanceGoal"` | `buildKernel` | FindRootOptim.wl | Speed vs Quality |
| `"CompileMode"` | `buildKernel` | FindRootOptim.wl | Function/Jacobian/Both |
| `"Compiler"` | `buildKernel` | FindRootOptim.wl | Compile vs FunctionCompile |
| `"RuntimeOptions"` | `buildKernel` | FindRootOptim.wl | Compile runtime options |
| `"CompilationTarget"` | `buildKernel` | FindRootOptim.wl | C/WVM/MVM |
| `"FlattenExpressions"` | `buildKernel` | FindRootOptim.wl | Pre-compilation flattening |
| `"AllowCompileDuringCoverage"` | `buildKernel` | FindRootOptim.wl | Coverage mode control |
| ⚠️ `"SignSymbol"` | **MULTIPLE** | | See flagged section |

---

### Numerical Subsystem

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"initialGuess"` | `solveCoeffRoots` | SolveEulerEq.wl | Starting values |
| `"RootSigns"` | `solveCoeffRoots` | SolveEulerEq.wl | Sign selection |
| `"ReduceTimeLimit"` | `solveND` | SolveEulerEq.wl | TimeConstrained Reduce |
| `"UpdatePd"` | `updateCoeffsSol` | SolveEulerEq.wl | What to update |
| `"UpdateBond"` | `updateCoeffsSol` | SolveEulerEq.wl | What to update |
| `"UpdateNomBond"` | `updateCoeffsSol` | SolveEulerEq.wl | What to update |
| `"UpdateBonds"` | `updateCoeffsSol` | SolveEulerEq.wl | What to update |
| `"RecurrenceTableOptions"` | `addCoeffsSolution` | ProcessModels.wl | RecurrenceTable options |
| ⚠️ `"MaxMaturity"` | **MULTIPLE** | | See flagged section |
| ⚠️ `"Signs"` | **MULTIPLE** | | See flagged section |

#### FindRoot Nested Options

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"MaxIterations"` | `fastRoot` | FindRootOptim.wl | Passed to FindRoot |
| `"PrecisionGoal"` | `fastRoot` | FindRootOptim.wl | Passed to FindRoot |
| `"AccuracyGoal"` | `fastRoot` | FindRootOptim.wl | Passed to FindRoot |
| `"WorkingPrecision"` | `fastRoot` | FindRootOptim.wl | Passed to FindRoot |
| `"Options"` (FindRoot) | `fastRoot` | FindRootOptim.wl | Merged with FindRoot |
| `"FindRootOptions"` | `fastRoot` | FindRootOptim.wl | Unpacked for FindRoot |
| `Jacobian` | `fastRoot` | FindRootOptim.wl | Passed to FindRoot |
| `Method` (FindRoot) | `fastRoot` | FindRootOptim.wl | Algorithm selection |
| `"SecantBlend"` | `fastRoot` | FindRootOptim.wl | Blend factor |
| `"Return"` | `fastRoot` | FindRootOptim.wl | Output format |

#### RecurrenceTable Nested Options

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"DependentVariables"` | `addCoeffsSolution` | ProcessModels.wl | RecurrenceTable param |
| `"Options"` (RecurrenceTable) | `addCoeffsSolution` | ProcessModels.wl | Merged options |

#### Scan Nested Options

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"FastRootOptions"` | `scanAndSolve` | FindRootOptim.wl | Passed to fastRoot |
| `"ScanMethod"` | `scanAndSolve` | FindRootOptim.wl | Scanning algorithm |
| `"BracketGrid"` | `scanAndSolve` | FindRootOptim.wl | Grid size |
| `"Tolerance"` | `scanAndSolve` | FindRootOptim.wl | Near-zero detection |
| `"UnboundedPad"` | `extractIntervalsFromReduce` | FindRootOptim.wl | Interval padding |
| `"InteriorShrink"` | `extractIntervalsFromReduce` | FindRootOptim.wl | Interval shrinking |
| `"RootUpperBound"` | `extractIntervalsFromReduce` | FindRootOptim.wl | Upper bound |

#### Checks Nested Options

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"PrintResidualsNorm"` | `checks` | SolveEulerEq.wl | Output control |
| `"CheckResiduals"` | `checks` | SolveEulerEq.wl | Validation enable |
| `"Tol"` | `checks` | SolveEulerEq.wl | Tolerance threshold |

---

### Moments Subsystem

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"maxMomentsLagsToCreate"` | `createDatabase` | CreateMomentsDatabase.wl | Loop control |
| `"startSequenceAtLag"` | `createDatabase` | CreateMomentsDatabase.wl | Sequence boundary |
| `"simplifyDownValues"` | `createDatabase` | CreateMomentsDatabase.wl | DownValues simplification |
| `"IterationLimit"` | `uncondCovLongExo` | CreateMomentsDatabase.wl | Block[$IterationLimit] |

---

### Parallel Subsystem

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"NumKernels"` | `setupParallelKernels` | ManageResources.wl | Kernel count |

---

### Build Subsystem

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"Models"` | `buildModelsInternal` | ManageResources.wl | Model selection |
| `"CompileJacobians"` | `buildModelsInternal` | ManageResources.wl | Jacobian compilation |
| `"MaxMaturity"` (Build) | `buildModelsInternal` | ManageResources.wl | Currently unused |
| `"FileSuffix"` | `buildModelsInternal` | ManageResources.wl | Checkpoint naming |
| `"UpdateManifest"` | `buildModelsInternal` | ManageResources.wl | Manifest update |
| ⚠️ `"FromScratch"` | **MULTIPLE** | | See flagged section |
| ⚠️ `"CreateMoments"` | **MULTIPLE** | | See flagged section |

---

### Time Aggregation (Function-Level)

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"v0"` | `growth` | TimeAggregation.wl | Initial value function |
| `"Order"` | `growth` | TimeAggregation.wl | Power series order |
| `"TimeAggregation"` | `timeSeriesVector` | TimeAggregation.wl | Aggregation periods |
| `"numPeriods"` | `timeSeriesVector` | TimeAggregation.wl | Number of periods |
| `"Variable"` | `g` | TimeAggregation.wl | Flow/Stock/Ratio |

---

### Visualization (Function-Level)

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"ShowSelector"` | `visualizeCoeffs` | VisualizeCoeffs.wl | UI control |
| `"ShowDetails"` | `visualizeCoeffs` | VisualizeCoeffs.wl | UI control |
| `"MomentFunction"` | `yieldCurve` | NicePlots.wl | Moment function |

---

### Pipeline (Function-Level)

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"AutoBuild"` | `checkModels` | PipelineMonitor.wl | Auto-build control |

---

### Internal (Not User-Accessible)

| Option | Owner | File | Notes |
|--------|-------|------|-------|
| `"MaxIterations"` (internal) | `lagStateVarst` | ComputeConditionalExpectations.wl | Internal only |
| `"TimeConstraint"` (internal) | `lagStateVarst` | ComputeConditionalExpectations.wl | Internal only |

---

## Built-in Wolfram Language Symbol Options

These are options for Wolfram built-in symbols that are used in the codebase. The "Forwarded By" column shows which package function passes the option to the built-in.

### FindRoot Options

| Option | Terminal Built-in | Forwarded By | File | Notes |
|--------|-------------------|--------------|------|-------|
| `MaxIterations` | `FindRoot` | `fastRoot` | FindRootOptim.wl | Default: 100 |
| `AccuracyGoal` | `FindRoot` | `fastRoot` | FindRootOptim.wl | Default: 8 |
| `PrecisionGoal` | `FindRoot` | `fastRoot` | FindRootOptim.wl | Default: 8 |
| `WorkingPrecision` | `FindRoot` | `fastRoot` | FindRootOptim.wl | Default: MachinePrecision |
| `StepMonitor` | `FindRoot` | `makeFindRootOptions` | FindRootOptim.wl | Dynamic clipping |
| `Jacobian` | `FindRoot` | `tryNewton1D`, `tryNewtonND` | FindRootOptim.wl | Compiled Jacobian |
| `Method` | `FindRoot` | `fastRoot` | FindRootOptim.wl | "Newton", "Brent", "Secant" |

### RecurrenceTable Options

| Option | Terminal Built-in | Forwarded By | File | Notes |
|--------|-------------------|--------------|------|-------|
| `DependentVariables` | `RecurrenceTable` | `addCoeffsSolution` | ProcessModels.wl | Default: Automatic |

### Simplify Options

| Option | Terminal Built-in | Forwarded By | File | Notes |
|--------|-------------------|--------------|------|-------|
| `TimeConstraint` | `Simplify` | `solveCoeffsSystem`, `paramQuadSolve` | ProcessModels.wl, ParamQuadSolve.wl | Default: {5, 300} |
| `Assumptions` | `Simplify` | `paramQuadSolve` | ParamQuadSolve.wl | Model assumptions |

### Compile Options

| Option | Terminal Built-in | Forwarded By | File | Notes |
|--------|-------------------|--------------|------|-------|
| `CompilationTarget` | `Compile` | `buildKernel` | FindRootOptim.wl | Default: "C" |
| `RuntimeOptions` | `Compile` | `buildKernel` | FindRootOptim.wl | Default: Automatic |

### GroebnerBasis Options

| Option | Terminal Built-in | Forwarded By | File | Notes |
|--------|-------------------|--------------|------|-------|
| `MonomialOrder` | `GroebnerBasis` | `paramQuadSolve` | ParamQuadSolve.wl | Default: Automatic |
| `Method` | `GroebnerBasis` | `paramQuadSolve` | ParamQuadSolve.wl | "GroebnerWalk" |

### ParallelMap/ParallelTable Options

| Option | Terminal Built-in | Forwarded By | File | Notes |
|--------|-------------------|--------------|------|-------|
| `DistributedContexts` | `ParallelMap`, `ParallelTable` | `createDatabase`, `buildModelsParallel` | CreateMomentsDatabase.wl, ManageResources.wl | Default: All or Automatic |

### Reduce Options

| Option | Terminal Built-in | Forwarded By | File | Notes |
|--------|-------------------|--------------|------|-------|
| (domain) | `Reduce` | `findRootInterval` | FindRootOptim.wl | Always `Reals` |

### NMinimize/FindMinimum Options

| Option | Terminal Built-in | Forwarded By | File | Notes |
|--------|-------------------|--------------|------|-------|
| `Method` | `NMinimize` | `tryNMinimize` | SolveEulerEq.wl | "NelderMead" |
| `Method` | `FindMinimum` | `tryFindMinimumFallback` | FindRootOptim.wl | "InteriorPoint" |
| `Gradient` | `FindMinimum` | `tryFindMinimumFallback` | FindRootOptim.wl | Optional |

---

## ⚠️ Flagged: Options with Multiple Owners

These options have more than one terminal consumer. This may indicate:
- Intentional shared usage across subsystems
- An opportunity to consolidate ownership
- Potential for inconsistent behavior

### `"SignSymbol"`

| Owner | File | Context |
|-------|------|---------|
| `buildKernel` | FindRootOptim.wl | Compile phase - variable naming |
| `paramQuadSolve` | ParamQuadSolve.wl | Symbolic phase - sign parameters |

**Analysis:** Used in both symbolic (sign parameter creation) and compile (variable naming) phases. The option serves related but distinct purposes in each context.

---

### `"MaxMaturity"` (Numerical)

| Owner | File | Context |
|-------|------|---------|
| `addCoeffsSolution` | ProcessModels.wl | Symbolic phase - RecurrenceTable loop |
| `updateCoeffsSol` | SolveEulerEq.wl | Numerical phase - bond iteration |
| `updateCoeffsBond` | SolveEulerEq.wl | Numerical phase - bond evaluation |
| `checkCoeffs` | SolveEulerEq.wl | Numerical phase - validation loop |

**Analysis:** Controls maximum bond maturity across multiple phases. All uses are semantically consistent (bond maturity limit).

---

### `"Signs"`

| Owner | File | Context |
|-------|------|---------|
| `solveCoeffRoots` | SolveEulerEq.wl | Explicit sign values for roots |
| `bindUnary` | FindRootOptim.wl | Sign binding in root finding |
| `findRootInterval` | FindRootOptim.wl | Interval computation |

**Analysis:** Sign values propagate through root-finding chain. Multiple consumers access the same conceptual data.

---

### `"FromScratch"`

| Owner | File | Context |
|-------|------|---------|
| `buildModelsInternal` | ManageResources.wl | Main cleanup trigger |
| `buildModelsParallel` | ManageResources.wl | Parallel cleanup trigger |

**Analysis:** Both entry points need to trigger cleanup. `buildModelsParallel` forces False for child calls after initial cleanup.

---

### `"CreateMoments"`

| Owner | File | Context |
|-------|------|---------|
| `buildModelsInternal` | ManageResources.wl | Phase 4 gate |
| `determineModelStatus` | ManageResources.wl | Cache validation |
| `buildModelsParallel` | ManageResources.wl | Sequential phase control |

**Analysis:** Binary gate controlling moments creation. Multiple functions check this flag for orchestration purposes.

---

## Ownership by Owner Function

This inverted view shows all options owned by each function.

### `paramQuadSolve` (13 options)
- `"DomainOption"`, `"Assumptions"`, `"Method"`, `"MonomialOrder"`
- `"TimeoutOption"`, `"SimplifyTimeout"`, `"ValidationOption"`, `"ReturnOption"`
- `"DiagnosticsOption"`, `"OnlyQuadTerms"`
- `"GroebnerMemoryFraction"`, `"GroebnerMemoryFloor"`, `"GroebnerMemoryCap"`

### `buildKernel` (8 options)
- `"CoeffName"`, `"PerformanceGoal"`, `"CompileMode"`, `"Compiler"`
- `"RuntimeOptions"`, `"CompilationTarget"`, `"FlattenExpressions"`, `"AllowCompileDuringCoverage"`

### `fastRoot` (10 options)
- `"MaxIterations"`, `"PrecisionGoal"`, `"AccuracyGoal"`, `"WorkingPrecision"`
- `"Options"` (FindRoot), `"FindRootOptions"`, `Jacobian`, `Method`
- `"SecantBlend"`, `"Return"`

### `scanAndSolve` (4 options)
- `"FastRootOptions"`, `"ScanMethod"`, `"BracketGrid"`, `"Tolerance"`

### `extractIntervalsFromReduce` (3 options)
- `"UnboundedPad"`, `"InteriorShrink"`, `"RootUpperBound"`

### `buildModelsInternal` (5 options)
- `"Models"`, `"CompileJacobians"`, `"MaxMaturity"` (Build), `"FileSuffix"`, `"UpdateManifest"`

### `solveCoeffsSystem` (3 options)
- `"PdEquations"`, `"SimplifyOptions"`, `"paramQuadSolveOptions"`

### `updateCoeffsSol` (4 options)
- `"UpdatePd"`, `"UpdateBond"`, `"UpdateNomBond"`, `"UpdateBonds"`

### `createDatabase` (3 options)
- `"maxMomentsLagsToCreate"`, `"startSequenceAtLag"`, `"simplifyDownValues"`

### `checks` (3 options)
- `"PrintResidualsNorm"`, `"CheckResiduals"`, `"Tol"`

### `addCoeffsSolution` (3 options)
- `"RecurrenceTableOptions"`, `"DependentVariables"`, `"Options"` (RecurrenceTable)

### `solveCoeffRoots` (2 options)
- `"initialGuess"`, `"RootSigns"`

### `simplifyWithDummySubstitution` (2 options)
- `"Level0Pattern"`, `"SimplifyFunction"`

### `growth` (2 options)
- `"v0"`, `"Order"`

### `timeSeriesVector` (2 options)
- `"TimeAggregation"`, `"numPeriods"`

### Single-Option Owners
| Function | Option |
|----------|--------|
| `uncondCovLongExo` | `"IterationLimit"` |
| `setupParallelKernels` | `"NumKernels"` |
| `solveND` | `"ReduceTimeLimit"` |
| `g` | `"Variable"` |
| `visualizeCoeffs` | `"ShowSelector"`, `"ShowDetails"` |
| `yieldCurve` | `"MomentFunction"` |
| `checkModels` | `"AutoBuild"` |
| `lagStateVarst` | `"MaxIterations"` (internal), `"TimeConstraint"` (internal) |

---

## Built-in Symbol Forwarders

These package functions forward options to Wolfram built-in symbols.

| Package Function | Forwards To | Options Forwarded |
|------------------|-------------|-------------------|
| `fastRoot` | `FindRoot` | MaxIterations, AccuracyGoal, PrecisionGoal, WorkingPrecision, StepMonitor, Jacobian, Method |
| `tryNewton1D` | `FindRoot` | All FindRoot options via FilterRules |
| `tryNewtonND` | `FindRoot` | All FindRoot options via FilterRules |
| `tryBrent1D` | `FindRoot` | Method → "Brent", filtered options |
| `trySecant1D` | `FindRoot` | Method → "Secant", filtered options |
| `addCoeffsSolution` | `RecurrenceTable` | DependentVariables, Options via FilterRules |
| `updateCoeffsBond` | `RecurrenceTable` | RecurrenceTableOptions via ReplaceRepeated |
| `solveCoeffsSystem` | `Simplify` | TimeConstraint via SimplifyOptions |
| `paramQuadSolve` | `Simplify` | TimeConstraint, Assumptions |
| `paramQuadSolve` | `GroebnerBasis` | MonomialOrder, Method |
| `buildKernel` | `Compile` | CompilationTarget, RuntimeOptions |
| `buildKernel` | `FunctionCompile` | Options via FilterRules |
| `createDatabase` | `ParallelMap` | DistributedContexts → All |
| `buildModelsParallel` | `ParallelTable` | DistributedContexts → Automatic |
| `findRootInterval` | `Reduce` | Domain (Reals) |
| `tryNMinimize` | `NMinimize` | Method → "NelderMead" |
| `tryFindMinimumFallback` | `FindMinimum` | Method → "InteriorPoint", Gradient |

---

## Recommendations

### Options to Consider Consolidating

| Option | Current Owners | Recommendation |
|--------|----------------|----------------|
| `"SignSymbol"` | buildKernel, paramQuadSolve | Keep separate - different phases |
| `"MaxMaturity"` | 4 functions | Consider single source of truth |
| `"FromScratch"` | 2 entry points | OK - orchestration pattern |
| `"CreateMoments"` | 3 functions | OK - gate pattern |

### Ownership Clarity Improvements

1. **`"MaxMaturity"`** - Create a single accessor function that all consumers call
2. **`"Signs"`** - Document the intentional multi-consumer pattern
3. **Build vs Numerical `"MaxMaturity"`** - Currently two distinct options with same name in different subsystems; consider renaming for clarity

### Built-in Option Forwarding Best Practices

1. **Use FilterRules consistently** - Most forwarding uses `FilterRules[{opts}, Options[BuiltIn]]`
2. **Document defaults** - When overriding built-in defaults (e.g., AccuracyGoal → 8), document why
3. **StepMonitor pattern** - The dynamic StepMonitor construction in `makeFindRootOptions` is a good pattern for bound enforcement
