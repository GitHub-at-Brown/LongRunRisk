#!/usr/bin/env wolframscript
(* ::Package:: *)

(*
 * RunTests.wls
 *
 * Run all individual split test files with TestReport to verify they work.
 * This tests the split files WITHOUT coverage instrumentation.
 *)

Print["=" StringRepeat["=", 69]];
Print["Running Split Test Files - No Coverage"];
Print["=" StringRepeat["=", 69]];
Print[];

(* === Path Setup === *)
scriptDir = DirectoryName[$InputFileName];
testsRoot = DirectoryName[scriptDir];
pacletRoot = DirectoryName[testsRoot];

Print["Script directory: ", scriptDir];
Print["Tests root: ", testsRoot];
Print["Paclet root: ", pacletRoot];
Print[];

(* === Load the paclet === *)
Print["Loading paclet from: ", pacletRoot];
PacletDirectoryLoad[pacletRoot];
Print["Paclet loaded"];
Print[];

(* === Find all individual test files === *)
testFiles = FileNames["*_test*.wlt", scriptDir, Infinity];
testFiles = Sort[testFiles];

Print["Found ", Length[testFiles], " individual test files"];
Print[];

(* === Run tests === *)
Print["Running tests..."];
Print["This will take a few minutes..."];
Print[];

startTime = AbsoluteTime[];

report = TestReport[testFiles, "ProgressReporting" -> True];

endTime = AbsoluteTime[];
elapsedTime = endTime - startTime;

Print[];
Print["Tests complete in ", Round[elapsedTime], " seconds"];
Print[];

(* === Analyze results === *)
totalTests = report["TestsRunCount"];
totalPassed = report["TestsSucceededCount"];
totalFailed = report["TestsFailedCount"];

Print["=" StringRepeat["=", 69]];
Print["Results"];
Print["=" StringRepeat["=", 69]];
Print["Total tests: ", totalTests];
Print["Passed: ", totalPassed];
Print["Failed: ", totalFailed];
Print[];

If[totalFailed > 0,
  Print["Failed tests:"];
  failedTests = Select[Values[report["TestResults"]], #["Outcome"] === "Failure" &];
  Do[
    Print["  - ", failed["TestFileName"]];
    Print["    TestID: ", failed["TestID"]],
    {failed, Take[failedTests, UpTo[10]]}
  ];
  Print[];
  If[Length[failedTests] > 10,
    Print["  ... and ", Length[failedTests] - 10, " more"];
    Print[]
  ]
];

Print["=" StringRepeat["=", 69]];
Print["Done!"];
Print["=" StringRepeat["=", 69]];
Print[];

If[totalFailed > 0,
  Quit[1],
  Quit[0]
]
