Great — here’s the **companion “implementation plan”** that turns the option map into a **mechanical refactor**:

* **where each `Options[...]` lives** (file-by-file),
* **where OptionsValidation runs** (and how),
* **the canonical `OptionsPattern[{...}]` list for every wrapper**, using the *wolfram-options* “Declare / Accept / Cache / Forward / Inject” rules.

I’ll also explicitly call out the **one intentional deviation** from the `wolfram-options` “wrapper inherits options via `Join@@Options[...]`” pattern: you asked for **single source of truth**, so we do **not** duplicate defaults onto wrapper symbols.

---

# 0) A key policy choice for this refactor

## No “wrapper copies child options”

Even though `wolfram-options/QUICK_REFERENCE.md` shows a wrapper pattern where:

```wl
wrapper // Options = Join @@ (Options /@ {core});
```

…you explicitly want **single source of truth**, so we do **not** do that.

Instead, wrappers are one of:

1. **True owners** (they declare only their owned options), or
2. **Forward-only wrappers** (they declare *no* options, and accept options via `OptionsPattern[{...}]`).

If you still want a wrapper symbol to *report* options to users, the cleanest single-source pattern is to make it a **true alias**:

```wl
PublicName = InternalOwnerFunction;
```

Then `Options[PublicName]` == `Options[InternalOwnerFunction]` automatically.

---

# 1) New “Options management layout” in the paclet

Add a tiny options “framework” folder. Nothing here becomes a second source of truth for defaults.

```
Kernel/
  Options/
    Forwarding.wl
    Validation.wl
    Registry.wl           (optional, no defaults; names only)
```

### `Kernel/Options/Forwarding.wl`

Pure helper utilities so every file forwards options identically:

```wl
BeginPackage["LongRunRisk`Options`"];

forwardTo::usage = "forwardTo[opts, child] gives the forwarded option rules for child.";

Begin["`Private`"];

forwardTo[opts_, child_] :=
  Evaluate @ FilterRules[Flatten @ {opts}, Options[child]];

mergeForwarded[opts_, child_, bundled_List] :=
  Flatten @ { forwardTo[opts, child], Evaluate @ bundled };

End[];
EndPackage[];
```

This is just packaging your “Forward” rule into one place so you don’t ever regress back to `FilterRules[opts,...]` etc.

---

### `Kernel/Options/Validation.wl`

This is where **OptionsValidation** lives.

Rules of thumb:

* Define `CheckOption[owner, opt]` only for options that `owner` *actually consumes*.
* Enable validation on:

  * all **public entrypoints**, and
  * all **owner functions** (even if not public), because they’re the “single point of truth”.

Sketch:

```wl
BeginPackage["LongRunRisk`OptionsValidation`"];
Begin["`Private`"];

Needs["OptionsValidation`"];

(* Example checks *)
CheckOption[buildModelsInternal, "BuildMaxMaturity"][v_] /; ! (IntegerQ[v] && v > 0) :=
  (Message[buildModelsInternal::optx, "BuildMaxMaturity", v]; $Failed);

CheckOption[solveCoeffRoots, "Signs"][v_] /; ! validSignsSpecQ[v] :=
  (Message[solveCoeffRoots::optx, "Signs", v]; $Failed);

(* Turn validation on *)
SetDefaultOptionsValidation @ {
  buildModelsInternal,
  solveCoeffsSystem,
  paramQuadSolve,
  buildKernel,
  fastRoot,
  scanAndSolve,
  extractIntervalsFromReduce,
  solveND,
  solveCoeffRoots,
  updateCoeffsSol,
  checks,
  addCoeffsSolution,
  createDatabase,
  uncondCovLongExo,
  setupParallelKernels,
  growth, g, timeSeriesVector,
  visualizeCoeffs,
  yieldCurve,
  checkModels,
  lagStateVarst
};

