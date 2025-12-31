# LongRunRisk options refactor – implementation plan

**Objective:** Refactor the LongRunRisk paclet’s option plumbing so it follows Wolfram option conventions (single source of truth, unambiguous ownership, predictable precedence, and pass‑through forwarding) and **eliminates** the legacy `OptionsConfig` / config‑association system.

This document is deliberately **implementation‑ready**: it lists every file to touch and includes copy‑pasteable Wolfram Language code blocks (not pseudocode).

---

## How to execute this plan

1. Create a branch.
   ```bash
   git checkout -b refactor/options-ownership
   ```

2. Run the full test suite **before any changes**.
   ```bash
   wolframscript Tests/RunTests.wls --all
   ```
   Record failures (if any) and the exact commit hash. If failure, halt 
   plan execution and report details of failure to user.

3. Implement phases **in order**. At the end of each phase:
   - Run the same test command.
   - Fix any failures introduced by that phase.
   - Commit with a message like `phase N: <short description>`.

4. After Phase 6, generate a final diff for review:
   ```bash
   git diff main...HEAD
   ```

---

## Definitions

### Option owner

For this refactor, the **option owner** is the symbol whose `Options[owner]` contains the default value for the option **and** whose implementation ultimately consumes it to affect behavior.

### Single source of truth

For any custom option (string‑keyed or otherwise), its default value must live in exactly one place: `Options[owner]`.

### Pass‑through forwarding

A wrapper should forward options to its callees via:

- `FilterRules[opts, Options[callee]]` for each callee
- `Sequence @@ ...` to pass them

and **must not** copy callee defaults into its own `Options[...]`.

### Precedence (built‑in compatible)

- Explicit options passed by the caller override defaults.
- If the same option appears multiple times in an option sequence, the **last** one wins.

---

## Current state summary

### 1) `OptionsConfig` duplicates defaults and hides ownership

The current build pipeline (`buildModels`) normalizes caller options into a configuration association via:

- `defaultConfig[]`
- `normalizeConfig[config, opts]`
- `splitConfig[config]`

This creates multiple “sources of truth” for defaults, because many defaults exist both in:

- `Options[publicFunction]` (e.g., `buildModels // Options`)
- `defaultConfig[]` (in `Tools/OptionsConfig.wl`)

Example mismatches (pre‑refactor):

- `buildModels // Options` says `"CompileJacobians" -> False` but `OptionsConfig` sets `"CompileJacobians" -> True`.
- `buildKernel // Options` says `"PerformanceGoal" -> "Speed"` but `OptionsConfig` sets `"PerformanceGoal" -> "Quality"`.
- `buildKernel // Options` says `"CompileMode" -> "FunctionOnly"` but `OptionsConfig` sets `"CompileMode" -> "Both"`.

### 2) `SignSymbol` is overloaded (symbolic vs compile)

`"SignSymbol"` currently means:

- A **Symbol head** for symbolic sign variables in `paramQuadSolve`.
- A **String name** for compiled sign variables in `buildKernel`.

This ambiguity leaks across the pipeline and is a direct cause of “multi‑owner” behavior.

### 3) `Signs` has multiple partial “owners”

The list of sign values used during numerical root finding is:

- passed positionally into `solveCoeffRoots`, **and**
- also an option of lower helpers (`bindUnary`, `findRootInterval`).

This produces overlapping “ownership” and makes it unclear where the default should live.

### 4) `MaxMaturity` is used for both build and evaluation

- Build pipeline sets a maturity limit for *precomputing* numerical coefficients.
- Evaluation (`yieldCurve`, `updateCoeffsSol`) also needs a maturity limit.

Using one option name for both makes it easy to accidentally drive the wrong stage.

---

## Target state summary

### A) Remove `OptionsConfig`

- Delete `Kernel/Tools/OptionsConfig.wl`.
- Remove all uses of `normalizeConfig` / `splitConfig`.
- Resolve options via `OptionValue` from the true owner’s `Options[...]`.

### B) Split `SignSymbol`

- **Symbolic stage** option: `"SymbolicSignSymbol"` (owned by `paramQuadSolve`).
- **Compile stage** option: `"CompileSignSymbol"` (owned by `buildKernel`).

