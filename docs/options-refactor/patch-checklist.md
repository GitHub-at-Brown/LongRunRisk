Here’s the **mechanical, call‑graph–oriented patch checklist** you can apply file‑by‑file. I’m using the **exact function/line anchors from your analysis** (the `options-forward/*.md` + `options-backward/*.md` docs), and each item is written as:

* **Where** (file + line range from your docs)
* **What to change**
* **Old → New** call form (or search pattern → replacement)

I’m assuming your refactor goal is exactly what we agreed earlier:

* **No legacy / no OptionsConfig normalization**
* **Wrappers forward, owners consume**
* **Split SignSymbol**, **split MaxMaturity**, **Signs owned upstream**, etc.

---

# 0) One small helper (optional but makes edits painless)

Add somewhere central (or per file) a helper:

```wl
forwardTo[opts_, f_Symbol] := FilterRules[Flatten @ {opts}, Options[f]];
```

Then everywhere you currently do `FilterRules[Flatten@{opts}, Options[f]]` becomes `forwardTo[opts, f]`.

---

# 1) FindRootOptim.wl patches

## 1.1 `bindUnary`: stop consuming `"Signs"` as an option

**Where:** `Kernel/Tools/FindRootOptim.wl` lines **363–424**

### Change definition

**Search:** a definition like

```wl
Options[bindUnary] = {"Signs" -> {}};
bindUnary[ savedKernel_, paramsAll_, opts:OptionsPattern[{bindUnary}] ] := ...
```

**Replace with:**

```wl
bindUnary[savedKernel_Association, paramsAll_Association, signs : ({} | {_Integer ..}) : {}] := ...
```

### Change internals

**Search:** `signs = OptionValue["Signs"]`

**Replace with:** use the positional `signs`.

---

## 1.2 `findRootInterval`: remove `"CoeffName"`, `"SignSymbol"`, `"Signs"` options

**Where:** `Kernel/Tools/FindRootOptim.wl` lines **430–510**

### Change definition

**Search:** a definition like

```wl
Options[findRootInterval] = {"CoeffName"->"A","SignSymbol"->"signA","Signs"->{}};
findRootInterval[conds_, paramValues_Association, opts:OptionsPattern[{findRootInterval}]] := ...
```

**Replace with:**

```wl
findRootInterval[
  conds_,
  paramValues_Association,
  coeffName_String,
  signSymbol_String,
  signs : ({} | {_Integer ..}) : {}
] := ...
```

### Change internals

**Search & delete:**

* `coeffName = OptionValue["CoeffName"]`
* `signSym   = OptionValue["SignSymbol"]`
* `signs     = OptionValue["Signs"]`

Use the positional args:

* `coeffName`
* `signSymbol` (string; still do `ToExpression[signSymbol]` internally)
* `signs`

---

## 1.3 Split compile SignSymbol option name at the owner: `buildKernel`

**Where:** `Kernel/Tools/FindRootOptim.wl` lines **83–356**

### Change option name

* **Old compile option:** `"SignSymbol" -> "signA"`
* **New compile option:** `"CompileSignSymbol" -> "signA"`

**Search:**

```wl
"SignSymbol" -> "signA"
signSym = OptionValue["SignSymbol"]
```

**Replace with:**

```wl
"CompileSignSymbol" -> "signA"
signSym = OptionValue["CompileSignSymbol"]
```

### Keep the *returned kernel metadata key* stable (recommended)

Keep storing **metadata** as `"SignSymbol" -> signSym` in the returned Association, because it’s not an option name—just a field used downstream.

---

# 2) SolveEulerEq.wl patches (this is where most call sites change)

## 2.1 `safeReduceCall`: drop `findOpts` and stop calling `findRootInterval` with options

**Where:** `Kernel/ComputationalEngine/SolveEulerEq.wl` lines **85–91**

### Old → New

**Search (you have this exact shape in the docs):**

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

**Replace with:**

```wl
safeReduceCall[conds_, paramsAll_Association, signs_, cName_String, sName_String, timeout_?NumericQ] :=
  TimeConstrained[
    findRootInterval[conds, paramsAll, cName, sName, signs],
    timeout,
    $Failed
  ];
```

---

