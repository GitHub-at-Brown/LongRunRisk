# Minimal Reproducible Examples for Phase 9 Warnings

This directory contains minimal reproducible examples (MREs) for all warning messages observed during Phase 9 testing of the ToNum/toNum functions.

## Files

### Phase9_MRE_CopyPaste.wl
**Format:** Wolfram Language notebook-ready code
**Use:** Copy individual examples into Mathematica/Wolfram Desktop notebooks

**Contains:**
- Section-by-section examples for each warning type
- Formatted with section headers (`(* ::Section:: *)`)
- Copy-paste ready snippets
- Diagnostic checklist
- Real ToNum usage examples

**How to use:**
1. Open in Mathematica or Wolfram Desktop
2. Navigate to the warning you want to reproduce
3. Copy the relevant code block
4. Run in your notebook

---

### Phase9_MRE_Examples.wls
**Format:** WolframScript executable
**Use:** Run directly from command line to see all warnings

**Contains:**
- Executable demonstrations of all 5 warning types
- Combined example simulating ToNum solving
- Explanatory output with each example
- Suppression guidance

**How to use:**
```bash
wolframscript docs/Phase9_MRE_Examples.wls
```

Output shows each warning in action with explanations.

---

## Warning Types Demonstrated

### 1. LinearProgramming::lpsub
**Message:** "This problem is unbounded."
**Status:** Normal during constraint exploration
**Example:** Simple unbounded linear program

### 2. Reduce::ratnz
**Message:** "Reduce was unable to solve with inexact coefficients..."
**Status:** Correct behavior (inexact→exact→numericize)
**Example:** Solving equation with floating-point coefficients

### 3. FindRoot::njnum
**Message:** "The Jacobian is not a matrix of numbers at..."
**Status:** Normal, FindRoot still converges
**Example:** Piecewise function with conditional Jacobian

### 4. Refine::lpsub
**Message:** "This problem is unbounded." (during refinement)
**Status:** Normal during symbolic refinement
**Example:** Refining piecewise expressions with constraints

### 5. MIMETypeToFormatList::fmterr
**Message:** "None is not a recognized MIME Type."
**Status:** Cosmetic only, doesn't affect computation
**Example:** Export with None format

---

## When Are These Warnings OK?

All 5 warnings are **EXPECTED and NORMAL** during ToNum solving when:

✅ **Solutions are found successfully**
✅ **Results are numeric and finite**
✅ **No Failure objects returned**

They become problems only when:

❌ **No solution found** (returns Failure or $Failed)
❌ **Solver fails to converge**
❌ **Results are unevaluated or symbolic**

---

## How to Suppress

If you've **verified results are correct** and want to suppress warnings:

```wolfram
(* Suppress specific warnings *)
Quiet[
  ToNum["Rules", model],
  {LinearProgramming::lpsub, Reduce::ratnz, FindRoot::njnum}
]

(* Suppress all warnings *)
Quiet[ToNum["Rules", model]]
```

⚠️ **WARNING:** Only suppress after verifying results. Don't use suppression to hide actual errors.

---

## Background

These examples were created during comprehensive testing of ToNum/toNum functions (Phase 9):
- **5,879 messages** captured during testing
- **2,914 messages** classified as "unexpected"
- **All "unexpected" messages are actually NORMAL solver warnings**
- Complete analysis in `Tests/Integration/ToNumber/PHASES_9_10_DETAILED_EXPLANATION.md`

---

## Related Documentation

- **Test Summary:** `Tests/Integration/ToNumber/TEST_SUMMARY.md`
- **Detailed Explanation:** `Tests/Integration/ToNumber/PHASES_9_10_DETAILED_EXPLANATION.md`
- **Test README:** `Tests/Integration/ToNumber/README.md`

---

## Commits

- MRE examples created: d69ea39
- Moved to docs/: (current commit)

**Status:** ✅ All warning types documented with working examples
