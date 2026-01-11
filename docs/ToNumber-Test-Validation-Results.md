# Test Validation Results: ToNumber.wl

**Date:** 2026-01-11
**Test File:** `Tests/Tools/ToNumber.wlt`
**Section Added:** `(*SolutionSelector - Bug Coverage Tests*)`

---

## Summary

Bug coverage tests were added to validate suspected issues identified during code analysis by Codex, Gemini, and Claude. Of 10 tests added, 4 failed - confirming specific bugs.

### Overall Results

| Metric | Count |
|--------|-------|
| Bug Coverage Tests Added | 10 |
| Tests Passed | 6 |
| Tests Failed | 4 |
| Total ToNumber.wlt Tests | 116 |
| Total Passed | 112 |
| Total Failed | 4 |

---

## Failed Tests (Confirmed Bugs)

### 1. `[toNum/BugCoverage] SignsA with Real values matches Integer solutions`

**What it tests:** Whether `SignsA -> {1.}` (Real) matches a solution with `SignsA -> {1}` (Integer)

**Expected:** Both should match (numeric equality)
**Actual:** Real values fail to match

**Root Cause:** Line 408 uses `===` (SameQ) instead of `==` (Equal)
```wolfram
If[KeyExistsQ[selector, "SignsA"], aSol["SignsA"] === selector["SignsA"], True]
```

**Fix:** Change `===` to `==`

---

### 2. `[toNum/BugCoverage] SignsB with Real values matches Integer solutions`

**What it tests:** Whether `SignsB -> {1.}` (Real) matches a solution with `SignsB -> {1}` (Integer)

**Expected:** Both should match
**Actual:** Real values fail to match

**Root Cause:** Line 423 uses `===` instead of `==`
```wolfram
stockKey -> Select[bSolList, #["SignsB"] === selector["SignsB"] &]
```

**Fix:** Change `===` to `==`

---

### 3. `[toNum/BugCoverage] User-constructed SignsA pattern works`

**What it tests:** Whether a user-constructed signs pattern `ConstantArray[1, n]` works as a selector

**Expected:** Should either find a match or return `Failure`
**Actual:** Fails when signs don't match exactly due to `===`

**Root Cause:** Same as #1 - strict equality comparison

---

### 4. `[toNum/BugCoverage] User-constructed Real SignsA pattern works`

**What it tests:** Whether a user-constructed Real signs pattern `ConstantArray[1., n]` works

**Expected:** Should either find a match or return `Failure`
**Actual:** Always fails to match because `===` comparison

**Root Cause:** Same as #1 and #3

---

## Passed Tests (Disproved Bugs or Confirmed Behavior)

### 5. `[toNum/BugCoverage] Partial selector with only SignsA works` - PASSED

**What it tests:** Whether `<|"SignsA" -> {...}|>` alone works (tests SubsetQ logic)

**Result:** Partial selectors work correctly. The suspected SubsetQ argument reversal is NOT a bug.

---

### 6. `[toNum/BugCoverage] Partial selector with only SignsB works` - PASSED

**Result:** Confirms partial selectors work.

---

### 7. `[toNum/BugCoverage] Partial selector with only SolutionIndexA works` - PASSED

**Result:** Confirms partial selectors work.

---

### 8. `[toNum/BugCoverage] SolutionIndexB currently ignored (documents behavior)` - PASSED

**What it tests:** Whether adding `SolutionIndexB -> 1` changes results

**Result:** Results are identical with/without `SolutionIndexB`, confirming it is accepted but unused.

**Implication:** `SolutionIndexB` should either be implemented or removed from `validKeys`.

---

### 9. `[toNum/BugCoverage] Standard model evaluation works` - PASSED

**What it tests:** Basic sanity check that `toNum["Rules", model]` works

**Result:** Baseline functionality confirmed.

---

### 10. `[toNum/BugCoverage] SignsA matching works with copied list` - PASSED

**What it tests:** Whether object identity matters (same list vs copied list)

**Result:** Object identity is NOT an issue. A copied list matches correctly (when types match).

---

## Conclusions

### Confirmed Bugs Requiring Fix

1. **Lines 408, 409, 423:** Change `===` to `==` for numeric comparison in selector matching

### Disproved Bugs

1. **Line 370 SubsetQ:** The argument order is correct. Partial selectors work as expected.
2. **Object identity:** Not an issue. Lists match by value, not reference.

### Documented Behavior (Not Necessarily Bugs)

1. **SolutionIndexB:** Accepted but ignored. Should be removed or implemented.

---

## Test Code Added

Location: `Tests/Tools/ToNumber.wlt`, Section `(*SolutionSelector - Bug Coverage Tests*)`

```wolfram
(* Bug Coverage: Integer vs Real comparison in SignsA *)
TestCreate[
    Module[{integerSigns, realSigns, rulesInt, rulesReal},
        integerSigns = $nrcFirstA["SignsA"];
        realSigns = N /@ integerSigns;
        rulesInt = toNum["Rules", $modNRC, "RootSigns" -> All,
            "SolutionSelector" -> <|"SignsA" -> integerSigns|>];
        rulesReal = toNum["Rules", $modNRC, "RootSigns" -> All,
            "SolutionSelector" -> <|"SignsA" -> realSigns|>];
        validFlatRules[rulesInt] && validFlatRules[rulesReal]
    ],
    True,
    {},
    TestID -> "[toNum/BugCoverage] SignsA with Real values matches Integer solutions"
]
(* ... 9 more tests ... *)
```

---

## Next Steps

1. Apply fix: Change `===` to `==` at lines 408, 409, 423
2. Run tests again to verify all 4 failing tests now pass
3. Decide on `SolutionIndexB`: remove from `validKeys` or implement filtering
4. Proceed with refactoring plan (Phase 1+)
