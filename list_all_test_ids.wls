#!/usr/bin/env wolframscript

Needs["PacletTools`"];
PacletDirectoryLoad["."];

Print["Running tests..."];
report = TestReport["Tests/Tools/ToNumber.wlt"];

Print["Total tests: ", Length[report["TestResults"]]];
Print["Passed: ", report["TestsSucceededCount"]];
Print["Failed: ", report["TestsFailedCount"]];

(* Find expression-related tests *)
allTestIDs = Keys[report["TestResults"]];
exprTestIDs = Select[allTestIDs, StringContainsQ[#, "expression" | "Expression"] &];

Print["\nExpression-related test IDs:"];
Do[
  outcome = report["TestResults"][testID]["Outcome"];
  Print["  ", testID, ": ", outcome];
  ,
  {testID, exprTestIDs}
];
