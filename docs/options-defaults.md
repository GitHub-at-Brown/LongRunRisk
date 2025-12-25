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

## Option Flow Trees

Interpretation: each “option” below refers to the **function name** in the tables above (i.e., a function that defines `Options[...]` or `f // Options = ...`), not individual option keys like `"MaxMaturity"`.

### How these trees are built (general method)

Each tree is a small “wiring diagram” showing how a configurable **setting bundle** (an “option-set”) moves through function calls.

- **Root** = the highest-level function in the repo where a user can supply that option-set (no other function passes the same option-set into it).
- **Branch/edge** (`A` → `B`) = `A` calls `B` and forwards the option-set (often by passing along an `opts`/`options` argument).
- **Leaf** = the option-set is finally **used** (read) or handed off to external code (a system/library call).

To build trees like this in any codebase:

1. **Find where settings are declared** (defaults + accepted keys) — e.g., a defaults dictionary/struct; in Mathematica, `Options[foo] = ...`.
2. **Find all call sites** of that owner function/module.
3. At each call site, decide if settings are **forwarded** (passed through) or **consumed** (read). Forwarding often looks like “pass the same options object”, merge dicts, `...kwargs`, or (in this repo) `OptionsPattern[...]` + `FilterRules[..., Options[foo]]` + `Sequence @@ ...`.
4. Follow forwarding **upward** to find the root, and **downward** to find leaves, branching whenever settings are forwarded to multiple callees.

