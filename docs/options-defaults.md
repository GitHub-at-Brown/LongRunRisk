# Option Defaults and Inheritance

Package-defined options, their defaults, and where they flow. Built-ins (`FindRoot`, `RecurrenceTable`, `FunctionCompile`, `Compile`, `Simplify`) keep their Mathematica defaults unless noted.

## Computational Engine

| Option | Defaults | Inherited / Used by | Notes |
| --- | --- | --- | --- |
| `paramQuadSolve` | `"DomainOption"->Reals`, `"Assumptions"->Automatic`, `"Method"->Automatic`, `"MonomialOrder"->Automatic`, `"ValidationOption"->True`, `"ReturnOption"->"All"`, `"TimeoutOption"->600`, `"SimplifyTimeout"->Automatic`, `"DiagnosticsOption"->False`, `"OnlyQuadTerms"->False`, `"SignSymbol"->signA`, `"GroebnerMemoryFraction"->0.5`, `"GroebnerMemoryFloor"->1*1024^3`, `"GroebnerMemoryCap"->16*1024^3` | — | Memory options control Groebner basis computation limits. |
| `simplifyWithDummySubstitution` | `"Assumptions"->Automatic`, `"Level0Pattern"->_Symbol[0]\|_Symbol[_][0]`, `"SimplifyFunction"->Simplify` | Internal to `paramQuadSolve` | Helper for simplifying expressions with level-0 pattern substitutions. |
| `lagStateVarst` | `"MaxIterations"->100`, `"TimeConstraint"->30` | — | `MaxIterations` here is unrelated to `FindRoot`. Prevents infinite recursion in state variable expansion. |
| `solveND` | `"ReduceTimeLimit"->5.` | `solveCoeffRoots` (nD path) | Timeout for Reduce-based interval finding in nD fallback. |
| `updateCoeffsSol` | `"initialGuess"-><\|"Ewc"->{4},"Epd"->{{4}}\|>`, `"FindRootOptions"->{}`, `"RecurrenceTableOptions"->{"DependentVariables"->Automatic}`, `"UpdatePd"->False`, `"UpdateBond"->False`, `"UpdateNomBond"->False`, `"UpdateBonds"->False`, `"MaxMaturity"->12`, `"RootSigns"->Automatic` | `updateCoeffs`, `yieldCurve`, `toNumRules`, `addCoeffsSolutionN` | Forwards any `FindRoot` / `RecurrenceTable` options. `RootSigns` controls which sign combinations to solve: `Automatic`, `All`, or explicit list. |
| `checks` | `"PrintResidualsNorm"->False`, `"CheckResiduals"->False`, `"Tol"->10.^-16` | `updateCoeffsSol`, `updateCoeffs` | Controls residual reporting / abort behavior. |
| `updateCoeffs` | union of `updateCoeffsSol` + `checks` | Wrapper to `updateCoeffsSol` | No unique defaults. |
| `getStartingValues` | `"initialGuess"-><\|"Ewc"->{4},"Epd"->{{4}}\|>` | — (currently unused) | Internal helper intended to pull initial guesses from model extraInfo. |
| `addCoeffsSolutionN` | **No options**. Calls `updateCoeffs` with fixed: `"UpdatePd"->True`, `"UpdateBonds"->True`, `"MaxMaturity"->12`, `"RootSigns"->All` | Used by `buildModels` numerical phase | Hardcoded helper; does not accept options. |
| `uncondCovLongExo` | `"IterationLimit"->$IterationLimit/4` | `uncondVarLongExo`, `createDatabase` | — |
| `createDatabase` | `"maxMomentsLagsToCreate"->8`, `"startSequenceAtLag"->3`, `"simplifyDownValues"->False` | — (accepts `uncondCovLongExo` options) | — |

## Model Processing

| Option | Defaults | Inherited / Used by | Notes |
| --- | --- | --- | --- |
| `solveCoeffsSystem` | `"SimplifyOptions"->{TimeConstraint->{5,300}}`, `"paramQuadSolveOptions"->{}`, `"PdEquations"->"B"` | `processModels` | `PdEquations` controls which pd equations to compute: `"B"`, `"AB"`, or `"Both"`. |
| `simplifyCoeffsSystem` | `"SimplifyOptions"->{TimeConstraint->{5,300}}` | — (accepts `solveCoeffsSystem` + `Simplify` options) | Simplifies coefficient systems; shares `SimplifyOptions` with `solveCoeffsSystem`. |
| `tryTransforms` | `"SimplifyOptions"->{TimeConstraint->{5,300}}` | inside `solveCoeffsSystem` | Inherits `Simplify` options; tries ψ/γ/θ substitutions and picks simpler forms. |

