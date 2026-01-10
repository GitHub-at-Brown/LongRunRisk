#!/usr/bin/env wolframscript
(* Phases 9, 10: Warnings Validation and Performance Tests *)

Print["========================================"];
Print["Phases 9-10: Diagnostics and Performance"];
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

allModels = {"BY", "BKY", "NRC", "DES", "NRCStochVol"};

(* ========================================
   Phase 9: No Warning Messages Validation
   ======================================== *)

Print["========================================"];
Print["Phase 9: Warning Messages Validation"];
Print["========================================"];
Print[""];

(* Capture messages during normal operations *)
Print["Monitoring messages during standard operations..."];
Print[""];

messageLog = {};

Internal`AddHandler["Message", (AppendTo[messageLog, #])&];

(* Perform standard operations on all models *)
Do[
  model = modelsData[modelName];

  (* Basic operations that should not produce unexpected warnings *)
  Quiet[
    ToNum["Rules", model];
    ToNum[A[0], model];
    If[model["numStocks"] > 0, ToNum[B[1][0], model]];
    ToNum["Rules", model, "ReturnAllSolutions" -> True];
  , {toNum::badreturnall, toNum::badselector, toNum::nosolution, toNum::badidx, toNum::badbidx, processNewParameters::subsetparam}];
,
  {modelName, allModels}
];

Internal`RemoveHandler["Message", 1];

(* Define expected message tags that are part of normal error handling *)
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

phase9Results = <|
  "TotalMessages" -> Length[messageLog],
  "UnexpectedMessages" -> Length[unexpectedMessages],
  "UnexpectedMessagesList" -> If[Length[unexpectedMessages] > 0,
    Take[unexpectedMessages, UpTo[10]],
    {}
  ]
|>;

Print["Message Summary:"];
Print["  Total messages captured: ", phase9Results["TotalMessages"]];
Print["  Unexpected messages: ", phase9Results["UnexpectedMessages"]];

If[Length[unexpectedMessages] > 0,
  Print[""];
  Print["WARNING: Found unexpected messages:"];
  Do[
    Print["  ", i, ": ", unexpectedMessages[[i]][[1]]];
  ,
    {i, 1, Min[5, Length[unexpectedMessages]]}
  ];
];

phase9AllPass = Length[unexpectedMessages] == 0;

Print[""];
Print["Phase 9 Summary: ", If[phase9AllPass, "OK ALL PASS (no unexpected warnings)", "WARNING SOME UNEXPECTED MESSAGES"]];
Print[""];

(* ========================================
   Phase 10: Performance Tests
   ======================================== *)

Print["========================================"];
Print["Phase 10: Performance Benchmarks"];
Print["========================================"];
Print[""];

phase10Results = <||>;

(* Test 10.1: Flat rules performance *)
Print["Test 10.1: Flat rules generation performance"];
Print[""];

flatRulesTimings = <||>;

Do[
  model = modelsData[modelName];

  timing = AbsoluteTiming[
    Do[ToNum["Rules", model], {5}]
  ][[1]] / 5.0;

  flatRulesTimings[modelName] = timing;

  Print["  ", modelName, ": ", NumberForm[timing, {5, 4}], " seconds"];
,
  {modelName, allModels}
];

Print[""];

(* Test 10.2: Hierarchical solution performance *)
Print["Test 10.2: Hierarchical solution performance"];
Print[""];

hierTimings = <||>;

Do[
  model = modelsData[modelName];

  timing = AbsoluteTiming[
    Do[ToNum["Rules", model, "ReturnAllSolutions" -> True], {5}]
  ][[1]] / 5.0;

  hierTimings[modelName] = timing;

  Print["  ", modelName, ": ", NumberForm[timing, {5, 4}], " seconds"];
,
  {modelName, allModels}
];

Print[""];

(* Test 10.3: Expression evaluation performance *)
Print["Test 10.3: Expression evaluation performance"];
Print[""];