```text
Legend (file tags)
[PQS] Kernel/ComputationalEngine/ParamQuadSolve.wl
[CCE] Kernel/ComputationalEngine/ComputeConditionalExpectations.wl
[CUE] Kernel/ComputationalEngine/ComputeUnconditionalExpectations.wl
[SE]  Kernel/ComputationalEngine/SolveEulerEq.wl
[CMD] Kernel/ComputationalEngine/CreateMomentsDatabase.wl
[PM]  Kernel/Model/ProcessModels.wl
[TA]  Kernel/Tools/TimeAggregation.wl
[FRO] Kernel/Tools/FindRootOptim.wl
[MR]  Kernel/Tools/ManageResources.wl
[TN]  Kernel/Tools/ToNumber.wl
[NP]  Kernel/Tools/NicePlots.wl


========================
Computational Engine
========================

1) paramQuadSolve
solveCoeffsSystem [PM]   (passes via its "paramQuadSolveOptions" list)
└─ paramQuadSolve [PQS]
   └─ simplifyWithDummySubstitution [PQS]
      └─ Simplify / FullSimplify (System)

(paramQuadSolve can also be called directly)
paramQuadSolve [PQS]
└─ simplifyWithDummySubstitution [PQS]
   └─ Simplify / FullSimplify (System)


2) simplifyWithDummySubstitution
solveCoeffsSystem [PM]
└─ simplifyWithDummySubstitution [PQS]
   └─ FullSimplify (System)   (via "SimplifyFunction")

paramQuadSolve [PQS]
└─ simplifyWithDummySubstitution [PQS]
   └─ Simplify / FullSimplify (System)

simplifyWithDummySubstitution [PQS] (direct)
└─ Simplify / FullSimplify (System)


3) lagStateVarst
ev [CCE]
└─ lagStateVarst [CCE]

var/cov/corr [CCE]
└─ ev [CCE]
   └─ lagStateVarst [CCE]

(evNoEps / lagStateVarsProduct path)
ComputeUnconditionalExpectations [CUE]
└─ lagStateVarst [CCE]


4) solveND
solveCoeffRoots [SE]   (nD path)
└─ solveND [SE]
   ├─ safeReduceCall [SE]
   │  └─ findRootInterval [FRO]
   │     └─ Reduce (System)
   ├─ trySmartIntervals [SE]
   │  └─ extractIntervalsFromReduce [FRO]
   ├─ tryArtificialBox [SE]
   └─ nMinimizeFallback [SE]
      └─ NMinimize (System)


5) updateCoeffsSol
yieldCurve [NP]
└─ updateCoeffs [SE]
   └─ updateCoeffsSol [SE]
      ├─ solveCoeffRoots [SE]
      │  ├─ bindUnary [FRO]
      │  ├─ findRootInterval [FRO] -> Reduce (System)
      │  ├─ extractIntervalsFromReduce [FRO]
      │  ├─ scanAndSolve [FRO] -> FindRoot (System)
      │  ├─ fastRoot [FRO] -> FindRoot (System)
      │  └─ (nD) solveND [SE] -> ...
      ├─ updateCoeffsBond [SE]
      │  └─ RecurrenceTable (System)
      └─ checks [SE]   (if enabled)

toNumRules [TN]
└─ updateCoeffs [SE]
   └─ updateCoeffsSol [SE]
      └─ (same subtree as above)

addCoeffsSolutionN [SE]   (hard-coded: UpdatePd/UpdateBonds/MaxMaturity/RootSigns)
└─ updateCoeffs [SE]
   └─ updateCoeffsSol [SE]
      └─ (same subtree as above)

updateCoeffs [SE]
└─ updateCoeffsSol [SE]
   └─ (same subtree as above)

updateCoeffsSol [SE] (direct)
└─ (same subtree as above)


6) checks
yieldCurve [NP]
└─ updateCoeffs [SE]
   └─ updateCoeffsSol [SE]
      └─ checks [SE]

toNumRules [TN]
└─ updateCoeffs [SE]
   └─ updateCoeffsSol [SE]
      └─ checks [SE]

updateCoeffs [SE]
└─ updateCoeffsSol [SE]
   └─ checks [SE]

checks [SE] (direct)


7) updateCoeffs
yieldCurve [NP]
└─ updateCoeffs [SE]
   └─ updateCoeffsSol [SE]

toNumRules [TN]
└─ updateCoeffs [SE]
   └─ updateCoeffsSol [SE]

addCoeffsSolutionN [SE]
└─ updateCoeffs [SE]
   └─ updateCoeffsSol [SE]

updateCoeffs [SE]
└─ updateCoeffsSol [SE]


8) getStartingValues
getStartingValues [SE] (direct)


9) addCoeffsSolutionN  (no options)
buildModels [MR]
└─ addCoeffsSolutionN [SE]
   └─ updateCoeffs [SE]
      └─ updateCoeffsSol [SE]


10) uncondCovLongExo
createDatabase [CMD]
└─ totCovLong [CMD]
   ├─ cov/ev (ComputeConditionalExpectations) [CCE]   (inside totCovLong)
   └─ uncondCovLong [CMD]
      └─ uncondCovLongExo [CMD]

uncondVarLongExo [CMD]
└─ uncondCovLongExo [CMD]

uncondCovLong [CMD]
└─ uncondCovLongExo [CMD]

uncondVarLong [CMD]
└─ uncondVarLongExo [CMD]
   └─ uncondCovLongExo [CMD]

totCovLong [CMD] (direct)
└─ uncondCovLong [CMD]
   └─ uncondCovLongExo [CMD]


11) createDatabase
buildModels [MR]   (moments phase)
└─ createDatabase [CMD]
   └─ totCovLong/uncondCovLong/uncondCovLongExo [CMD]   (via filtered uncondCovLongExo opts)

createDatabase [CMD] (direct)
└─ totCovLong/uncondCovLong/uncondCovLongExo [CMD]


========================
Model Processing
========================

12) solveCoeffsSystem
buildModelsParallel [MR]
└─ buildModels [MR]
   └─ processModels [PM]
      └─ solveCoeffsSystem [PM]
         ├─ paramQuadSolve [PQS] (via "paramQuadSolveOptions")
         │  └─ simplifyWithDummySubstitution [PQS]
         ├─ simplifyWithDummySubstitution [PQS] (conditions)
         └─ tryTransforms [PM]

processModels [PM]
└─ solveCoeffsSystem [PM]
   └─ (same subtree as above)

solveCoeffsSystem [PM] (direct)
└─ (same subtree as above)


13) simplifyCoeffsSystem
processModels [PM]
└─ simplifyCoeffsSystem [PM]
   └─ FullSimplify (System)

simplifyCoeffsSystem [PM] (direct)
└─ FullSimplify (System)


14) tryTransforms
solveCoeffsSystem [PM]
└─ tryTransforms [PM]
   └─ Simplify (System)

tryTransforms [PM] (direct)
└─ Simplify (System)


========================
Time Aggregation Tools
========================

15) timeSeriesVector
growth [TA]
└─ gt [TA]
   └─ timeSeriesVector [TA]

gt [TA]
└─ timeSeriesVector [TA]

timeSeriesVector [TA] (direct)


16) g
growth [TA]
└─ gt [TA]
   └─ g [TA]

gt [TA]
└─ g [TA]

g [TA] (direct)


17) growth
growth [TA]
└─ gt [TA]
   ├─ timeSeriesVector [TA]
   └─ g [TA]


========================
FindRoot Optimizer Tools
========================

18) buildKernel
createCompiledEq [FRO]
└─ buildKernel [FRO]
   └─ Compile / FunctionCompile (System)

buildKernel [FRO] (direct)
└─ Compile / FunctionCompile (System)


19) bindUnary
solveWcPdRoots [SE]
└─ solveCoeffRoots [SE]
   └─ bindUnary [FRO]

solveCoeffRoots [SE]
└─ bindUnary [FRO]

bindUnary [FRO] (direct)


20) findRootInterval
solveWcPdRoots [SE]
└─ solveCoeffRoots [SE]
   └─ findRootInterval [FRO]
      └─ Reduce (System)

solveCoeffRoots [SE] (nD path)
└─ solveND [SE]
   └─ safeReduceCall [SE]
      └─ findRootInterval [FRO] -> Reduce (System)

findRootInterval [FRO] (direct)


21) extractIntervalsFromReduce
solveWcPdRoots [SE]
└─ solveCoeffRoots [SE]
   └─ extractIntervalsFromReduce [FRO]

solveCoeffRoots [SE] (nD path)
└─ solveND [SE]
   └─ trySmartIntervals [SE]
      └─ extractIntervalsFromReduce [FRO]

extractIntervalsFromReduce [FRO] (direct)


22) buildModels
buildModelsParallel [MR]
└─ buildModels [MR]
   ├─ processModels [PM]
   │  ├─ simplifyCoeffsSystem [PM]
   │  ├─ solveCoeffsSystem [PM]
   │  └─ addCoeffsSolution [PM] -> RecurrenceTable (System)
   ├─ createCompiledEq [FRO] -> buildKernel [FRO] -> Compile/FunctionCompile (System)
   ├─ addCoeffsSolutionN [SE] -> updateCoeffs [SE] -> updateCoeffsSol [SE]
   └─ createDatabase [CMD] -> uncondCovLongExo [CMD] (moments phase)

buildModels [MR] (direct)
└─ (same subtree as above)


23) buildModelsParallel
buildModelsParallel [MR]
├─ (parallel per model) buildModels [MR]
└─ (optional moments, sequential) buildModels [MR]
```