After refactor, *no public function* should mention `"SignSymbol"` as an option.

### C) Make `"Signs"` owned by `solveCoeffRoots`

- `solveCoeffRoots` becomes the only option owner for `"Signs"`.
- Lower helpers (`bindUnary`, `findRootInterval`) take an explicit `signs_List` argument.

### D) Split `MaxMaturity`

- Build stage option: `"BuildMaxMaturity"` (owned by `buildModels`).
- Evaluation option: `"MaxMaturity"` remains owned by `updateCoeffsSol`.

### E) OptionsValidation

- Add a dedicated rules file that uses `OptionsValidation` **without** `ErrorTools`.
- Install validations at paclet load (guarded so missing dependency doesn’t hard‑fail).

---

## Call graph and option flow

### Build pipeline (`buildModels`)

```text
buildModels
  └─ buildModelsInternal
       ├─ determineModelStatus
       │    └─ validateCompiledFile
       │         └─ buildEqMapFromModel
       ├─ processModels                (symbolic)
       │    └─ solveCoeffsSystem
       │         └─ paramQuadSolve
       ├─ createCompiledEq             (compile)
       │    └─ buildKernel
       ├─ addCoeffsSolutionN           (numerical precompute)
       │    └─ updateCoeffs
       │         └─ updateCoeffsSol
       │              └─ solveCoeffRoots
       │                   └─ solveND
       │                        └─ findRootInterval
       └─ createDatabase               (moments)
```

### Evaluation pipeline (`yieldCurve`)

```text
yieldCurve
  └─ updateCoeffsBond
       └─ updateCoeffs
            └─ updateCoeffsSol
                 └─ solveCoeffRoots (owns "Signs")
                      └─ findRootInterval (takes signs argument)
```

---

## Option ownership table

### Key changes (pre → post)

| Concept | Pre‑refactor | Post‑refactor |
|---|---|---|
| Symbolic sign head | `"SignSymbol"` (ambiguous) | `paramQuadSolve` owns `"SymbolicSignSymbol"` |
| Compile sign name | `"SignSymbol"` (ambiguous) | `buildKernel` owns `"CompileSignSymbol"` |
| Root‑finding sign values | positional + helper options | `solveCoeffRoots` owns `"Signs"` only |
| Build maturity limit | `"MaxMaturity"` (shared) | `buildModels` owns `"BuildMaxMaturity"` |
| Evaluation maturity limit | `"MaxMaturity"` (shared) | `updateCoeffsSol` continues to own `"MaxMaturity"` |
| PD equation selection | duplicated in buildModels/buildModelsParallel | `solveCoeffsSystem` owns `"PdEquations"` |

### Post‑refactor ownership for touched custom options

| Option | Owner symbol | Notes |
|---|---|---|
| `"FromScratch"` | `buildModels` | build pipeline only |
| `"CompileJacobians"` | `buildModels` | build pipeline only |
| `"CreateMoments"` | `buildModels` | build pipeline only |
| `"NumKernels"` | `buildModels` | passed to `setupParallelKernels` |
| `"BuildMaxMaturity"` | `buildModels` | forwarded into `addCoeffsSolutionN` (positional) |
| `"PdEquations"` | `solveCoeffsSystem` | **removed** from `buildModels` options |
| `"SymbolicSignSymbol"` | `paramQuadSolve` | replaces symbolic meaning of `SignSymbol` |
| `"CompileSignSymbol"` | `buildKernel` | replaces compile meaning of `SignSymbol` |
| `"Signs"` | `solveCoeffRoots` | passed positionally to `bindUnary`/`findRootInterval` |


---

## Phase plan

### Phase 0 — Baseline

1. Run tests:
   ```bash
   wolframscript Tests/RunTests.wls --all
   ```
2. Save the output.
3. Commit nothing.

---

### Phase 1 — Split `SignSymbol`

#### 1.1 `Kernel/ComputationalEngine/ParamQuadSolve.wl`

**Change:** rename the option key.

