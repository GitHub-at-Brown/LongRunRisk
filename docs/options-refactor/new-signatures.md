Below are the **concrete “new signatures”** for the functions that (per your constraints) should stop “consuming” certain values via `OptionValue[...]` and instead receive them **positionally** from the single owner (or from the orchestration layer), along with the **minimal call-site rewrites** you’ll need.

I’m using the **actual current signatures shown in your analysis docs** (e.g. `safeReduceCall`, `solveND`, `updateCoeffsBond`) and then giving the “after” versions.

---

## Kernel/Tools/FindRootOptim.wl

### 1) `bindUnary` — remove `"Signs"` option; take `signs` positionally

**Before (current pattern):**

```wl
Options[bindUnary] = {
  "Signs" -> {}
};

bindUnary[savedKernel_Association, paramsAll_Association, opts : OptionsPattern[{bindUnary}]] := ...
```

**After (new signature):**

```wl
bindUnary[
  savedKernel_Association,
  paramsAll_Association,
  signs : ({} | {_Integer ..}) : {}
] := ...
```

**Call-site update (in `solveCoeffRoots`):**

```diff
- bindUnary[savedKernel, paramsAll, "Signs" -> signs]
+ bindUnary[savedKernel, paramsAll, signs]
```

This makes `solveCoeffRoots` the **single owner of `"Signs"`** (it can still *accept* `"Signs"` as an option—see below—but downstream helpers won’t).

---

### 2) `findRootInterval` — remove `"CoeffName"`, `"SignSymbol"`, `"Signs"` options; take them positionally

**Before (current signature from docs):**

```wl
Options[findRootInterval] = {
  "CoeffName"  -> "A",
  "SignSymbol" -> "signA",
  "Signs"      -> {}
};

findRootInterval[
  conds_,
  paramValues_Association,
  opts : OptionsPattern[{findRootInterval}]
] := ...
```

**After (new signature):**

```wl
findRootInterval[
  conds_,
  paramValues_Association,
  coeffName_String,
  signSymbol_String,
  signs : ({} | {_Integer ..}) : {}
] := ...
```

**Call-site updates:**

In the 1D path inside `solveCoeffRoots`:

```diff
- findRootInterval[conds, paramsAll,
-   "Signs" -> signs, "CoeffName" -> cName, "SignSymbol" -> sName,
-   Sequence @@ findOpts
- ]
+ findRootInterval[conds, paramsAll, cName, sName, signs]
```

In `safeReduceCall` (see below), same idea.

> Net effect: `"CoeffName"` and compile-stage `"SignSymbol"` are now **pure kernel metadata** (ultimately owned by `buildKernel`), not option-consumed in the numeric layer.

---

## Kernel/ComputationalEngine/SolveEulerEq.wl

### 3) `safeReduceCall` — drop `findOpts` and stop passing “Signs/CoeffName/SignSymbol” as options

Your docs give the *exact current* implementation signature:

**Before (from your ReduceTimeLimit analysis):**

```wl
safeReduceCall[conds_, paramsAll_, signs_, cName_, sName_, findOpts_, timeout_] :=
  TimeConstrained[
    findRootInterval[conds, paramsAll,
      "Signs" -> signs, "CoeffName" -> cName,
      "SignSymbol" -> sName, Sequence @@ findOpts
    ],
    timeout,
    $Failed
  ];
```

**After (new signature):**

```wl
safeReduceCall[
  conds_,
  paramsAll_Association,
  signs : ({} | {_Integer ..}) : {},
  cName_String,
  sName_String,
  timeout_?NumericQ
] :=
  TimeConstrained[
    findRootInterval[conds, paramsAll, cName, sName, signs],
    timeout,
    $Failed
  ];
```

**Call-site update:** `solveND` (next section) no longer threads `findOpts` into this.

---

### 4) `solveND` — remove the now-dead `findOpts_` positional argument

**Before (current signature from your docs):**

```wl
solveND[
  f_, df_, conds_, paramsAll_, signs_, coefList_, cName_, sName_,
  findOpts_, extractOpts_, scanOpts_, solTemplate_,
  opts : OptionsPattern[{solveND}]
] := ...
```

**After (new signature):**

```wl
solveND[
  f_, df_, conds_, paramsAll_, signs_, coefList_, cName_String, sName_String,
  extractOpts_, scanOpts_, solTemplate_,
  opts : OptionsPattern[{solveND}]
] := ...
```

**Internal change inside `solveND`:**
Where you currently do:

```wl
reduceExpr = safeReduceCall[conds, paramsAll, signs, cName, sName, findOpts, OptionValue["ReduceTimeLimit"]];
```

Change to:

```wl
reduceExpr = safeReduceCall[conds, paramsAll, signs, cName, sName, OptionValue["ReduceTimeLimit"]];
```

**Call-site update (in `solveCoeffRoots` nD branch):**

