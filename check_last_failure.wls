#!/usr/bin/env wolframscript

Needs["PacletTools`"];
PacletDirectoryLoad["."];

Print["Running tests..."];
report = TestReport["Tests/Tools/ToNumber.wlt"];

failed = Select[Values[report["TestResults"]], #["Outcome"] =!= "Success" &];
Print["Failed tests: ", Length[failed]];

If[Length[failed] > 0,
  test = First[failed];
  Print["\nTestID: ", test["TestID"]];
  Print["Outcome: ", test["Outcome"]];
  Print["Expected Messages: ", test["ExpectedMessages"]];
  Print["Actual Messages: ", test["ActualMessages"]];
];