Find:
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
    "SignSymbol" -> signA,
    "GroebnerMemoryFraction" -> 0.5,  (* fraction of MemoryAvailable[] to use *)
    "GroebnerMemoryFloor" -> 1*1024^3,  (* minimum memory limit in bytes *)
    "GroebnerMemoryCap" -> 16*1024^3,  (* maximum memory limit in bytes *)
    "Verbose" -> False  (* whether to print memory usage during solving *)
};
```
Replace with:
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
    "SymbolicSignSymbol" -> signA,
    "GroebnerMemoryFraction" -> 0.5,  (* fraction of MemoryAvailable[] to use *)
    "GroebnerMemoryFloor" -> 1*1024^3,  (* minimum memory limit in bytes *)
    "GroebnerMemoryCap" -> 16*1024^3,  (* maximum memory limit in bytes *)
    "Verbose" -> False  (* whether to print memory usage during solving *)
};
```

Then find inside `paramQuadSolve[...]`:
```wl
signHead        = OptionValue["SignSymbol"],
```
Replace with:
```wl
signHead        = OptionValue["SymbolicSignSymbol"],
```

#### 1.2 `Kernel/Model/ProcessModels.wl`

Update the injected nested option name.

Find both occurrences:
```wl
"SignSymbol" -> Symbol[
    "sign"<>SymbolName[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc]
]
```
and
```wl
"SignSymbol" -> Symbol[
    "sign"<>SymbolName[Head@FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd]
]
```
Replace with:
```wl
"SymbolicSignSymbol" -> Symbol[
    "sign"<>SymbolName[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc]
]
```
and
```wl
"SymbolicSignSymbol" -> Symbol[
    "sign"<>SymbolName[Head@FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd]
]
```

#### 1.3 `Kernel/Tools/FindRootOptim.wl`

**Change:** rename compile‑stage option and associated metadata key.

1) Update `buildKernel` usage and options.

Find:
```wl
buildKernel//Options = {
    "CoeffName" -> "A",
    "SignSymbol" -> "signA",
    "PerformanceGoal" -> "Speed",
    "CompileMode" -> "FunctionOnly",
    "Compiler" -> "Compile",
    "FlattenExpressions" -> Automatic,
    "AllowCompileDuringCoverage" -> False
};
```
Replace with:
```wl
buildKernel // Options = {
    "CoeffName" -> "A",
    "CompileSignSymbol" -> "signA",
    "PerformanceGoal" -> "Speed",
    "CompileMode" -> "FunctionOnly",
    "Compiler" -> "Compile",
    "FlattenExpressions" -> Automatic,
    "AllowCompileDuringCoverage" -> False
};
```

2) Inside `buildKernel[...]`, change:
```wl
signSym = OptionValue["SignSymbol"],
```
to:
```wl
signSym = OptionValue["CompileSignSymbol"],
```

3) In the returned kernel association, change:
```wl
"SignSymbol" -> signSym
```
to:
```wl
"CompileSignSymbol" -> signSym
```

4) Rename the eqMap key.

In `buildEqMapFromModel[...]`, replace:
```wl
"SignSymbol" -> ...
```
with:
```wl
"CompileSignSymbol" -> ...
```

In `createEqMapFromModel[...]`, replace:
```wl
"SignSymbol" -> ...
```
with:
```wl
"CompileSignSymbol" -> ...
```

In `createCompiledEq[...]`, replace:
```wl
"SignSymbol" -> eqMap[eq]["SignSymbol"]
```
with:
```wl
"CompileSignSymbol" -> eqMap[eq]["CompileSignSymbol"]
```

#### 1.4 `Kernel/ComputationalEngine/SolveEulerEq.wl`

Update kernel metadata key name.

Find:
```wl
sName = Lookup[savedKernel, "SignSymbol"];
```
Replace with:
```wl
sName = Lookup[savedKernel, "CompileSignSymbol"];
```

#### 1.5 Gate checks

- `ripgrep` should find **zero** occurrences of an option name `"SignSymbol"`:
  ```bash
  rg '"SignSymbol"' Kernel
  ```
  Acceptable remaining hits are only comments you intentionally leave (prefer none).

- Run tests, commit.

---

### Phase 2 — Make `"Signs"` owned by `solveCoeffRoots`

This phase removes `"Signs"` as an option from helper functions and makes it a true option of `solveCoeffRoots`.

#### 2.1 `Kernel/ComputationalEngine/SolveEulerEq.wl`

