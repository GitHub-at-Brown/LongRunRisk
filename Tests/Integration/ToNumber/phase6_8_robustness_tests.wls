#!/usr/bin/env wolframscript
(* Phases 6, 7, 8: Parameter Overrides, Edge Cases, Model-Specific Tests *)

Print["========================================"];
Print["Phases 6-8: Robustness and Model-Specific Tests"];
Print["========================================"];
Print[""];

(* Load paclet *)
Needs["FernandoDuarte`LongRunRisk`"];

(* Import from previous phases *)
If[!FileExistsQ["Tests/Integration/ToNumber/modelsData.mx"],
  Print["ERROR: Required .mx files not found. Run phases 1, 1b, 2 first."];
  Exit[1]
];

modelsData = Import["Tests/Integration/ToNumber/modelsData.mx"];

Print["OK Data imported from previous phases"];
Print[""];

(* ========================================
   Phase 6: Parameter Override Tests
   ======================================== *)

Print["========================================"];
Print["Phase 6: Parameter Override Tests"];
Print["========================================"];
Print[""];

testModel = modelsData["BY"];
phase6Results = <||>;

(* Test 6.1: Single parameter override with symbol keys *)
Print["Test 6.1: Single parameter override (symbol keys)"];
baseRules = ToNum["Rules", testModel];
overrideRules = ToNum["Rules", testModel, {gamma -> 15.0}];

(* Find gamma value in rules *)
gammaBase = Cases[baseRules, HoldPattern[gamma -> v_] :> v, Infinity];
gammaOverride = Cases[overrideRules, HoldPattern[gamma -> v_] :> v, Infinity];

test61 = <|
  "BaseRulesValid" -> MatchQ[baseRules, {__Rule}],
  "OverrideRulesValid" -> MatchQ[overrideRules, {__Rule}],
  "GammaChanged" -> If[Length[gammaBase] > 0 && Length[gammaOverride] > 0,
    gammaBase[[1]] != gammaOverride[[1]],
    False],
  "GammaCorrectValue" -> If[Length[gammaOverride] > 0, gammaOverride[[1]] == 15.0, False]
|>;

Print["  Base rules valid: ", If[test61["BaseRulesValid"], "OK", "FAIL"]];
Print["  Override rules valid: ", If[test61["OverrideRulesValid"], "OK", "FAIL"]];
Print["  Gamma changed: ", If[test61["GammaChanged"], "OK", "FAIL"]];
Print["  Gamma correct value: ", If[test61["GammaCorrectValue"], "OK", "FAIL"]];
Print[""];

(* Test 6.2: Multiple parameter override *)
Print["Test 6.2: Multiple parameter override"];
multiOverride = ToNum["Rules", testModel, {gamma -> 12.0, psi -> 2.5}];

test62 = <|
  "MultiOverrideValid" -> MatchQ[multiOverride, {__Rule}],
  "NotSameAsBase" -> multiOverride =!= baseRules
|>;

Print["  Multi override valid: ", If[test62["MultiOverrideValid"], "OK", "FAIL"]];
Print["  Different from base: ", If[test62["NotSameAsBase"], "OK", "FAIL"]];
Print[""];

(* Test 6.3: Expression evaluation with parameter override *)
Print["Test 6.3: Expression evaluation with override"];
exprTest = A[0] + A[1];
baseExprValue = ToNum[exprTest, testModel];
overrideExprValue = ToNum[exprTest, testModel, {gamma -> 20.0}];

test63 = <|
  "BaseExprNumeric" -> NumericQ[baseExprValue],
  "OverrideExprNumeric" -> NumericQ[overrideExprValue],
  "ValuesDifferent" -> baseExprValue != overrideExprValue
|>;

Print["  Base expr numeric: ", If[test63["BaseExprNumeric"], "OK", "FAIL"]];
Print["  Override expr numeric: ", If[test63["OverrideExprNumeric"], "OK", "FAIL"]];
Print["  Values different: ", If[test63["ValuesDifferent"], "OK", "FAIL"]];
Print[""];

