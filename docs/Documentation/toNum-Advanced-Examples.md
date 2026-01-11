### Override a single parameter and verify it changes in the output rules:

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

### Override multiple parameters simultaneously:

```mathematica
testModel = Models["BY"];
baseRules = ToNum["Rules", testModel];

(* Override multiple parameters *)
multiOverride = ToNum["Rules", testModel, {gamma -> 12.0, psi -> 2.5}];

(* Verify overrides are applied *)
multiOverride =!= baseRules
(* Expected output: True *)
```

### Use parameter overrides when evaluating expressions:

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

### When you provide a parameter name that isn't in the model's parameter set:

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

### The override parameters must be provided with symbol keys, not string keys:

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

### A complex expression combining multiple terms across different state variables:

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

### Invalid values for `ReturnAllSolutions` option:

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

### Check basic properties that all models should satisfy:

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

### Each model has specific characteristics:

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

### Testing B-expressions (stock indices) across models:

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

### Combining multiple expression types:

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