## Simplifying And Untangling Options (Refactor Roadmap)

This section describes a refactor strategy to make option handling easier to understand and maintain **without changing what the package can do**. The external API and option names may change, but the final behavior should match today’s behavior.

### What makes options feel “tangled”

Common sources of complexity in option-heavy codebases (including this one) are:

- **Many places accept the same options**, so it’s unclear where a setting is actually used.
- **Options are forwarded implicitly** (e.g., passing a big `opts` list everywhere), so call chains become hard to follow.
- **Overlapping names** (same key used by different subsystems with different meanings or expected shapes).
- **Global option mutation** (changing `Options[otherFunction]` inside a helper), which creates hidden coupling between files.
- **“Accepted but ignored” options** (a wrapper accepts options for convenience but doesn’t actually forward them).

### A cleaner end state (architecture)

A simple, general approach that scales to large codebases:

1. **One owner per option.** Every option key has exactly one “owner” function/module where it is consumed (read). Other functions may only pass it along inside a clearly-named sub-config.
2. **Structured configuration instead of a flat option soup.** Use a single config object (e.g., a nested association/dict/struct) with one section per subsystem.
3. **No global mutation.** Functions should not modify other functions’ defaults at runtime; instead pass options explicitly.
4. **Validate at the boundary.** Top-level entry points validate keys and shapes once, then pass normalized config downstream.

### Practical changes for this repo (same functionality, less wiring)