Replace the `solveCoeffRoots` signature and internal option resolution.

**Find the existing `solveCoeffRoots[...] := Module[...]` definition** and replace the *function header* and first few locals as follows.

Replace the current header:
```wl
solveCoeffRoots[
    quadSol_Association,
    savedKernel_Association,
    paramsBase_Association,
    signs : ({} | {_Integer ..}) : {},
    extraParams_Association : <||>,
    opts : OptionsPattern[{solveCoeffRoots, findRootInterval, extractIntervalsFromReduce, scanAndSolve, fastRoot, FindRoot}]
] /; AllTrue[signs, (# === 1 || # === -1) &]  := With[{ ... }, ...]
```
with:
```wl
solveCoeffRoots // Options = {
    "Signs" -> {}
};

solveCoeffRoots[
    quadSol_Association,
    savedKernel_Association,
    paramsBase_Association,
    extraParams_Association : <||>,
    opts : OptionsPattern[{solveCoeffRoots, findRootInterval, extractIntervalsFromReduce, scanAndSolve, fastRoot, FindRoot}]
] /; AllTrue[signs, (# === 1 || # === -1) &]  := With[
    {
        signs = OptionValue["Signs"],
       
    (* existing body continues, with the edits below *)
```

Then, inside the body:

- Where `bindUnary[...]` is called, replace:
  ```wl
  bindResult = bindUnary[savedKernel, paramsAll, "Signs" -> signs];
  ```
  with:
  ```wl
  bindResult = bindUnary[savedKernel, paramsAll, signs];
  ```

- Remove any attempt to pass `"Signs" -> ...` into `findRootInterval` (that helper will no longer have options).

- Wherever `solveND[...]` is called, stop passing `findOpts`/`findRootIntervalOpts` (those disappear when `findRootInterval` has no options). The `solveND` signature will be updated in step 2.2.

#### 2.2 Update `safeReduceCall` and `solveND`

Update these functions so they call the new `findRootInterval` positional API.

In `safeReduceCall`, replace the `findRootInterval[...]` call:
```wl
findRootInterval[
    conds,
    paramsAll,
    "CoeffName" -> coefName,
    "SignSymbol" -> signName,
    "Signs" -> signs,
    Sequence @@ findRootIntervalOpts
]
```
with:
```wl
findRootInterval[conds, paramsAll, coefName, signName, signs]
```

Also remove the now-unused `findRootIntervalOpts` parameter from `safeReduceCall` and the plumbing from `solveND`.

#### 2.3 `Kernel/Tools/FindRootOptim.wl`

Update helper signatures:

1) Remove options from `bindUnary`.

Delete the entire block:
```wl
bindUnary // Options = {"Signs" -> {}};
```

Change the function header:
```wl
bindUnary[kernel_Association, params_Association, opts : OptionsPattern[bindUnary]] := Module[
    { signs = OptionValue["Signs"], ... },
    ...
]
```
To:
```wl
bindUnary[kernel_Association, params_Association, signs_List : {}] := Module[
    { (* same locals as before, but remove OptionValue["Signs"] *) },
    ...
]
```

Inside the body, keep the existing sign validation logic, but replace references to the old local `signs = OptionValue[...]` with the argument `signs`.

2) Remove options from `findRootInterval`.

Delete the entire options block:
```wl
findRootInterval // Options = {
    "CoeffName" -> "coefwc",
    "SignSymbol" -> "signA",
    "Signs" -> {}
};
```

Replace the function header:
```wl
findRootInterval[condExpr_, paramValues_Association, opts : OptionsPattern[{findRootInterval, FindRoot}]] := Module[
    { coeffName = OptionValue["CoeffName"], signSym = OptionValue["SignSymbol"], signs = OptionValue["Signs"], ... },
    ...
]
```
with:
```wl
findRootInterval[condExpr_, paramValues_Association, coeffName_String, signSym_String, signs_List : {}] := Module[
    { (* keep the rest of locals; remove OptionValue[...] for these *) },
    ...
]
```

Update all internal references accordingly.

> Note: `signSym` remains a String *parameter* (compile sign symbol name). This is not an option anymore.

#### 2.4 Gate checks

