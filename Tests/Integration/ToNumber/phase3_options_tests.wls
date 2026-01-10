#!/usr/bin/env wolframscript
(* Phases 3, 4, 5: Option Tests *)

Print["========================================"];
Print["Phases 3-5: Option Tests"];
Print["========================================"];
Print[""];

(* Load paclet *)
Needs["FernandoDuarte`LongRunRisk`"];

(* Import from previous phases *)
If[!FileExistsQ["Tests/Integration/ToNumber/modelsData.mx"] || !FileExistsQ["Tests/Integration/ToNumber/helpers.mx"] || !FileExistsQ["Tests/Integration/ToNumber/phase2_results.mx"],
  Print["ERROR: Required .mx files not found. Run phases 1, 1b, 2 first."];
  Exit[1]
];

modelsData = Import["Tests/Integration/ToNumber/modelsData.mx"];
helpers = Import["Tests/Integration/ToNumber/helpers.mx"];
phase2Results = Import["Tests/Integration/ToNumber/phase2_results.mx"];

realFiniteNumberQ = helpers["realFiniteNumberQ"];
validateHierarchicalStructure = helpers["validateHierarchicalStructure"];
cachedSolutions = phase2Results["cachedSolutions"];

Print["OK Data imported from previous phases"];
Print[""];

testModels = {"BY", "NRC", "DES"};

(* ========================================
   Phase 3: ReturnAllSolutions Deep Validation
   ======================================== *)

Print["========================================"];
Print["Phase 3: ReturnAllSolutions Deep Validation"];
Print["========================================"];
Print[""];

phase3Results = <||>;

Do[
  model = modelsData[modelName];
  sol = cachedSolutions[modelName];

  Print["Testing ", modelName, "..."];

  (* Basic validation *)
  basicValid = validateHierarchicalStructure[sol];

  (* Deep checks *)
  deepChecks = <|
    "NumASolutions" -> Length[sol],
    "FirstAHasNumericValues" -> If[Length[sol] > 0 && AssociationQ[sol[[1]]] && KeyExistsQ[sol[[1]], "A"],
      AllTrue[Flatten[Values[sol[[1]]["A"]]], NumericQ],
      False],
    "StocksHasCorrectIndices" -> If[Length[sol] > 0 && AssociationQ[sol[[1]]] && KeyExistsQ[sol[[1]], "Stocks"],
      Sort[Keys[sol[[1]]["Stocks"]]] === Range[modelsData[modelName]["numStocks"]],
      False],
    "EachStockHasBSolutions" -> If[Length[sol] > 0 && AssociationQ[sol[[1]]] && KeyExistsQ[sol[[1]], "Stocks"],
      AllTrue[Values[sol[[1]]["Stocks"]], ListQ],
      False]
  |>;

  (* Extract boolean checks only for validation *)
  booleanChecks = KeyDrop[deepChecks, "NumASolutions"];

  phase3Results[modelName] = <|
    "BasicValid" -> !FailureQ[basicValid],
    "DeepChecks" -> deepChecks,
    "AllDeepChecksPassed" -> AllTrue[Values[booleanChecks], TrueQ]
  |>;

  Print["  Basic validation: ", If[phase3Results[modelName]["BasicValid"], "OK", "FAIL"]];
  Print["  Deep checks: ", If[phase3Results[modelName]["AllDeepChecksPassed"], "OK", "FAIL"]];
  Print["  Num A solutions: ", deepChecks["NumASolutions"]];
  Print[""];
,
  {modelName, testModels}
];

