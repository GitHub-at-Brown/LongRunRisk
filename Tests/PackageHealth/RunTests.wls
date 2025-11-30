#!/usr/bin/env wolframscript
(* ::Package:: *)

Module[
  {
    testDir, testFiles, report, verbose, specificFiles,
    pacletRoot, paclets, startTime, endTime,
    totalTests, totalPassed, totalFailed, totalAborted
  },

  Needs["MUnit`"];

  verbose = MemberQ[$ScriptCommandLine, "--verbose" | "-v"];
  specificFiles = Select[$ScriptCommandLine, StringEndsQ[#, ".wlt"] &];

  testDir = DirectoryName[$InputFileName];

  pacletRoot = testDir;
  While[! FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}] && pacletRoot =!= DirectoryName[pacletRoot],
    pacletRoot = DirectoryName[pacletRoot]
  ];

  If[! FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}],
    Print["ERROR: Could not find PacletInfo.wl in parent directories!"];
    Quit[1];
  ];

  paclets = PacletDirectoryLoad[pacletRoot];
  If[paclets === {} || !ListQ[paclets],
    Print["ERROR: Failed to load paclet from ", pacletRoot];
    Quit[1];
  ];

  If[verbose,
    Print["Loaded paclet from: ", pacletRoot];
    Print[""]
  ];

  testFiles = If[Length[specificFiles] > 0,
    FileNameJoin[{testDir, #}] & /@ specificFiles,
    Sort[FileNames["*.wlt", testDir]]
  ];

  If[Length[testFiles] == 0,
    Print["ERROR: No test files found!"];
    Quit[1];
  ];

  If[verbose,
    Print["Running tests from: ", testDir];
    Print["Files: ", Length[testFiles]];
    Print[""]
  ];

  startTime = AbsoluteTime[];
  (* Use TestReport directly on files - handles .wlt natively and collects all tests *)
  report = TestReport[testFiles, "ProgressReporting" -> verbose];
  endTime = AbsoluteTime[];

  totalPassed = report["TestsSucceededCount"];
  totalFailed = report["TestsFailedCount"];
  (* TestsAborted can be Missing if none aborted *)
  totalAborted = Replace[report["TestsAbortedCount"], _Missing -> 0];
  totalTests = totalPassed + totalFailed + totalAborted;

  Print["================================================================="];
  Print["PackageHealth Test Suite"];
  Print["================================================================="];
  Print["Total Test Files: ", Length[testFiles]];
  Print["Total Tests:      ", totalTests];
  Print["Passed:           ", totalPassed, If[totalFailed == 0 && totalAborted == 0, " ✓", ""]];
  Print["Failed:           ", totalFailed, If[totalFailed > 0, " ✗", ""]];
  If[totalAborted > 0,
    Print["Aborted:          ", totalAborted, " ✗"]
  ];
  Print["Time Elapsed:     ", NumberForm[endTime - startTime, {5, 2}], " seconds"];
  Print[""];

  If[totalFailed > 0 || totalAborted > 0,
    If[totalFailed > 0,
      Print["Failed Tests:"];
      (* TestsFailed returns nested association - flatten all values *)
      Flatten[Values /@ Values[report["TestsFailed"]]] // Map[
        Function[test,
          Print["  ✗ ", test["TestID"] /. Missing[_, _] :> "unlabeled"];
          If[verbose,
            Print["    Expected: ", Short[test["ExpectedOutput"], 3]];
            Print["    Got:      ", Short[test["ActualOutput"], 3]];
            If[test["ExpectedMessages"] =!= {},
              Print["    Expected messages: ", test["ExpectedMessages"]]
            ];
            Print[""]
          ];
        ]
      ];
    ];
    If[totalAborted > 0,
      Print["Aborted Tests:"];
      (* TestsAborted returns association of test results *)
      Values[report["TestsAborted"]] // Map[
        Function[test,
          Print["  ✗ ", test["TestID"] /. Missing[_, _] :> "unlabeled"];
        ]
      ];
    ];
    Quit[1],
    Quit[0]
  ];
]
