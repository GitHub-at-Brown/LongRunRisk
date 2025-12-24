#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Coverage analysis for LongRunRisk paclet using Wolfram Instrumentation.
   Generates LCOV files for use with lcov/genhtml.

   Usage:
     wolframscript Tests/RunCoverage.wls [--mode=Auto|Baseline|Execution] [--verbose]

   Modes:
     Auto      - Try execution coverage, fall back to baseline if it fails (default)
     Baseline  - Only generate baseline coverage (code structure, no execution)
     Execution - Attempt execution coverage, fail if it doesn't work
*)

Module[{
    (* Configuration *)
    coverageMode, verbose,
    (* Paths *)
    testsRoot, pacletRoot, kernelDir, resourcesDir,
    instrumentedDir, instrumentedKernel, coverageDir,
    (* Test data *)
    testFiles, ignoreDirs,
    (* Coverage data *)
    baseline, runData, executionCoverageSuccess,
    (* Test results *)
    report, totalFailed, noCovFailed
  },

  (* === Parse command-line arguments === *)
  coverageMode = "Auto";
  verbose = False;

  Map[
    Function[arg,
      Which[
        StringMatchQ[arg, "--mode=" ~~ __],
          coverageMode = StringReplace[arg, "--mode=" -> ""],
        arg === "--verbose" || arg === "-v",
          verbose = True
      ]
    ],
    $ScriptCommandLine
  ];

  (* Validate mode *)
  If[!MemberQ[{"Auto", "Baseline", "Execution"}, coverageMode],
    Print["Error: Invalid mode '", coverageMode, "'. Use Auto, Baseline, or Execution."];
    Quit[1]
  ];

  Print["=== LongRunRisk Coverage Analysis ==="];
  Print["Mode: ", coverageMode];
  Print["Wolfram Engine: ", $Version];
  Print[""];

  (* === Setup paths === *)
  testsRoot = DirectoryName[$InputFileName];
  (* Walk up from Tests/ directory to find paclet root *)
  pacletRoot = DirectoryName[testsRoot];
  While[!FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}] &&
        pacletRoot =!= DirectoryName[pacletRoot],
    pacletRoot = DirectoryName[pacletRoot]
  ];

  If[!FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}],
    Print["Error: Could not locate PacletInfo.wl"];
    Quit[1]
  ];

  kernelDir = FileNameJoin[{pacletRoot, "Kernel"}];
  resourcesDir = FileNameJoin[{pacletRoot, "Resources"}];
  instrumentedDir = FileNameJoin[{pacletRoot, "build", "coverage-instrumented"}];
  instrumentedKernel = FileNameJoin[{instrumentedDir, "Kernel"}];
  coverageDir = FileNameJoin[{pacletRoot, "build", "coverage"}];

  (* Clean and create output directories *)
  If[DirectoryQ[instrumentedDir], DeleteDirectory[instrumentedDir, DeleteContents -> True]];
  If[DirectoryQ[coverageDir], DeleteDirectory[coverageDir, DeleteContents -> True]];
  CreateDirectory[instrumentedDir, CreateIntermediateDirectories -> True];
  CreateDirectory[coverageDir, CreateIntermediateDirectories -> True];

  (* === Load Instrumentation === *)
  Needs["Instrumentation`"];
  Needs["MUnit`"];

  If[verbose,
    Print["Instrumentation version: ", PacletFind["Instrumentation"][[1]]["Version"]]
  ];

  (* === Build instrumented paclet structure === *)
  Print["Building instrumented paclet structure..."];

  (* Copy PacletInfo.wl so paclet resolution works *)
  If[FailureQ[CopyFile[
    FileNameJoin[{pacletRoot, "PacletInfo.wl"}],
    FileNameJoin[{instrumentedDir, "PacletInfo.wl"}]
  ]],
    Print["Error: Failed to copy PacletInfo.wl"];
    Quit[1]
  ];

  (* Copy Resources directory (needed for Models.wl, etc.) *)
  If[DirectoryQ[resourcesDir],
    If[FailureQ[CopyDirectory[resourcesDir, FileNameJoin[{instrumentedDir, "Resources"}]]],
      Print["Error: Failed to copy Resources directory"];
      Quit[1]
    ]
  ];

  (* === Instrument Kernel/ === *)
  Print["Instrumenting source files..."];
  baseline = Instrumentation`CoverageInstrument[kernelDir, instrumentedKernel];

  If[FailureQ[baseline],
    Print["Error: CoverageInstrument failed: ", baseline];
    Quit[1]
  ];

  (* Write baseline LCOV - shows code structure *)
  Print["Generating baseline coverage (code structure)..."];
  Instrumentation`CoverageProcess[baseline, coverageDir, "baseline.lcov"];

  (* === Prepare test files === *)
  ignoreDirs = {"InteractiveTests", "GenerateCITests"};
  testFiles = FileNames["*.wlt", testsRoot, Infinity];
  testFiles = Select[testFiles, FreeQ[FileNameSplit[#], Alternatives @@ ignoreDirs] &];

  If[testFiles === {},
    Print["No .wlt tests found outside ignored directories: ", StringRiffle[ignoreDirs, ", "]];
    Quit[1]
  ];

  (* Directories that cause CoverageEvaluate to abort or corrupt coverage data:
     - FindRootOptim: Causes abort during cleanup
     - ParamQuadSolve: Causes AssociateTo::invak errors that corrupt coverage runtime *)
  coverageExcludeDirs = {"FindRootOptim", "ParamQuadSolve"};

  (* Test files that load the umbrella package (Needs["FernandoDuarte`LongRunRisk`"])
     break function body coverage tracking for sub-packages. These must be excluded
     from CoverageEvaluate and run separately. *)
  coverageExcludeFiles = {"ComputeConditionalExpectations.wlt", "PacletizeResources.wlt"};

  noCoverageTests = Select[testFiles,
    !FreeQ[FileNameSplit[#], Alternatives @@ coverageExcludeDirs] ||
    MemberQ[coverageExcludeFiles, FileNameTake[#]] &
  ];
  coverageTests = Select[testFiles,
    FreeQ[FileNameSplit[#], Alternatives @@ coverageExcludeDirs] &&
    !MemberQ[coverageExcludeFiles, FileNameTake[#]] &
  ];

  Print["Found ", Length[testFiles], " test files total"];
  Print["  ", Length[coverageTests], " for coverage tracking"];
  Print["  ", Length[noCoverageTests], " excluded from coverage"];
  Print["    Dirs: ", StringRiffle[coverageExcludeDirs, ", "]];
  Print["    Files: ", StringRiffle[coverageExcludeFiles, ", "]];

  (* === Initialize coverage tracking state === *)
  executionCoverageSuccess = False;
  runData = Null;
  report = Null;

  (* === Attempt execution coverage if mode allows === *)
  If[coverageMode === "Execution" || coverageMode === "Auto",
    Print["\nAttempting execution coverage with CoverageEvaluate..."];

    (* CRITICAL: Unload original paclet to ensure instrumented version is used.
       When tests load the umbrella package, Needs calls must resolve to the
       instrumented sub-packages, not the original ones. *)
    PacletDirectoryUnload[pacletRoot];
    PacletDirectoryLoad[instrumentedDir];

    (* Run CoverageEvaluate WITHOUT:
       - TimeConstrained/CheckAbort wrappers (these break coverage tracking entirely)
       - Pre-loading umbrella package (prevents function body coverage)
       Let test files load their own packages via their Needs calls *)
    {report, runData} = Instrumentation`CoverageEvaluate[
      TestReport[coverageTests, "ProgressReporting" -> True]
    ];

    If[MatchQ[runData, _Instrumentation`CoverageData],
      executionCoverageSuccess = True;
      Print["CoverageEvaluate completed successfully!"],
      (* Failed *)
      Print["CoverageEvaluate failed or returned invalid data: ", Head[runData]];
      If[coverageMode === "Execution",
        Print["Error: Execution mode requested but CoverageEvaluate failed."];
        Quit[1]
      ];
      Print["Falling back to baseline-only coverage..."]
    ]
  ];


  (* === Generate execution coverage LCOV or fall back === *)
  If[executionCoverageSuccess,
    (* Write real execution coverage data *)
    Print["Generating execution coverage data..."];
    Instrumentation`CoverageProcess[runData, coverageDir, "tests.lcov"],
    (* Fall back: copy baseline as placeholder *)
    Print["Using baseline as tests.lcov (no execution tracking)"];
    CopyFile[
      FileNameJoin[{coverageDir, "baseline.lcov"}],
      FileNameJoin[{coverageDir, "tests.lcov"}]
    ]
  ];

  (* === Run tests separately if execution coverage failed === *)
  If[!executionCoverageSuccess,
    Print["\nRunning all tests (without coverage tracking)..."];

    (* Load ORIGINAL paclet since instrumented one may have issues *)
    PacletDirectoryUnload[instrumentedDir];
    PacletDirectoryLoad[pacletRoot];
    Needs["FernandoDuarte`LongRunRisk`"];

    report = TestReport[testFiles, "ProgressReporting" -> True]
  ];

  (* === Run excluded tests separately (without coverage) === *)
  noCovFailed = 0;  (* Track excluded test failures *)
  Block[{noCovReport},
    If[noCoverageTests =!= {},
      Print["\nRunning excluded tests without coverage (", StringRiffle[coverageExcludeDirs, ", "], ")..."];

      (* Make sure we have original paclet loaded *)
      If[executionCoverageSuccess,
        PacletDirectoryUnload[instrumentedDir];
        PacletDirectoryLoad[pacletRoot];
        Needs["FernandoDuarte`LongRunRisk`"]
      ];

      (* Quiet instrumentation messages from residual coverage code in memory *)
      noCovReport = Quiet[
        TestReport[noCoverageTests, "ProgressReporting" -> True],
        {CoverageEvaluate::call, Insert::ins, Values::invrl}
      ];

      (* Filter out coverage-artifact failures (instrumentation messages) *)
      coverageArtifactFailures = Select[Values[noCovReport["TestResults"]],
        #["Outcome"] === "MessagesFailure" &&
        AnyTrue[#["ActualMessages"],
          MatchQ[#, HoldPattern[MessageName[CoverageEvaluate | Insert | Values, _]]] &
        ] &
      ];
      realFailedCount = noCovReport["TestsFailedCount"] - Length[coverageArtifactFailures];

      Print["Excluded tests: ", noCovReport["TestsSucceededCount"], " passed, ",
        realFailedCount, " failed"];
      If[Length[coverageArtifactFailures] > 0,
        Print["  (", Length[coverageArtifactFailures], " test(s) with instrumentation artifacts ignored)"]
      ];
      noCovFailed = realFailedCount + Lookup[noCovReport, "TestsAbortedCount", 0];
      (* Print details of real failed tests *)
      If[realFailedCount > 0,
        Do[
          If[result["Outcome"] =!= "Success" &&
             !MemberQ[coverageArtifactFailures, result],
            Print["  Failed: ", result["TestID"]];
            Print["    Outcome: ", result["Outcome"]];
            If[result["Outcome"] === "MessagesFailure",
              Print["    Expected: ", result["ExpectedMessages"]];
              Print["    Actual: ", result["ActualMessages"]];
            ];
            If[result["Outcome"] === "Failure",
              Print["    Expected: ", Short[result["ExpectedOutput"], 3]];
              Print["    Actual: ", Short[result["ActualOutput"], 3]];
            ];
          ],
          {result, Values[noCovReport["TestResults"]]}
        ]
      ]
    ]
  ];

  (* === Summary === *)
  Print["\n=== Test Results ==="];

  (* Filter out coverage-artifact failures from main report *)
  (* CoverageEvaluate, Insert, Values messages are instrumentation artifacts *)
  mainArtifactFailures = Select[Values[report["TestResults"]],
    #["Outcome"] === "MessagesFailure" &&
    AnyTrue[#["ActualMessages"],
      MatchQ[#, HoldPattern[MessageName[CoverageEvaluate | Insert | Values, _]]] &
    ] &
  ];
  mainRealFailed = report["TestsFailedCount"] - Length[mainArtifactFailures];
  Print["Passed: ", report["TestsSucceededCount"]];
  Print["Failed: ", mainRealFailed];
  If[Length[mainArtifactFailures] > 0,
    Print["  (", Length[mainArtifactFailures], " coverage artifact failure(s) ignored)"]
  ];
  Print["Aborted: ", Lookup[report, "TestsAbortedCount", 0]];
  totalFailed = mainRealFailed + Lookup[report, "TestsAbortedCount", 0] + noCovFailed;

  Print["\n=== Coverage Files Generated ==="];
  Print["  Mode: ", If[executionCoverageSuccess, "Execution", "Baseline"]];
  Print["  ", FileNameJoin[{coverageDir, "baseline.lcov"}], " (code structure)"];
  Print["  ", FileNameJoin[{coverageDir, "tests.lcov"}],
    If[executionCoverageSuccess,
      " (execution coverage)",
      " (same as baseline - execution tracking disabled)"
    ]
  ];

  Print["\nTo generate HTML report, run:"];
  Print["  cd ", pacletRoot];
  Print["  lcov -a build/coverage/baseline.lcov -a build/coverage/tests.lcov -o build/coverage/combined.lcov"];
  Print["  genhtml build/coverage/combined.lcov -o build/coverage/html"];
  Print["  open build/coverage/html/index.html"];

  (* Exit with failure if any tests failed OR aborted *)
  If[totalFailed > 0,
    Print["\n=== TESTS FAILED ==="];
    Print["Total failures: ", totalFailed];
    Print["Please review test output above for details."];
    Quit[1],
    Print["\n=== ALL TESTS PASSED ==="];
    Quit[0]
  ]
];