## Time Aggregation Tools

| Option | Defaults | Inherited / Used by | Notes |
| --- | --- | --- | --- |
| `timeSeriesVector` | `"TimeAggregation"->1`, `"numPeriods"->1` | `growth` (via inheritance) | — |
| `g` | `"Variable"->"Flow"` | `growth` (via inheritance) | Flow vs stock vs ratio switch. |
| `growth` | `"v0"->Function[{t,j,h,k,v,im},0]`, `"Order"->1` | — (inherits `timeSeriesVector`, `g`) | Uses `gt` / `timeSeriesVector`; no extra wrappers. |

## FindRoot Optimizer Tools

| Option | Defaults | Inherited / Used by | Notes |
| --- | --- | --- | --- |
| `buildKernel` | `"CoeffName"->"A"`, `"SignSymbol"->"signA"`, `"PerformanceGoal"->"Speed"`, `"CompileMode"->"FunctionOnly"`, `"Compiler"->"Compile"`, `"FlattenExpressions"->Automatic` | `createCompiledEq` | Inherits `FunctionCompile` / `Compile` options. `CompileMode` can be `"Both"`, `"FunctionOnly"`, or `"JacobianOnly"`. `Compiler` can be `"Compile"` or `"FunctionCompile"`. |
| `bindUnary` | `"Signs"->{}` | `solveCoeffRoots` | Supplies explicit sign tuples for square-root branches; values should be ±1 and match the solver's sign index. |
| `findRootInterval` | `"CoeffName"->"A"`, `"SignSymbol"->"signA"`, `"Signs"->{}` | `solveCoeffRoots` | `Signs` controls which sign tuple is substituted for the sign symbol; defaults to no substitution. |
| `extractIntervalsFromReduce` | `"InteriorShrink"->0.001`, `"RootUpperBound"->15`, `"UnboundedPad"->1.*^5` | `solveCoeffRoots`, `solveND` | — |
| `fastRoot` | `Jacobian->None`, `Method->Automatic`, `"SecantBlend"->0.5`, `"Return"->"Value"`, `"FindRootOptions"->Automatic` | `scanAndSolve`, `solveCoeffRoots` | Also accepts all `FindRoot` options via `OptionsPattern`. `Method` can be `"Newton"`, `"Brent"`, `"Secant"`, or `Automatic`. |
| `scanAndSolve` | `"BracketGrid"->32`, `"Tolerance"->Automatic`, `"FastRootOptions"->{}`, `"FindRootOptions"->Automatic` | `solveCoeffRoots` | Inherits `fastRoot` and `FindRoot` options. |

## Plotting

| Option | Defaults | Inherited / Used by | Notes |
| --- | --- | --- | --- |
| `yieldCurve` | `"MaxMaturity"->12`, `"MomentFunction"->uncondE` | — (inherits `updateCoeffs` + `FindRoot` / `RecurrenceTable`) | Controls coefficient solving when rebuilding curves. |

## Visualization

| Option | Defaults | Inherited / Used by | Notes |
| --- | --- | --- | --- |
| `visualizeCoeffs` | `"ShowSelector"->True`, `"ShowDetails"->True` | — | Toggles the interactive coefficient selector and collapsible bundle details when inspecting coefficient solutions. |

## Resource Management

| Option | Defaults | Inherited / Used by | Notes |
| --- | --- | --- | --- |
| `buildModels` | `"FromScratch"->False`, `"CompileJacobians"->False`, `"CreateMoments"->True`, `"NumKernels"->Automatic`, `"MaxMaturity"->120`, `"Models"->All`, `"PdEquations"->"B"`, `"FileSuffix"->""`, `"UpdateManifest"->True` | Orchestrates catalog build pipeline | `Models` can be `All` or a list of shortnames. `FileSuffix` controls checkpoint file naming (e.g., `"_BY"` writes to `Models_BY.wl`). `NumKernels` can be `Automatic`, a number, or `None`. Note: caller options are not currently forwarded to `processModels` / `createCompiledEq`. |
| `buildModelsParallel` | `"CreateMoments"->True`, `"NumKernels"->Automatic`, `"FromScratch"->False`, `"PdEquations"->"B"` | Wrapper around `buildModels` | Runs Symbolic+Compile+Numerical phases in parallel across models; moments optionally run sequentially. |

