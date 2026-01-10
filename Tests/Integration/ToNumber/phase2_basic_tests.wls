#!/usr/bin/env wolframscript
(* Phase 2: Basic Functionality Tests *)

Print["========================================"];
Print["Phase 2: Basic Functionality Tests"];
Print["========================================"];
Print[""];

(* Load paclet *)
Needs["FernandoDuarte`LongRunRisk`"];

(* Import models and helpers from previous phases *)
If[!FileExistsQ["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Integration/ToNumber/modelsData.mx"],
  Print["ERROR: modelsData.mx not found. Run phase1_setup.wls first."];
  Exit[1]
];

If[!FileExistsQ["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Integration/ToNumber/helpers.mx"],
  Print["ERROR: helpers.mx not found. Run phase1b_helpers.wls first."];
  Exit[1]
];

modelsData = Import["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Integration/ToNumber/modelsData.mx"];
helpers = Import["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Integration/ToNumber/helpers.mx"];

realFiniteNumberQ = helpers["realFiniteNumberQ"];
validateFlatRules = helpers["validateFlatRules"];
validateHierarchicalStructure = helpers["validateHierarchicalStructure"];

Print["OK Models and helpers imported"];
Print[""];

(* Representative model subset as per plan *)
testModels = {"BY", "NRC", "DES"};

Print["========================================"];
Print["Phase 2.1: Compute and Cache Solutions"];
Print["========================================"];
Print[""];

cachedSolutions = <||>;

Do[
  model = modelsData[modelName];
  Print["Computing hierarchical solution for ", modelName, "..."];

  cachedSolutions[modelName] = ToNum["Rules", model, "ReturnAllSolutions" -> True];

  Print["  Result: ", Head[cachedSolutions[modelName]]];
  Print["  Length: ", Length[cachedSolutions[modelName]]];
  If[Length[cachedSolutions[modelName]] > 0 && AssociationQ[cachedSolutions[modelName][[1]]],
    Print["  Keys: ", Keys[cachedSolutions[modelName][[1]]]]
  ];
  Print[""];
,
  {modelName, testModels}
];

Print["OK Hierarchical solutions cached for ", Length[testModels], " models"];
Print[""];

Print["========================================"];
Print["Phase 2.2: Flat Rules Validation"];
Print["========================================"];
Print[""];

flatResults = <||>;

Do[
  model = modelsData[modelName];
  rules = ToNum["Rules", model];

  checks = validateFlatRules[rules];

  flatResults[modelName] = <|
    "RuleCount" -> If[ListQ[rules], Length[rules], 0],
    "Valid" -> !FailureQ[checks],
    "HasACoeffs" -> If[ListQ[rules], AnyTrue[rules, MatchQ[#[[1]], A[_]] &], False],
    "HasBCoeffs" -> If[ListQ[rules], AnyTrue[rules, MatchQ[#[[1]], B[_][_]] &], False]
  |>;

  Print[modelName, " flat rules:"];
  Print["  Count: ", flatResults[modelName]["RuleCount"]];
  Print["  Valid: ", If[flatResults[modelName]["Valid"], "OK", "FAIL"]];
  Print["  Has A coeffs: ", If[flatResults[modelName]["HasACoeffs"], "OK", "FAIL"]];
  Print["  Has B coeffs: ", If[flatResults[modelName]["HasBCoeffs"], "OK", "FAIL"]];
  Print[""];
,
  {modelName, testModels}
];

Print["Flat Rules Summary: ",
  If[AllTrue[flatResults, #["Valid"] &], "OK ALL PASS", "FAIL SOME FAIL"]
];
Print[""];

Print["========================================"];
Print["Phase 2.3: Expression Evaluation"];
Print["========================================"];
Print[""];

exprResults = <||>;

Do[
  model = modelsData[modelName];

  Print["Testing ", modelName, "..."];

  (* A-only expression *)
  exprA = A[0] + A[1];
  resultA = ToNum[exprA, model];
  Print["  A-only (A[0] + A[1]): ", If[NumericQ[resultA], N[resultA, 5], Head[resultA]]];

  (* Stock-dependent expression - only if model has stocks *)
  numStocks = modelsData[modelName]["numStocks"];
  If[numStocks > 0,
    exprB = B[1][0] + B[1][1];
    resultB = ToNum[exprB, model];
    Print["  Stock-dep (B[1][0] + B[1][1]): ", If[NumericQ[resultB], N[resultB, 5], Head[resultB]]];
  ];

  (* Mixed expression - only for multi-stock models *)
  If[numStocks >= 2,
    exprMixed = A[0] + B[1][0] + B[2][0];
    resultMixed = ToNum[exprMixed, model];
    Print["  Mixed (A[0] + B[1][0] + B[2][0]): ", If[NumericQ[resultMixed], N[resultMixed, 5], Head[resultMixed]]];
  ];

  exprResults[modelName] = <|
    "A_Only_OK" -> NumericQ[resultA],
    "A_Only_Value" -> If[NumericQ[resultA], N[resultA, 5], "unevaluated"]
  |>;

  Print[""];
,
  {modelName, testModels}
];

Print["Expression Evaluation Summary: ",
  If[AllTrue[exprResults, #["A_Only_OK"] &], "OK ALL PASS", "FAIL SOME FAIL"]
];
Print[""];

Print["========================================"];
Print["Phase 2: COMPLETE"];
Print["========================================"];
Print[""];

Print["Final Summary:"];
Print["  Flat Rules: ", If[AllTrue[flatResults, #["Valid"] &], "OK PASS", "FAIL FAIL"]];
Print["  Expression Eval: ", If[AllTrue[exprResults, #["A_Only_OK"] &], "OK PASS", "FAIL FAIL"]];
Print[""];

(* Export results *)
Export["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Integration/ToNumber/phase2_results.mx",
  <|
    "cachedSolutions" -> cachedSolutions,
    "flatResults" -> flatResults,
    "exprResults" -> exprResults
  |>
];

Print["Results exported to phase2_results.mx"];

(* Exit with appropriate code *)
allPass = AllTrue[flatResults, #["Valid"] &] && AllTrue[exprResults, #["A_Only_OK"] &];
If[!allPass, Exit[1]];
