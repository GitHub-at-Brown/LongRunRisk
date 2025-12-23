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
  specificFiles = Select[$ScriptCommandLine, StringEndsQ[#, ".mt"] &];

  testDir = DirectoryName[$InputFileName];

  pacletRoot = testDir;
  While[! FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}] && pacletRoot =!= DirectoryName[pacletRoot],
    pacletRoot = DirectoryName[pacletRoot]
  ];

  If[! FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}],
    Quit[1];
  ];

  paclets = PacletDirectoryLoad[pacletRoot];
  If[paclets === {} || !ListQ[paclets],
    Quit[1];
  ];

  testFiles = If[Length[specificFiles] > 0,
    FileNameJoin[{testDir, #}] & /@ specificFiles,
    Sort[FileNames["*.mt", testDir]]
  ];

  If[Length[testFiles] == 0,
    Quit[1];
  ];

  startTime = AbsoluteTime[];
  report = TestReport[testFiles, "ProgressReporting" -> verbose];
  endTime = AbsoluteTime[];

  totalPassed = report["TestsSucceededCount"];
  totalFailed = report["TestsFailedCount"];
  totalAborted = Replace[report["TestsAbortedCount"], _Missing -> 0];
  totalTests = totalPassed + totalFailed + totalAborted;
  Print["Total: ", totalTests, ", Passed: ", totalPassed, ", Failed: ", totalFailed, ", Aborted: ", totalAborted, " (" <> ToString[NumberForm[100.0 * totalPassed / totalTests, {4, 1}]] <> "%)"];

  If[totalFailed > 0 || totalAborted > 0,
    If[totalFailed > 0,
      Flatten[Values /@ Values[report["TestsFailed"]]] // Map[
        Function[test,
          Print["FAILED: ", test["TestID"]];
        ]
      ];
    ];
    If[totalAborted > 0,
      Values[report["TestsAborted"]] // Map[
        Function[test,
          Print["ABORTED: ", test["TestID"]];
        ]
      ];
    ];
    Quit[1],
    Quit[0]
  ];
]