**1) Introduce a single normalized configuration**

Create one “front door” representation, e.g.:

- `config["Symbolic"]` → options for model processing (`processModels`, `solveCoeffsSystem`, `paramQuadSolve`, simplify settings)
- `config["Compile"]` → options for compilation (`createCompiledEq`, `buildKernel`, compiler choices)
- `config["Numerical"]` → options for numeric solving (`updateCoeffsSol`, `solveCoeffRoots`, interval extraction/scan/root-finding)
- `config["Moments"]` → options for moments database (`createDatabase`, `uncondCovLongExo`)
- `config["Parallel"]` → options for kernel count / parallel behavior

Then make top-level functions (`buildModels`, `buildModelsParallel`, `yieldCurve`, `toNumRules`) accept either:

- a single `config_Association` (new style), or
- legacy flat options (old style), which are immediately converted into `config` by a `normalizeConfig[...]` helper.

**2) Stop forwarding “everything everywhere”**

After normalization, each subsystem receives only its section:

- `processModels[..., Sequence @@ config["Symbolic"]]`
- `createCompiledEq[..., Sequence @@ config["Compile"]]`
- `updateCoeffs[..., Sequence @@ config["Numerical"]]`
- `createDatabase[..., Sequence @@ config["Moments"]]`

This keeps option flow local and makes “who owns what” obvious.

**3) Remove global option mutation**

Replace patterns like “temporarily `SetOptions[...]` on another function” with direct calls that pass options explicitly. This eliminates hidden cross-file dependencies and makes parallel execution safer.

**4) Resolve overlapping/ambiguous option names**

When two subsystems use the same name differently (or expect different shapes), rename or nest to disambiguate. For example:

- Use `config["Numerical"]["FindRoot"]` vs `config["Numerical"]["FastRoot"]` instead of one overloaded `FindRootOptions`.
- Keep a single `InitialGuess` concept (one shape), and translate legacy `initialGuess` forms in `normalizeConfig`.
- Make “meaningful shared concepts” truly shared: e.g., one `MaxMaturity` that is consumed by the maturity-dependent code, with other layers merely passing it through.

**5) Make wrappers honest**

If a wrapper accepts options only for convenience, it should either:

- actually forward them, or
- stop accepting them (and provide a clear error message or migration note).

This reduces “silent ignore” behavior and makes the trees simpler.

**6) Centralize defaults + documentation**

Put defaults and allowed keys in one place (a small schema module), and have each entry point pull from it. Benefits:

- fewer duplicated defaults
- consistent naming
- one place to add validation
- docs can be generated/checked for drift

### How to migrate safely

Even if you allow API changes, you can keep user disruption low:

1. Add `normalizeConfig[...]` and make current entry points use it internally.
2. Add a new config-first API (documented) while keeping old flat options working via translation.
3. Add lightweight validation warnings for unknown keys / wrong shapes.
4. Once stable, simplify signatures and deprecate legacy names gradually (or keep small compatibility wrappers indefinitely if desired).

The key rule is: **normalize once at the boundary, then keep option passing explicit and local**.

## Applying The Roadmap To LongRunRisk (Concrete Targets)

This section applies the roadmap above to the actual entry points and “hot spots” in this repository.

### Natural subsystem boundaries in this repo

LongRunRisk already has clear pipeline stages and tool layers, which makes option untangling easier than in a generic project:

- **Model processing (symbolic):** `Kernel/Model/ProcessModels.wl` (`processModels`, `solveCoeffsSystem`, `simplifyCoeffsSystem`)
- **Compilation:** `Kernel/Tools/FindRootOptim.wl` (`createCompiledEq`, `buildKernel`)
- **Numerical solving:** `Kernel/ComputationalEngine/SolveEulerEq.wl` (`updateCoeffsSol`, `updateCoeffs`, `solveCoeffRoots`)
- **Moments database:** `Kernel/ComputationalEngine/CreateMomentsDatabase.wl` (`createDatabase`, `uncondCovLongExo`)
- **Orchestration:** `Kernel/Tools/ManageResources.wl` (`buildModels`, `buildModelsParallel`)
- **User helpers:** `Kernel/Tools/NicePlots.wl`, `Kernel/Tools/ToNumber.wl`, `Kernel/Tools/TimeAggregation.wl`

