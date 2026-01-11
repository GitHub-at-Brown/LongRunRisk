# Refactoring Plan: ToNumber.wl (Codex)

## Overview

This refactoring plan aims to simplify and reorganize `ToNumber.wl` while keeping the public API unchanged. The plan is organized into 5 phases.

---

## Phase 1: Inventory & Boundaries

**Summary:** Map responsibilities and public entrypoints, identify duplicated logic and side effects.

**Validation Gate:** Public symbols (`toNum`, `toEquation`, `toExogenousVars`, `toStateVars`, `processNewParameters`) signatures unchanged; option names unchanged; messages preserved.

**Next Actions:**
- Scan for other private helpers referenced (`updateCoeffs`, `SolveEulerEq`, etc.) only as needed for dependencies
- Create a function responsibility map for ToNumber.wl sections

**Risks:** Hidden reliance on `Abort[]` side-effects or implicit `$ContextPath` behaviors.

**Mitigations:** Introduce Failure-based returns but preserve Message templates; wrap Abort replacements with compatibility shims where needed.

---

## Phase 2: File/Namespace Refactor Design

**Summary:** Propose new internal file split under `Kernel/Tools/ToNumber/Private` while keeping public loader in `ToNumber.wl`.

**Validation Gate:** `BeginPackage`/`EndPackage` remains in `ToNumber.wl`; new files are loaded from it via `Get`/`Needs`; no new public symbols.

**Next Actions:**
- Draft file map and function allocations
- Identify shared helpers that should live in a Utilities subfile

**Risks:** Circular load ordering between helpers.

**Mitigations:** Define a strict load order: Params -> Selector -> Rules -> Eval -> Meta.

---

## Phase 3: Core Refactors (Dispatch, DRY, Helpers)

**Summary:** Unify dispatch paths, collapse duplicated rule/FixedPoint code, and extract helpers.

**Validation Gate:** All current patterns resolve the same as before; existing tests pass.

**Next Actions:**
- Implement dispatcher + helper extraction
- Replace repeated `FixedPoint`/`ReplaceAll` usage with a shared evaluator

**Risks:** Subtle behavior differences in selector handling and evaluation order.

**Mitigations:** Add small internal regression tests via temporary notebooks or inline checks; preserve selector validations verbatim.

---

## Phase 4: processNewParameters & Metaprogramming Cleanup

**Summary:** Simplify parameter processing and replace metaprogramming with explicit transformation steps.

**Validation Gate:** Parameter edge cases (`psi=1`, theta rules, subset validation) behave identically (messages and failures).

**Next Actions:**
- Implement normalize/validate/solve/reconcile steps for parameters
- Replace `modelEval` with a direct, explicit rewrite pipeline

**Risks:** Context reconciliation differences for symbols with indices.

**Mitigations:** Keep existing key-splitting logic but isolate and unit-test it as helpers.

---

## Phase 5: Error Handling Improvements & Tidy-up

**Summary:** Replace `Abort[]` paths with `Failure` returns, add consistent Failure structure, and tidy messages.

**Validation Gate:** No new messages, only existing ones; downstream code continues to propagate Failure.

**Next Actions:**
- Add a `makeFailure` helper and replace `Abort[]` with `Return[Failure[...]]`
- Ensure `toNum`/`toNumRules` propagate Failure without evaluation

**Risks:** Callers rely on `Abort` to halt global evaluation.

**Mitigations:** Introduce internal `$AbortOnError` flag default True to preserve behavior; document for future migration.

---

## Proposed New File Structure