End[];
EndPackage[];
```

You said “OptionsValidation only (no ErrorTools)”, so this stays message + `$Failed` style.

---

### `Kernel/Options/Registry.wl` (optional but very useful)

This is NOT defaults. It is only a **names-only inventory** to prevent drift and to support tests/docs:

```wl
$OwnedOptions = <|
  buildModelsInternal -> {"Models","CompileJacobians","BuildMaxMaturity","FileSuffix","UpdateManifest","FromScratch","CreateMoments"},
  solveCoeffsSystem   -> {"PdEquations","SimplifyOptions"},
  paramQuadSolve      -> {"DomainOption","TimeoutOption","SimplifyTimeout","ValidationOption","ReturnOption","DiagnosticsOption",
                          "OnlyQuadTerms","GroebnerMemoryFraction","GroebnerMemoryFloor","GroebnerMemoryCap","SymbolicSignSymbol"},
  buildKernel         -> {"CoeffName","PerformanceGoal","CompileMode","Compiler","RuntimeOptions","CompilationTarget","FlattenExpressions",
                          "AllowCompileDuringCoverage","CompileSignSymbol"},
  updateCoeffsSol     -> {"UpdatePd","UpdateBond","UpdateNomBond","UpdateBonds","MaxMaturity"},
  solveCoeffRoots     -> {"initialGuess","RootSigns","Signs"},
  solveND             -> {"ReduceTimeLimit"},
  checks              -> {"PrintResidualsNorm","CheckResiduals","Tol"},
  createDatabase      -> {"maxMomentsLagsToCreate","startSequenceAtLag","simplifyDownValues"},
  uncondCovLongExo    -> {"IterationLimit"},
  setupParallelKernels-> {"NumKernels"},
  visualizeCoeffs     -> {"ShowSelector","ShowDetails"},
  yieldCurve          -> {"MomentFunction"}