This suggests a config split that matches the code layout:

- `config["Symbolic"]`, `config["Compile"]`, `config["Numerical"]`, `config["Moments"]`, `config["Parallel"]`, plus a small `config["Build"]` for `buildModels`-only knobs (`"Models"`, `"FromScratch"`, `"FileSuffix"`, `"UpdateManifest"`, …).

### Specific tangles to remove (while preserving behavior)

**1) Avoid global option mutation (`yieldCurve` → `addCoeffsSolution`)**

`Kernel/Tools/NicePlots.wl` currently mutates `Options[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution]` to thread `FindRoot`/`RecurrenceTable` options. This couples files in a non-local way and can break parallel execution.

Refactor direction:

- Make `addCoeffsSolution` own its needed defaults (define `Options[addCoeffsSolution]` in `Kernel/Model/ProcessModels.wl`), and/or
- Pass all needed options explicitly down into `addCoeffsSolution`/`updateCoeffsBond` without touching global `Options[...]`.

**2) Make wrappers explicit about what they forward**

Examples today:

- `processModels` accepts options for multiple subsystems but (currently) only threads `"PdEquations"` through to `solveCoeffsSystem`.
- `buildModels` defines `"PdEquations"` but (currently) does not forward it into the symbolic/compile phase.

Refactor direction (preserving current behavior):

- In the new config normalization layer, decide (and document) exactly which keys affect which stage.
- If a key is intentionally ignored today, keep it ignored for compatibility, but make that explicit in one place (normalizer + docs) rather than by accident in call chains.

**3) Disentangle “FindRootOptions” shape clashes**

The same name is used with different expected types across the solver stack (e.g., `updateCoeffsSol` stores a list; `fastRoot`/`scanAndSolve` accept `Automatic`/function/list).

Refactor direction:

- Replace a single overloaded knob with stage-local names (e.g., `config["Numerical"]["Scan"]["FindRoot"]` vs `config["Numerical"]["FastRoot"]["FindRoot"]`).
- Keep a legacy translation layer that maps old names into the new nested structure.

**4) Normalize sign-handling in one place**

There are multiple “sign” concepts: `RootSigns`, `Signs`, and the `SignSymbol` representation (string vs symbol). Centralizing normalization (e.g., one `normalizeSigns[...]`) reduces cross-file assumptions.

**5) Move repeated option plumbing into helpers**

Patterns like `Flatten@{opts}`, `FilterRules[..., Options[...]]`, and repeated merging appear across files. A single helper that returns per-subsystem option lists makes call sites shorter and less error-prone.

## Re-Optimized For This Repo (Bigger Wins Available Here)

Because LongRunRisk already has a staged pipeline (`buildModels`: Symbolic → Compile → Numerical → Moments), you can simplify more aggressively than a generic library:

### 1) Make the pipeline config match pipeline phases

Instead of letting each layer accept a wide `OptionsPattern[...]`, treat the pipeline as the API:

- `buildModels[config_Association]` becomes the canonical entry point.
- `processModels`, `createCompiledEq`, `updateCoeffs`, `createDatabase` become lower-level functions that primarily accept their stage config sections.

This collapses “option forwarding trees” because stage boundaries become explicit, and most forwarding disappears.

### 2) Replace cross-package option dependencies with data dependencies

Instead of “set options on X so that Y behaves differently”, prefer:

- `yieldCurve` computes/requests exactly the data it needs (coeff solutions, maturities, moments) and passes explicit parameters.

This is especially valuable here because the code already passes rich `Association` objects (`model_Association`, `savedKernels_Association`).

### 3) Reduce the number of public “option surfaces”

A large part of perceived complexity is simply the number of places options can be attached. For this repo, the biggest payoff comes from shrinking the public surfaces to:

- pipeline (`buildModels*`)
- numerical solve (`updateCoeffs*`)
- a small set of user helpers (`toNum`, `yieldCurve`, `growth`)

Everything else can become internal helpers with fewer or no options (taking a validated config section instead).

### 4) Generate documentation from the schema (optional but high leverage)

