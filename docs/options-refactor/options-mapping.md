Below is an explicit **old → new** option map based on the current inventory in `options-ownership.md`, with the **single-owner rule** enforced, **no backward compatibility**, and the **wolfram-options** guidelines applied broadly.

A couple of important global decisions that show up in the table:

* **OptionsConfig-style “subkeys” are removed** (e.g. `"MaxIterations"` / `"AccuracyGoal"` / `"Options"` for FindRoot, `"DependentVariables"` / `"Options"` for RecurrenceTable). In the refactor, you use **built-in options directly** (e.g. `MaxIterations -> …`) and/or put those rules inside your **bundle** option (e.g. `"FindRootOptions" -> {MaxIterations -> …}`).
* **Multi-owner options are explicitly split/relocated**:

  * `SignSymbol` → **two options** (`SymbolicSignSymbol`, `CompileSignSymbol`)
  * `MaxMaturity` → **two options** (`BuildMaxMaturity`, `MaxMaturity`)
  * `Signs` → **single owner** (`solveCoeffRoots`)
  * `FromScratch`, `CreateMoments` → **single owner** (`buildModelsInternal`)
* I also **split RecurrenceTable bundles by stage** (symbolic vs numerical) so you don’t have the same option name consumed in two independent pipelines.

---

## Build and pipeline

| Old option          | New option       | Owner               | Public? | Notes                                                                        |
| ------------------- | ---------------- | ------------------- | ------- | ---------------------------------------------------------------------------- |
| AutoBuild           | AutoBuild        | checkModels         | Public  | —                                                                            |
| CompileJacobians    | CompileJacobians | buildModelsInternal | Public  | —                                                                            |
| CreateMoments       | CreateMoments    | buildModelsInternal | Public  | Single owner moved to buildModelsInternal; wrappers forward without reading. |
| FileSuffix          | FileSuffix       | buildModelsInternal | Public  | —                                                                            |
| FromScratch         | FromScratch      | buildModelsInternal | Public  | Single owner moved to buildModelsInternal; wrappers forward without reading. |
| MaxMaturity (Build) | BuildMaxMaturity | buildModelsInternal | Public  | Renamed to BuildMaxMaturity (build/process horizon).                         |
| Models              | Models           | buildModelsInternal | Public  | —                                                                            |
| UpdateManifest      | UpdateManifest   | buildModelsInternal | Public  | —                                                                            |

---

## Removed OptionsConfig subkeys (use built-ins)

These are **removed** (no legacy support). Users pass the **built-in option symbols** directly and/or include them inside `"FindRootOptions"`.

| Old option                | New option | Owner           | Public? | Notes                                                                                                                        |
| ------------------------- | ---------- | --------------- | ------- | ---------------------------------------------------------------------------------------------------------------------------- |
| AccuracyGoal              | (removed)  | FindRoot        | Public  | Removed. Use built-in FindRoot option AccuracyGoal (symbol) or include AccuracyGoal -> ... inside "FindRootOptions".         |
| DependentVariables        | (removed)  | RecurrenceTable | Public  | Removed. Use built-in DependentVariables -> ... passed directly to RecurrenceTable (or include in the relevant bundle).      |
| MaxIterations             | (removed)  | FindRoot        | Public  | Removed. Use built-in FindRoot option MaxIterations (symbol) or include MaxIterations -> ... inside "FindRootOptions".       |
| Options (FindRoot)        | (removed)  | FindRoot        | Public  | Removed. Pass built-in FindRoot options directly and/or via "FindRootOptions" bundle.                                        |
| Options (RecurrenceTable) | (removed)  | RecurrenceTable | Public  | Removed. Pass built-in RecurrenceTable options directly (or include in the relevant bundle).                                 |
| PrecisionGoal             | (removed)  | FindRoot        | Public  | Removed. Use built-in FindRoot option PrecisionGoal (symbol) or include PrecisionGoal -> ... inside "FindRootOptions".       |
| WorkingPrecision          | (removed)  | FindRoot        | Public  | Removed. Use built-in FindRoot option WorkingPrecision (symbol) or include WorkingPrecision -> ... inside "FindRootOptions". |