```diff
- solveND[f, df, conds, paramsAll, signs, coefList, cName, sName,
-         findOpts, extractOpts, scanOpts, quadSol["Solution"],
-         Sequence @@ solveNDOpts]
+ solveND[f, df, conds, paramsAll, signs, coefList, cName, sName,
+         extractOpts, scanOpts, quadSol["Solution"],
+         Sequence @@ solveNDOpts]
```

Where `solveNDOpts = FilterRules[{opts}, Options[solveND]]`.

---

### 5) `solveCoeffRoots` — make it the `"Signs"` owner (and stop inheriting findRootInterval/bindUnary options)

**Before (current signature from docs):**

```wl
solveCoeffRoots[
  quadSol_Association, savedKernel_Association, paramsBase_Association,
  signs : ({} | {_Integer ..}) : {},
  extraParams_Association : <||>,
  opts : OptionsPattern[{solveCoeffRoots, findRootInterval, extractIntervalsFromReduce, scanAndSolve, fastRoot, FindRoot}]
] := ...
```

**After (new signature + new Options):**

```wl
Options[solveCoeffRoots] = {
  "Signs" -> {}   (* now the single owner of Signs *)
};

solveCoeffRoots[
  quadSol_Association,
  savedKernel_Association,
  paramsBase_Association,
  extraParams_Association : <||>,
  opts : OptionsPattern[{solveCoeffRoots, extractIntervalsFromReduce, scanAndSolve, fastRoot, FindRoot, solveND}]
] := ...
```

**Key internal rewrite:**

```wl
signs = OptionValue["Signs"];
cName = Lookup[savedKernel, "CoeffName"];
sName = Lookup[savedKernel, "SignSymbol"];
```

Then:

* `bindUnary[savedKernel, paramsAll, signs]`
* `findRootInterval[conds, paramsAll, cName, sName, signs]`
* for nD: `solveND[..., signs, ..., Sequence@@FilterRules[{opts}, Options[solveND]]]`

**Call-site update:** everywhere you used to call:

```wl
solveCoeffRoots[..., signsTuple, extraParams, opts...]
```

now call:

```wl
solveCoeffRoots[..., extraParams, "Signs" -> signsTuple, opts...]
```

This is the cleanest way to let `updateCoeffsSol` iterate RootSigns combinations without having a second positional parameter that competes with the `"Signs"` option.

---

### 6) `updateCoeffsBond` — change `maxMaturity_` to a *maturity grid/list* (so only `updateCoeffsSol` “owns” MaxMaturity)

Your docs show:

**Before (current):**

```wl
updateCoeffsBond[
  modelCoeffsSolution_, modelParameters_, newParameters_, maxMaturity_, coeffsWc_,
  opts : OptionsPattern[{RecurrenceTable}]
] := ...
```

**After (new signature):**

```wl
updateCoeffsBond[
  modelCoeffsSolution_,
  modelParameters_,
  newParameters_,
  maturities : {__Integer},   (* e.g. Range[maxMaturity] produced upstream *)
  coeffsWc_,
  opts : OptionsPattern[{RecurrenceTable}]
] := ...
```

**Call-site update (inside `updateCoeffsSol`):**
Instead of

```wl
maxMaturity = OptionValue["MaxMaturity"];
updateCoeffsBond[..., maxMaturity, coeffsWc, Sequence @@ recurrenceOpts]
```

do

```wl
maxMaturity = OptionValue["MaxMaturity"];
maturities  = Range[maxMaturity];
updateCoeffsBond[..., maturities, coeffsWc, Sequence @@ recurrenceOpts]
```

---

### 7) `checkCoeffs` — same idea: accept maturities list instead of `maxMaturity`

Your Checks analysis shows `checkCoeffs` currently receives `maxMaturity` positionally.

**Before (as called today):**

```wl
checkCoeffs[type, model, sol, params, newParams, maxMaturity, numStocks, checkOpts]
```

**After (new signature):**

```wl
checkCoeffs[
  type_,
  model_,
  sol_,
  params_,
  newParams_,
  maturities : {__Integer},
  numStocks_Integer,
  opts : OptionsPattern[{checks}]
] := ...
```

**Call-site update (inside `updateCoeffsSol`):**

```wl
maxMaturity = OptionValue["MaxMaturity"];
maturities  = Range[maxMaturity];

checkCoeffs[type, model, sol, params, newParams, maturities, numStocks, Sequence @@ checkOpts]
```

…and inside `checkCoeffs`, wherever you had:

```wl
Table[..., {n, 1, maxMaturity}]
```

you now do:

```wl
Table[..., {n, maturities}]
```

---

## Kernel/Model/ProcessModels.wl

### 8) `addCoeffsSolution` — remove `"MaxMaturity"` option; receive `buildMaxMaturity` positionally

**Before (from your docs):**