- Search for remaining `OptionValue["Signs"]` outside `solveCoeffRoots` (should be none):
  ```bash
  rg 'OptionValue\["Signs"\]' Kernel
  ```

- Run tests, commit.

---

### Phase 3 — Split build vs evaluation maturity (`BuildMaxMaturity`)

#### 3.1 `Kernel/Tools/ManageResources.wl`

Update the public `buildModels` options.

Find:
```wl
buildModels // Options = {
    "FromScratch" -> False,
    "CompileJacobians" -> False,
    "CreateMoments" -> True,
    "NumKernels" -> Automatic,
    "MaxMaturity" -> 120,
    "Models" -> All,
    "PdEquations" -> "B",
    "FileSuffix" -> "",
    "UpdateManifest" -> True,
    "Verbose" -> False
};
```
Replace with:
```wl
buildModels // Options = {
    "FromScratch" -> False,
    "CompileJacobians" -> True,
    "CreateMoments" -> True,
    "NumKernels" -> Automatic,
    "BuildMaxMaturity" -> 120,
    "Models" -> All,
    "FileSuffix" -> "",
    "UpdateManifest" -> True,
    "Verbose" -> False
};
```

Notes:
- Defaults for `"CompileJacobians"` are adjusted to match the *effective* defaults previously coming from `OptionsConfig`.
- `"PdEquations"` is removed here; it is owned by `solveCoeffsSystem`.

Then update any references inside `buildModelsInternal` that previously used `config["Build"]["MaxMaturity"]` to use a new local variable `buildMaxMaturity` derived from settings (Phase 4 will fully refactor `buildModelsInternal`; here you only rename the option so later phases compile).

#### 3.2 `Kernel/ComputationalEngine/SolveEulerEq.wl`

Update `addCoeffsSolutionN` so the build pipeline can control maturity.

Replace the current definition header:
```wl
addCoeffsSolutionN[model_] := Module[{k},
    k=FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels[model["shortname"]];
    updateCoeffs[
        model,
        k,
        "UpdatePd"->True,
        "UpdateBonds"->True,
        "MaxMaturity"->12,
        "RootSigns" -> All
    ]
];
```
with:
```wl
addCoeffsSolutionN[model_Association, buildMaxMaturity_Integer, opts : OptionsPattern[{updateCoeffs, FindRoot, RecurrenceTable}]] := Module[
    {
        maxMaturity = buildMaxMaturity,
        rootSigns = All,
        updateOpts,
        k,
        sol,
        solWc,
        solPd
    },

    updateOpts = Join[
        FilterRules[{opts}, Options[updateCoeffs]],
        {
            "MaxMaturity" -> maxMaturity,
            "RootSigns" -> rootSigns
        }
    ];

    (* existing body, but call updateCoeffs with Sequence @@ updateOpts *)
];
```

Then, in the body where `updateCoeffs[...]` is called, ensure you pass `Sequence @@ updateOpts`.

Also keep (or add) a one‑argument convenience wrapper if desired:
```wl
addCoeffsSolutionN[model_Association, opts : OptionsPattern[{updateCoeffs, FindRoot, RecurrenceTable}]] :=
    addCoeffsSolutionN[model, 12, opts];
```

#### 3.3 `Kernel/Tools/NicePlots.wl`

Remove `"MaxMaturity"` from `yieldCurve`’s owned options and source it from `updateCoeffs` instead.

Find:
```wl
yieldCurve//Options={
    "MaxMaturity" -> 12,
    "MomentFunction" -> uncondE
};
```
Replace with:
```wl
yieldCurve//Options={
    "MomentFunction" -> uncondE
};
```

Then in `yieldCurve[...]`, replace:
```wl
maxMaturity = Evaluate@OptionValue[yieldCurve,"MaxMaturity"],
```
with:
```wl
maxMaturity = OptionValue[updateCoeffs, {opts}, "MaxMaturity"],
```

#### 3.4 `Kernel/Model/ProcessModels.wl`

Clean up `addCoeffsSolution`’s options (it does not consume `MaxMaturity`, `RootSigns`, `FindRootOptions`).

