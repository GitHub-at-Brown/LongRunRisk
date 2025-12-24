#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Smoke test for coverage script - testing parallel kernel compatibility *)

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

  Print["=== LongRunRisk Coverage Smoke Test (Parallel Kernels) ==="];
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

  Print["Instrumentation version: ", PacletFind["Instrumentation"][[1]]["Version"]];
  Print[""];

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

  (* === Single test file with parallel kernels === *)
  testFiles = {FileNameJoin[{testsRoot, "CreateMomentsDatabase.wlt"}]};

  If[!FileExistsQ[testFiles[[1]]],
    Print["Error: Test file not found: ", testFiles[[1]]];
    Quit[1]
  ];

  Print["Test file: ", testFiles[[1]]];
  Print["This test uses parallel kernels - checking compatibility..."];
  Print[""];

  (* Check initial parallel kernel state *)
  Print["Initial parallel kernel state:"];
  Print["  Kernels configured: ", $ConfiguredKernels];
  Print["  Kernels launched: ", Length[Kernels[]]];
  Print[""];

  (* === Run coverage evaluation === *)
  Print["Running CoverageEvaluate on test with parallel kernels..."];

  PacletDirectoryUnload[pacletRoot];
  PacletDirectoryLoad[instrumentedDir];

  (* Capture any errors or warnings during evaluation *)
  {report, runData} = Instrumentation`CoverageEvaluate[
    TestReport[testFiles, "ProgressReporting" -> True]
  ];

  Print[""];
  Print["Post-execution parallel kernel state:"];
  Print["  Kernels launched: ", Length[Kernels[]]];
  If[Length[Kernels[]] > 0,
    Print["  Parallel kernels were used during test execution"]
  ];
  Print[""];

  If[MatchQ[runData, _Instrumentation`CoverageData],
    executionCoverageSuccess = True;
    Print["✓ CoverageEvaluate completed successfully!"];
    Print["  Coverage tracking worked WITH parallel kernels!"],
    Print["✗ CoverageEvaluate failed: ", Head[runData]];
    Print["  This may be expected if Instrumentation doesn't support parallel kernels"];
    executionCoverageSuccess = False
  ];
  Print[""];

  (* Generate execution coverage LCOV *)
  If[executionCoverageSuccess,
    Print["Generating execution coverage data..."];
    Instrumentation`CoverageProcess[runData, coverageDir, "tests.lcov"];
    Print["✓ Execution coverage written"],
    Print["Copying baseline as fallback (coverage tracking failed)..."];
    CopyFile[
      FileNameJoin[{coverageDir, "baseline.lcov"}],
      FileNameJoin[{coverageDir, "tests.lcov"}]
    ];
    Print["Note: Test results are still valid even if coverage tracking failed"]
  ];

  (* === Test Results === *)
  Print["\n=== Test Results ==="];
  Print["Passed: ", report["TestsSucceededCount"]];
  Print["Failed: ", report["TestsFailedCount"]];
  Print["Aborted: ", Lookup[report, "TestsAbortedCount", 0]];

  (* Show any failed tests *)
  If[report["TestsFailedCount"] > 0,
    Print["\nFailed tests:"];
    Do[
      If[result["Outcome"] =!= "Success",
        Print["  ", result["TestID"], ": ", result["Outcome"]];
        If[result["Outcome"] === "MessagesFailure",
          Print["    Expected: ", result["ExpectedMessages"]];
          Print["    Actual: ", result["ActualMessages"]];
        ];
        If[result["Outcome"] === "Failure",
          Print["    Expected: ", Short[result["ExpectedOutput"], 2]];
          Print["    Actual: ", Short[result["ActualOutput"], 2]];
        ];
      ],
      {result, Values[report["TestResults"]]}
    ]
  ];

  Print["\n=== Coverage Files ==="];
  Print["Baseline: ", FileNameJoin[{coverageDir, "baseline.lcov"}]];
  Print["Tests:    ", FileNameJoin[{coverageDir, "tests.lcov"}]];

  Print["\n=== Parallel Kernel Compatibility ==="];
  If[executionCoverageSuccess,
    Print["✓ PASS: Coverage tracking works with parallel kernels"];
    Print["  The Instrumentation paclet successfully tracked coverage even with parallel execution."],
    Print["✗ FAIL: Coverage tracking incompatible with parallel kernels"];
    Print["  The Instrumentation paclet could not track coverage with parallel execution."];
    Print["  Tests may still pass, but coverage data will be incomplete."];
    Print["  Recommendation: Exclude tests using parallel kernels from CoverageEvaluate."]
  ];

  Print["\n=== Smoke Test Complete ==="];

  (* Close any parallel kernels *)
  If[Length[Kernels[]] > 0,
    Print["Closing parallel kernels..."];
    CloseKernels[];
  ];

  If[report["TestsFailedCount"] > 0 || Lookup[report, "TestsAbortedCount", 0] > 0,
    Print["✗ Tests failed"];
    Quit[1],
    Print["✓ All tests passed"];
    If[executionCoverageSuccess,
      Print["✓ Coverage tracking worked"],
      Print["⚠ Coverage tracking failed (but tests passed)"]
    ];
    Quit[0]
  ]
];