|>;
```

This lets you write a unit test like:

* “no option name appears in more than one `$OwnedOptions[f]` list”
* “every option in `$OwnedOptions[f]` is actually in `Options[f]`”
* “no other symbol defines those options”

Again: **no defaults here**, so it doesn’t violate single-source-of-truth.

---

# 2) Where each `Options[...]` declaration should live

Your **single source of truth** = `Options[owner]`.
So: every owner’s `Options[...]` lives in the file that defines the owner function.

Below is the canonical “ownership → file” layout (reflecting your repo structure in the analysis docs):

## `Kernel/Tools/ManageResources.wl`

**Owners declared here**

* `buildModelsInternal`

  * Own: `"Models"`, `"CompileJacobians"`, `"FileSuffix"`, `"UpdateManifest"`
  * Plus (after refactor): `"FromScratch"`, `"CreateMoments"`, `"BuildMaxMaturity"` (**rename from Build.MaxMaturity**)
* `setupParallelKernels`

  * Own: `"NumKernels"`
* (If `buildModels` is only a public name): make it an alias to `buildModelsInternal`

**Important structural change**

* `buildModelsParallel`, `determineModelStatus` become **argument-driven** (no longer owners of `"FromScratch"` / `"CreateMoments"`)

---

## `Kernel/Model/ProcessModels.wl`

**Owners declared here**

* `solveCoeffsSystem`

  * Own: `"PdEquations"`, `"SimplifyOptions"`
  * (You can keep `"paramQuadSolveOptions"` as a bundle OR go fully pass-through — your call; see wrapper patterns below)
* `addCoeffsSolution`

  * Own: (recommended) only `"RecurrenceTableOptions"` bundle **or nothing** if you go fully pass-through to RecurrenceTable
  * **Stop consuming MaxMaturity** (build max maturity arrives as an *argument* from buildModelsInternal)

---

## `Kernel/ComputationalEngine/ParamQuadSolve.wl`

**Owners declared here**

* `paramQuadSolve`

  * Own: its true solver controls + **`"SymbolicSignSymbol"`** (split from `SignSymbol`)
* `simplifyWithDummySubstitution`

  * Own: `"Level0Pattern"`, `"SimplifyFunction"`

---

## `Kernel/Tools/FindRootOptim.wl`

**Owners declared here**

* `buildKernel`

  * Own: compile controls + **`"CompileSignSymbol"`** (split from `SignSymbol`)
* `fastRoot`

  * Own: wrapper-specific controls (recommend rename `Method` to `"RootMethod"` to avoid ambiguity)
  * Own: `"FindRootOptions"` bundle (list of FindRoot option rules)
  * **Stop “re-owning” FindRoot options** like `"MaxIterations"` etc — instead accept FindRoot options directly and forward.
* `scanAndSolve`

  * Own: `"FastRootOptions"` (bundle), `"ScanMethod"`, `"BracketGrid"`, `"Tolerance"`
* `extractIntervalsFromReduce`

  * Own: `"UnboundedPad"`, `"InteriorShrink"`, `"RootUpperBound"`
* `bindUnary`, `findRootInterval`

  * **Stop consuming `"Signs"`** (they take sign data as an argument)

---

## `Kernel/ComputationalEngine/SolveEulerEq.wl`

**Owners declared here**

* `updateCoeffsSol`

  * Own: `"UpdatePd"`, `"UpdateBond"`, `"UpdateNomBond"`, `"UpdateBonds"`
  * Plus (after refactor): **`"MaxMaturity"`** (evaluation knob)
  * **Stop other functions consuming MaxMaturity**: pass `maxMaturity` as an argument to `updateCoeffsBond`, `checkCoeffs`, etc.
* `solveCoeffRoots`

  * Own: `"initialGuess"`, `"RootSigns"`
  * Plus (after refactor): **`"Signs"`** (single owner per your decision)
* `solveND`

  * Own: `"ReduceTimeLimit"`
* `checks`

  * Own: `"PrintResidualsNorm"`, `"CheckResiduals"`, `"Tol"`

---

## `Kernel/ComputationalEngine/CreateMomentsDatabase.wl`

**Owners declared here**

* `createDatabase`

  * Own: `"maxMomentsLagsToCreate"`, `"startSequenceAtLag"`, `"simplifyDownValues"`
* `uncondCovLongExo`

  * Own: `"IterationLimit"`

---

## `Kernel/Tools/TimeAggregation.wl`

**Owners declared here**

* `growth` : `"v0"`, `"Order"`
* `timeSeriesVector` : `"TimeAggregation"`, `"numPeriods"`
* `g` : `"Variable"`

---

## `Kernel/Tools/VisualizeCoeffs.wl`

**Owners declared here**

* `visualizeCoeffs` : `"ShowSelector"`, `"ShowDetails"`

---

## `Kernel/Tools/NicePlots.wl`

**Owners declared here**

* `yieldCurve` : `"MomentFunction"`

---

## `Kernel/Tools/PipelineMonitor.wl`

**Owners declared here**

* `checkModels` : `"AutoBuild"`

---

## `Kernel/ComputationalEngine/ComputeConditionalExpectations.wl`

**Owners declared here**

* `lagStateVarst` : internal `"MaxIterations"`, `"TimeConstraint"` (you said promotable/configurable — keep them as real options now)

---

# 3) Canonical wrapper signatures: `OptionsPattern[{...}]` lists

Below are the **canonical “Accept lists”** that make option passing work without redeclaring child options.

I’m giving these in two layers:

* **Internal wrappers:** include *direct callees only* (keeps code tidy)
* **Public entry points:** include a superset so users can pass relevant options at the top level without fighting the pipeline

You can choose to be minimal or generous at the public layer; internal layer should remain “direct only”.

---

## 3.1 Build pipeline wrappers

### `buildModelsInternal` (owner)

It orchestrates: symbolic (`processModels`), compile (`buildKernel`), numerical (`updateCoeffsSol` / `solveCoeffRoots`), moments (`createDatabase`), etc.

**Signature:**

```wl
buildModelsInternal[
  args___,
  opts : OptionsPattern[{
    buildModelsInternal,
    processModels, solveCoeffsSystem, paramQuadSolve,
    addCoeffsSolution,
    buildKernel,
    updateCoeffsSol, solveCoeffRoots, solveND, checks,
    fastRoot, scanAndSolve, extractIntervalsFromReduce,
    createDatabase, uncondCovLongExo,
    setupParallelKernels
  }]
] := ...
```

Why this list?

* Lets users configure *any* true consumer in the build pipeline from one call.
* Doesn’t redeclare child options, just accepts and forwards.

**Key forwarding convention inside `buildModelsInternal`:**

* Compute **`buildMaxMat = OptionValue["BuildMaxMaturity"]` once**
* Call `processModels[..., maxMatBuild, Sequence @@ forwardTo[opts, processModels]]`
* Call `updateCoeffsSol[..., maxMatBuild, Sequence @@ forwardTo[opts, updateCoeffsSol]]` (override via arg)
* Call `createDatabase[..., Sequence @@ forwardTo[opts, createDatabase]]`
* etc.

So BuildMaxMaturity stays a build-only knob without becoming a shared MaxMaturity.

---

### `processModels` (forward-only wrapper)

It calls `solveCoeffsSystem` and `addCoeffsSolution`.

```wl
processModels[
  args___,
  opts : OptionsPattern[{processModels, solveCoeffsSystem, addCoeffsSolution, paramQuadSolve}]
] := ...
```

Note: include `paramQuadSolve` only if you want to allow passing paramQuadSolve options through this layer directly. If you keep them bundled at `solveCoeffsSystem`, you can omit `paramQuadSolve` here.

---

### `solveCoeffsSystem` (owner)

Calls `paramQuadSolve` and forwards.

```wl
solveCoeffsSystem[
  args___,
  opts : OptionsPattern[{solveCoeffsSystem, paramQuadSolve}]
] := With[
  {
    pdEq = OptionValue["PdEquations"],
    simpOpts = OptionValue["SimplifyOptions"],
    pqOpts = LongRunRisk`Options`forwardTo[opts, paramQuadSolve]  (* direct passthrough *)
  },
  ...
]
```

If you keep `paramQuadSolveOptions` as a bundle, you’d merge:

* direct passthrough + bundle defaults
  just like the guideline’s merge rule.

---

### `addCoeffsSolution` (owner or forward-only, depending on design)

Calls `RecurrenceTable`.

Recommended signature:

```wl
addCoeffsSolution[
  args___,
  opts : OptionsPattern[{addCoeffsSolution, RecurrenceTable}]
] := ...
```

* If you keep `"RecurrenceTableOptions"` as a paclet bundle option, add it to `Options[addCoeffsSolution]` and merge it with `FilterRules[..., Options[RecurrenceTable]]`.

Also: build max maturity should be an argument, not an option here, to avoid multi-ownership.

---

## 3.2 Numerical/evaluation wrappers

### `updateCoeffs` (forward-only wrapper)

Calls `updateCoeffsSol`:

```wl
updateCoeffs[
  args___,
  opts : OptionsPattern[{updateCoeffs, updateCoeffsSol, solveCoeffRoots, checks}]
] := ...
```

### `updateCoeffsSol` (owner)

Calls `solveCoeffRoots`, `checks`, `updateCoeffsBond`, etc.

```wl
updateCoeffsSol[
  args___,
  opts : OptionsPattern[{updateCoeffsSol, solveCoeffRoots, checks, fastRoot, scanAndSolve, extractIntervalsFromReduce, solveND}]
] := With[
  {
    maxMat = OptionValue["MaxMaturity"],
    updPd  = OptionValue["UpdatePd"],
    ...
  },
  (* pass maxMat as an argument to anyone else that needs it *)
]
```

This is where MaxMaturity should be consumed for evaluation, and then passed as a *value*.

---

### `solveCoeffRoots` (owner)

Consumes `"Signs"` per your decision and passes sign data explicitly to helpers:

```wl
solveCoeffRoots[
  args___,
  opts : OptionsPattern[{solveCoeffRoots, fastRoot, scanAndSolve, extractIntervalsFromReduce, solveND}]
] := With[
  {
    signsSpec = OptionValue["Signs"],
    guess     = OptionValue["initialGuess"],
    rootSigns = OptionValue["RootSigns"]
  },
  ...
]
```

No other function calls `OptionValue["Signs"]`.

---

### `solveND` (owner)

Wraps `Reduce`/interval logic, may call `findRootInterval` etc.

```wl
solveND[
  args___,
  opts : OptionsPattern[{solveND, extractIntervalsFromReduce, scanAndSolve, fastRoot}]
] := With[
  {t = OptionValue["ReduceTimeLimit"]},
  ...
]
```

---

## 3.3 Root-finding wrappers

### `fastRoot` (owner, FindRoot wrapper)

Calls `FindRoot` (and optional fallbacks).

```wl
fastRoot[
  args___,
  opts : OptionsPattern[{fastRoot, FindRoot, NMinimize, FindMinimum}]
] := With[
  {
    rootMethod = OptionValue["RootMethod"],
    frOpts = LongRunRisk`Options`mergeForwarded[opts, FindRoot, OptionValue["FindRootOptions"]]
  },
  FindRoot[(* ... *), Sequence @@ frOpts]
]
```

Crucially: this obeys the guideline precedence:

* direct user FindRoot opts win,
* then user bundle override,
* then bundle default,
* then FindRoot defaults.

---

### `scanAndSolve` (owner)

Calls `fastRoot` and forwards its options:

```wl
scanAndSolve[
  args___,
  opts : OptionsPattern[{scanAndSolve, fastRoot}]
] := With[
  {
    scanMethod = OptionValue["ScanMethod"],
    frOpts = LongRunRisk`Options`mergeForwarded[opts, fastRoot, OptionValue["FastRootOptions"]]
  },
  fastRoot[(*...*), Sequence @@ frOpts]
]
```

---

### `extractIntervalsFromReduce` (owner)

Forward-only to Reduce? (or just internal logic)

```wl
extractIntervalsFromReduce[
  args___,
  opts : OptionsPattern[{extractIntervalsFromReduce}]
] := ...
```

---

## 3.4 Moments + parallel

### `createDatabase` (owner)

Uses parallel functions; accept `ParallelMap`/`ParallelTable` options if you want:

```wl
createDatabase[
  args___,
  opts : OptionsPattern[{createDatabase, ParallelMap, ParallelTable}]
] := ...
```

### `setupParallelKernels` (owner)

```wl
setupParallelKernels[args___, opts:OptionsPattern[{setupParallelKernels}]] := ...
```

---

## 3.5 Public entry points

These are the ones users call. You can keep these very permissive.

### `BuildModels` (public)

If you keep it separate from `buildModelsInternal`, make it an alias:

```wl
BuildModels = buildModelsInternal;
```

If you prefer it as a wrapper, do:

```wl
BuildModels[args___, opts : OptionsPattern[{buildModelsInternal, (* plus whatever you want to expose *)}]] :=
  buildModelsInternal[args, opts];
