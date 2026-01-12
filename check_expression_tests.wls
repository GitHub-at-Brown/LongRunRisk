#!/usr/bin/env wolframscript

Needs["PacletTools`"];
PacletDirectoryLoad["."];

Print["Running all tests..."];
report = TestReport["Tests/Tools/ToNumber.wlt"];

failed = Select[Values[report["TestResults"]], #["Outcome"] =!= "Success" &];
Print["Total failed: ", Length[failed]];

(* Filter for expression evaluation tests *)
filteredFailed = Select[failed, StringContainsQ[#["TestID"], "All expression types evaluate to numbers" | "Composite arithmetic expressions evaluate to numbers"] &];
Print["Expression evaluation tests failed: ", Length[filteredFailed]];

Do[
  Print["  - ", test["TestID"], ": ", test["Outcome"]];
  If[KeyExistsQ[test, "ExpectedMessages"] || KeyExistsQ[test, "ActualMessages"],
    Print["    Expected messages: ", test["ExpectedMessages"]];
    Print["    Actual messages: ", test["ActualMessages"]];
  ];
  ,
  {test, filteredFailed}
];