```wl
Options[addCoeffsSolution] = {
  "MaxMaturity" -> 12,
  "initialGuess" -> <||>,
  "RootSigns" -> Automatic,
  "FindRootOptions" -> {},
  "RecurrenceTableOptions" -> {},
  "DependentVariables" -> Automatic
};

addCoeffsSolution[
  model_,
  ratio : "bond" | "nombond",
  opts : OptionsPattern[{addCoeffsSolution, updateCoeffs, RecurrenceTable}]
] := ...
```

**After (new signature + Options remove MaxMaturity):**

```wl
Options[addCoeffsSolution] = {
  "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
  "RootSigns" -> Automatic,
  "FindRootOptions" -> {},
  "RecurrenceTableOptions" -> {},
  "DependentVariables" -> Automatic
};

addCoeffsSolution[
  model_,
  ratio : ("bond" | "nombond"),
  buildMaxMaturity_Integer,
  opts : OptionsPattern[{addCoeffsSolution, updateCoeffs, RecurrenceTable}]
] := ...
```

Now *internally* you use `buildMaxMaturity` instead of `OptionValue["MaxMaturity"]`.

---

### 9) `processModels` — thread `buildMaxMaturity` down positionally

**Before (current signature from docs):**

```wl
processModels[
  modelsCatalog_Association,
  opts : OptionsPattern[{solveCoeffsSystem, updateCoeffs, getStartingValues, FindRoot, RecurrenceTable}]
] := ...
```

**After (new signature):**

```wl
processModels[
  modelsCatalog_Association,
  buildMaxMaturity_Integer,
  opts : OptionsPattern[{solveCoeffsSystem, updateCoeffs, getStartingValues, FindRoot, RecurrenceTable}]
] := ...
```

And where it currently does:

```wl
addCoeffsSolution[model, ratio, Sequence @@ addCoeffOpts]
```

it becomes:

```wl
addCoeffsSolution[model, ratio, buildMaxMaturity, Sequence @@ addCoeffOpts]
```

---

## Kernel/Tools/NicePlots.wl

### 10) `yieldCurve` — stop owning `"MaxMaturity"` (no signature change required, but remove that option)

**Before:**

* `Options[yieldCurve]` includes `"MaxMaturity" -> 12`
* It calls `maxMaturity = OptionValue[yieldCurve, "MaxMaturity"]`

**After:**

* Remove `"MaxMaturity"` from `Options[yieldCurve]`
* Do **not** call `OptionValue[..., "MaxMaturity"]`

Let `"MaxMaturity"` be accepted *only* via `updateCoeffs/updateCoeffsSol` and infer maturities from the returned solution (or just use `Range @ Length[...]` on bond coeff arrays).

Signature can remain:

```wl
Options[yieldCurve] = {
  "MomentFunction" -> uncondE
};

yieldCurve[
  args___,
  opts : OptionsPattern[{yieldCurve, updateCoeffs, FindRoot, RecurrenceTable}]
] := ...
```

---

## Kernel/Tools/ManageResources.wl

### 11) `buildModelsParallel` — if you keep it, make it a pure helper taking booleans positionally

Right now it **consumes** `"FromScratch"`/`"CreateMoments"` via `OptionValue`. To make `buildModels` the single owner, `buildModelsParallel` should **not read options at all**.

A clean “after” signature is:

```wl
buildModelsParallel[
  models_List,
  numKernels_,                  (* already resolved by caller *)
  fromScratch_?BooleanQ,         (* resolved by caller *)
  createMoments_?BooleanQ,        (* resolved by caller *)
  buildOneModelFn_               (* pure function: modelKey |-> result *)
] := ...
```

Then `buildModels` (owner) does the `OptionValue[...]` work and passes **resolved values** in.

If you want it to still forward extra build options to `buildOneModelFn`, keep them in a captured closure, not as OptionsPattern.

---

## Quick “diff summary” of the functions that actually change signature

### FindRootOptim.wl

* `bindUnary[kernel, params, opts...]` → `bindUnary[kernel, params, signs]`
* `findRootInterval[conds, params, opts...]` → `findRootInterval[conds, params, cName, sName, signs]`

### SolveEulerEq.wl

* `safeReduceCall[..., findOpts, timeout]` → `safeReduceCall[..., timeout]`
* `solveND[..., findOpts, extractOpts, scanOpts, ...]` → `solveND[..., extractOpts, scanOpts, ...]`
* `solveCoeffRoots[..., signs, extraParams, opts...]` → `solveCoeffRoots[..., extraParams, "Signs"->signs, opts...]`
* `updateCoeffsBond[..., maxMaturity, ...]` → `updateCoeffsBond[..., maturities_List, ...]`
* `checkCoeffs[..., maxMaturity, ...]` → `checkCoeffs[..., maturities_List, ...]`

### ProcessModels.wl

* `processModels[catalog, opts...]` → `processModels[catalog, buildMaxMaturity, opts...]`
* `addCoeffsSolution[model, ratio, opts...]` → `addCoeffsSolution[model, ratio, buildMaxMaturity, opts...]`

---

