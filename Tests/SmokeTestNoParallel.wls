#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Smoke test for coverage script - NO parallel kernels *)

Module[{
    (* Paths *)
    testsRoot, pacletRoot, kernelDir, resourcesDir,
    instrumentedDir, instrumentedKernel, coverageDir,
    (* Test data *)
    testFiles,
    (* Coverage data *)
    baseline, runData, executionCoverageSuccess,
    (* Test results *)
    report
  },

  Print["=== LongRunRisk Coverage Smoke Test (NO Parallel) ==="];
  Print["Wolfram Engine: ", $Version];
  Print[""];

  (* Explicitly disable parallel kernels *)
  Print["Disabling parallel kernels..."];
  CloseKernels[];
  $ConfiguredKernels = {};
  Print["Kernels configured: ", Length[$ConfiguredKernels]];
  Print["Kernels launched: ", Length[Kernels[]]];
  Print[""];

  (* === Setup paths === *)
  testsRoot = DirectoryName[$InputFileName];
  pacletRoot = DirectoryName[testsRoot];
  While[!FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}] &&
        pacletRoot =!= DirectoryName[pacletRoot],
    pacletRoot = DirectoryName[pacletRoot]
  ];

  If[!FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}],
    Print["Error: Could not locate PacletInfo.wl"];
    Quit[1]
  ];

  Print["Paclet root: ", pacletRoot];

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
  Print["Loading Instrumentation..."];
  Needs["Instrumentation`"];
  Needs["MUnit`"];

  (* === Build instrumented paclet structure === *)
  Print["Building instrumented paclet structure..."];

  (* Copy PacletInfo.wl *)
  If[FailureQ[CopyFile[
    FileNameJoin[{pacletRoot, "PacletInfo.wl"}],
    FileNameJoin[{instrumentedDir, "PacletInfo.wl"}]
  ]],
    Print["Error: Failed to copy PacletInfo.wl"];
    Quit[1]
  ];

  (* Copy Resources directory *)
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

  Print["✓ Instrumentation successful"];

  (* Write baseline LCOV *)
  Print["Generating baseline coverage..."];
  Instrumentation`CoverageProcess[baseline, coverageDir, "baseline.lcov"];
  Print["✓ Baseline coverage written"];
  Print[""];

  (* === Single test file === *)
  testFiles = {FileNameJoin[{testsRoot, "CreateMomentsDatabase.wlt"}]};

  If[!FileExistsQ[testFiles[[1]]],
    Print["Error: Test file not found: ", testFiles[[1]]];
    Quit[1]
  ];

  Print["Test file: ", testFiles[[1]]];
  Print[""];

  (* Verify no parallel kernels before test *)
  Print["Pre-test kernel check:"];
  Print["  Kernels configured: ", Length[$ConfiguredKernels]];
  Print["  Kernels launched: ", Length[Kernels[]]];
  Print[""];

  (* === Run coverage evaluation === *)
  Print["Running CoverageEvaluate (single kernel only)..."];

  PacletDirectoryUnload[pacletRoot];
  PacletDirectoryLoad[instrumentedDir];

  {report, runData} = Instrumentation`CoverageEvaluate[
    TestReport[testFiles, "ProgressReporting" -> True]
  ];

  Print[""];
  Print["Post-test kernel check:"];
  Print["  Kernels launched: ", Length[Kernels[]]];
  Print[""];

  If[MatchQ[runData, _Instrumentation`CoverageData],
    executionCoverageSuccess = True;
    Print["✓ CoverageEvaluate completed successfully!"],
    Print["✗ CoverageEvaluate failed: ", Head[runData]];
    executionCoverageSuccess = False
  ];
  Print[""];

  (* Generate execution coverage LCOV *)
  If[executionCoverageSuccess,
    Print["Generating execution coverage data..."];
    Instrumentation`CoverageProcess[runData, coverageDir, "tests.lcov"];
    Print["✓ Execution coverage written"],
    Print["Copying baseline as fallback..."];
    CopyFile[
      FileNameJoin[{coverageDir, "baseline.lcov"}],
      FileNameJoin[{coverageDir, "tests.lcov"}]
    ]
  ];

  (* === Test Results === *)
  Print["\n=== Test Results ==="];
  Print["Passed: ", report["TestsSucceededCount"]];
  Print["Failed: ", report["TestsFailedCount"]];
  Print["Aborted: ", Lookup[report, "TestsAbortedCount", 0]];

  (* Show failed tests if any *)
  If[report["TestsFailedCount"] > 0,
    Print["\nFailed tests:"];
    Do[
      If[result["Outcome"] =!= "Success",
        Print["  ", result["TestID"]];
        Print["    Outcome: ", result["Outcome"]];
        If[result["Outcome"] === "MessagesFailure",
          Print["    Expected messages: ", result["ExpectedMessages"]];
          Print["    Actual messages: ", Short[result["ActualMessages"], 3]];
        ];
        If[result["Outcome"] === "Failure",
          Print["    Expected: ", Short[result["ExpectedOutput"], 2]];
          Print["    Actual: ", Short[result["ActualOutput"], 2]];
        ];
      ],
      {result, Values[report["TestResults"]]}
    ]
  ];

  Print["\n=== Smoke Test Complete ==="];

  If[report["TestsFailedCount"] > 0 || Lookup[report, "TestsAbortedCount", 0] > 0,
    Print["✗ Tests failed"];
    Quit[1],
    Print["✓ All tests passed"];
    Quit[0]
  ]
];
