Below is the **concrete “paste-ready” post‑refactor `Options[...]` set** for every **true owner (terminal consumer)**, plus an **exact OptionValue surgery checklist** (what `OptionValue["…"]` calls must be removed/relocated) to make:

* **single source of truth** = `Options[owner]`
* **single consumer per option name**
* **wrappers forward only**
* **no legacy support**
* **built‑in option conventions** (pass built‑in option symbols directly; don’t redeclare them on wrappers)

I’m basing this on your `options-defaults.md` and the per‑option trees in `options/` (notably the trees for `"Signs"`, `"MaxMaturity"`, `"CoeffName"`, `"SignSymbol"`, `"FromScratch"`, `"CreateMoments"`).

---

# 1) Final owner defaults: exact `Options[...]` blocks (grouped by file)

## `Kernel/Tools/ManageResources.wl`

### `buildModelsInternal` owns all Build orchestration knobs

```wl
Options[buildModelsInternal] = {
  "Models" -> All,
  "CompileJacobians" -> True,
  "BuildMaxMaturity" -> 12,     (* NEW: build/process knob (split from MaxMaturity) *)
  "FileSuffix" -> "",
  "UpdateManifest" -> True,
  "FromScratch" -> False,
  "CreateMoments" -> True
};
```

### `setupParallelKernels`

```wl
Options[setupParallelKernels] = {
  "NumKernels" -> Automatic
};
```

> **Intentional change**: `"MaxMaturity"` (Build) is gone from Build defaults and replaced by `"BuildMaxMaturity" -> 12`.
> This matches your requirement to split build/process vs evaluation.

---

## `Kernel/Model/ProcessModels.wl`

### `solveCoeffsSystem` owns only its own options (no nested `paramQuadSolveOptions`)

```wl
Options[solveCoeffsSystem] = {
  "PdEquations" -> "B",
  "SimplifyOptions" -> {TimeConstraint -> {5, 300}}
};
```

> **Removed**: `"paramQuadSolveOptions"` as an owned option.
> New behavior: solveCoeffsSystem **accepts and forwards** `paramQuadSolve` options directly (via `OptionsPattern[{solveCoeffsSystem, paramQuadSolve}]`) but does not “own” them.

---

## `Kernel/ComputationalEngine/ParamQuadSolve.wl`

### `paramQuadSolve` owns the symbolic solver controls (including the **symbolic** sign variable symbol)

```wl
Options[paramQuadSolve] = {
  "DomainOption" -> Reals,
  "Assumptions" -> Automatic,
  "Method" -> Automatic,
  "MonomialOrder" -> Automatic,

  "ValidationOption" -> True,
  "ReturnOption" -> "All",
  "TimeoutOption" -> 600,
  "SimplifyTimeout" -> Automatic,
  "DiagnosticsOption" -> False,
  "OnlyQuadTerms" -> False,

  "SymbolicSignSymbol" -> signA,     (* NEW: was "SignSymbol" (Symbol) *)

  "GroebnerMemoryFraction" -> 0.5,
  "GroebnerMemoryFloor" -> 1*1024^3,
  "GroebnerMemoryCap" -> 16*1024^3
};
```

### `simplifyWithDummySubstitution`

```wl
Options[simplifyWithDummySubstitution] = {
  "Level0Pattern" -> (_Symbol[0] | _Symbol[_][0]),
  "SimplifyFunction" -> Simplify
};
```

> Note: if `simplifyWithDummySubstitution` previously had its own `"Assumptions"`, remove it and pass the assumptions in as an **argument from `paramQuadSolve`** (so `"Assumptions"` remains single-owned by `paramQuadSolve`).

---

## `Kernel/Tools/FindRootOptim.wl`

### `buildKernel` owns compile‑time naming knobs (string sign name) + compile configuration

```wl
Options[buildKernel] = {
  "CoeffName" -> "A",
  "CompileSignSymbol" -> "signA",     (* NEW: was "SignSymbol" (String) *)

  "PerformanceGoal" -> "Quality",
  "CompileMode" -> "Both",
  "Compiler" -> "Compile",

  "RuntimeOptions" -> Automatic,
  "CompilationTarget" -> "C",

  "FlattenExpressions" -> Automatic,
  "AllowCompileDuringCoverage" -> False
};
```

### `fastRoot` owns only wrapper‑specific knobs (NOT FindRoot’s options)

```wl
Options[fastRoot] = {
  "SecantBlend" -> 0.5,
  "ReturnType" -> "Value"            (* NEW NAME: was "Return" *)
};
```

### `scanAndSolve`

```wl
Options[scanAndSolve] = {
  "ScanMethod" -> "Grid",
  "BracketGrid" -> 32,
  "Tolerance" -> Automatic
};
```

### `extractIntervalsFromReduce`

```wl
Options[extractIntervalsFromReduce] = {
  "InteriorShrink" -> 0.001,
  "RootUpperBound" -> 15,
  "UnboundedPad" -> 1.*^5
};
```

