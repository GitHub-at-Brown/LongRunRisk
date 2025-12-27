# Missing Jacobian Detection Tests

## Overview

This test suite (`fastRootMissingJacobian.wlt`) verifies that the system correctly detects and handles cases where the Jacobian is not available for Newton's method.

## Test Coverage

### Case 1: FunctionOnly Compilation Mode ✓
**Test**: `buildKernel-functiononly-missing-jacobian`
**Covers**: When `buildKernel` is called with `CompileMode -> "FunctionOnly"`, it produces `Missing["NotCompiled"]` for the Jacobian.

```wolfram
kernel = buildKernel[expr, vars, params, CompileMode -> "FunctionOnly"];
(* kernel["dfC"] === Missing["NotCompiled"] *)
```

### Case 2: Detection Logic ✓
**Tests**:
- `missingq-detects-missing-notcompiled` - Verifies `MissingQ[Missing["NotCompiled"]] === True`
- `failureq-detects-failed` - Verifies `FailureQ[$Failed] === True`
- `missingq-does-not-match-failed` - Verifies `MissingQ[$Failed] === False`
- `failureq-does-not-match-missing` - Verifies `FailureQ[Missing["NotCompiled"]] === False`

**Covers**: The detection logic in `SolveEulerEq.wl:846`:
```wolfram
If[MissingQ[savedKernel["dfC"]] || FailureQ[savedKernel["dfC"]],
  df = None
];
```

### Case 3: Both Mode Produces Valid Jacobian ✓
**Test**: `buildKernel-both-has-jacobian`
**Covers**: When `buildKernel` is called with `CompileMode -> "Both"`, it produces a valid compiled Jacobian (not Missing or $Failed).

```wolfram
kernel = buildKernel[expr, vars, params, CompileMode -> "Both"];
(* !MissingQ[kernel["dfC"]] && !FailureQ[kernel["dfC"]] *)
```

## Integration with Full Workflow

The complete workflow is:

1. **buildKernel** creates compiled functions
   - `CompileMode -> "FunctionOnly"` → `dfC = Missing["NotCompiled"]`
   - `CompileMode -> "Both"` → `dfC = CompiledFunction` or `$Failed`

2. **SolveEulerEq** detects Missing/Failed Jacobians:
   ```wolfram
   If[MissingQ[savedKernel["dfC"]] || FailureQ[savedKernel["dfC"]],
     df = None
   ];
   ```

3. **fastRoot** handles `df = None`:
   - 1D: Uses Newton with numerical derivatives (tested in `fastRootNewtonWithoutJacobian.wlt`)
   - nD: Requires explicit Jacobian (performance reasons)

## What These Tests Do NOT Cover

- Full workflow with `bindUnary` + `fastRoot` (too complex, tested elsewhere)
- Actual failed Jacobian compilation producing `$Failed` (hard to trigger reliably)
- Integration with SolveEulerEq (tested via existing model tests)

## Running the Tests

```bash
wolframscript -code 'PacletDirectoryLoad[Directory[]]; TestReport["Tests/FindRootOptim/fastRootMissingJacobian.wlt"]'
```

Expected result: 6/6 tests pass