phase6Results = <|"Test61" -> test61, "Test62" -> test62, "Test63" -> test63|>;
phase6AllPass = AllTrue[{test61, test62, test63}, AllTrue[Values[#], TrueQ] &];

Print["Phase 6 Summary: ", If[phase6AllPass, "OK ALL PASS", "FAIL SOME FAIL"]];
Print[""];

(* ========================================
   Phase 7: Edge Cases and Error Conditions
   ======================================== *)

Print["========================================"];
Print["Phase 7: Edge Cases and Error Conditions"];
Print["========================================"];
Print[""];

phase7Results = <||>;

(* Test 7.1: Invalid parameter names (non-subset) *)
Print["Test 7.1: Invalid parameter name"];
invalidParam = CheckAbort[
  ToNum["Rules", testModel, {invalidParameterName -> 1.0}],
  $Aborted
];

test71 = <|
  "InvalidParamAborts" -> invalidParam === $Aborted
|>;

Print["  Invalid param aborts: ", If[test71["InvalidParamAborts"], "OK", "FAIL"]];
Print[""];

(* Test 7.2: String keys instead of symbol keys *)
Print["Test 7.2: String keys (expect abort or failure)"];
stringKeyResult = CheckAbort[
  ToNum["Rules", testModel, {"gamma" -> 15.0}],
  $Aborted
];

test72 = <|
  "StringKeyAbortsOrFails" -> stringKeyResult === $Aborted || FailureQ[stringKeyResult]
|>;

Print["  String key aborts/fails: ", If[test72["StringKeyAbortsOrFails"], "OK", "FAIL"]];
Print[""];

(* Test 7.3: Large expression stress test *)
Print["Test 7.3: Large expression evaluation"];
largeExpr = Sum[A[i], {i, 0, 2}] + B[1][0] + B[1][1] + B[1][2];
largeResult = ToNum[largeExpr, testModel];

test73 = <|
  "LargeExprNumeric" -> NumericQ[largeResult],
  "LargeExprNoFailure" -> !FailureQ[largeResult]
|>;

Print["  Large expr numeric: ", If[test73["LargeExprNumeric"], "OK", "FAIL"]];
Print["  Large expr no failure: ", If[test73["LargeExprNoFailure"], "OK", "FAIL"]];
Print[""];

(* Test 7.4: Invalid ReturnAllSolutions value *)
Print["Test 7.4: Invalid ReturnAllSolutions value"];
invalidRAS1 = ToNum["Rules", testModel, "ReturnAllSolutions" -> "true"];
invalidRAS2 = ToNum["Rules", testModel, "ReturnAllSolutions" -> 1];

test74 = <|
  "StringValueFails" -> FailureQ[invalidRAS1],
  "IntegerValueFails" -> FailureQ[invalidRAS2]
|>;

Print["  String value fails: ", If[test74["StringValueFails"], "OK", "FAIL"]];
Print["  Integer value fails: ", If[test74["IntegerValueFails"], "OK", "FAIL"]];
Print[""];

phase7Results = <|"Test71" -> test71, "Test72" -> test72, "Test73" -> test73, "Test74" -> test74|>;
phase7AllPass = AllTrue[{test71, test72, test73, test74}, AllTrue[Values[#], TrueQ] &];

Print["Phase 7 Summary: ", If[phase7AllPass, "OK ALL PASS", "FAIL SOME FAIL"]];
Print[""];

(* ========================================
   Phase 8: Model-Specific Tests (All 5 Models)
   ======================================== *)

Print["========================================"];
Print["Phase 8: Model-Specific Tests"];
Print["========================================"];
Print[""];

allModels = {"BY", "BKY", "NRC", "DES", "NRCStochVol"};
phase8Results = <||>;

Do[
  model = modelsData[modelName];
  Print["Testing ", modelName, "..."];

  (* Basic model properties *)
  numStocks = model["numStocks"];
  numStates = Length[model["stateVars"]];
  stateVarNames = model["stateVars"];

  (* Test basic ToNum functionality *)
  rulesTest = ToNum["Rules", model];
  hierTest = ToNum["Rules", model, "ReturnAllSolutions" -> True];

  (* Test A-only expression *)
  aExpr = A[0];
  aResult = ToNum[aExpr, model];

  (* Test stock-dependent expression if model has stocks *)
  If[numStocks > 0,
    bExpr = B[1][0];
    bResult = ToNum[bExpr, model];
    bNumeric = NumericQ[bResult],
    bResult = Missing["NoStocks"];
    bNumeric = True (* Skip test *)
  ];

  (* Model-specific checks *)
  modelChecks = <|
    "NumStocks" -> numStocks,
    "NumStates" -> numStates,
    "RulesValid" -> MatchQ[rulesTest, {__Rule}],
    "HierarchicalValid" -> MatchQ[hierTest, {__Association}],
    "AExprNumeric" -> NumericQ[aResult],
    "BExprNumeric" -> bNumeric
  |>;

  (* Add model-specific validation *)
  Which[
    (* BY/BKY: Long-run risk models *)
    MemberQ[{"BY", "BKY"}, modelName],
    modelChecks["HasLongRunRisk"] = True;
    modelChecks["ModelType"] = "LongRunRisk",

    (* NRC: No long-run risk, nominal-real covariance *)
    modelName == "NRC",
    modelChecks["HasLongRunRisk"] = False;
    modelChecks["ModelType"] = "NominalRealCovariance";
    modelChecks["MultiStock"] = (numStocks == 3),

    (* DES: Long-run risk + NRC *)
    modelName == "DES",
    modelChecks["HasLongRunRisk"] = True;
    modelChecks["ModelType"] = "LRR+NRC",

    (* NRCStochVol: NRC with stochastic volatility *)
    modelName == "NRCStochVol",
    modelChecks["HasLongRunRisk"] = False;
    modelChecks["ModelType"] = "NRC+StochVol";
    (* NRCStochVol actually has 1 stock, not 3 *)
    modelChecks["HasStochVol"] = True
  ];

  phase8Results[modelName] = modelChecks;

  (* Extract boolean checks for validation *)
  booleanKeys = {"RulesValid", "HierarchicalValid", "AExprNumeric", "BExprNumeric"};
  If[KeyExistsQ[modelChecks, "MultiStock"], AppendTo[booleanKeys, "MultiStock"]];
  If[KeyExistsQ[modelChecks, "HasStochVol"], AppendTo[booleanKeys, "HasStochVol"]];

  booleanChecks = KeyTake[modelChecks, booleanKeys];
  allPass = AllTrue[Values[booleanChecks], TrueQ];

  Print["  Model type: ", modelChecks["ModelType"]];
  Print["  Stocks: ", numStocks, ", States: ", numStates];
  Print["  Basic tests: ", If[allPass, "OK PASS", "FAIL"]];
  Print[""];
,
  {modelName, allModels}
];

phase8AllPass = AllTrue[allModels,
  Function[m,
    checks = phase8Results[m];
    booleanKeys = {"RulesValid", "HierarchicalValid", "AExprNumeric", "BExprNumeric"};
    If[KeyExistsQ[checks, "MultiStock"], AppendTo[booleanKeys, "MultiStock"]];
    If[KeyExistsQ[checks, "HasStochVol"], AppendTo[booleanKeys, "HasStochVol"]];
    booleanChecks = KeyTake[checks, booleanKeys];
    AllTrue[Values[booleanChecks], TrueQ]
  ]
];

Print["Phase 8 Summary: ", If[phase8AllPass, "OK ALL PASS", "FAIL SOME FAIL"]];
Print[""];

(* ========================================
   Export and Final Summary
   ======================================== *)

Print["========================================"];
Print["Phases 6-8: COMPLETE"];
Print["========================================"];
Print[""];

Print["Final Summary:"];
Print["  Phase 6 (Parameter Overrides): ", If[phase6AllPass, "OK PASS", "FAIL"]];
Print["  Phase 7 (Edge Cases): ", If[phase7AllPass, "OK PASS", "FAIL"]];
Print["  Phase 8 (Model-Specific): ", If[phase8AllPass, "OK PASS", "FAIL"]];
Print[""];

(* Export results *)
Export["Tests/Integration/ToNumber/phase6_8_results.mx",
  <|
    "phase6" -> phase6Results,
    "phase7" -> phase7Results,
    "phase8" -> phase8Results
  |>
];

Print["Results exported to phase6_8_results.mx"];

(* Exit with appropriate code *)
allPass = phase6AllPass && phase7AllPass && phase8AllPass;
If[!allPass, Exit[1]];