Once a single normalization/schema exists, `docs/options-defaults.md` can be generated (or at least checked) from code. This reduces drift between docs and implementation.

## Implementation Plan (LongRunRisk)

This is a concrete, staged plan to implement the refactor described above while keeping computational behavior the same.

### Phase 0 — Inventory and “truth tables”

1. **Pick the supported entry points** (what users should call): likely `buildModels`, `buildModelsParallel`, `updateCoeffs`, `toNum`, `yieldCurve`, `growth`.
2. For each entry point, write a short “truth table” of current behavior:
   - which options are actually consumed vs silently ignored
   - which built-in options are forwarded (`FindRoot`, `RecurrenceTable`, `Simplify`, …)
   - what the defaults are today (as observed via `Options[...]` and/or code)

### Phase 1 — Add a schema + normalizer (no behavior change)

1. Add a single internal module (e.g., `Kernel/Tools/OptionsConfig.wl`) that defines:
   - **default config** (nested association by stage/subsystem)
   - a `normalizeConfig[...]` function that accepts:
     - new-style `config_Association`, and
     - legacy flat options (`OptionsPattern[...]`)
   - a `splitConfig[...]` helper that returns stage-local option lists ready for `Sequence @@ ...`.
2. Make normalization conservative:
   - keep “ignored today” keys ignored (for compatibility)
   - validate shapes (lists vs associations) but default to non-fatal behavior (e.g., message + fallback) unless the current code would already throw.

### Phase 2 — Refactor the pipeline entry points

1. Update `Kernel/Tools/ManageResources.wl`:
   - change `buildModels` internals to call `normalizeConfig` once
   - pass `config["Symbolic"]`/`["Compile"]`/`["Numerical"]`/`["Moments"]` explicitly to the stage functions
   - keep `buildModels`’ current caching/manifest semantics unchanged
2. Update `buildModelsParallel` similarly, and remove any option forwarding that currently depends on incidental `FilterRules` behavior.

### Phase 3 — Remove global option mutation and tighten the helper APIs

1. Update `Kernel/Tools/NicePlots.wl` to stop using `SetOptions[...]` on `addCoeffsSolution`.
2. Give `addCoeffsSolution` its own explicit `Options[...]` (or remove its dependency on `OptionValue[addCoeffsSolution,...]`) so defaults are local.
3. Convert internal helper signatures that currently accept huge option sets into:
   - either a narrow `OptionsPattern[...]` for a single subsystem, or
   - a normalized config section association.

### Phase 4 — Rename/reshape confusing knobs (with a compatibility layer)

1. Replace overloaded names with nested config (preferred) or namespaced keys.
2. Keep a compatibility translation layer in `normalizeConfig`:
   - map old keys to new keys
   - optionally emit a deprecation message (off by default, or behind a `"Warnings" -> True` switch)

### Phase 5 — Validation and regression protection

Minimum checks (fast, ad-hoc) after each phase:

- `Needs[...]` loads cleanly for the main packages.
- `Options[...]` for the public entry points match expected defaults (or expected compatibility behavior). For the coefficient solver, use `Options[updateCoeffs]` (the public wrapper), not the internal `updateCoeffsSol`.
- A tiny numerical smoke test runs end-to-end on a single model (or on a minimal synthetic input where possible).

Example ad-hoc WolframScript checks (run from the repo root):

```sh
wolframscript -code 'PacletDirectoryLoad[Directory[]];
Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
Print[Options[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels]];

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
Print[Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs]];

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
red = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval[A[0] > 0 && A[0] < 2, <||>];
Print[red];
Print[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce[red, A[0]]];
Quit[]'
```

Recommended regression tests (slower but higher confidence):

- Pin one or two representative models and assert invariants:
  - `processModels` output keys exist and are stable (`"coeffsSystem"`, `"coeffsParamQuadSolve"`, …)
  - `createCompiledEq` produces a valid `.mx` for the current `$SystemID`
  - `updateCoeffs` returns the same *number* of solution bundles and the same key structure
  - `createDatabase` writes moments files and metadata unchanged for identical inputs

The main success criterion is: **for the same inputs, the same models produce the same outputs (up to benign ordering/format differences), even if option names and call signatures evolve**.
