# ToNum Advanced Examples

This document contains advanced, complex, and performance-intensive examples of the `ToNum` function that are not included in the main `toNum-Additional-Examples.nb` due to their length, complexity, or computational intensity. These examples showcase real-world usage patterns and stress tests from the integration test suite.

## Overview

The examples in this document are organized by category:

1. **Phase 6**: Parameter Override Tests - Multiple parameters, complex override patterns
2. **Phase 7**: Edge Cases and Error Conditions - Invalid inputs, string keys, large expressions
3. **Phase 8**: Model-Specific Comprehensive Tests - Validation across all 5 models
4. **Phase 9**: Warning Validation - Diagnostic message handling
5. **Phase 10**: Performance Benchmarks - Timing measurements and thresholds

---

## Phase 6: Parameter Override Tests

Parameter overrides allow you to supply custom values for model parameters when generating rules or evaluating expressions. These examples demonstrate advanced override patterns beyond the basic examples in the notebook.

### Test 6.1: Single Parameter Override with Symbol Keys

Override a single parameter and verify it changes in the output rules:

```mathematica
(* Load test model *)
testModel = Models["BY"];

(* Generate base rules *)
baseRules = ToNum["Rules", testModel];

(* Generate rules with gamma override *)
overrideRules = ToNum["Rules", testModel, {gamma -> 15.0}];

(* Extract and compare gamma values *)
gammaBase = Cases[baseRules, HoldPattern[gamma -> v_] :> v, Infinity];
gammaOverride = Cases[overrideRules, HoldPattern[gamma -> v_] :> v, Infinity];

(* Verify the override worked *)
If[Length[gammaBase] > 0 && Length[gammaOverride] > 0,
  gammaBase[[1]] != gammaOverride[[1]],
  False
]
(* Expected output: True *)
```

### Test 6.2: Multiple Parameter Override

Override multiple parameters simultaneously:

```mathematica
testModel = Models["BY"];
baseRules = ToNum["Rules", testModel];

(* Override multiple parameters *)
multiOverride = ToNum["Rules", testModel, {gamma -> 12.0, psi -> 2.5}];

(* Verify overrides are applied *)
multiOverride =!= baseRules
(* Expected output: True *)
```

### Test 6.3: Expression Evaluation with Parameter Override

Use parameter overrides when evaluating expressions:

```mathematica
testModel = Models["BY"];

(* Evaluate expression with base parameters *)
exprTest = A[0] + A[1];
baseExprValue = ToNum[exprTest, testModel];

(* Evaluate same expression with parameter override *)
overrideExprValue = ToNum[exprTest, testModel, {gamma -> 20.0}];

(* Results should differ due to parameter change *)
{baseExprValue, overrideExprValue, baseExprValue != overrideExprValue}
(* Expected: {numeric1, numeric2, True} *)
```

---

## Phase 7: Edge Cases and Error Conditions

These examples demonstrate error handling and edge cases, showing what happens when invalid inputs are provided.

### Test 7.1: Invalid Parameter Names

When you provide a parameter name that isn't in the model's parameter set:

```mathematica
testModel = Models["BY"];

(* This will abort - invalidParameterName doesn't exist *)
result = CheckAbort[
  ToNum["Rules", testModel, {invalidParameterName -> 1.0}],
  $Aborted
];

result === $Aborted
(* Expected output: True - operation aborted as expected *)
```

**Expected behavior**: The system detects the invalid parameter name and aborts with a `processNewParameters::subsetparam` message indicating the parameter is not a valid subset.

### Test 7.2: String Keys vs Symbol Keys

The override parameters must be provided with symbol keys, not string keys:

```mathematica
testModel = Models["BY"];

(* This fails - string keys are not accepted *)
stringKeyResult = CheckAbort[
  ToNum["Rules", testModel, {"gamma" -> 15.0}],
  $Aborted
];

(* Check for failure *)
stringKeyResult === $Aborted || FailureQ[stringKeyResult]
(* Expected output: True *)
```

**Expected behavior**: String keys cannot be used for parameter overrides; use symbol keys instead.

### Test 7.3: Large Expression Stress Test

A complex expression combining multiple terms across different state variables:

```mathematica
testModel = Models["BY"];

(* Large stress test expression *)
largeExpr = Sum[A[i], {i, 0, 2}] + B[1][0] + B[1][1] + B[1][2];

(* Evaluate the expression *)
largeResult = ToNum[largeExpr, testModel];

(* Verify result is numeric and valid *)
{NumericQ[largeResult], !FailureQ[largeResult]}
(* Expected output: {True, True} *)
```

**Performance note**: This expression combines summation over multiple A indices with multiple B indices, testing the robustness of the evaluation engine with complex nested structures.

### Test 7.4: Invalid Option Values

Invalid values for `ReturnAllSolutions` option:

```mathematica
testModel = Models["BY"];

(* String value - should fail *)
invalidRAS1 = ToNum["Rules", testModel, "ReturnAllSolutions" -> "true"];

(* Integer value - should fail *)
invalidRAS2 = ToNum["Rules", testModel, "ReturnAllSolutions" -> 1];

(* Both should produce failures *)
{FailureQ[invalidRAS1], FailureQ[invalidRAS2]}
(* Expected output: {True, True} *)
```

**Valid values**: Only `True` or `False` are accepted for the `ReturnAllSolutions` option.

---

## Phase 8: Model-Specific Comprehensive Tests

Comprehensive validation across all 5 models, checking model-specific properties and behaviors.

### Test 8.1: Universal Model Properties

Check basic properties that all models should satisfy:

```mathematica
allModels = {"BY", "BKY", "NRC", "DES", "NRCStochVol"};

(* For each model *)
Do[
  model = Models[modelName];

  (* Model properties *)
  numStocks = model["numStocks"];
  numStates = Length[model["stateVars"]];

  (* Basic ToNum operations *)
  rulesTest = ToNum["Rules", model];
  hierTest = ToNum["Rules", model, "ReturnAllSolutions" -> True];

  (* Expression evaluation *)
  aExpr = A[0];
  aResult = ToNum[aExpr, model];

  Print[modelName, " - Stocks: ", numStocks,
        ", States: ", numStates,
        ", Rules valid: ", MatchQ[rulesTest, {__Rule}],
        ", Hierarchical valid: ", MatchQ[hierTest, {__Association}],
        ", A[0] numeric: ", NumericQ[aResult]
  ];
,
  {modelName, allModels}
]
```

**Expected output**: All models should:
- Have valid flat rules (list of Rule objects)
- Have valid hierarchical solutions (list of Association objects)
- Evaluate expressions to numeric values

### Test 8.2: Model-Specific Type Annotations

Each model has specific characteristics:

```mathematica
(* BY model - Long-Run Risk *)
by = Models["BY"];
(* Properties: 1 stock, long-run risk component *)
{by["numStocks"], "LongRunRisk"}

(* BKY model - Long-Run Risk (multi-stock) *)
bky = Models["BKY"];
(* Properties: 2 stocks, long-run risk component *)
{bky["numStocks"], "LongRunRisk"}

(* NRC model - Nominal-Real Covariance *)
nrc = Models["NRC"];
(* Properties: 3 stocks, no long-run risk *)
{nrc["numStocks"], "NominalRealCovariance"}

(* DES model - LRR + NRC *)
des = Models["DES"];
(* Properties: 7 states, long-run risk + nominal-real *)
{Length[des["stateVars"]], "LRR+NRC"}

(* NRCStochVol model - NRC with Stochastic Volatility *)
stochvol = Models["NRCStochVol"];
(* Properties: stochastic volatility extension *)
{stochvol["numStocks"], "StochasticVolatility"}
```

### Test 8.3: Stock-Dependent Expression Evaluation

Testing B-expressions (stock indices) across models:

```mathematica
allModels = {"BY", "BKY", "NRC", "DES", "NRCStochVol"};

Do[
  model = Models[modelName];

  If[model["numStocks"] > 0,
    (* Evaluate B-expression for stock 1 *)
    bExpr = B[1][0];
    bResult = ToNum[bExpr, model];
    numStocks = model["numStocks"];

    Print[modelName, " - NumStocks: ", numStocks,
          ", B[1][0] numeric: ", NumericQ[bResult]
    ];
  ,
    Print[modelName, " - No stocks in model"]
  ];
,
  {modelName, allModels}
]
```

---

## Phase 9: Warning Validation

Diagnostic testing to ensure that expected error messages are produced correctly and no unexpected warnings appear during normal operations.

### Test 9.1: Message Capture and Filtering

Capture and filter messages during normal operations:

