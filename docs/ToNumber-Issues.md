# ToNumber.wl Issues and Proposed Fixes

This document describes issues identified in `Kernel/Tools/ToNumber.wl` and their proposed fixes.

---

## Test Validation Status (2026-01-11)

Bug coverage tests were added to `Tests/Tools/ToNumber.wlt` to validate these issues:

| Issue | Test Result | Status |
|-------|-------------|--------|
| Issue 1: `===` vs `==` comparison | **4 tests FAILED** | **CONFIRMED** |
| Issue 2: Missing B solutions message | Not directly tested | Recommended |

---

## Issue 1: SignsA/SignsB Selector Matching Uses Overly Strict Comparison

**STATUS: CONFIRMED BY TESTS**

### Symptom

```wolfram
With[{nrcSolAll = ToNum["Rules", nrcModel, "ReturnAllSolutions" -> True]},
  {signsA = nrcSolAll[[3]]["SignsA"]},
  ToNum["Rules", nrcModel, "SolutionSelector" -> <|"SignsA" -> signsA|>]
]

(* Output: *)
toNum::nosolution: No solution matching SolutionSelector <|SignsA->{1}|> was found.
```

Even though solution 3 has `SignsA -> {1}`, the selector fails to find it.

### Root Cause

The comparison in `selectByAssociation` (lines 408-409) uses `===` (SameQ):

```wolfram
matchingASols = Select[solHierarchical, Function[aSol,
    And[
        If[KeyExistsQ[selector, "SignsA"], aSol["SignsA"] === selector["SignsA"], True],
        If[KeyExistsQ[selector, "SolutionIndexA"], aSol["SolutionIndexA"] === selector["SolutionIndexA"], True]
    ]
]];
```

`===` is structurally exact and fails when:
- `{1} === {1.}` → `False` (integer vs real)
- Different internal numeric representations

Additionally, each call to `ToNum["Rules", ...]` calls `updateCoeffs` independently, so the second call may find different solutions than the first.

### Proposed Fix

Change `===` to `==` for numeric comparisons in `selectByAssociation`:

```wolfram
(* Line 408: Change === to == *)
If[KeyExistsQ[selector, "SignsA"], aSol["SignsA"] == selector["SignsA"], True],

(* Line 409: Change === to == *)
If[KeyExistsQ[selector, "SolutionIndexA"], aSol["SolutionIndexA"] == selector["SolutionIndexA"], True]
```

Similarly for SignsB comparison at line 423:

```wolfram
(* Line 423: Change === to == *)
stockKey -> Select[bSolList, #["SignsB"] == selector["SignsB"] &]
```

This makes the comparison more flexible: `{1} == {1.}` → `True`.

### Test Evidence

Four bug coverage tests were added to `Tests/Tools/ToNumber.wlt` and all failed:

1. `[toNum/BugCoverage] SignsA with Real values matches Integer solutions` - **FAILED**
2. `[toNum/BugCoverage] SignsB with Real values matches Integer solutions` - **FAILED**
3. `[toNum/BugCoverage] User-constructed SignsA pattern works` - **FAILED**
4. `[toNum/BugCoverage] User-constructed Real SignsA pattern works` - **FAILED**

These failures confirm that the `===` operator is too strict and prevents valid matches between Integer and Real sign values.

---

## Issue 2: Misleading Error Message When B Solutions Are Missing

**STATUS: RECOMMENDED (not directly tested)**

### Symptom

```wolfram
ToNum["Rules", byModel, {gamma -> 2}]

(* Output: *)
toNum::nosolution: No solution matching SolutionSelector Automatic was found.
```

The syntax is correct, but the error message suggests the selector didn't match when the actual problem is different.

### Root Cause

In `flattenCoeffsFromSelected` (lines 490-492), the `toNum::nosolution` message is reused inappropriately:

```wolfram
flattenCoeffsFromSelected[selectedSolutions_List, selector_, numStocks_] := Module[
    {aSol = First[selectedSolutions], stockKeys},
    stockKeys = Keys[aSol["Stocks"]];
    If[!hasValidBSolutions[aSol],
        Message[toNum::nosolution, selector];  (* Misleading! *)
        Failure["NoSolution", ...],
        ...
    ]
]
```

The actual issue is that `updateCoeffs` found A solutions but **zero B solutions** for one or more stocks (possibly because the parameter values make the B equations unsolvable). The error message incorrectly implies the selector didn't match.

### Proposed Fix

Add a new, specific error message for missing B solutions:

```wolfram
(* Add to message definitions around line 48 *)
toNum::nobsolutions = "No valid B solutions found for one or more stocks. The model may be unsolvable with the given parameters.";

(* Update flattenCoeffsFromSelected *)
flattenCoeffsFromSelected[selectedSolutions_List, selector_, numStocks_] := Module[
    {aSol = First[selectedSolutions], stockKeys},
    stockKeys = Keys[aSol["Stocks"]];
    If[!hasValidBSolutions[aSol],
        Message[toNum::nobsolutions];  (* Clear message *)
        Failure["NoBSolutions", <|"MessageTemplate" -> toNum::nobsolutions|>],
        flattenCoeffsForIndices[aSol, AssociationThread[stockKeys, ConstantArray[1, Length[stockKeys]]]]
    ]
]
```

---

## Summary of Changes

| Location | Change |
|----------|--------|
| Line ~48 | Add `toNum::nobsolutions` message definition |
| Line 408 | Change `===` to `==` for SignsA comparison |
| Line 409 | Change `===` to `==` for SolutionIndexA comparison |
| Line 423 | Change `===` to `==` for SignsB comparison |
| Lines 490-492 | Use `toNum::nobsolutions` instead of `toNum::nosolution` |

## Files Affected

- `Kernel/Tools/ToNumber.wl`