---

## Compilation

(Kept, but marked **Internal** by default; you can “promote” any of these later without changing structure.)

| Old option                 | New option                 | Owner       | Public?  | Notes                                                                                                                           |
| -------------------------- | -------------------------- | ----------- | -------- | ------------------------------------------------------------------------------------------------------------------------------- |
| AllowCompileDuringCoverage | AllowCompileDuringCoverage | buildKernel | Internal | —                                                                                                                               |
| CoeffName                  | CoeffName                  | buildKernel | Internal | —                                                                                                                               |
| CompilationTarget          | CompilationTarget          | buildKernel | Internal | —                                                                                                                               |
| CompileMode                | CompileMode                | buildKernel | Internal | —                                                                                                                               |
| Compiler                   | Compiler                   | buildKernel | Internal | —                                                                                                                               |
| FlattenExpressions         | FlattenExpressions         | buildKernel | Internal | —                                                                                                                               |
| PerformanceGoal            | PerformanceGoal            | buildKernel | Internal | —                                                                                                                               |
| RuntimeOptions             | RuntimeOptions             | buildKernel | Internal | —                                                                                                                               |
| SignSymbol (compile)       | CompileSignSymbol          | buildKernel | Internal | Split from SignSymbol. Name of sign variable used during compilation; accept Symbol or String, normalize to String for codegen. |

---

## Internal engine

| Old option                | New option     | Owner         | Public?  | Notes |
| ------------------------- | -------------- | ------------- | -------- | ----- |
| MaxIterations (internal)  | MaxIterations  | lagStateVarst | Internal | —     |
| TimeConstraint (internal) | TimeConstraint | lagStateVarst | Internal | —     |

---

## Model processing

This is the **RecurrenceTable bundle split** to enforce single-owner across independent pipelines.

| Old option                        | New option                     | Owner             | Public?  | Notes                                                                          |
| --------------------------------- | ------------------------------ | ----------------- | -------- | ------------------------------------------------------------------------------ |
| RecurrenceTableOptions (symbolic) | SymbolicRecurrenceTableOptions | addCoeffsSolution | Internal | Renamed to SymbolicRecurrenceTableOptions for processModels/addCoeffsSolution. |

---

## Moments database

| Old option             | New option             | Owner            | Public? | Notes |
| ---------------------- | ---------------------- | ---------------- | ------- | ----- |
| IterationLimit         | IterationLimit         | uncondCovLongExo | Public  | —     |
| maxMomentsLagsToCreate | maxMomentsLagsToCreate | createDatabase   | Public  | —     |
| simplifyDownValues     | simplifyDownValues     | createDatabase   | Public  | —     |
| startSequenceAtLag     | startSequenceAtLag     | createDatabase   | Public  | —     |

---

## Numerical solving

Key refactors here:

* `"Signs"` becomes **single-owned by `solveCoeffRoots`**
* `"MaxMaturity"` becomes **numerical-only** and **single-owned by `updateCoeffsSol`**
* `"FindRootOptions"` is **single-owned by `solveCoeffRoots`** (downstream code must not call `OptionValue` on it)
* `"RecurrenceTableOptions"` numerical bundle is **owned by `updateCoeffsSol`** (symbolic bundle renamed above)