```
Kernel/Tools/ToNumber.wl                    (public API, BeginPackage, usage/messages, thin wrappers)
Kernel/Tools/ToNumber/Private/Dispatch.wl   (toNum entrypoints, dispatcher, shared eval)
Kernel/Tools/ToNumber/Private/Rules.wl      (toNumRules, updateCoeffs orchestration)
Kernel/Tools/ToNumber/Private/Selectors.wl  (selectSolutions, selectByTupleIndex, selectByAssociation)
Kernel/Tools/ToNumber/Private/Eval.wl       (evaluateExprHierarchical, flattenCoeffs*, allBIndexCombinations)
Kernel/Tools/ToNumber/Private/Params.wl     (processNewParameters + helpers)
Kernel/Tools/ToNumber/Private/ModelEval.wl  (modelEval, toEquation/toExogenousVars/toStateVars helpers)
Kernel/Tools/ToNumber/Private/Errors.wl     (makeFailure, error guards)
```

---

## Specific Code Transformations

### A. Unify FixedPoint Evaluation

**Before:**
```wolfram
toNum[expr_, model_] := With[{rules = toNum["Rules", model]},
  If[FailureQ[rules], rules, FixedPoint[ReplaceAll[#, rules] &, toEquation[expr, model], 10]]
]
```

**After:**
```wolfram
applyRules[expr_, rules_] := FixedPoint[ReplaceAll[#, rules] &, expr, 10];

toNumExpr[expr_, model_, rules_] := applyRules[toEquation[expr, model], rules];
```

### B. Dispatch Consolidation

**Before:** Multiple overlapping `toNum[...]` patterns including explicit "Rules" and generic expr.

**After:**
```wolfram
toNum["Rules", model_, rest___] := toNumRules[model, rest];
toNum[expr_, model_, params_: {}, opts___] := toNumDispatch[expr, model, params, opts];
```

---

## Eliminate DRY Violations

- Merge parameter merging (currently duplicated in `toNum` and `toNumRules`) into `resolveParameters[model, newParameters]`
- Centralize rule application (`applyRules`) and hierarchical evaluation selection (`evaluateWithRules`)
- Consolidate selector validation into `validateSelector[selector, returnAll]`

---

## Simplify `toNum` Dispatch Mechanism

- Single entry function `toNumDispatch` that:
  1. Resolves params
  2. Obtains rules via `toNumRules`
  3. Chooses flat vs hierarchical eval
- Guard "Rules" once; remove repeated pattern guards (`expr =!= "Rules"`)

---

## Simplify `processNewParameters`

Refactor into pure helpers:
- `normalizeParams[newParameters, parameters]` (Association + replace using rules)
- `splitParamKeys[assoc]` (context/name/index triple)
- `validateSubset[new, base]` (returns Failure instead of Abort)
- `resolveThetaGammaPsi[new]` (returns augmented assoc)
- `reconcileContexts[new, base]` (map SymbolName back to base contexts)

---

## Clean Up Metaprogramming

Replace `clone`/`withUserDefs` with an explicit rewrite of moment heads:

```wolfram
rewriteMoments[expr_, model_] := expr /.
    h:(uncondE|uncondVar|uncondCov|uncondCorr|ev|var|cov|corr)[args___] :> h[args, model];

modelEval[expr_, model_] := rewriteMoments[expr, model];
```

If context-sensitive heads are needed, create a whitelist mapping table once and apply via `ReplaceAll`.

---

## Suggested Helper Functions to Extract

- `resolveParameters`
- `applyRules`
- `evaluateWithRules`
- `validateSelector`
- `flattenCoeffsForIndices`
- `allBIndexCombinations`
- `makeFailure`
- `normalizeParams`
- `splitParamKeys`

---

## Error Handling Improvements

- Replace `Abort[]` with `Return[Failure[...]]` in `processNewParameters`
- Add `makeFailure[tag_, msg_, params_:{}]` to standardize failures and reduce boilerplate
- Ensure `toNum`, `toNumRules`, and selectors early-return on Failure and do not evaluate further

---

## Immediate Next Actions

1. Implement file split and add `Get` order in `ToNumber.wl`
2. Introduce dispatcher + shared helpers
3. Refactor `processNewParameters` into helper pipeline
4. Replace metaprogramming with explicit rewrite functions
5. Add minimal internal regression checks for selector and parameter edge cases
