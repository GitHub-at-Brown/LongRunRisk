#!/usr/bin/env wolframscript

Needs["PacletTools`"];
PacletDirectoryLoad["."];

Print["Running tests..."];
report = TestReport["Tests/Tools/ToNumber.wlt"];

failed = Select[Values[report["TestResults"]], #["Outcome"] =!= "Success" &];
Print["Total failed: ", Length[failed]];

(* Check specific expression evaluation tests *)
exprTests = {
  "[toNum] All expression types evaluate to numbers for NRC model",
  "[toNum] Composite arithmetic expressions evaluate to numbers",
  "[toNum] All expression types evaluate to numbers for BKY model"
};

Print["\nExpression evaluation test results:"];
Do[
  If[KeyExistsQ[report["TestResults"], testID],
    Print["  ", testID, ": ", report["TestResults"][testID]["Outcome"]],
    Print["  ", testID, ": NOT FOUND"]
  ];
  ,
  {testID, exprTests}
];