Replace:
```wl
Options[addCoeffsSolution] = {
    "MaxMaturity" -> 12,
    "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
    "RootSigns" -> Automatic,
    "FindRootOptions" -> {},
    "RecurrenceTableOptions" -> {},
    "DependentVariables" -> Automatic
};
```
with:
```wl
Options[addCoeffsSolution] = {};
```

Inside `addCoeffsSolution[...]`, replace:
```wl
Evaluate[First@OptionValue[addCoeffsSolution,{"RecurrenceTableOptions"}]]
```
with:
```wl
OptionValue[updateCoeffs, {opts}, "RecurrenceTableOptions"]
```

Update any call sites that previously did `FilterRules[..., Options[addCoeffsSolution]]` to instead pass through `updateCoeffs` / `RecurrenceTable` options (Phase 4 will handle this in `buildModelsInternal`).

#### 3.5 Gate checks

- `rg '"MaxMaturity" -> 120'` should find nothing.
- `rg 'yieldCurve//Options'` should no longer contain MaxMaturity.

Run tests, commit.

---

### Phase 4 — Remove `OptionsConfig` and refactor `buildModels`

This is the largest mechanical change.

#### 4.1 Delete `OptionsConfig`

- Delete file: `Kernel/Tools/OptionsConfig.wl`
- Remove any `Needs[...]` or `NeedsDefinitions[...]` for it.

#### 4.2 `Kernel/LongRunRisk.wl`

Remove:
```wl
Needs["FernandoDuarte`LongRunRisk`Tools`OptionsConfig`"];
```

Optionally add loading of the new validation rules (Phase 5) later.

#### 4.3 `Kernel/Tools/ManageResources.wl`

Remove:
```wl
Needs["FernandoDuarte`LongRunRisk`Tools`OptionsConfig`"];
```

Then remove the entire `buildModels[config_Association] := ...` definition.

Replace the `buildModels[opts___?OptionQ] := ...` body so it no longer calls `normalizeConfig`.

Add a helper inside `Private`:

```wl
resolveBuildSettings[opts_List] := Module[
    {
        fromScratch,
        compileJacobians,
        createMoments,
        numKernels,
        buildMaxMaturity,
        modelFilter,
        fileSuffix,
        updateManifest,
        verbose,
        compileMode,
        compilerChoice,
        flattenOpt,
        pdMode
    },

    (* Ensure dependent owners are loaded for OptionValue *)
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`ProcessModels`"];

    fromScratch = OptionValue[buildModels, opts, "FromScratch"];
    compileJacobians = OptionValue[buildModels, opts, "CompileJacobians"];
    createMoments = OptionValue[buildModels, opts, "CreateMoments"];
    numKernels = OptionValue[buildModels, opts, "NumKernels"];
    buildMaxMaturity = OptionValue[buildModels, opts, "BuildMaxMaturity"];
    modelFilter = OptionValue[buildModels, opts, "Models"];
    fileSuffix = OptionValue[buildModels, opts, "FileSuffix"];
    updateManifest = OptionValue[buildModels, opts, "UpdateManifest"];
    verbose = OptionValue[buildModels, opts, "Verbose"];

    compileMode = OptionValue[buildKernel, opts, "CompileMode"];
    compilerChoice = OptionValue[buildKernel, opts, "Compiler"];
    flattenOpt = OptionValue[buildKernel, opts, "FlattenExpressions"];

    pdMode = OptionValue[solveCoeffsSystem, opts, "PdEquations"];

    <|
        "FromScratch" -> fromScratch,
        "CompileJacobians" -> compileJacobians,
        "CreateMoments" -> createMoments,
        "NumKernels" -> numKernels,
        "BuildMaxMaturity" -> buildMaxMaturity,
        "Models" -> modelFilter,
        "FileSuffix" -> fileSuffix,
        "UpdateManifest" -> updateManifest,
        "Verbose" -> verbose,
        "CompileMode" -> compileMode,
        "Compiler" -> compilerChoice,
        "FlattenExpressions" -> flattenOpt,
        "PdEquations" -> pdMode
    |>
];
```

Then set:
```wl
buildModels[opts___?OptionQ] := Module[
    {optsList = Flatten@{opts}, settings},
    settings = resolveBuildSettings[optsList];
    buildModelsInternal[settings, optsList]
];
```

