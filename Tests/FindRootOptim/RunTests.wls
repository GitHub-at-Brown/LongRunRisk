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
    verbose, specificFiles, testsFromFile
  },

  (* Load MUnit for test reporting *)
  Needs["MUnit`"];

  (* Parse command-line arguments *)
  verbose = MemberQ[$ScriptCommandLine, "--verbose" | "-v"];
  specificFiles = Select[$ScriptCommandLine, StringEndsQ[#, ".wlt"] &];

  testDir = DirectoryName[$InputFileName];

  (* Get test files *)
  testFiles = If[Length[specificFiles] > 0,
    (* Run specific files *)
    FileNameJoin[{testDir, #}] & /@ specificFiles,
    (* Run all .wlt files in directory, sorted for consistent ordering *)
    Sort[FileNames["*.wlt", testDir]]
  ];

  If[Length[testFiles] == 0,
    Print["ERROR: No test files found!"];
    Quit[1];
  ];

  (* Helper: load a file and extract only test expressions *)
  testsFromFile[file_] := Module[{expr = Get[file]},
    Select[Flatten[{expr}], MatchQ[_TestObject | _VerificationTest]]
  ];

  (* Print header *)
  Print["================================================================="];
  Print["FindRootOptim Test Suite"];
  Print["================================================================="];
  Print[""];
  Print["Test directory: ", testDir];
  Print["Test files:     ", Length[testFiles]];
  If[Length[specificFiles] > 0,
    Print["Running specific files: ", specificFiles];
  ];
  Print["Verbose mode:   ", If[verbose, "ON", "OFF"]];
  Print[""];

  startTime = AbsoluteTime[];

  (* Run all test files with progress reporting *)
  If[verbose,
    Print["Running tests..."];
    Print[""];
  ];

  report = TestReport[testsFromFile /@ testFiles, "ProgressReporting" -> verbose];

  endTime = AbsoluteTime[];

  (* Extract results *)
  totalTests = report["TestsSucceededCount"] + report["TestsFailedCount"];
  totalPassed = report["TestsSucceededCount"];
  totalFailed = report["TestsFailedCount"];

  (* Print summary *)
  Print["================================================================="];
  Print["Test Results"];
  Print["================================================================="];
  Print[""];
  Print["Total Test Files: ", Length[testFiles]];
  Print["Total Tests:      ", totalTests];
  Print["Passed:           ", totalPassed, If[totalPassed == totalTests, " ✓ (100%)",
                                             " (" <> ToString[NumberForm[100.0 * totalPassed / totalTests, {4, 1}]] <> "%)"]];
  Print["Failed:           ", totalFailed, If[totalFailed > 0, " ✗", ""]];
  Print["Time Elapsed:     ", NumberForm[endTime - startTime, {5, 2}], " seconds"];
  If[totalTests > 0,
    Print["Avg Time/Test:    ", NumberForm[(endTime - startTime) / totalTests, {4, 3}], " seconds"];
  ];
  Print[""];

  (* Per-file summary *)
  Print["================================================================="];
  Print["Per-File Summary"];
  Print["================================================================="];
  Print[""];

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
          Print["  ", status, " ", padded, " ", passed, "/", total, " passed"],
          Print["  ", status, " ", padded, " ", passed, "/", total, " passed  (", failed, " FAILED)"]
        ];
      ];
    ],
    {testFile, testFiles}
  ];
  Print[""];

  (* Detailed failure report *)
  If[totalFailed > 0,
    Print["================================================================="];
    Print["Failed Tests Details"];
    Print["================================================================="];
    Print[""];

    Module[{failuresByFile},
      (* Group failures by file for better readability *)
      failuresByFile = GroupBy[
        report["TestsFailed"],
        If[KeyExistsQ[#, "TestID"] && StringContainsQ[#["TestID"], "@@"],
          Last[StringSplit[#["TestID"], "@@"]],
          "Unknown file"
        ] &
      ];

      KeyValueMap[
        Function[{file, tests},
          Print["File: ", file];
          Print[StringRepeat["-", 65]];
          Do[
            Module[{testID, expected, actual, messages},
              testID = If[KeyExistsQ[test, "TestID"],
                          First[StringSplit[test["TestID"], "@@"]],
                          "Unknown"];
              expected = If[KeyExistsQ[test, "ExpectedOutput"],
                           test["ExpectedOutput"],
                           "Unknown"];
              actual = If[KeyExistsQ[test, "ActualOutput"],
                         test["ActualOutput"],
                         "Unknown"];
              messages = If[KeyExistsQ[test, "ExpectedMessages"],
                           test["ExpectedMessages"],
                           None];

              Print["  ✗ Test: ", testID];
              Print["    Expected: ", Short[expected, 3]];
              Print["    Got:      ", Short[actual, 3]];
              If[messages =!= None,
                Print["    Expected messages: ", messages];
              ];
              Print[""];
            ],
            {test, tests}
          ];
          Print[""];
        ],
        failuresByFile
      ];
    ];
  ];

  (* Final status *)
  Print["================================================================="];
  If[totalFailed == 0,
    Print["✓ SUCCESS: ALL ", totalTests, " TESTS PASSED!"];
    Print["================================================================="];
    Print[""];
    Quit[0];
  ,
    Print["✗ FAILURE: ", totalFailed, " OF ", totalTests, " TEST(S) FAILED"];
    Print["================================================================="];
    Print[""];
    Print["To debug failures:"];
    Print["  1. Run specific test file: wolframscript RunTests.wls <filename>.wlt"];
    Print["  2. Run with verbose output: wolframscript RunTests.wls --verbose"];
    Print["  3. Load test file in notebook: Get[\"Tests/FindRootOptim/<filename>.wlt\"]"];
    Print[""];
    Quit[1];
  ];
]
