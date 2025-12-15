#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Coverage Diagnostic Script

   Tests whether CoverageEvaluate works correctly with the current Wolfram Engine.
   Run this to determine if execution coverage can be enabled.

   Usage: wolframscript Tests/CoverageDiagnostic.wls [--verbose]
*)

Module[{
    verbose, pacletRoot, testsRoot,
    kernelDir, instrumentedDir, coverageDir,
    testResults, allPassed
  },

  (* === Parse arguments === *)
  verbose = MemberQ[$ScriptCommandLine, "--verbose"] || MemberQ[$ScriptCommandLine, "-v"];

  (* === Setup paths === *)
  testsRoot = DirectoryName[$InputFileName];
  pacletRoot = testsRoot;
  While[!FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}] &&
        pacletRoot =!= DirectoryName[pacletRoot],
    pacletRoot = DirectoryName[pacletRoot]
  ];

  If[!FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}],
    Print["Error: Could not locate PacletInfo.wl"];
    Quit[1]
  ];

  kernelDir = FileNameJoin[{pacletRoot, "Kernel"}];
  instrumentedDir = FileNameJoin[{pacletRoot, "build", "coverage-diagnostic"}];
  coverageDir = FileNameJoin[{pacletRoot, "build", "coverage-diagnostic-output"}];

  Print["=== Coverage Diagnostic ==="];
  Print["Wolfram Engine: ", $Version];
  Print["Paclet Root: ", pacletRoot];
  Print[""];

  (* === Clean and create directories === *)
  If[DirectoryQ[instrumentedDir], DeleteDirectory[instrumentedDir, DeleteContents -> True]];
  If[DirectoryQ[coverageDir], DeleteDirectory[coverageDir, DeleteContents -> True]];
  CreateDirectory[instrumentedDir, CreateIntermediateDirectories -> True];
  CreateDirectory[coverageDir, CreateIntermediateDirectories -> True];

  (* === Load Instrumentation === *)
  Print["Loading Instrumentation package..."];
  Needs["Instrumentation`"];
  Print["  Instrumentation version: ",
    Quiet[PacletFind["Instrumentation"][[1]]["Version"], {PacletFind::notfound, Part::partw}] /.
      {} -> "built-in"];

  (* === Test Results Container === *)
  testResults = <||>;

  (* ============================================ *)
  (* TEST 1: Basic CoverageInstrument works      *)
  (* ============================================ *)
  Print["\n--- Test: CoverageInstrument ---"];
  Module[{baseline},
    baseline = Quiet[
      TimeConstrained[
        Instrumentation`CoverageInstrument[kernelDir, FileNameJoin[{instrumentedDir, "Kernel"}]],
        300, (* 5 min timeout *)
        $TimedOut
      ],
      Instrumentation::versions
    ];

    If[FailureQ[baseline] || baseline === $TimedOut,
      Print["  FAILED: CoverageInstrument returned ", baseline];
      testResults["CoverageInstrument"] = False,
      (* else *)
      Print["  PASSED: CoverageInstrument succeeded"];
      If[verbose, Print["  Baseline data type: ", Head[baseline]]];
      testResults["CoverageInstrument"] = True;

      (* Write baseline LCOV *)
      Quiet[Instrumentation`CoverageProcess[baseline, coverageDir, "baseline.lcov"]];
    ]
  ];

  (* ============================================ *)
  (* TEST 2: Basic CoverageEvaluate (no paclet)  *)
  (* ============================================ *)
  Print["\n--- Test: CoverageEvaluate (simple expression) ---"];
  Module[{result, runData},
    {result, runData} = Quiet[
      TimeConstrained[
        Check[
          Instrumentation`CoverageEvaluate[1 + 1],
          {$Failed, $Failed}
        ],
        60, (* 1 min timeout *)
        {$TimedOut, $TimedOut}
      ]
    ];

    If[result === $Failed || result === $TimedOut,
      Print["  FAILED: CoverageEvaluate returned ", result];
      testResults["CoverageEvaluate_Simple"] = False,
      (* else *)
      Print["  PASSED: CoverageEvaluate[1+1] = ", result];
      testResults["CoverageEvaluate_Simple"] = True
    ]
  ];

  (* ============================================ *)
  (* TEST 3: CoverageEvaluate with instrumented code *)
  (* ============================================ *)
  Print["\n--- Test: CoverageEvaluate (instrumented paclet load) ---"];
  If[testResults["CoverageInstrument"] === True,
    Module[{result, runData, resourcesDir},
      (* Copy PacletInfo and Resources for paclet resolution *)
      CopyFile[
        FileNameJoin[{pacletRoot, "PacletInfo.wl"}],
        FileNameJoin[{instrumentedDir, "PacletInfo.wl"}]
      ];
      resourcesDir = FileNameJoin[{pacletRoot, "Resources"}];
      If[DirectoryQ[resourcesDir],
        CopyDirectory[resourcesDir, FileNameJoin[{instrumentedDir, "Resources"}]]
      ];

      (* Load instrumented paclet *)
      PacletDirectoryLoad[instrumentedDir];

      {result, runData} = Quiet[
        TimeConstrained[
          CheckAbort[
            Check[
              Instrumentation`CoverageEvaluate[
                Needs["FernandoDuarte`LongRunRisk`"];
                Length[Names["FernandoDuarte`LongRunRisk`*"]]
              ],
              {$Failed, $Failed}
            ],
            {$Aborted, $Aborted}
          ],
          300, (* 5 min timeout *)
          {$TimedOut, $TimedOut}
        ]
      ];

      If[result === $Failed || result === $TimedOut || result === $Aborted,
        Print["  FAILED: CoverageEvaluate returned ", result];
        testResults["CoverageEvaluate_Paclet"] = False,
        (* else *)
        Print["  PASSED: Loaded paclet, found ", result, " public symbols"];
        testResults["CoverageEvaluate_Paclet"] = True;

        (* Try to process the coverage data *)
        If[runData =!= $Failed && runData =!= Null,
          Print["  Coverage data collected successfully"];
          Quiet[Instrumentation`CoverageProcess[runData, coverageDir, "run.lcov"]];
          If[FileExistsQ[FileNameJoin[{coverageDir, "run.lcov"}]],
            Print["  LCOV file generated: ", FileNameJoin[{coverageDir, "run.lcov"}]];
            testResults["CoverageProcess"] = True,
            Print["  Warning: LCOV file not generated"];
            testResults["CoverageProcess"] = False
          ],
          Print["  Warning: No coverage data returned"];
          testResults["CoverageProcess"] = False
        ]
      ]
    ],
    Print["  SKIPPED: CoverageInstrument failed"];
    testResults["CoverageEvaluate_Paclet"] = "Skipped"
  ];

  (* ============================================ *)
  (* TEST 4: Check for DA: lines in LCOV         *)
  (* ============================================ *)
  Print["\n--- Test: LCOV data quality ---"];
  Module[{lcovFile, content, hasDA},
    lcovFile = FileNameJoin[{coverageDir, "run.lcov"}];
    If[FileExistsQ[lcovFile],
      content = ReadString[lcovFile];
      hasDA = StringContainsQ[content, "DA:"];
      If[hasDA,
        Print["  PASSED: LCOV contains DA: (execution data) lines"];
        testResults["LCOV_HasData"] = True,
        Print["  WARNING: LCOV missing DA: lines (no execution tracking)"];
        testResults["LCOV_HasData"] = False
      ],
      Print["  SKIPPED: No run.lcov file"];
      testResults["LCOV_HasData"] = "Skipped"
    ]
  ];

  (* ============================================ *)
  (* SUMMARY                                     *)
  (* ============================================ *)
  Print["\n=== Summary ==="];
  allPassed = True;
  KeyValueMap[
    Function[{test, result},
      Print["  ", test, ": ",
        Switch[result,
          True, "PASSED",
          False, allPassed = False; "FAILED",
          "Skipped", "SKIPPED",
          _, allPassed = False; ToString[result]
        ]
      ]
    ],
    testResults
  ];

  Print[""];
  If[allPassed && testResults["CoverageEvaluate_Paclet"] === True,
    Print["SUCCESS: CoverageEvaluate appears to work!"];
    Print["Execution coverage can be enabled in RunCoverage.wls"];
    Quit[0],
    (* else *)
    If[testResults["CoverageEvaluate_Simple"] === True,
      Print["PARTIAL: Basic CoverageEvaluate works, but paclet loading has issues."];
      Print["Investigate the paclet load failure before enabling execution coverage."];
      Quit[1],
      (* else *)
      Print["FAILED: CoverageEvaluate still has issues."];
      Print["Continue using baseline-only coverage."];
      Quit[1]
    ]
  ]
];
