#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Coverage analysis for LongRunRisk paclet using Wolfram Instrumentation.
   Generates LCOV files for use with lcov/genhtml.

   Usage:
     wolframscript Tests/RunCoverage.wls [--mode=Auto|Baseline|Execution] [--verbose] [--no-html]

   Modes:
     Auto      - Try execution coverage, fall back to baseline if it fails (default)
     Baseline  - Only generate baseline coverage (code structure, no execution)
     Execution - Attempt execution coverage, fail if it doesn't work

   Options:
     --verbose, -v  - Print detailed progress information
     --no-html      - Skip HTML report generation (by default, generates and opens HTML report)
*)

Module[{
    (* Configuration *)
    coverageMode, verbose, generateHtml,
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
  generateHtml = True;

  Map[
    Function[arg,
      Which[
        StringMatchQ[arg, "--mode=" ~~ __],
          coverageMode = StringReplace[arg, "--mode=" -> ""],
        arg === "--verbose" || arg === "-v",
          verbose = True,
        arg === "--no-html",
          generateHtml = False
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

  (* === LCOV Post-Processing Helper ===
     The Instrumentation package creates FN (function) entries at the line where
     the function name starts, but DA (line data) entries only for lines with
     executable code. When a function definition spans multiple lines with the
     name on a different line than := and body, the FN line has no DA entry.
     This causes genhtml to report "unexpected category UNK" errors.

     This helper adds DA:line,0 entries for any FN line missing a DA entry.

     Patterns that cause FN/DA mismatch (validated against Instrumentation v1.10):
       - Function name split across lines: f[\n  x_\n] := body
       - := at end of line: f[x_] :=\n  body
       - /; at end of line: f[x_] /;\n  cond := body
       - /; condition := at line end: f[x_] /; cond :=\n  body
       - Optional argument split: f[x_,\n  y_:0] := body
       - Pattern test split: f[\n  x_?NumericQ\n] := body
       - Compound ( alone: f[x_] := (\n  body\n)
       - Association/List after :=\n: f[x_] :=\n  <|...|> or {...}

     Patterns that are SAFE (do NOT cause issues):
       - /. at end of line: x /.\n  {rule} is fine
       - List/Assoc opener same line: f[x_] := <|\n  ...|> is fine

     Note: LCOV format may use either:
       - FN:line,name (standard format)
       - FNL:index,line + FNA:index,count,name (Wolfram Instrumentation format)
     This function handles both. *)
  fixLcovForGenhtml[lcovPath_String] := Module[{
      content, lines, currentFile, fnLines, daLines,
      result, fileFnLines, fileDALines, missingDALines, newDAEntries,
      totalFixed
    },
    If[!FileExistsQ[lcovPath],
      Print["Warning: LCOV file not found: ", lcovPath];
      Return[$Failed]
    ];

    content = Import[lcovPath, "Text"];
    lines = StringSplit[content, "\n"];

    (* Track FN and DA lines per source file *)
    currentFile = None;
    fnLines = <||>;  (* file -> {line numbers} *)
    daLines = <||>;  (* file -> {line numbers} *)

    (* Parse LCOV to extract FN and DA line numbers per file *)
    Do[
      Which[
        (* Source file marker *)
        StringStartsQ[line, "SF:"],
          currentFile = StringDrop[line, 3];
          If[!KeyExistsQ[fnLines, currentFile], fnLines[currentFile] = {}];
          If[!KeyExistsQ[daLines, currentFile], daLines[currentFile] = {}],
        (* Function definition line - standard format: FN:line,name *)
        StringStartsQ[line, "FN:"] && currentFile =!= None,
          Module[{parts, lineNum},
            parts = StringSplit[StringDrop[line, 3], ","];
            If[Length[parts] >= 1,
              lineNum = ToExpression[parts[[1]]];
              If[IntegerQ[lineNum],
                AppendTo[fnLines[currentFile], lineNum]
              ]
            ]
          ],
        (* Function definition line - Wolfram format: FNL:index,line *)
        StringStartsQ[line, "FNL:"] && currentFile =!= None,
          Module[{parts, lineNum},
            parts = StringSplit[StringDrop[line, 4], ","];
            If[Length[parts] >= 2,
              lineNum = ToExpression[parts[[2]]];
              If[IntegerQ[lineNum],
                AppendTo[fnLines[currentFile], lineNum]
              ]
            ]
          ],
        (* Line data: DA:line,count *)
        StringStartsQ[line, "DA:"] && currentFile =!= None,
          Module[{parts, lineNum},
            parts = StringSplit[StringDrop[line, 3], ","];
            If[Length[parts] >= 1,
              lineNum = ToExpression[parts[[1]]];
              If[IntegerQ[lineNum],
                AppendTo[daLines[currentFile], lineNum]
              ]
            ]
          ],
        (* End of record resets current file *)
        line === "end_of_record",
          currentFile = None
      ],
      {line, lines}
    ];

    (* Build new LCOV content with missing DA entries added *)
    currentFile = None;
    result = {};
    totalFixed = 0;

    Do[
      Which[
        StringStartsQ[line, "SF:"],
          currentFile = StringDrop[line, 3];
          AppendTo[result, line],
        (* Insert missing DA entries before LF (lines found) or end_of_record *)
        (StringStartsQ[line, "LF:"] || line === "end_of_record") && currentFile =!= None,
          (* Find FN lines without DA entries for this file *)
          fileFnLines = Lookup[fnLines, currentFile, {}];
          fileDALines = Lookup[daLines, currentFile, {}];
          missingDALines = Complement[fileFnLines, fileDALines];

          (* Add DA:line,0 for each missing line *)
          If[Length[missingDALines] > 0,
            newDAEntries = ("DA:" <> ToString[#] <> ",0") & /@ Sort[missingDALines];
            result = Join[result, newDAEntries];
            totalFixed += Length[missingDALines];
            If[verbose,
              Print["  Added ", Length[missingDALines], " missing DA entries for ", FileBaseName[currentFile]]
            ]
          ];

          AppendTo[result, line];
          If[line === "end_of_record", currentFile = None],
        True,
          AppendTo[result, line]
      ],
      {line, lines}
    ];

    (* Write fixed LCOV file *)
    Export[lcovPath, StringRiffle[result, "\n"], "Text"];

    totalFixed
  ];

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

        (* Skip Resources (contains Models.wl which gets run as test) *)
        If[subdirName =!= "Resources",
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
  fixLcovForGenhtml[FileNameJoin[{coverageDir, "baseline.lcov"}]];

  (* === Prepare test files === *)
  (* Find all .wlt files in Tests/ recursively *)
  allFiles = FileNames["*.wlt", testsRoot, Infinity];

  (* Exclude non-automated test directories *)
  excludedDirs = {"InteractiveTests", "GenerateCITests"};
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
    Instrumentation`CoverageProcess[runData, coverageDir, "tests.lcov"];
    fixLcovForGenhtml[FileNameJoin[{coverageDir, "tests.lcov"}]],
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
  Print["  (LCOV files post-processed for genhtml compatibility)"];

  (* Generate HTML report or print instructions *)
  If[generateHtml,
    (* Run lcov/genhtml to generate HTML report *)
    Print["\n=== Generating HTML Coverage Report ==="];
    Module[{lcovResult, genhtmlResult, openResult, htmlIndexPath},
      (* Combine baseline and test coverage *)
      Print["Running lcov to combine coverage files..."];
      lcovResult = RunProcess[
        {"lcov", "-a", "build/coverage/baseline.lcov", "-a", "build/coverage/tests.lcov", "-o", "build/coverage/combined.lcov"},
        ProcessDirectory -> pacletRoot
      ];
      If[lcovResult["ExitCode"] =!= 0,
        Print["Error: lcov failed with exit code ", lcovResult["ExitCode"]];
        Print[lcovResult["StandardError"]];
        Print["\nTo generate HTML report manually, run:"];
        Print["  cd ", pacletRoot];
        Print["  lcov -a build/coverage/baseline.lcov -a build/coverage/tests.lcov -o build/coverage/combined.lcov"];
        Print["  genhtml build/coverage/combined.lcov -o build/coverage/html"];
        Print["  open build/coverage/html/index.html"],
        (* lcov succeeded, run genhtml *)
        Print["Running genhtml to create HTML report..."];
        genhtmlResult = RunProcess[
          {"genhtml", "build/coverage/combined.lcov", "-o", "build/coverage/html"},
          ProcessDirectory -> pacletRoot
        ];
        If[genhtmlResult["ExitCode"] =!= 0,
          Print["Error: genhtml failed with exit code ", genhtmlResult["ExitCode"]];
          Print[genhtmlResult["StandardError"]],
          (* genhtml succeeded, open in browser *)
          htmlIndexPath = FileNameJoin[{pacletRoot, "build", "coverage", "html", "index.html"}];
          Print["Opening coverage report: ", htmlIndexPath];
          openResult = RunProcess[{"open", htmlIndexPath}];
          If[openResult["ExitCode"] =!= 0,
            Print["Note: Could not open browser automatically. Open manually: ", htmlIndexPath]
          ]
        ]
      ]
    ],
    (* Just print instructions *)
    Print["\nTo generate HTML report, run:"];
    Print["  cd ", pacletRoot];
    Print["  lcov -a build/coverage/baseline.lcov -a build/coverage/tests.lcov -o build/coverage/combined.lcov"];
    Print["  genhtml build/coverage/combined.lcov -o build/coverage/html"];
    Print["  open build/coverage/html/index.html"]
  ];

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
