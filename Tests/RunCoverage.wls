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
    testFiles,
    (* Coverage data *)
    baseline, runData, executionCoverageSuccess,
    (* Test results *)
    report, totalFailed
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

  (* Copy test data files (but not as instrumented code) *)
  (* Tests use FindFile to locate package, then derive Tests/ path for test data *)
  (* We copy only .wl data files (not .wlt test files) to the instrumented Tests/ directory *)
  Module[{instrumentedTestsDir, testSubdirs, dataFiles},
    instrumentedTestsDir = FileNameJoin[{instrumentedDir, "Tests"}];
    CreateDirectory[instrumentedTestsDir, CreateIntermediateDirectories -> True];

    (* Find all test subdirectories *)
    testSubdirs = Select[FileNames["*", testsRoot], DirectoryQ];

    (* Copy test data files from each subdirectory *)
    Do[
      Module[{subdirName, targetSubdir, subDataFiles},
        subdirName = FileBaseName[subdir];

        (* Skip Resources (contains Models.wl which gets run as test), Scripts (utilities) *)
        If[subdirName =!= "Resources" && subdirName =!= "Scripts",
          (* Find .wl data files (not .wlt test files) in this subdirectory *)
          subDataFiles = FileNames["*.wl", subdir, 1];
          subDataFiles = Select[subDataFiles, !StringEndsQ[#, ".wlt"] &];

          If[Length[subDataFiles] > 0,
            targetSubdir = FileNameJoin[{instrumentedTestsDir, subdirName}];
            CreateDirectory[targetSubdir, CreateIntermediateDirectories -> True];

            (* Copy each data file without instrumentation (using CopyFile, not loading) *)
            Do[
              CopyFile[dataFile,
                FileNameJoin[{targetSubdir, FileBaseName[dataFile] <> ".wl"}],
                OverwriteTarget -> True
              ],
              {dataFile, subDataFiles}
            ]
          ]
        ]
      ],
      {subdir, testSubdirs}
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
  (* Find all .wlt files in Tests/ recursively *)
  allFiles = FileNames["*.wlt", testsRoot, Infinity];

  (* Exclude non-automated test directories *)
  excludedDirs = {"InteractiveTests", "GenerateCITests", "Scripts"};
  testFiles = Select[allFiles,
    FreeQ[FileNameSplit[#], Alternatives @@ excludedDirs] &
  ];

  If[testFiles === {},
    Print["No .wlt tests found outside ignored directories: ", StringRiffle[excludedDirs, ", "]];
    Quit[1]
  ];

  Print["Found ", Length[testFiles], " test files in category subdirectories"];

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
      TestReport[testFiles, "ProgressReporting" -> True]
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

    report = TestReport[testFiles, "ProgressReporting" -> True]
  ];

  (* === Summary === *)
  Print["\n=== Test Results ==="];
  Print["Passed: ", report["TestsSucceededCount"]];
  Print["Failed: ", report["TestsFailedCount"]];
  Print["Aborted: ", Lookup[report, "TestsAbortedCount", 0]];
  totalFailed = report["TestsFailedCount"] + Lookup[report, "TestsAbortedCount", 0];

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