Print["Phase 3 Summary: ",
  If[AllTrue[phase3Results, #["AllDeepChecksPassed"] &], "OK ALL PASS", "FAIL SOME FAIL"]
];
Print[""];

(* ========================================
   Phase 4: SolutionSelector Tests
   ======================================== *)

Print["========================================"];
Print["Phase 4: SolutionSelector Tests"];
Print["========================================"];
Print[""];

(* Use BY model for selector tests *)
testModel = modelsData["BY"];

(* Test 4.1: Automatic selector *)
Print["Test 4.1: SolutionSelector -> Automatic"];
rulesAuto = ToNum["Rules", testModel, "SolutionSelector" -> Automatic];
rulesDefault = ToNum["Rules", testModel];
test41 = <|
  "SameAsDefault" -> (rulesAuto === rulesDefault),
  "IsFlatRules" -> MatchQ[rulesAuto, {__Rule}]
|>;
Print["  Same as default: ", If[test41["SameAsDefault"], "OK", "FAIL"]];
Print["  Is flat rules: ", If[test41["IsFlatRules"], "OK", "FAIL"]];
Print[""];

(* Test 4.2: All selector with ReturnAllSolutions *)
Print["Test 4.2: SolutionSelector -> All (gating test)"];
solValid = ToNum["Rules", testModel, "ReturnAllSolutions" -> True, "SolutionSelector" -> All];
solInvalid1 = ToNum["Rules", testModel, "SolutionSelector" -> All];
solInvalid2 = ToNum["Rules", testModel, "ReturnAllSolutions" -> False, "SolutionSelector" -> All];

test42 = <|
  "ValidIsHierarchical" -> MatchQ[solValid, {__Association}],
  "InvalidDefaultIsFailure" -> FailureQ[solInvalid1],
  "InvalidExplicitFalseIsFailure" -> FailureQ[solInvalid2]
|>;
Print["  Valid case: ", If[test42["ValidIsHierarchical"], "OK", "FAIL"]];
Print["  Invalid (no ReturnAll): ", If[test42["InvalidDefaultIsFailure"], "OK", "FAIL"]];
Print["  Invalid (explicit False): ", If[test42["InvalidExplicitFalseIsFailure"], "OK", "FAIL"]];
Print[""];

(* Test 4.3: Integer selector *)
Print["Test 4.3: SolutionSelector -> Integer"];
rules1 = ToNum["Rules", testModel, "SolutionSelector" -> 1];
hierSol = ToNum["Rules", testModel, "ReturnAllSolutions" -> True];
numASolutions = Length[hierSol];

test43 = <|
  "FirstSolution" -> MatchQ[rules1, {__Rule}],
  "OutOfRangeFailure" -> FailureQ[ToNum["Rules", testModel, "SolutionSelector" -> 999]]
|>;
Print["  First solution: ", If[test43["FirstSolution"], "OK", "FAIL"]];
Print["  Out of range fails: ", If[test43["OutOfRangeFailure"], "OK", "FAIL"]];
Print["  Total A solutions: ", numASolutions];
Print[""];

(* Test 4.4: Tuple selector {aIdx, bIdx} *)
Print["Test 4.4: SolutionSelector -> {aIdx, bIdx}"];
rulesTuple = ToNum["Rules", testModel, "SolutionSelector" -> {1, 1}];
test44 = <|
  "ValidTuple" -> MatchQ[rulesTuple, {__Rule}],
  "InvalidBIndexFailure" -> FailureQ[ToNum["Rules", testModel, "SolutionSelector" -> {1, 999}]]
|>;
Print["  Valid {1,1}: ", If[test44["ValidTuple"], "OK", "FAIL"]];
Print["  Invalid B index fails: ", If[test44["InvalidBIndexFailure"], "OK", "FAIL"]];
Print[""];

phase4Results = <|
  "Test41" -> test41,
  "Test42" -> test42,
  "Test43" -> test43,
  "Test44" -> test44
|>;

phase4AllPass = AllTrue[{test41, test42, test43, test44}, AllTrue[Values[#], TrueQ] &];
Print["Phase 4 Summary: ", If[phase4AllPass, "OK ALL PASS", "FAIL SOME FAIL"]];
Print[""];

(* ========================================
   Phase 5: Update Options Tests
   ======================================== *)

Print["========================================"];
Print["Phase 5: Update Options Tests"];
Print["========================================"];
Print[""];

(* Test UpdatePd, UpdateBond options *)
Print["Test 5.1: UpdatePd option"];
rulesWithPd = ToNum["Rules", testModel, "UpdatePd" -> True];
rulesWithoutPd = ToNum["Rules", testModel, "UpdatePd" -> False];

test51 = <|
  "WithPdIsValid" -> MatchQ[rulesWithPd, {__Rule}],
  "WithoutPdIsValid" -> MatchQ[rulesWithoutPd, {__Rule}]
|>;
Print["  UpdatePd -> True: ", If[test51["WithPdIsValid"], "OK", "FAIL"]];
Print["  UpdatePd -> False: ", If[test51["WithoutPdIsValid"], "OK", "FAIL"]];
Print[""];

Print["Test 5.2: UpdateBond options"];
rulesWithBond = ToNum["Rules", testModel, "UpdateBond" -> True];
rulesWithNomBond = ToNum["Rules", testModel, "UpdateNomBond" -> True];

test52 = <|
  "UpdateBondWorks" -> MatchQ[rulesWithBond, {__Rule}],
  "UpdateNomBondWorks" -> MatchQ[rulesWithNomBond, {__Rule}]
|>;
Print["  UpdateBond -> True: ", If[test52["UpdateBondWorks"], "OK", "FAIL"]];
Print["  UpdateNomBond -> True: ", If[test52["UpdateNomBondWorks"], "OK", "FAIL"]];
Print[""];

phase5Results = <|"Test51" -> test51, "Test52" -> test52|>;
phase5AllPass = AllTrue[{test51, test52}, AllTrue[Values[#], TrueQ] &];
Print["Phase 5 Summary: ", If[phase5AllPass, "OK ALL PASS", "FAIL SOME FAIL"]];
Print[""];

(* ========================================
   Export and Final Summary
   ======================================== *)

Print["========================================"];
Print["Phases 3-5: COMPLETE"];
Print["========================================"];
Print[""];

Print["Final Summary:"];
Print["  Phase 3 (Deep Validation): ", If[AllTrue[phase3Results, #["AllDeepChecksPassed"] &], "OK PASS", "FAIL"]];
Print["  Phase 4 (SolutionSelector): ", If[phase4AllPass, "OK PASS", "FAIL"]];
Print["  Phase 5 (Update Options): ", If[phase5AllPass, "OK PASS", "FAIL"]];
Print[""];

(* Export results *)
Export["Tests/Integration/ToNumber/phase3_5_results.mx",
  <|
    "phase3" -> phase3Results,
    "phase4" -> phase4Results,
    "phase5" -> phase5Results
  |>
];

Print["Results exported to phase3_5_results.mx"];

(* Exit with appropriate code *)
allPass = AllTrue[phase3Results, #["AllDeepChecksPassed"] &] && phase4AllPass && phase5AllPass;
If[!allPass, Exit[1]];
