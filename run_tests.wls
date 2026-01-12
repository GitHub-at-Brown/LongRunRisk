#!/usr/bin/env wolframscript

Needs["PacletTools`"];
PacletDirectoryLoad["."];
Print["Running tests... (this may take several minutes)"];
report = Quiet[TestReport["Tests/Tools/ToNumber.wlt"]];

Print["=== Test Summary ==="];
Print["Total: ", Length[report["TestResults"]]];
Print["Passed: ", report["TestsSucceededCount"]];
Print["Failed: ", report["TestsFailedCount"]];

failed = Select[Values[report["TestResults"]], #["Outcome"] =!= "Success" &];
Print["\n=== Failed Tests (", Length[failed], ") ==="];

Do[
  Print["\nTestID: ", test["TestID"]];
  Print["Outcome: ", test["Outcome"]];
  If[KeyExistsQ[test, "ExpectedMessages"],
    Print["Expected Messages: ", test["ExpectedMessages"]]];
  If[KeyExistsQ[test, "ActualMessages"],
    Print["Actual Messages: ", test["ActualMessages"]]];
  If[KeyExistsQ[test, "ExpectedOutput"],
    Print["Expected: ", Short[test["ExpectedOutput"], 2]]];
  If[KeyExistsQ[test, "ActualOutput"],
    Print["Actual: ", Short[test["ActualOutput"], 2]]];
  ,
  {test, failed}
];