> **Major cleanup here (matches wolfram-options guidelines):**
>
> * `fastRoot` no longer “owns” `MaxIterations`, `AccuracyGoal`, `PrecisionGoal`, `WorkingPrecision`, `Method`, `Jacobian`, etc.
>   It **accepts them by including `FindRoot` in `OptionsPattern[{fastRoot, FindRoot}]` and forwards them**.
> * `scanAndSolve` no longer owns `"FastRootOptions"` / `"FindRootOptions"` bundles; it forwards to `fastRoot`.

---

## `Kernel/ComputationalEngine/SolveEulerEq.wl`

### `updateCoeffsSol` is the **single owner** of evaluation `"MaxMaturity"`

```wl
Options[updateCoeffsSol] = {
  "UpdatePd" -> False,
  "UpdateBond" -> False,
  "UpdateNomBond" -> False,
  "UpdateBonds" -> False,
  "MaxMaturity" -> 12
};
```

### `solveCoeffRoots` is the **single owner** of `"Signs"` (per your decision)

```wl
Options[solveCoeffRoots] = {
  "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
  "RootSigns" -> Automatic,
  "Signs" -> {}
};
```

### `checks`

```wl
Options[checks] = {
  "PrintResidualsNorm" -> False,
  "CheckResiduals" -> False,
  "Tol" -> 10.^-16
};
```

### `solveND`

```wl
Options[solveND] = {
  "ReduceTimeLimit" -> 5.
};
```

---

## `Kernel/ComputationalEngine/CreateMomentsDatabase.wl`

### `createDatabase`

```wl
Options[createDatabase] = {
  "maxMomentsLagsToCreate" -> 8,
  "startSequenceAtLag" -> 3,
  "simplifyDownValues" -> False
};
```

### `uncondCovLongExo`

```wl
Options[uncondCovLongExo] = {
  "IterationLimit" -> $IterationLimit/4
};
```

---

## `Kernel/ComputationalEngine/ComputeConditionalExpectations.wl`

### `lagStateVarst`

```wl
Options[lagStateVarst] = {
  "MaxIterations" -> 100,
  "TimeConstraint" -> 30
};
```

---

## `Kernel/Tools/TimeAggregation.wl`

```wl
Options[growth] = {
  "v0" -> Function[{t, j, h, k, v, im}, 0],
  "Order" -> 1
};

Options[timeSeriesVector] = {
  "TimeAggregation" -> 1,
  "numPeriods" -> 1
};

Options[g] = {
  "Variable" -> "Flow"
};
```

---

## `Kernel/Tools/VisualizeCoeffs.wl`

```wl
Options[visualizeCoeffs] = {
  "ShowSelector" -> True,
  "ShowDetails" -> True
};
```

---

## `Kernel/Tools/NicePlots.wl`

```wl
Options[yieldCurve] = {
  "MomentFunction" -> uncondE
};
```

> **Removed**: `yieldCurve` no longer owns/consumes `"MaxMaturity"`.

---

## `Kernel/Tools/PipelineMonitor.wl`

```wl
Options[checkModels] = {
  "AutoBuild" -> Automatic
};
```

---

# 2) Functions that should NOT have `Options[...]` anymore (delete their `Options[...]` blocks)

These should be **pure forwarders** (accept via `OptionsPattern[{...}]`, then `FilterRules`/`forwardTo`):

* `buildModels` (make it an alias to `buildModelsInternal`, or a trivial forwarder with no options)
* `buildModelsParallel` (forwarder; no longer consumes `"FromScratch"` / `"CreateMoments"`)
* `determineModelStatus` (no longer consumes `"CreateMoments"`)
* `processModels` (forwarder)
* `addCoeffsSolution` (forwarder **plus** it receives build maturity as an argument)
* `updateCoeffs` (forwarder)
* `yieldCurve` keeps only `"MomentFunction"` (already shown)
* Any internal glue (`toNum`, `toNumRules`, etc.) should be forwarders

---

# 3) Exact OptionValue surgery checklist (delete/move/replace)

This is the “do these edits and ownership becomes true” list. I’m using the dependency trees you generated (they explicitly mark where each option is **use** vs **pass**).

## A) `"Signs"`: only `solveCoeffRoots` may consume it

### REMOVE these OptionValue reads

* `bindUnary` (in `FindRootOptim.wl`)
  **Delete**: `OptionValue["Signs"]`
  **Replace with**: positional argument `signsSpec_` (or a normalized `signData_`) supplied by `solveCoeffRoots`.

* `findRootInterval` (in `FindRootOptim.wl`)
  **Delete**: `OptionValue["Signs"]`
  **Replace with**: positional argument `signsSpec_` (passed by caller)

* `safeReduceCall` (in `SolveEulerEq.wl`)
  The option tree shows `safeReduceCall -> findRootInterval [use]` for `"Signs"`.
  **Delete any `OptionValue["Signs"]` here** and require caller to pass sign data down.