```

No `Options[BuildModels]` duplication.

---

### `ToNum` (public)

It should accept the numerical owner functions:

```wl
ToNum[
  args___,
  opts : OptionsPattern[{ToNum, updateCoeffs, updateCoeffsSol, solveCoeffRoots, fastRoot, scanAndSolve, extractIntervalsFromReduce, solveND, checks}]
] := ...
```

Same idea for:

### `YieldCurve` (public)

```wl
yieldCurve[
  args___,
  opts : OptionsPattern[{yieldCurve, updateCoeffs, updateCoeffsSol, solveCoeffRoots, fastRoot, scanAndSolve, extractIntervalsFromReduce, solveND, checks}]
] := ...
```

---

# 4) Your special refactors baked into this layout

This layout **implements** your decisions mechanically:

* `SignSymbol` split:

  * `paramQuadSolve` owns `"SymbolicSignSymbol"`
  * `buildKernel` owns `"CompileSignSymbol"`

* `MaxMaturity` split by pipeline:

  * `buildModelsInternal` owns `"BuildMaxMaturity"`
  * `updateCoeffsSol` owns `"MaxMaturity"`
  * build pipeline overrides evaluation max maturity **by argument**, not by option name

* `Signs` single owner:

  * only `solveCoeffRoots` calls `OptionValue["Signs"]`
  * downstream root helpers receive `signData` as an argument

* `FromScratch`, `CreateMoments` single owner:

  * only `buildModelsInternal` consumes them
  * parallel/helpers receive booleans as arguments

---

# 5) What you should do next (mechanical refactor order)

1. **Create `Kernel/Options/Forwarding.wl`** and replace all ad-hoc `FilterRules` usage with `forwardTo`/`mergeForwarded` (pure mechanical).
2. **Move ownership**:

   * Remove `OptionValue["Signs"]` from `bindUnary`/`findRootInterval`
   * Remove `OptionValue["MaxMaturity"]` from `addCoeffsSolution`, `updateCoeffsBond`, `checkCoeffs` (pass arg)
   * Remove reads of `FromScratch` / `CreateMoments` outside `buildModelsInternal`
3. **Rename options** and update `Options[...]` on the true owner:

   * `BuildMaxMaturity`, `SymbolicSignSymbol`, `CompileSignSymbol`, `"RootMethod"` etc.
4. **Add `Kernel/Options/Validation.wl`** and turn OptionsValidation on for owners + public entry points.
5. Add a small **unit test** that asserts:

   * every option name appears in exactly one owner’s `Options[...]`
   * and OptionsValidation rejects bad values

---

If you want, I can now produce the **exact post-refactor `Options[...]` blocks** for each owner function (with your renamed options inserted), and a **checklist of the exact `OptionValue[...]` calls that must be deleted/moved** to satisfy the “single owner consumes” rule for `Signs`, `MaxMaturity`, `FromScratch`, and `CreateMoments`.
