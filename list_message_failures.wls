#!/usr/bin/env wolframscript

Needs["PacletTools`"];
PacletDirectoryLoad["."];

Print["Running tests..."];
report = TestReport["Tests/Tools/ToNumber.wlt"];

messageFailures = Select[Values[report["TestResults"]], #["Outcome"] == "MessagesFailure" &];
Print["Total MessagesFailure: ", Length[messageFailures]];

Print["\nAll MessagesFailure tests:"];
Do[
  Print[i, ". ", test["TestID"]];
  Print["   Expected: ", test["ExpectedMessages"]];
  Print["   Actual: ", test["ActualMessages"]];
  ,
  {i, 1, Length[messageFailures]},
  {test, {messageFailures[[i]]}}
];