| Old option                         | New option             | Owner                      | Public?  | Notes                                                                                         |
| ---------------------------------- | ---------------------- | -------------------------- | -------- | --------------------------------------------------------------------------------------------- |
| BracketGrid                        | BracketGrid            | scanAndSolve               | Internal | —                                                                                             |
| CheckResiduals                     | CheckResiduals         | checks                     | Public   | —                                                                                             |
| FastRootOptions                    | FastRootOptions        | scanAndSolve               | Internal | —                                                                                             |
| FindRootOptions                    | FindRootOptions        | solveCoeffRoots            | Public   | Single owner moved to solveCoeffRoots; downstream functions no longer call OptionValue on it. |
| InteriorShrink                     | InteriorShrink         | extractIntervalsFromReduce | Internal | —                                                                                             |
| MaxMaturity                        | MaxMaturity            | updateCoeffsSol            | Public   | Numerical horizon only. updateCoeffsSol is the only consumer; wrappers pass it through.       |
| Method (FindRoot)                  | Method                 | fastRoot                   | Internal | —                                                                                             |
| PrintResidualsNorm                 | PrintResidualsNorm     | checks                     | Public   | —                                                                                             |
| RecurrenceTableOptions (numerical) | RecurrenceTableOptions | updateCoeffsSol            | Internal | Numerical RecurrenceTable bundle owned by updateCoeffsSol.                                    |
| ReduceTimeLimit                    | ReduceTimeLimit        | solveND                    | Public   | —                                                                                             |
| Return                             | Return                 | fastRoot                   | Internal | —                                                                                             |
| RootSigns                          | RootSigns              | solveCoeffRoots            | Public   | —                                                                                             |
| RootUpperBound                     | RootUpperBound         | extractIntervalsFromReduce | Internal | —                                                                                             |
| RootSigns                          | RootSigns              | solveCoeffRoots            | Public   | —                                                                                             |
| ScanMethod                         | ScanMethod             | scanAndSolve               | Internal | —                                                                                             |
| SecantBlend                        | SecantBlend            | fastRoot                   | Internal | —                                                                                             |
| Signs                              | Signs                  | solveCoeffRoots            | Public   | Single owner moved to solveCoeffRoots; downstream sign consumers take explicit arguments.     |
| Tol                                | Tol                    | checks                     | Public   | —                                                                                             |
| Tolerance                          | Tolerance              | scanAndSolve               | Internal | —                                                                                             |
| UnboundedPad                       | UnboundedPad           | extractIntervalsFromReduce | Internal | —                                                                                             |
| UpdateBond                         | UpdateBond             | updateCoeffsSol            | Public   | —                                                                                             |
| UpdateBonds                        | UpdateBonds            | updateCoeffsSol            | Public   | —                                                                                             |
| UpdateNomBond                      | UpdateNomBond          | updateCoeffsSol            | Public   | —                                                                                             |
| UpdatePd                           | UpdatePd               | updateCoeffsSol            | Public   | —                                                                                             |
| initialGuess                       | initialGuess           | solveCoeffRoots            | Public   | —                                                                                             |

---

## Parallel

| Old option | New option | Owner                | Public? | Notes |
| ---------- | ---------- | -------------------- | ------- | ----- |
| NumKernels | NumKernels | setupParallelKernels | Public  | —     |

---

## Plotting and visualization

| Old option     | New option     | Owner           | Public? | Notes |
| -------------- | -------------- | --------------- | ------- | ----- |
| MomentFunction | MomentFunction | yieldCurve      | Public  | —     |
| ShowDetails    | ShowDetails    | visualizeCoeffs | Public  | —     |
| ShowSelector   | ShowSelector   | visualizeCoeffs | Public  | —     |

---

## Symbolic solving

Two changes of note in this block:

* `SignSymbol` split: the **symbolic** one is now `SymbolicSignSymbol`
* (Default stance) paramQuadSolve knobs are **Internal**, but remain fully configurable/promotable

