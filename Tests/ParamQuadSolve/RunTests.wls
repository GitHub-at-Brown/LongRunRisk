#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Test runner for all ParamQuadSolve tests with detailed reporting

   Usage:
     wolframscript RunTests.wls              # Run all tests
     wolframscript RunTests.wls --verbose    # Run with detailed output
     wolframscript RunTests.wls file1.wlt    # Run specific test file

   Exit codes:
     0 - All tests passed
     1 - One or more tests failed
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
                                             " (" <> ToString[NumberForm[100.0 * totalPassed / totalTests, {4, 1}]] <> "%)"]];
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

              If[messages =!= None,
              ];
            ],
            {test, tests}
          ];
        ],
        failuresByFile
      ];
    ];
  ];

  (* Final status *)
  If[totalFailed == 0,
    Quit[0];
  ,
    Quit[1];
  ];
]