## 2.2 `solveND`: remove `findOpts_` parameter and update `safeReduceCall` call

**Where:** `Kernel/ComputationalEngine/SolveEulerEq.wl` lines **212–261**

### Signature change

**Search:**

```wl
solveND[..., cName_, sName_, findOpts_, extractOpts_, scanOpts_, solTemplate_, opts:OptionsPattern[{solveND}]] := ...
```

**Replace with:**

```wl
solveND[..., cName_String, sName_String, extractOpts_, scanOpts_, solTemplate_, opts:OptionsPattern[{solveND}]] := ...
```

### Call inside `solveND`

**Search:**

```wl
reduceExpr = safeReduceCall[conds, paramsAll, signs, cName, sName, findOpts, OptionValue["ReduceTimeLimit"]];
```

**Replace with:**

```wl
reduceExpr = safeReduceCall[conds, paramsAll, signs, cName, sName, OptionValue["ReduceTimeLimit"]];
```

---

## 2.3 `solveCoeffRoots`: stop inheriting `findRootInterval` options and stop passing them

**Where:** `Kernel/ComputationalEngine/SolveEulerEq.wl` lines **803–904**

### Change signature & option inheritance

**Search:**

```wl
solveCoeffRoots[quadSol_, savedKernel_, paramsBase_, signs_:{}, extraParams_:<||>,
  opts:OptionsPattern[{solveCoeffRoots, findRootInterval, extractIntervalsFromReduce, scanAndSolve, fastRoot, FindRoot}]] := ...
```

**Replace with:**

```wl
Options[solveCoeffRoots] = {"Signs" -> {}};

solveCoeffRoots[quadSol_, savedKernel_, paramsBase_, extraParams_:<||>,
  opts:OptionsPattern[{solveCoeffRoots, extractIntervalsFromReduce, scanAndSolve, fastRoot, FindRoot, solveND}]] := ...
```

### Internal extraction

Add near the top:

```wl
signs = OptionValue["Signs"];
cName = Lookup[savedKernel, "CoeffName"];
sName = Lookup[savedKernel, "SignSymbol"];  (* still the kernel metadata key *)
```

### Update 1D path call sites

**Search (per docs, line ~840 / ~862):**

```wl
bindUnary[savedKernel, paramsAll, "Signs" -> signs]
```

**Replace with:**

```wl
bindUnary[savedKernel, paramsAll, signs]
```

**Search:**

```wl
findRootInterval[conds, paramsAll,
  "Signs" -> signs, "CoeffName" -> cName, "SignSymbol" -> sName,
  Sequence @@ findOpts
]
```

**Replace with:**

```wl
findRootInterval[conds, paramsAll, cName, sName, signs]
```

### Update nD path call into `solveND`

**Search:**

```wl
solveND[f, df, conds, paramsAll, signs, coefList, cName, sName,
        findOpts, extractOpts, scanOpts, quadSol["Solution"],
        Sequence @@ solveNDOpts]
```

**Replace with:**

```wl
solveND[f, df, conds, paramsAll, signs, coefList, cName, sName,
        extractOpts, scanOpts, quadSol["Solution"],
        Sequence @@ solveNDOpts]
```

> Note: you’ll also remove creation of `findOpts = FilterRules[..., Options[findRootInterval]]` inside `solveCoeffRoots` entirely.

---

## 2.4 `solveWcPdRoots`: update its calls into `solveCoeffRoots`

**Where:** `Kernel/ComputationalEngine/SolveEulerEq.wl` (described under `solveWcPdRoots` in `engine-moments-solveeuler.md`)

**Search:** calls like

```wl
solveCoeffRoots[quadSolWc, savedKernelWc, paramsBase, signsWc, extraParams, Sequence @@ optSeq]
```

**Replace with:**

```wl
solveCoeffRoots[quadSolWc, savedKernelWc, paramsBase, extraParams,
  "Signs" -> signsWc, Sequence @@ optSeq
]
```

And similarly for Pd.

---

# 3) MaxMaturity split patches (BuildMaxMaturity vs evaluation MaxMaturity)

## 3.1 Fix the build pipeline: stop binding Build MaxMaturity and not using it

**Where:** `Kernel/Tools/ManageResources.wl` line **835**

You currently have:

* `maxMaturity = config["Build"]["MaxMaturity"]` (bound, unused)
* and downstream numerical hardcodes 12

### Replace the “build maturity” option name

* **Old:** `"MaxMaturity"` in build subsystem
* **New:** `"BuildMaxMaturity"` owned by `buildModelsInternal`

So in `buildModelsInternal`, you should extract:

```wl
buildMaxMaturity = OptionValue["BuildMaxMaturity"];
```

…and then pass it **positionally** to the build-time coefficient generation functions (`processModels` → `addCoeffsSolution`).

---

## 3.2 `addCoeffsSolutionN`: delete the hard-coded `"MaxMaturity"->12` and thread buildMaxMaturity

**Where:** `Kernel/ComputationalEngine/SolveEulerEq.wl` lines **1036–1046**

**Search (exact snippet from docs):**

```wl
addCoeffsSolutionN[model_] := Module[{k},
  k = loadModelKernels[model["shortname"]];
  updateCoeffs[
    model, k,
    "UpdatePd"->True,
    "UpdateBonds"->True,
    "MaxMaturity"->12,
    "RootSigns" -> All
  ]
]
```

### Replace with either (pick one)

**Option A (recommended): remove `addCoeffsSolutionN` entirely**
Inline the call in the orchestrator and pass `MaxMaturity` only where evaluation happens.

**Option B: keep it but make it explicit**

```wl
addCoeffsSolutionN[model_, buildMaxMaturity_Integer, opts:OptionsPattern[{updateCoeffs}]] := Module[{k},
  k = loadModelKernels[model["shortname"]];
  updateCoeffs[
    model, k,
    "UpdatePd" -> True,
    "UpdateBonds" -> True,
    (* NOTE: this is *evaluation* MaxMaturity, owned by updateCoeffsSol *)
    "MaxMaturity" -> buildMaxMaturity,
    "RootSigns" -> All,
    Sequence @@ forwardTo[opts, updateCoeffs]
  ]
]
```

This keeps **ownership of `"MaxMaturity"`** in `updateCoeffsSol` but allows the build phase to supply a value via an argument.

---

## 3.3 ProcessModels: thread `buildMaxMaturity` into `addCoeffsSolution` (no `"MaxMaturity"` option there)

**Where:** `Kernel/Model/ProcessModels.wl` `addCoeffsSolution` options at **904–911** and uses at **1047–1062**

### Change signature

**Search:**

```wl
addCoeffsSolution[model_, ratio:("bond"|"nombond"), opts:OptionsPattern[{addCoeffsSolution, updateCoeffs, RecurrenceTable}]] := ...
```

**Replace with:**

```wl
addCoeffsSolution[model_, ratio:("bond"|"nombond"), buildMaxMaturity_Integer,
  opts:OptionsPattern[{addCoeffsSolution, updateCoeffs, RecurrenceTable}]] := ...
```

### Remove owned `"MaxMaturity"` from Options[addCoeffsSolution]

Delete `"MaxMaturity" -> 12` from that options list.

### Replace internal uses

Everywhere `OptionValue["MaxMaturity"]` inside `addCoeffsSolution` becomes the positional `buildMaxMaturity`.

---

## 3.4 NicePlots `yieldCurve`: remove `"MaxMaturity"` option and stop consuming it

**Where:** `Kernel/Tools/NicePlots.wl` lines **46–105**, especially line **61** `OptionValue[yieldCurve,"MaxMaturity"]`

### Remove option and reads

**Search:**

```wl
Options[yieldCurve] = {"MaxMaturity"->12, "MomentFunction"->uncondE};
maxMaturity = OptionValue[yieldCurve, "MaxMaturity"];
```

**Replace with:**

```wl
Options[yieldCurve] = {"MomentFunction" -> uncondE};
```

### Replace Table iteration

Replace loops like:

```wl
Table[..., {mm, maxMaturity}]
```

with something derived from returned bond coeffs, e.g.:

```wl
mmMax = Length[bondCoeffs]; (* or Max@Keys[...] depending on your structure *)
Table[..., {mm, mmMax}]
```

Crucially: **do not** call `OptionValue["MaxMaturity"]` in `yieldCurve`.

---

# 4) Signs ownership patches (make `solveCoeffRoots` the only option entry)