| Old option             | New option             | Owner                         | Public?  | Notes                                                                                                                                     |
| ---------------------- | ---------------------- | ----------------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Assumptions            | Assumptions            | paramQuadSolve                | Internal | —                                                                                                                                         |
| DiagnosticsOption      | DiagnosticsOption      | paramQuadSolve                | Internal | —                                                                                                                                         |
| DomainOption           | DomainOption           | paramQuadSolve                | Internal | —                                                                                                                                         |
| GroebnerMemoryCap      | GroebnerMemoryCap      | paramQuadSolve                | Internal | —                                                                                                                                         |
| GroebnerMemoryFloor    | GroebnerMemoryFloor    | paramQuadSolve                | Internal | —                                                                                                                                         |
| GroebnerMemoryFraction | GroebnerMemoryFraction | paramQuadSolve                | Internal | —                                                                                                                                         |
| Level0Pattern          | Level0Pattern          | simplifyWithDummySubstitution | Internal | —                                                                                                                                         |
| Method                 | Method                 | paramQuadSolve                | Internal | —                                                                                                                                         |
| MonomialOrder          | MonomialOrder          | paramQuadSolve                | Internal | —                                                                                                                                         |
| OnlyQuadTerms          | OnlyQuadTerms          | paramQuadSolve                | Internal | —                                                                                                                                         |
| PdEquations            | PdEquations            | solveCoeffsSystem             | Public   | —                                                                                                                                         |
| ReturnOption           | ReturnOption           | paramQuadSolve                | Internal | —                                                                                                                                         |
| SimplifyFunction       | SimplifyFunction       | simplifyWithDummySubstitution | Internal | —                                                                                                                                         |
| SimplifyOptions        | SimplifyOptions        | solveCoeffsSystem             | Public   | —                                                                                                                                         |
| SimplifyTimeout        | SimplifyTimeout        | paramQuadSolve                | Internal | —                                                                                                                                         |
| SignSymbol (symbolic)  | SymbolicSignSymbol     | paramQuadSolve                | Internal | Split from SignSymbol. Symbolic sign-variable symbol used in paramQuadSolve; expected type: Symbol. Not forwarded outside symbolic solve. |
| TimeoutOption          | TimeoutOption          | paramQuadSolve                | Internal | —                                                                                                                                         |
| ValidationOption       | ValidationOption       | paramQuadSolve                | Internal | —                                                                                                                                         |
| paramQuadSolveOptions  | paramQuadSolveOptions  | solveCoeffsSystem             | Internal | —                                                                                                                                         |

---

## Time aggregation

| Old option      | New option      | Owner            | Public? | Notes |
| --------------- | --------------- | ---------------- | ------- | ----- |
| Order           | Order           | growth           | Public  | —     |
| TimeAggregation | TimeAggregation | timeSeriesVector | Public  | —     |
| Variable        | Variable        | g                | Public  | —     |
| numPeriods      | numPeriods      | timeSeriesVector | Public  | —     |
| v0              | v0              | growth           | Public  | —     |

---

### Quick “what you’ll actually see change” list

If you only want the **user-visible changes** you’ll feel immediately when refactoring:

* `SignSymbol` is gone; replace with:

  * `SymbolicSignSymbol -> s` (symbolic solve)
  * `CompileSignSymbol -> "s"` (compilation/codegen)
* `MaxMaturity` in build/process is renamed:

  * `BuildMaxMaturity -> …` (build/process pipeline)
  * `MaxMaturity -> …` (numerical evaluation via `updateCoeffsSol`, used by ToNum/YieldCurve)
* `Signs` is only read in **one place** now:

  * `Signs -> …` is owned by `solveCoeffRoots` (everything else takes explicit arguments)
* `FromScratch` / `CreateMoments` are only read in **one place** now:

  * both owned by `buildModelsInternal`
* FindRoot/RecurrenceTable config-subkeys are removed:

  * use **built-in option symbols** and/or bundle rules in `"FindRootOptions"`.

If you want, next I can also provide the *companion “new canonical options registry” file layout* (what file owns each `Options[...]` declaration, where OptionsValidation runs, and what each wrapper’s `OptionsPattern[{...}]` list should be) so this mapping becomes a straightforward mechanical refactor.