#### 4.4 Refactor `buildModelsInternal`

Change signature from:
```wl
buildModelsInternal[config_Association] := Module[ ... ]
```
to:
```wl
buildModelsInternal[settings_Association, opts_List] := Module[ ... ]
```

Inside the opening `With[...]` block, replace all `config[...]` reads with `settings[...]`.

Then replace each `splitConfig[...]` usage with stage‑specific `FilterRules` on `opts`:

- Symbolic stage:
  ```wl
  symbolicStageOpts = FilterRules[
      opts,
      Join[Options[solveCoeffsSystem], Options[updateCoeffs], Options[getStartingValues], Options[FindRoot], Options[RecurrenceTable]]
  ];
  ```

- Compile stage:
  ```wl
  compileStageOpts = FilterRules[opts, Join[Options[buildKernel], Options[Compile], Options[FunctionCompile]]];
  ```

- Numerical stage:
  ```wl
  numericalStageOpts = FilterRules[opts, Join[Options[updateCoeffs], Options[FindRoot], Options[RecurrenceTable]]];
  ```

- Moments stage (only when `settings["CreateMoments"]` is True):
  ```wl
  momentsStageOpts = FilterRules[opts, Options[createDatabase]];
  ```

Then update the key calls:

- `processModels[ ..., Sequence @@ symbolicStageOpts ]`
- `createCompiledEq[ ..., Sequence @@ compileStageOpts ]`
- `addCoeffsSolutionN[ ..., settings["BuildMaxMaturity"], Sequence @@ numericalStageOpts ]`
- `createDatabase[ ..., Sequence @@ momentsStageOpts ]`

#### 4.5 Fix `validateCompiledFile` defaults

In `ManageResources.wl`, change:
```wl
validateCompiledFile[mxFile_String, model_Association, compileMode_String : "FunctionOnly",
    compilerChoice_String : "Compile", flattenOpt_ : Automatic] := ...
```
To:
```wl
validateCompiledFile[mxFile_String, model_Association, compileMode_String, compilerChoice_String, flattenOpt_, pdMode_String] := ...
```

Update all call sites to pass values from `settings`.

#### 4.6 Update `getModelPipelineStatus`

Replace the `normalizeConfig` usage with:

```wl
getModelPipelineStatus[modelName_String] := Module[
    {optsList = {}, settings, compiledDir, coeffsDir, momentsDir},
    settings = resolveBuildSettings[optsList];
    compiledDir = getDataDir["compiled"]; (* existing helper *)
    coeffsDir = getDataDir["coeffs"];     (* existing helper *)
    momentsDir = getDataDir["moments"];   (* existing helper *)
    determineModelStatus[
        modelName,
        compiledDir,
        coeffsDir,
        momentsDir,
        settings["CompileMode"],
        settings["Compiler"],
        settings["FlattenExpressions"],
        settings["PdEquations"]
    ]
];
```

#### 4.7 Gate checks

- Confirm the legacy API is gone:
  ```bash
  rg 'OptionsConfig|normalizeConfig|splitConfig' Kernel
  ```
  should return nothing.

- Run tests, commit.

---

### Phase 5 — Add OptionsValidation rules

#### 5.1 Add file `Kernel/Tools/OptionsValidationRules.wl`

Create a new file with the following content:

```wl
BeginPackage["FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`"];

InstallOptionsValidationRules::usage = "InstallOptionsValidationRules[] installs option validation rules via OptionsValidation.`";

Begin["`Private`"];