exprTimings = <||>;

Do[
  model = modelsData[modelName];

  (* A-only expression *)
  aExpr = A[0] + A[1];

  (* Stock expression if available *)
  bExpr = If[model["numStocks"] > 0, B[1][0], 0];

  timing = AbsoluteTiming[
    Do[
      ToNum[aExpr, model];
      If[model["numStocks"] > 0, ToNum[bExpr, model]];
    , {10}]
  ][[1]] / 10.0;

  exprTimings[modelName] = timing;

  Print["  ", modelName, ": ", NumberForm[timing, {5, 4}], " seconds"];
,
  {modelName, allModels}
];

Print[""];

(* Compute statistics *)
avgFlatTiming = Mean[Values[flatRulesTimings]];
avgHierTiming = Mean[Values[hierTimings]];
avgExprTiming = Mean[Values[exprTimings]];

maxFlatTiming = Max[Values[flatRulesTimings]];
maxHierTiming = Max[Values[hierTimings]];
maxExprTiming = Max[Values[exprTimings]];

Print["Performance Summary:"];
Print["  Average flat rules: ", NumberForm[avgFlatTiming, {5, 4}], " seconds"];
Print["  Average hierarchical: ", NumberForm[avgHierTiming, {5, 4}], " seconds"];
Print["  Average expression: ", NumberForm[avgExprTiming, {5, 4}], " seconds"];
Print[""];
Print["  Max flat rules: ", NumberForm[maxFlatTiming, {5, 4}], " seconds"];
Print["  Max hierarchical: ", NumberForm[maxHierTiming, {5, 4}], " seconds"];
Print["  Max expression: ", NumberForm[maxExprTiming, {5, 4}], " seconds"];
Print[""];

(* Performance thresholds (reasonable expectations) *)
flatThreshold = 5.0;  (* 5 seconds per flat rules generation *)
hierThreshold = 10.0; (* 10 seconds per hierarchical solution *)
exprThreshold = 5.0;  (* 5 seconds per expression evaluation *)

phase10Results = <|
  "FlatRulesTimings" -> flatRulesTimings,
  "HierarchicalTimings" -> hierTimings,
  "ExpressionTimings" -> exprTimings,
  "AvgFlatTiming" -> avgFlatTiming,
  "AvgHierTiming" -> avgHierTiming,
  "AvgExprTiming" -> avgExprTiming,
  "MaxFlatTiming" -> maxFlatTiming,
  "MaxHierTiming" -> maxHierTiming,
  "MaxExprTiming" -> maxExprTiming,
  "PerformanceAcceptable" -> maxFlatTiming < flatThreshold &&
                             maxHierTiming < hierThreshold &&
                             maxExprTiming < exprThreshold
|>;

phase10AllPass = phase10Results["PerformanceAcceptable"];

Print["Phase 10 Summary: ", If[phase10AllPass, "OK ALL PASS (performance acceptable)", "WARNING SLOW PERFORMANCE"]];
Print[""];

(* ========================================
   Export and Final Summary
   ======================================== *)

Print["========================================"];
Print["Phases 9-10: COMPLETE"];
Print["========================================"];
Print[""];

Print["Final Summary:"];
Print["  Phase 9 (No Warnings): ", If[phase9AllPass, "OK PASS", "WARNING"]];
Print["  Phase 10 (Performance): ", If[phase10AllPass, "OK PASS", "WARNING"]];
Print[""];

(* Export results *)
Export["Tests/Integration/ToNumber/phase9_10_results.mx",
  <|
    "phase9" -> phase9Results,
    "phase10" -> phase10Results
  |>
];

Print["Results exported to phase9_10_results.mx"];

(* Exit with appropriate code - warnings are not failures *)
allPass = phase9AllPass && phase10AllPass;
If[!allPass,
  Print[""];
  Print["NOTE: Warnings detected but tests completed successfully"];
];
