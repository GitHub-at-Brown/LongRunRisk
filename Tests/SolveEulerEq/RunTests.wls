#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Test runner for all SolveEulerEq tests with detailed reporting

   Usage:
     wolframscript RunTests.wls              # Run all tests
     wolframscript RunTests.wls --verbose    # Run with detailed output
     wolframscript RunTests.wls file1.mt    # Run specific test file

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
  (* Needs["MUnit`"]; *)

  (* Parse command-line arguments *)
  verbose = MemberQ[$ScriptCommandLine, "--verbose" | "-v"];
  specificFiles = Select[$ScriptCommandLine, StringEndsQ[#, ".mt"] &];

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

  (* Get test files *)
  testFiles = If[Length[specificFiles] > 0,
    (* Run specific files *)
    FileNameJoin[{testDir, #}] & /@ specificFiles,
    (* Run all .mt files in directory, sorted for consistent ordering *)
    Sort[FileNames["*.mt", testDir]]
  ];

  If[Length[testFiles] == 0,
    Quit[1];
  ];

  (* Helper: load a file and extract only test expressions *)
  testsFromFile[file_] := Module[{expr = Get[file]},
    Select[Flatten[{expr}], MatchQ[_TestObject | _VerificationTest]]
  ];

  startTime = AbsoluteTime[];

  report = TestReport[testsFromFile /@ testFiles, "ProgressReporting" -> verbose];

  endTime = AbsoluteTime[];

  (* Extract results *)
  totalTests = report["TestsSucceededCount"] + report["TestsFailedCount"];
  totalPassed = report["TestsSucceededCount"];
  totalFailed = report["TestsFailedCount"];

  (* Print summary *)
  Print["Total: ", totalTests, ", Passed: ", totalPassed, ", Failed: ", totalFailed, " (" <> ToString[NumberForm[100.0 * totalPassed / totalTests, {4, 1}]] <> "%)"];

  (* Detailed failure report *)
  If[totalFailed > 0,
    Module[{failuresByFile},
      (* Group failures by file for better readability *)
      failuresByFile = GroupBy[
        report["TestsFailed"],
        Function[test,
            Module[{t = If[Head[test] === TestObject, First[test], test]},
                  If[KeyExistsQ[t, "TestID"] && StringQ[t["TestID"]] && StringContainsQ[t["TestID"], "@@"],
                    Last[StringSplit[t["TestID"], "@@"]],
                    "Unknown file"
                  ]
            ]
        ]
      ];

      KeyValueMap[
        Function[{file, tests},
          Do[
            Module[{t = If[Head[test] === TestObject, First[test], test]},
              Print["\nKeys: ", Keys[t]];
              Print["Raw: ", Short[t, 2]];
              Print["\nTest ID: ", Lookup[t, "TestID", "N/A"]];
              Print["Expected: ", Lookup[t, "ExpectedOutput", "N/A"]];
              Print["Actual:   ", Lookup[t, "ActualOutput", "N/A"]];
              If[KeyExistsQ[t, "ExpectedMessages"] && t["ExpectedMessages"] =!= {},
                  Print["Expected Messages: ", t["ExpectedMessages"]];
              ];
            ],
            {test, Values[tests]}
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