This is already covered by the `solveCoeffRoots` changes above, but here are the remaining “search & destroy” items:

## 4.1 Remove any `OptionValue["Signs"]` outside `solveCoeffRoots`

**Search across project:** `OptionValue["Signs"]`

Expected remaining hits:

* only inside `solveCoeffRoots` (now the owner)

Everything else must be positional `signs` arg.

---

# 5) FromScratch & CreateMoments: remove extra consumers in `buildModelsParallel`

## 5.1 buildModelsParallel should not call `OptionValue["FromScratch"]` or `OptionValue["CreateMoments"]`

**Where:** `Kernel/Tools/ManageResources.wl` lines:

* FromScratch: **1155**, **1169–1172**, **1197**
* CreateMoments: **1154**, **1195**, **1261–1272**

### Change signature (recommended)

Make it positional:

```wl
buildModelsParallel[models_List, numKernels_, fromScratch_?BooleanQ, createMoments_?BooleanQ, (* plus whatever else *)] := ...
```

### Replace OptionValue reads

**Search:**

```wl
fromScratch = OptionValue["FromScratch"];
createMoments = OptionValue["CreateMoments"];
```

**Replace:** use the positional args.

### Update callers

Wherever `buildModelsInternal` calls `buildModelsParallel`, pass:

* `fromScratch`
* `createMoments`

…and delete the “force False” rules you used to inject into recursive `buildModels[...]` calls.

---

# 6) Symbolic SignSymbol split: `paramQuadSolve` stops using `"SignSymbol"` and uses `"SymbolicSignSymbol"`

## 6.1 ParamQuadSolve option rename

**Where:** `Kernel/ComputationalEngine/ParamQuadSolve.wl` (see `engine-conditional-quadsolve.md`)

### In `paramQuadSolve`

**Search in Options:**

```wl
"SignSymbol" -> signA
```

**Replace with:**

```wl
"SymbolicSignSymbol" -> signA
```

**Search in body:**

```wl
signHead = OptionValue["SignSymbol"];
```

**Replace with:**

```wl
signHead = OptionValue["SymbolicSignSymbol"];
```

---

## 6.2 Update the call site in ProcessModels `solveCoeffsSystem`

**Where:** `Kernel/Model/ProcessModels.wl` (call shown in `model-catalog-processmodels.md`)

**Search (exact shape from docs):**

```wl
paramQuadSolve[sysA, varsA,
  "SignSymbol" -> Symbol["sign"<>SymbolName[coefwc]],
  Assumptions -> assumeA,
  Sequence @@ paramQuadSolveOpts
]
```

**Replace with:**

```wl
paramQuadSolve[sysA, varsA,
  Assumptions -> assumeA,
  Sequence @@ forwardTo[opts, paramQuadSolve],
  "SymbolicSignSymbol" -> Symbol["sign" <> SymbolName[coefwc]]
]
```

That ordering makes user‑passed `"SymbolicSignSymbol"` win (because it comes earlier via `forwardTo`).

---

# 7) Final “call graph patch” summary (quick search checklist)

Run these searches and ensure each is handled exactly once / in the right place:

### Must become **zero occurrences**

* `OptionValue["SignSymbol"]`  (because you split it)
* `OptionValue[yieldCurve, "MaxMaturity"]`
* `Options[findRootInterval] = ...`
* `Options[bindUnary] = ...`

### Must exist only in owners

* `OptionValue["Signs"]` → **only in** `solveCoeffRoots`
* `OptionValue["MaxMaturity"]` → **only in** `updateCoeffsSol` (evaluation)
* `OptionValue["BuildMaxMaturity"]` → **only in** `buildModelsInternal` (build orchestration)
* `OptionValue["CompileSignSymbol"]` → **only in** `buildKernel`
* `OptionValue["SymbolicSignSymbol"]` → **only in** `paramQuadSolve`

---

If you want, I can give you an **even more mechanical “diff script” style checklist** (like: “in SolveEulerEq.wl line 862 replace the `findRootInterval[...]` call with …”) for each of the line anchors you have (803–904, 212–261, 85–91, etc.). The above is already aligned with those anchors, but I can rewrite it as a pure “replace this exact expression” list if that’s how you want to execute the refactor.
