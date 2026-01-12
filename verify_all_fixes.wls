#!/usr/bin/env wolframscript

Needs["PacletTools`"];
PacletDirectoryLoad["."];

Print["Running all tests..."];
report = TestReport["Tests/Tools/ToNumber.wlt"];

Print["\n=== Test Summary ==="];
Print["Total: ", Length[report["TestResults"]]];
Print["Passed: ", report["TestsSucceededCount"]];
Print["Failed: ", report["TestsFailedCount"]];
Print["Pass rate: ", N[100 * report["TestsSucceededCount"] / Length[report["TestResults"]]], "%"];

If[report["TestsFailedCount"] > 0,
  Print["\n=== Failed Tests ==="];
  failed = Select[Values[report["TestResults"]], #["Outcome"] =!= "Success" &];
  Do[
    Print[i, ". ", test["TestID"], " (", test["Outcome"], ")"];
    ,
    {i, 1, Min[10, Length[failed]]},
    {test, {failed[[i]]}}
  ];
];