### KEEP only here

* `solveCoeffRoots` (in `SolveEulerEq.wl`)
  **Keep**: `OptionValue["Signs"]`
  **Normalize once**, then pass as argument to everything downstream.

---

## B) `"MaxMaturity"`: split build/process vs evaluation exactly as you specified

### 1) Build/process max maturity

* New option: `"BuildMaxMaturity"` owned by `buildModelsInternal`
* **Everywhere else** receives it as an *argument* OR `buildModelsInternal` explicitly overrides evaluation `"MaxMaturity"` when calling `updateCoeffsSol` during build.

**Edits:**

* In `buildModelsInternal`:

  * **Replace** `OptionValue["MaxMaturity"]` (build config)
  * With: `OptionValue["BuildMaxMaturity"]`

* In `addCoeffsSolution` (ProcessModels.wl):

  * **Delete**: `OptionValue["MaxMaturity"]`
  * **Replace with**: argument `buildMaxMaturity_Integer` passed by `buildModelsInternal`

### 2) Evaluation max maturity

* Keep option name: `"MaxMaturity"` owned by `updateCoeffsSol`

**Edits:**

* In `updateCoeffsSol`:

  * **Keep**: `OptionValue["MaxMaturity"]`

* In these functions (all currently flagged as consumers in your ownership analysis):

  * `updateCoeffsBond` (SolveEulerEq.wl)
  * `checkCoeffs` (SolveEulerEq.wl)
  * `yieldCurve` (NicePlots.wl)
  * `addCoeffsSolution` (ProcessModels.wl)
    **Delete**: `OptionValue["MaxMaturity"]`
    **Replace with**: a positional `maxMaturity_Integer` argument supplied by `updateCoeffsSol`, OR rely on the returned data length from `updateCoeffsSol` (for plotting).

> This is the critical “single consumer” move: only `updateCoeffsSol` is allowed to interpret `"MaxMaturity"`.

---

## C) `"FromScratch"`: single owner `buildModelsInternal`

### REMOVE these OptionValue reads

* `buildModelsParallel` (ManageResources.wl)
  **Delete**: `OptionValue["FromScratch"]`
  **Replace with**: argument `fromScratch_True|False` passed from `buildModelsInternal` (or compute once there and pass down)

### KEEP only here

* `buildModelsInternal` keeps `OptionValue["FromScratch"]`

---

## D) `"CreateMoments"`: single owner `buildModelsInternal`

### REMOVE these OptionValue reads

* `buildModelsParallel` (ManageResources.wl)
  **Delete**: `OptionValue["CreateMoments"]`
* `determineModelStatus` (ManageResources.wl)
  **Delete**: `OptionValue["CreateMoments"]`

**Replace both with**: a boolean argument passed from `buildModelsInternal` (or eliminate the check entirely if it was only used to decide whether to call createDatabase).

### KEEP only here

* `buildModelsInternal` keeps `OptionValue["CreateMoments"]`

---

## E) `SignSymbol` split: **no `OptionValue["SignSymbol"]` should remain anywhere**

Your own option trees show `"SignSymbol"` is used by:

* `paramQuadSolve` (symbolic use)
* `buildKernel` (compile use)
* `findRootInterval` (string use in root interval logic)

### REQUIRED replacements

* In `ParamQuadSolve.wl / paramQuadSolve`:
  **Replace** `OptionValue["SignSymbol"]`
  **With** `OptionValue["SymbolicSignSymbol"]`

* In `FindRootOptim.wl / buildKernel`:
  **Replace** `OptionValue["SignSymbol"]`
  **With** `OptionValue["CompileSignSymbol"]`

* In `FindRootOptim.wl / findRootInterval`:
  **Delete** `OptionValue["SignSymbol"]` entirely.
  **Replace with**: argument `compileSignSymbol_String` (supplied from compiled-equation metadata, i.e. whatever `buildKernel` chose)

---

## F) Bonus (but important): `"CoeffName"` must also become compile‑owned only

Your tree shows `CoeffName` is “use” in `findRootInterval`. Same fix as SignSymbol:

* `buildKernel` keeps `OptionValue["CoeffName"]`
* `findRootInterval` **must not** call `OptionValue["CoeffName"]`; receive it as an argument

---

# 4) Quick “mechanical search” commands you can run (to confirm you’re done)

Search for remaining multi-owner reads:

* `OptionValue["Signs"]` must appear **only** in `solveCoeffRoots`
* `OptionValue["FromScratch"]` only in `buildModelsInternal`
* `OptionValue["CreateMoments"]` only in `buildModelsInternal`
* `OptionValue["MaxMaturity"]` only in `updateCoeffsSol`
* `OptionValue["SignSymbol"]` nowhere
* `OptionValue["CoeffName"]` only in `buildKernel`

---
