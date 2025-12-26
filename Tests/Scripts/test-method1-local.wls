#!/usr/bin/env wolframscript
(*
 * Method 1: Local Testing (Development Environment)
 * Fast iteration during development
 *)

Print["================================================="];
Print["Method 1: Local Testing (Development Environment)"];
Print["=================================================\n"];

pacletBaseDir = "/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-options-refactor";

(* Load paclet to enable resource path resolution *)
Print["Loading paclet from: ", pacletBaseDir];
PacletDirectoryLoad[pacletBaseDir];
Print["Paclet loaded\n"];

(* Find all test files recursively *)
testFileNames = FileNames["*.wlt", FileNameJoin[{pacletBaseDir, "Tests"}], Infinity];
Print["Found ", Length[testFileNames], " test files"];
Print["Test files:"];
Do[Print["  - ", FileNameTake[f]], {f, testFileNames}];
Print[""];

(* Run all tests *)
Print["Running tests..."];
trAll = TestReport[testFileNames];

(* Display results *)
Print["\n================================================="];
Print["Results"];
Print["================================================="];
Print["Total tests: ", trAll["TestsSucceededCount"] + trAll["TestsFailedCount"]];
Print["Passed: ", trAll["TestsSucceededCount"]];
Print["Failed: ", trAll["TestsFailedCount"]];
Print["Aborted: ", trAll["TestsAbortedCount"]];
Print["Success rate: ", N[100.0 * trAll["TestsSucceededCount"] / (trAll["TestsSucceededCount"] + trAll["TestsFailedCount"])], "%"];
Print[""];
Print["Report Succeeded: ", trAll["ReportSucceeded"]];
Print["=================================================\n"];

If[trAll["ReportSucceeded"],
  Print["✓ ALL TESTS PASSED"];
  Exit[0];
,
  Print["✗ SOME TESTS FAILED"];
  Exit[1];
];