InstallOptionsValidationRules[] := Module[
    {makeMsgs, checksByOwner},

    Needs["OptionsValidation`"]; (* no ErrorTools *)
    Needs["PacletizedResourceFunctions`"]; 

    (* Ensure owners exist *)
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`ProcessModels`"];

    makeMsgs[owner_Symbol] := Module[{base = SymbolName[owner]},
        owner::optx = "`1` is not a valid option for " <> base <> ".";
        owner::optv = "Invalid value `1` for option `2` in " <> base <> ".";
    ];

    checksByOwner = <|
        FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels -> {
            "FromScratch" -> "Boolean",
            "CompileJacobians" -> "Boolean",
            "CreateMoments" -> "Boolean",
            "NumKernels" -> {"Integer" | "Symbol", "Min" -> 1},
            "BuildMaxMaturity" -> {"Integer", "Min" -> 1},
            "Models" -> "Any",
            "FileSuffix" -> "String",
            "UpdateManifest" -> "Boolean",
            "Verbose" -> "Boolean"
        },

        FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel -> {
            "CoeffName" -> "String",
            "CompileSignSymbol" -> "String",
            "CompileMode" -> {"Member", {"Both", "JacobianOnly", "FunctionOnly"}},
            "Compiler" -> {"Member", {"Compile", "FunctionCompile"}},
            "FlattenExpressions" -> ("Boolean" | Automatic),
            "AllowCompileDuringCoverage" -> "Boolean"
        },

        FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`solveCoeffRoots -> {
            "Signs" -> "Any" (* keep permissive; or enforce list of ±1 if desired *)
        },

        FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve -> {
            "SymbolicSignSymbol" -> "Symbol",
            "DomainOption" -> "Any",
            "Assumptions" -> "Any",
            "Method" -> "Any",
            "MonomialOrder" -> "Any",
            "ValidationOption" -> "Boolean",
            "ReturnOption" -> {"Member", {"All", "Solution", "Equations"}},
            "TimeoutOption" -> {"Integer", "Min" -> 0},
            "SimplifyTimeout" -> "Any",
            "DiagnosticsOption" -> "Boolean",
            "OnlyQuadTerms" -> "Boolean",
            "GroebnerMemoryFraction" -> {"Real", "Min" -> 0, "Max" -> 1},
            "GroebnerMemoryFloor" -> {"Integer", "Min" -> 0},
            "GroebnerMemoryCap" -> {"Integer", "Min" -> 0},
            "Verbose" -> "Boolean"
        },

        FernandoDuarte`LongRunRisk`Model`ProcessModels`solveCoeffsSystem -> {
            "PdEquations" -> {"Member", {"A", "B", "C"}},
            "Verbose" -> "Boolean"
        }
    |>;

    KeyValueMap[
        Function[{owner, checks},
            makeMsgs[owner];
            OptionsValidation`SetDefaultOptionsValidation[
                owner,
                Map[OptionsValidation`CheckOption[owner, #] &, checks]
            ];
        ],
        checksByOwner
    ];

    True
];

End[];
EndPackage[];
```

#### 5.2 Load + install from `Kernel/LongRunRisk.wl`

Add (near other tooling loads):

```wl
Quiet[
    Check[
        PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`"];
        FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`InstallOptionsValidationRules[],
        Null
    ]
];
```

This is deliberately guarded so the paclet still loads even if `OptionsValidation` is missing.

#### 5.3 Gate checks

- Add at least one unit test that an invalid option value triggers `::optv`.
- Run tests, commit.

---

### Phase 6 — Final cleanup

1. Confirm removed symbols:
   ```bash
   rg 'OptionsConfig|normalizeConfig|splitConfig|"SignSymbol"' Kernel
   ```

2. Confirm new option names exist:
   ```bash
   rg '"SymbolicSignSymbol"|"CompileSignSymbol"|"BuildMaxMaturity"' Kernel
   ```

3. Run tests.

4. Generate final diff:
   ```bash
   git diff main...HEAD
   ```

---

## File index

### Delete

- `Kernel/Tools/OptionsConfig.wl`

### Add

- `Kernel/Tools/OptionsValidationRules.wl`

### Modify

- `Kernel/LongRunRisk.wl`
- `Kernel/Tools/ManageResources.wl`
- `Kernel/Tools/FindRootOptim.wl`
- `Kernel/ComputationalEngine/ParamQuadSolve.wl`
- `Kernel/Model/ProcessModels.wl`
- `Kernel/ComputationalEngine/SolveEulerEq.wl`
- `Kernel/Tools/NicePlots.wl`

### Explicitly untouched (expected)

- `Kernel/Parameters/*`
- `Kernel/Shocks/*`
- `Kernel/Tools/ToNumber.wl`
- `Kernel/Tools/NicePlotsExtra.wl`
- `Kernel/ComputationalEngine/CreateMomentsDatabase.wl` (unless you add validation rules)