## Wrapper Functions / Option Forwarders

Functions below do not define new option names or defaults; they simply accept and forward options for the core tools listed in the sections above (and a few built-ins).

| Function | Forwards options to | Notes |
| --- | --- | --- |
| `processModels` | `solveCoeffsSystem` | Symbolic model processor; currently only threads `"PdEquations"` through to `solveCoeffsSystem` (other accepted options are not forwarded). |
| `addCoeffsSolution` | `RecurrenceTable` | Builds bond and nominal-bond recursions; accepts `RecurrenceTable` options (does not call `updateCoeffs`). |
| `gt` | `timeSeriesVector`, `g` | Time-aggregation helper called by `growth`; merges options for the underlying aggregation tools. |
| `numberFormattingTemplate` | `ToString` | NiceOutput helper; accepts any `ToString` options for numeric formatting. |
| `plotCoeffs` | `FindRootPlot` (resource function) | Visualization helper for coefficient root-finding; passes all options to `FindRootPlot`. |
| `toNumRules` | `updateCoeffs` | Numericization helper; forwards all `updateCoeffs` options into the coefficient solver. |
| `updateCoeffsBond` | `RecurrenceTable` | Bond recursion helper; forwards `RecurrenceTable` options when solving bond coefficients. |
| `solveCoeffRoots` | `findRootInterval`, `extractIntervalsFromReduce`, `scanAndSolve`, `fastRoot`, `FindRoot` | Coefficient root finder; accepts and forwards all interval/solver options for these tools. |
| `solveWcPdRoots` | `solveCoeffRoots` | Joint wc/pd root finder; accepts the same options as `solveCoeffRoots`. |
| `uncondVarLongExo` | `uncondCovLongExo` | Computes variances via long-run covariances; forwards all `uncondCovLongExo` options. |
| `uncondCovLong` | `uncondCovLongExo` | Public wrapper for long-run covariances; passes through `uncondCovLongExo` options. |
| `uncondVarLong` | `uncondCovLongExo` | Public wrapper for long-run variances; passes through `uncondCovLongExo` options. |
| `totCovLong` | `uncondCovLongExo` | Law-of-total-covariance helper; propagates `uncondCovLongExo` options into the long-run covariance computations. |
| `createCompiledEq` | `buildKernel`, `FunctionCompile`, `Compile` | Compilation orchestrator; accepts all `buildKernel` options plus compiler-specific options for `FunctionCompile` / `Compile`. |

## Overlapping Option Names / Clashes

- `FindRootOptions` appears in `updateCoeffsSol` (prepended to `FindRoot` calls, default `{}`) and in `fastRoot`/`scanAndSolve` (can be `Automatic`, a list, or a function). Match the expected shape for the downstream caller.
- `initialGuess` appears in `getStartingValues` and `updateCoeffsSol`; both expect an association like `<|"Ewc" -> {...}, "Epd" -> {{...}}|>`.
- `MaxMaturity` is shared by `updateCoeffsSol` (default 12), `addCoeffsSolutionN` (hardcoded 12), `buildModels` (default 120), and `yieldCurve` (default 12).
- `RootSigns` controls which sign combinations to explore: `Automatic` (heuristic selection), `All` (all combinations), or an explicit list of sign tuples.
- `CoeffName` is shared by `buildKernel` and `findRootInterval`; `SignSymbol` is used by `buildKernel`/`findRootInterval` (string name) and `paramQuadSolve` (symbol head). Keep them aligned so kernels, interval extraction, and symbolic solver stay consistent.
- `MaxIterations` in `lagStateVarst` is unrelated to the `FindRoot` option of the same name.
- `PdEquations` is implemented in `solveCoeffsSystem` (default `"B"`). `buildModels` and `buildModelsParallel` currently define the option but do not consume/forward it.
- `Signs` appears in `bindUnary` and `findRootInterval`, controlling how sign variables are instantiated when selecting square-root branches.
- `FromScratch` appears in `buildModels` and `buildModelsParallel`. Usage is consistent (force re-computation).
- `SimplifyOptions` appears in `solveCoeffsSystem`, `simplifyCoeffsSystem`, and `tryTransforms` with the same default `{TimeConstraint->{5,300}}`.
- `NumKernels` appears in `buildModels` and `buildModelsParallel` with the same meaning: `Automatic` (use `$ProcessorCount` or model count), a specific number, or `None`/`1` for sequential.
- `CreateMoments` appears in `buildModels` and `buildModelsParallel` controlling whether to generate moments lookup tables.
