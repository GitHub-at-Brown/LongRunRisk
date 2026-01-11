# Code Analysis: ToNumber.wl (Codex)

## Overview
File reviewed: `Kernel/Tools/ToNumber.wl` (745 lines)

---

## Findings by Severity

### HIGH

#### 1. `selectByAssociation` SubsetQ Check Bug (Lines 369-373)
```wolfram
If[!SubsetQ[validKeys, selectorKeys], ...]
```

**Impact:** Rejects selector associations that specify only a subset of keys (e.g., `{"SignsA"->...}`), contradicting later conditional checks and the usage text; valid selectors will always fail unless all keys are present.

**Fix:** Change to `If[!SubsetQ[selectorKeys, validKeys], ...]` so only invalid keys are rejected.

#### 2. `SolutionIndexB` Accepted but Never Applied (Lines 366-439)
```wolfram
validKeys = {"SignsA", "SignsB", "SolutionIndexA", "SolutionIndexB"};
```
(no later use of SolutionIndexB)

**Impact:** Callers may believe `SolutionIndexB` filters solutions, but it is ignored; this can return unintended solutions (correctness/clarity).

**Fix:** Either implement filtering logic for `SolutionIndexB` (define semantics: per-stock index? global index?) or remove it from `validKeys` and update `toNum::badselector`/usage.

---

### MEDIUM

#### 3. `ToExpression` on User-Supplied Values (Lines 715-716)
```wolfram
ToExpression@("gamma"/.newParametersString)
```

**Impact:** `ToExpression` evaluates arbitrary input; if `newParameters` comes from untrusted sources, this is an execution vector (security risk).

**Fix:** Avoid evaluation by using `ToExpression[..., InputForm, HoldComplete]` and validate numeric form before releasing, or use numeric parsing (`Interpreter["Number"]`) to constrain to numeric values.

#### 4. Combinatorial Explosion in Hierarchical Evaluation (Lines 137-152, 474-483)
```wolfram
Tuples[Table[Range[Length[aSol["Stocks"][sk]]], {sk, stockKeys}]]
```

**Impact:** Number of evaluations grows as the product of solution counts per stock; for multi-stock models this can be exponential and become a performance hotspot.

**Fix:** Allow caller to pass a selector or cap to limit combinations; support lazy evaluation or pruning before `FixedPoint`.

#### 5. `processNewParameters` Uses `Abort[]` (Lines 665-723)
```wolfram
Message[processNewParameters::subsetparam, ...]; Abort[];
```

**Impact:** Hard-aborts bypass the `Failure`-based error handling elsewhere (`toNumRules` returns `Failure`), making error handling inconsistent and harder to recover from.

**Fix:** Return `Failure[...]` objects (with message templates) and let callers propagate.

---

### LOW

#### 6. Duplicated Rule-Application Logic in `toNum` (Lines 95-128 and 165-169)
Both branches use:
```wolfram
FixedPoint[ReplaceAll[#, rules] &, toEquation[expr, model], 10]
```

**Impact:** Duplicated logic increases maintenance cost; future changes must be applied twice.

**Fix:** Extract a helper like `applyRulesToExpr[expr_, rules_, model_]` and reuse.

#### 7. Repeated Construction of A-Solution Association (Lines 345-357 and 430-439)
Repeated blocks assigning `"IntervalA"`, `"SignsA"`, `"SolutionIndexA"`, `"IntervalIndexA"`, `"A"`, `"Stocks"`, `"Bond"`, `"NomBond"`.

**Impact:** DRY violation; future additions must be kept consistent.

**Fix:** Add a small helper `makeASolution[aSol_, stocks_]` or similar.

#### 8. Unused `numStocks_` Parameter (Line 270)
```wolfram
selectSolutions[solHierarchical_List, selector_, numStocks_]
```

**Impact:** Unused parameters reduce clarity and hint at missing logic.

**Fix:** Remove if unnecessary or use it to validate selector shape.

---

## Structural and Simplification Notes

### Overall Structure
File is well sectioned (`toNum`, helpers, `toEquation`, `toExogenousVars`, `processNewParameters`), but `toNum` and its helpers constitute a large block with mixed concerns (option parsing, solving, selection, evaluation). Consider splitting selection/evaluation into a separate internal module for clarity.

### DRY Violations
- Duplicate evaluation logic in `toNum` (lines 95-128 and 165-169)
- Duplicated association building in solution selectors (lines 345-357 and 430-439)

### Complexity Hotspots
- `evaluateExprHierarchical` + `allBIndexCombinations` (lines 137-152, 474-483) are exponential
- `processNewParameters` is also complex with nested `With`/`Module` and multiple transformation passes (lines 665-731)

### Logic Flow Clarity
- `selectByAssociation` has a key-validation bug and accepts `SolutionIndexB` without using it; this muddles intended usage (lines 366-439)
- `processNewParameters` mixes `Abort[]` with `Failure` patterns in callers

### Simplification Ideas
1. Consolidate `toNum` evaluation into one helper; pass in `rulesOrSol` and `allParams`
2. Extract common association-building into a helper
3. Replace `Abort[]` with `Failure` for consistent error handling
4. Introduce an option to limit hierarchical combinations or pass `bIndices` directly

---

## Positives

- Clear separation of public API (`toNum`, `toEquation`, etc.) and helper functions
- Good defensive option validation for `SolutionSelector`/`ReturnAllSolutions` with user-facing messages (Lines 202-215)
- The explicit `toNum["Rules", ...]` patterns prevent the previously noted recursion issue (lines 85-91)

---

## Summary

**Top Issues:**
1. `selectByAssociation` rejects partial selectors due to reversed `SubsetQ` check (Lines 369-373) - breaking correct selector usage; fix by flipping arguments
2. `SolutionIndexB` is accepted but ignored (Lines 366-439) - selection can be wrong; implement filtering or remove the key

**Medium Concerns:**
- `ToExpression` on user values (security)
- Exponential evaluation in hierarchical mode (performance)
- `Abort[]` usage in `processNewParameters` (inconsistent error flow)

**Positives:**
- Strong sectioning
- Explicit recursion fix for `toNum["Rules"]`
- Thorough option validation

**Recommended Fixes:**
- Correct selector validation
- Define or remove `SolutionIndexB`
- Replace `Abort[]` with `Failure`
- Add a cap/selector to avoid combinatorial blowups
