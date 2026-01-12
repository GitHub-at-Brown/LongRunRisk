#!/usr/bin/env wolframscript

Needs["PacletTools`"];
PacletDirectoryLoad["."];

Print["Running tests..."];
report = TestReport["Tests/Tools/ToNumber.wlt"];

failed = Select[Values[report["TestResults"]], #["Outcome"] =!= "Success" &];
Print["Total failed: ", Length[failed]];

Print["\nFailed test details:"];
Do[
  Print["\n--- Test ", i, " ---"];
  Print["TestID: ", test["TestID"]];
  Print["Outcome: ", test["Outcome"]];
  If[KeyExistsQ[test, "ExpectedMessages"],
    Print["Expected Messages: ", test["ExpectedMessages"]]];
  If[KeyExistsQ[test, "ActualMessages"],
    Print["Actual Messages: ", test["ActualMessages"]]];
  ,
  {i, 1, Min[5, Length[failed]]},
  {test, {failed[[i]]}}
];

Print["\n\nGrouping failures by type:"];
messageFailures = Select[failed, #["Outcome"] == "MessagesFailure" &];
outputFailures = Select[failed, #["Outcome"] == "Failure" &];
Print["MessagesFailure: ", Length[messageFailures]];
Print["Output Failure: ", Length[outputFailures]];
