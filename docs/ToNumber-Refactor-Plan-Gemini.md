# Refactoring Plan: ToNumber.wl (Gemini)

## Overview

This is a comprehensive refactoring plan for `Kernel/Tools/ToNumber.wl` aimed at improving maintainability and separation of concerns while preserving the public API.

---

## 1. Proposed New File Structure

To improve maintainability and separation of concerns, the monolithic `ToNumber.wl` should be split into a modular package structure under `Kernel/Tools/ToNumber/`.

```
Kernel/Tools/ToNumber/Loader.wl           - Main entry point, loads sub-components
Kernel/Tools/ToNumber/ModelTransformations.wl  - toEquation, toExogenousVars, toStateVars
Kernel/Tools/ToNumber/Parameters.wl       - processNewParameters
Kernel/Tools/ToNumber/NumericalEval.wl    - Core toNum logic and dispatch
Kernel/Tools/ToNumber/EvaluationUtils.wl  - Hierarchical evaluation and solution selection
Kernel/Tools/ToNumber/Metaprogramming.wl  - modelEval, moms, symbol injection logic
```

**Public Scope Strategy:** The `Loader.wl` will `Get` all sub-files but ensure they all contribute to the `FernandoDuarte`LongRunRisk`Tools`ToNumber`` context (or a common private context) to avoid context issues.

---

## 2. Specific Code Transformations

### A. Replace `withUserDefs` with Pattern Matching

The current `withUserDefs` hacks global definitions to inject `model`. This is dangerous. Replace it with a structural transformation.

**Before:**
```mathematica
(* Uses dynamic scoping and modifying DownValues *)
moms[fun_, expr_, model_] := withUserDefs[fun, {fun[x___] := fun[x, model]}, expr]
modelEval[expr_, model_] := Fold[ReverseApplied[moms[#1, #2, model]&], expr, {uncondE, ...}]
```

**After:**
```mathematica
(* Pure structural replacement - cleaner and safer *)
$ContextAwareSymbols = {uncondE, uncondVar, uncondCov, ...};

modelEval[expr_, model_Association] := expr /.
    (f_Symbol /; MemberQ[$ContextAwareSymbols, f])[args___] :> f[args, model];
```

### B. Refactor `processNewParameters`

Simplify the string-based parsing and context logic.

**Before:**
```mathematica
(* Complex string manipulation and hardcoded "gamma", "psi" strings *)
processNewParameters[newParameters_, parameters_] := ...
   (* nested Switch, manual string parsing *)
```

**After:**
```mathematica
(* Explicit handling of known parameter constraints *)
processNewParameters[newParams_List, oldParams_List] := Module[{combined, theta, psi, gamma},
    combined = Join[Association[oldParams], Association[newParams]];

    (* Enforce constraints *)
    If[KeyExistsQ[combined, "psi"] && combined["psi"] == 1,
        Failure["InvalidParameter", <|"Message" -> "psi=1 implies constant wealth-consumption"|>]
    ,
        (* Calculate derived theta if needed *)
        (* ... simple algebraic update logic ... *)
        Normal[combined]
    ]
]
```

---

## 3. Eliminate DRY Violations

`toEquation`, `toExogenousVars`, and `toStateVars` all share the exact same pattern: `ReplaceAll[modelEval[expr, model], rules]`.

**Solution:** Create a generic private transformer.

```mathematica
(* In ModelTransformations.wl *)

applyModelTransformation[expr_, model_, replacementRules_] :=
    ReplaceAll[modelEval[expr, model], replacementRules]

toEquation[expr_, model_] :=
    applyModelTransformation[expr, model, Join[model["endogenousEq"], model["exogenousEq"]]]

toExogenousVars[expr_, model_] :=
    applyModelTransformation[expr, model, model["endogenousEq"]]

toStateVars[expr_, model_] :=
    applyModelTransformation[expr, model, model["toStateVars"]]
```

---

## 4. Simplify `toNum` Dispatch

The current dispatch uses `Not@AssociationQ` guard clauses. A purely pattern-based dispatch is cleaner.

```mathematica
(* In NumericalEval.wl *)

(* 1. Rules Extraction *)
toNum["Rules", model_Association, args___] := toNumRules[model, args];

(* 2. Functional form (currying) *)
toNum[model_Association] := Function[expr, toNum[expr, model]];

(* 3. Main Evaluation *)
toNum[expr_, model_Association, args___] := Module[{rules},
    rules = toNumRules[model, args];
    If[FailureQ[rules], rules,
       (* Delegate to appropriate evaluator based on rules structure *)
       If[isHierarchicalSolution[rules],
           evaluateHierarchical[expr, model, rules],
           evaluateFlat[expr, model, rules]
       ]
    ]
]
```

---

## 5. Simplify `processNewParameters`

1. **Remove String Parsing:** Do not convert symbols to strings (`SymbolName`) unless absolutely necessary. Work with Symbols directly or consistent string keys.

2. **Validation:** Use `Check` or explicit `If` checks for `psi=1` or missing `theta` instead of `Abort[]`. Return `Failure` objects that propagate up.

3. **Constraint Solver:** Extract the `theta`, `psi`, `gamma` constraint logic into a standalone function `enforceModelConstraints[params]`.

---

## 6. Cleanup Metaprogramming

- **Remove `clone` and `withUserDefs`:** These are likely over-engineering for the task of injecting `model`. The pattern matching approach (Item 2A) is sufficient.
- **Remove `moms`:** It becomes redundant with the new `modelEval`.
- **Keep `modelEval`:** But simplify it to a single pass `ReplaceAll`.

---

## 7. Suggested Helper Functions to Extract

- **`evaluateFlat`:** Encapsulate the `FixedPoint[ReplaceAll..., 10]` logic.
- **`evaluateHierarchical`:** Encapsulate the complex Cartesian product logic for hierarchical solutions.
- **`selectSolutions`:** Fully extract the logic that filters solutions based on `SolutionSelector`.
- **`validateSelector`:** A pure function to check if a selector is valid, returning `True` or `Failure`.

---

## 8. Error Handling Improvements

1. **No Aborts:** Replace `Abort[]` in `processNewParameters` with `Return[Failure[...]]`.
2. **Propagate Failures:** Ensure `toNum` checks `If[FailureQ[rules], Return[rules]]` immediately.
3. **Structured Messages:** Define specific failure tags (e.g., `ToNum::InvalidSelector`) and attach context metadata to the `Failure` object for easier debugging.

---

## Refactoring Execution Plan

1. **Setup:** Create `Kernel/Tools/ToNumber/` directory.
2. **Extract Utils:** Create `Metaprogramming.wl` (simplified) and `EvaluationUtils.wl`.
3. **Extract Model Transforms:** Move `toEquation` etc. to `ModelTransformations.wl` using the DRY fix.
4. **Extract Parameters:** Move and clean up `processNewParameters` to `Parameters.wl`.
5. **Extract Main Logic:** Move `toNum` and `toNumRules` to `NumericalEval.wl`.
6. **Create Loader:** Create `ToNumber.wl` (or `Loader.wl`) that `Get`s the others.
7. **Verify:** Run existing tests (`Tests/Tools/ToNumber.wlt`) to ensure no API breakage.
