#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Test runner for all FindRootOptim tests with detailed reporting

   Usage:
     wolframscript RunTests.wls              # Run all tests
     wolframscript RunTests.wls --verbose    # Run with detailed output
     wolframscript RunTests.wls file1.wlt    # Run specific test file

   Exit codes:
     0 - All tests passed
     1 - One or more tests failed
*)

(* Recent Updates (2025-11-23):
   - Fixed message testing syntax issues in multiple test files
   - Replaced MessagesExpected option with proper third positional argument
   - Removed Quiet anti-pattern, now properly asserting expected messages
   - Files fixed: bindUnaryMessages.wlt, findRootCoeff0EdgeCases.wlt, fastRootOptions.wlt
   - Enhanced test runner with better reporting and error handling
*)

Module[
  {
    testDir, testFiles, report, startTime, endTime,
    totalTests, totalPassed, totalFailed,
    verbose, specificFiles, testsFromFile, pacletRoot, paclet
  },

  (* Load MUnit for test reporting *)
  Needs["MUnit`"];

  (* Parse command-line arguments *)
  verbose = MemberQ[$ScriptCommandLine, "--verbose" | "-v"];
  specificFiles = Select[$ScriptCommandLine, StringEndsQ[#, ".wlt"] &];

  testDir = DirectoryName[$InputFileName];

  (* Find and load the paclet using PacletDirectoryLoad *)
  pacletRoot = testDir;
  While[! FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}] && pacletRoot =!= DirectoryName[pacletRoot],
    pacletRoot = DirectoryName[pacletRoot]
  ];

  If[! FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}],
    Quit[1];
  ];

  (* Load the paclet - this makes all contexts available including dependencies *)
  paclet = PacletDirectoryLoad[pacletRoot];
  If[FailureQ[paclet],
    Quit[1];
  ];

  If[verbose,
  ];

  (* Get test files *)
  testFiles = If[Length[specificFiles] > 0,
    (* Run specific files *)
    FileNameJoin[{testDir, #}] & /@ specificFiles,
    (* Run all .wlt files in directory, sorted for consistent ordering *)
    Sort[FileNames["*.wlt", testDir]]
  ];

  If[Length[testFiles] == 0,
    Quit[1];
  ];

  (* Helper: load a file and extract only test expressions *)
  testsFromFile[file_] := Module[{expr = Get[file]},
    Select[Flatten[{expr}], MatchQ[_TestObject | _VerificationTest]]
  ];

  (* Print header *)
  If[Length[specificFiles] > 0,
  ];

  startTime = AbsoluteTime[];

  (* Run all test files with progress reporting *)
  If[verbose,
  ];

  report = TestReport[testsFromFile /@ testFiles, "ProgressReporting" -> verbose];

  endTime = AbsoluteTime[];

  (* Extract results *)
  totalTests = report["TestsSucceededCount"] + report["TestsFailedCount"];
  totalPassed = report["TestsSucceededCount"];
  totalFailed = report["TestsFailedCount"];

  (* Print summary *)
  Print["Total: ", totalTests, ", Passed: ", totalPassed, ", Failed: ", totalFailed, " (" <> ToString[NumberForm[100.0 * totalPassed / totalTests, {4, 1}]] <> "%)"];
  If[totalTests > 0,
  ];

  (* Per-file summary *)

  Do[
    Module[{fileReport, fileName, passed, failed, total, status},
      fileName = FileBaseName[testFile];
      fileReport = TestReport[testsFromFile[testFile]];
      passed = fileReport["TestsSucceededCount"];
      failed = fileReport["TestsFailedCount"];
      total = passed + failed;

      status = If[failed == 0, "✓", "✗"];

      With[{padded = StringPadRight[fileName <> ".wlt", 35]},
        If[failed == 0,
        ];
      ];
    ],
    {testFile, testFiles}
  ];

  (* Detailed failure report *)
  If[totalFailed > 0,

              Print["Failures: ", report["TestsFailed"]];
  ];

  (* Final status *)
  If[totalFailed == 0,
    Quit[0];
  ,
    Quit[1];
  ];
]