```mathematica
allModels = {"BY", "BKY", "NRC", "DES", "NRCStochVol"};
messageLog = {};

(* Set up message handler *)
Internal`AddHandler["Message", (AppendTo[messageLog, #])&];

(* Perform operations on all models *)
Do[
  model = Models[modelName];

  (* These operations should not produce unexpected warnings *)
  Quiet[
    ToNum["Rules", model];
    ToNum[A[0], model];
    If[model["numStocks"] > 0, ToNum[B[1][0], model]];
    ToNum["Rules", model, "ReturnAllSolutions" -> True];
  , {toNum::badreturnall, toNum::badselector, toNum::nosolution,
     toNum::badidx, toNum::badbidx, processNewParameters::subsetparam}];
,
  {modelName, allModels}
];

Internal`RemoveHandler["Message", 1];

(* Define expected message types *)
expectedMessageTags = {
  toNum::badreturnall,
  toNum::badselector,
  toNum::nosolution,
  toNum::badidx,
  toNum::badbidx,
  processNewParameters::subsetparam
};

(* Filter out expected messages *)
unexpectedMessages = Select[messageLog,
  !MemberQ[expectedMessageTags, #[[1]]] &
];

(* Report *)
{Length[messageLog], Length[unexpectedMessages]}
(* Expected: Total messages captured, 0 unexpected *)
```

### Test 9.2: Expected Message Tags

The following message tags are expected during error conditions:

- `toNum::badreturnall` - Invalid value for `ReturnAllSolutions` option
- `toNum::badselector` - Invalid selector specification
- `toNum::nosolution` - No solution found matching selector
- `toNum::badidx` - Invalid index for A terms
- `toNum::badbidx` - Invalid index for B terms
- `processNewParameters::subsetparam` - Parameter override not in parameter set

Any other message types would indicate unexpected behavior.

---

## Phase 10: Performance Benchmarks

Performance testing and timing measurements across all models. These benchmarks establish baseline expectations for performance.

### Test 10.1: Flat Rules Generation Performance

Timing how long it takes to generate flat (non-hierarchical) rules for each model:

```mathematica
allModels = {"BY", "BKY", "NRC", "DES", "NRCStochVol"};
flatRulesTimings = <||>;

Do[
  model = Models[modelName];

  (* Time 5 iterations and average *)
  timing = AbsoluteTiming[
    Do[ToNum["Rules", model], {5}]
  ][[1]] / 5.0;

  flatRulesTimings[modelName] = timing;

  Print[modelName, ": ", NumberForm[timing, {5, 4}], " seconds"];
,
  {modelName, allModels}
];

(* Compute statistics *)
avgFlatTiming = Mean[Values[flatRulesTimings]];
maxFlatTiming = Max[Values[flatRulesTimings]];

Print["Average: ", NumberForm[avgFlatTiming, {5, 4}], " seconds"];
Print["Maximum: ", NumberForm[maxFlatTiming, {5, 4}], " seconds"];
```

**Performance threshold**: Maximum should be under 5 seconds per generation.

**What to expect**:
- BY and BKY (smaller models): ~0.1-0.5 seconds
- NRC and DES (larger models): ~1-3 seconds
- NRCStochVol (extended model): ~2-4 seconds

### Test 10.2: Hierarchical Solution Performance

Timing how long it takes to generate hierarchical solutions with `ReturnAllSolutions -> True`:

```mathematica
allModels = {"BY", "BKY", "NRC", "DES", "NRCStochVol"};
hierTimings = <||>;

Do[
  model = Models[modelName];

  (* Time 5 iterations and average *)
  timing = AbsoluteTiming[
    Do[ToNum["Rules", model, "ReturnAllSolutions" -> True], {5}]
  ][[1]] / 5.0;

  hierTimings[modelName] = timing;

  Print[modelName, ": ", NumberForm[timing, {5, 4}], " seconds"];
,
  {modelName, allModels}
];

(* Compute statistics *)
avgHierTiming = Mean[Values[hierTimings]];
maxHierTiming = Max[Values[hierTimings]];

Print["Average: ", NumberForm[avgHierTiming, {5, 4}], " seconds"];
Print["Maximum: ", NumberForm[maxHierTiming, {5, 4}], " seconds"];
```

**Performance threshold**: Maximum should be under 10 seconds per generation.

**What to expect**:
- Multiple solutions generate hierarchical structures (Associations)
- More complex for larger models
- BY: ~0.2-1 second
- BKY, NRC: ~2-5 seconds
- DES, NRCStochVol: ~5-8 seconds

### Test 10.3: Expression Evaluation Performance

Timing expression evaluation on all models:

```mathematica
allModels = {"BY", "BKY", "NRC", "DES", "NRCStochVol"};
exprTimings = <||>;

Do[
  model = Models[modelName];

  (* A-only expression *)
  aExpr = A[0] + A[1];

  (* Stock expression if available *)
  bExpr = If[model["numStocks"] > 0, B[1][0], 0];

  (* Time 10 iterations and average *)
  timing = AbsoluteTiming[
    Do[
      ToNum[aExpr, model];
      If[model["numStocks"] > 0, ToNum[bExpr, model]];
    , {10}]
  ][[1]] / 10.0;

  exprTimings[modelName] = timing;

  Print[modelName, ": ", NumberForm[timing, {5, 4}], " seconds"];
,
  {modelName, allModels}
];

(* Compute statistics *)
avgExprTiming = Mean[Values[exprTimings]];
maxExprTiming = Max[Values[exprTimings]];

Print["Average: ", NumberForm[avgExprTiming, {5, 4}], " seconds"];
Print["Maximum: ", NumberForm[maxExprTiming, {5, 4}], " seconds"];
```

**Performance threshold**: Maximum should be under 5 seconds per evaluation.

**What to expect**:
- Much faster than rules/solution generation
- Single expression evaluation: ~0.01-0.5 seconds
- Expression evaluation is cached after first use

### Test 10.4: Performance Summary and Thresholds

Comprehensive performance validation:

```mathematica
performanceThresholds = <|
  "FlatRules" -> 5.0,      (* seconds *)
  "Hierarchical" -> 10.0,  (* seconds *)
  "Expression" -> 5.0      (* seconds *)
|>;

performanceAcceptable =
  maxFlatTiming < performanceThresholds["FlatRules"] &&
  maxHierTiming < performanceThresholds["Hierarchical"] &&
  maxExprTiming < performanceThresholds["Expression"];

Print["Performance Acceptable: ", performanceAcceptable];
Print[""];
Print["Detailed Results:"];
Print["  Flat Rules - Max: ", NumberForm[maxFlatTiming, {5, 4}],
      "s (threshold: ", performanceThresholds["FlatRules"], "s)"];
Print["  Hierarchical - Max: ", NumberForm[maxHierTiming, {5, 4}],
      "s (threshold: ", performanceThresholds["Hierarchical"], "s)"];
Print["  Expression - Max: ", NumberForm[maxExprTiming, {5, 4}],
      "s (threshold: ", performanceThresholds["Expression"], "s)"];
```

---

## Complex Expression Examples

### Comprehensive Expression Evaluation

Combining multiple expression types:

```mathematica
(* Set up test model *)
model = Models["NRC"];

(* Example 1: Multiple A terms *)
expr1 = A[0] + 2*A[1] + 3*A[2];
result1 = ToNum[expr1, model];

(* Example 2: Multiple B terms *)
expr2 = B[1][0] + B[1][1] + B[1][2];
result2 = ToNum[expr2, model];

(* Example 3: Mixed A and B terms *)
expr3 = A[0] + A[1] + B[1][0] + B[1][1];
result3 = ToNum[expr3, model];

(* Example 4: With summation *)
expr4 = Sum[A[i], {i, 0, 2}] + Sum[B[1][j], {j, 0, 2}];
result4 = ToNum[expr4, model];

(* Verify all results *)
{NumericQ[result1], NumericQ[result2], NumericQ[result3], NumericQ[result4]}
(* Expected: {True, True, True, True} *)
```

---

## Regression Test Suite

A complete regression test that validates all critical functionality:

```mathematica
regressionTests = <||>;

Do[
  modelName = name;
  model = Models[modelName];

  (* Test each critical feature *)
  tests = <|
    "RulesGeneration" -> (MatchQ[ToNum["Rules", model], {__Rule}]),
    "HierarchicalSolutions" -> (MatchQ[ToNum["Rules", model, "ReturnAllSolutions" -> True], {__Association}]),
    "AExpressionEvaluation" -> (NumericQ[ToNum[A[0], model]]),
    "ComplexExpression" -> (NumericQ[ToNum[Sum[A[i], {i, 0, 2}], model]]),
    "ParameterOverride" -> (ToNum["Rules", model, {gamma -> 10.0}] =!= ToNum["Rules", model]),
    "InvalidParameterAborts" -> (CheckAbort[ToNum["Rules", model, {invalidParam -> 1}], $Aborted] === $Aborted)
  |>;

  If[model["numStocks"] > 0,
    tests["BExpressionEvaluation"] = NumericQ[ToNum[B[1][0], model]]
  ];

  regressionTests[modelName] = tests;
,
  {name, {"BY", "BKY", "NRC", "DES", "NRCStochVol"}}
];

(* Verify all tests pass *)
Do[
  allPass = AllTrue[Values[regressionTests[model]], TrueQ];
  Print[model, ": ", If[allPass, "✓ PASS", "✗ FAIL"]];
,
  {model, {"BY", "BKY", "NRC", "DES", "NRCStochVol"}}
]
```

---

## Summary

These advanced examples represent approximately 5% of the test coverage that is not included in the main `toNum-Additional-Examples.nb` notebook due to:

1. **Performance benchmarking** - Timing measurements require system resources and are not suitable for interactive notebooks
2. **Stress testing** - Complex expressions with summations and multiple indices for durability testing
3. **Error validation** - Comprehensive error condition testing that would clutter the documentation
4. **Diagnostic patterns** - Message handling and logging patterns for integration and CI/CD
5. **Comprehensive model validation** - Full regression test suites across all 5 models

These patterns are preserved in the integration test suite files:
- `Tests/Integration/ToNumber/phase6_8_robustness_tests.wls` - Robustness and model-specific tests
- `Tests/Integration/ToNumber/phase9_10_diagnostics_tests.wls` - Warnings and performance diagnostics

For day-to-day usage, refer to `toNum-Additional-Examples.nb` for practical examples. This document serves as a reference for advanced scenarios and testing patterns.
