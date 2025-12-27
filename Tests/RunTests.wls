#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Aggregate runner for automated test suites.
   Skips interactive notebooks and CI test generators. *)

Module[
  {
    testsRoot, pacletRoot, ignoreDirs, verbose, specificFiles,
    allTestFiles, testFiles, report,
    totalPassed, totalFailed, totalAborted, totalTests
  },

  Needs["MUnit`"];

  testsRoot = DirectoryName[$InputFileName];

  pacletRoot = testsRoot;
  While[! FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}] && pacletRoot =!= DirectoryName[pacletRoot],
    pacletRoot = DirectoryName[pacletRoot]
  ];

  If[! FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}],
    Print["Could not locate PacletInfo.wl"];
    Quit[1];
  ];

  PacletDirectoryLoad[pacletRoot];

  ignoreDirs = {"InteractiveTests", "GenerateCITests", "Scripts"};

  verbose = MemberQ[$ScriptCommandLine, "--verbose" | "-v"];
  specificFiles = Select[$ScriptCommandLine, StringEndsQ[#, ".wlt"] &];

  allTestFiles = Sort @ FileNames["*.wlt", testsRoot, Infinity];
  allTestFiles = Select[allTestFiles, FreeQ[FileNameSplit[#], Alternatives @@ ignoreDirs] &];

  testFiles = If[specificFiles =!= {},
    Module[{resolved},
      resolved = Replace[specificFiles, f_ :> If[FileExistsQ[f], f, FileNameJoin[{testsRoot, f}]], {1}];
      Select[resolved, FileExistsQ]
    ],
    allTestFiles
  ];

  testFiles = Select[testFiles, FreeQ[FileNameSplit[#], Alternatives @@ ignoreDirs] &];

  If[testFiles === {},
    Print["No .wlt tests found outside ignored directories: ", StringRiffle[ignoreDirs, ", "]];
    Quit[1];
  ];

  report = TestReport[testFiles, "ProgressReporting" -> verbose];

  totalPassed = report["TestsSucceededCount"];
  totalFailed = report["TestsFailedCount"];
  totalAborted = Replace[report["TestsAbortedCount"], _Missing -> 0];
  totalTests = totalPassed + totalFailed + totalAborted;

  Print["Total: ", totalTests, ", Passed: ", totalPassed, ", Failed: ", totalFailed, ", Aborted: ", totalAborted,
    " (" <> ToString[NumberForm[100.0 * totalPassed / Max[1, totalTests], {4, 1}]] <> "%)"];

  (* Print failure details if any *)
  If[totalFailed > 0,
    Module[{failedTests},
      failedTests = Select[report["TestResults"], #["Outcome"] === "Failure" &];
      If[Length[failedTests] > 0,
        Print["Failed test IDs: ", failedTests[[1, "TestID"]]];
        Print["Failed test file: ", failedTests[[1, "TestFileName"]]];
      ];
    ]
  ];

  If[totalFailed > 0 || totalAborted > 0,
    Quit[1],
    Quit[0]
  ];
];
