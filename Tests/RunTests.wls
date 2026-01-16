#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Unified test runner supporting three testing modalities:

   Modalities:
     --local, -l      Local testing with PacletDirectoryLoad (fastest)
     --simulate, -s   PacletCICD environment simulation (catches context issues)
     --cicd, -c       Full PacletCICD TestPaclet (matches GitHub Actions)
     --all, -a        Run all three modalities sequentially (each in fresh kernel)

   Options:
     --verbose, -v    Show detailed progress
     --help, -h       Show this help message
     --dir <path>     Test directory (relative to paclet root or absolute)
     --test-category  Test category: core, extended, or all (default: all locally, core in CI)
     --coverage       Enable coverage instrumentation (generates LCOV files)
     --coverage-mode  Coverage mode: Auto, Baseline, or Execution (default: Auto)

   Test categories:
     core       Fast tests (untagged) - run on every PR
     extended   Slow tests (tagged with MetaInformation) - run manually
     all        Run all tests regardless of category

   Coverage modes:
     Auto       Try execution coverage; fall back to baseline if instrumentation fails
     Baseline   Generate code structure only (no execution tracking)
     Execution  Require execution coverage; fail if instrumentation doesn't work

   Coverage output (build/coverage/):
     baseline.lcov   Code structure (all instrumentable lines)
     tests.lcov      Lines executed during tests (or copy of baseline if execution failed)
     Use lcov to combine: lcov -a baseline.lcov -a tests.lcov -o combined.lcov
     Generate HTML:       genhtml combined.lcov -o html/

   Environment variables:
     LONGRUNRISK_TESTS_DIR   Alternative to --dir
     PACLET_CICD_VERSION     PacletCICD version (default: 0.36.2)
     DEBUG                   Enable debug output in Wolfram`PacletCICD`TestPaclet

   Examples:
     wolframscript Tests/RunTests.wls --local
     wolframscript Tests/RunTests.wls --simulate --verbose
     wolframscript Tests/RunTests.wls --cicd --dir Tests/FindRootOptim
     wolframscript Tests/RunTests.wls --all
     wolframscript Tests/RunTests.wls                 # defaults to --cicd
     wolframscript Tests/RunTests.wls --cicd --coverage  # with coverage
     wolframscript Tests/RunTests.wls --cicd --coverage --coverage-mode Baseline
     wolframscript Tests/RunTests.wls --cicd --test-category core    # fast tests only
     wolframscript Tests/RunTests.wls --cicd --test-category extended  # slow tests only

   Logging (via shell redirection):
     wolframscript Tests/RunTests.wls --verbose > tests.log 2>&1      # save to file
     wolframscript Tests/RunTests.wls --verbose 2>&1 | tee tests.log  # save and display

   Exit codes:
     0 - All tests passed in all requested modalities
     1 - One or more tests failed or error occurred

   Note: When multiple modalities are requested (--all or combinations),
   each runs in a separate kernel process for true isolation.
*)

(* -------------------------------------------------------------------------- *)
(* Utilities                                                                  *)
(* -------------------------------------------------------------------------- *)

printToStdout[a___] := WriteString["stdout", a, "\n"];

printSection[title_] := (
  printToStdout[""];
  printToStdout[StringJoin[Table["=", 70]]];
  printToStdout["  ", title];
  printToStdout[StringJoin[Table["=", 70]]];
);

hasFlag[flags__] := AnyTrue[{flags}, MemberQ[$ScriptCommandLine, #] &];

getFlagValue[flag_] := Module[{pos},
  pos = FirstPosition[$ScriptCommandLine, flag, None];
  If[pos =!= None && pos[[1]] < Length[$ScriptCommandLine],
    $ScriptCommandLine[[pos[[1]] + 1]],
    None
  ]
];

(* Format a percentage (matching PacletCICD's percentForm) *)
percentForm[0] := "0%";
percentForm[1] := "100%";
percentForm[p_] := ToString[NumberForm[100 * p, {4, 1}]] <> "%";

(* Format duration in human-readable format (matching PacletCICD's timeText) *)
formatDuration[sec_?NumberQ] := Module[{ms, s, m, h},
  ms = sec * 1000;
  Which[
    ms < 1, "< 1 ms",
    ms < 1000, ToString[Round[ms, 0.1]] <> " ms",
    sec < 60, ToString[Round[sec, 0.1]] <> " seconds",
    sec < 3600,
      m = Floor[sec / 60];
      s = Round[Mod[sec, 60]];
      StringJoin[
        ToString[m], If[m == 1, " minute", " minutes"],
        If[s > 0, " " <> ToString[s] <> If[s == 1, " second", " seconds"], ""]
      ],
    True,
      h = Floor[sec / 3600];
      m = Floor[Mod[sec, 3600] / 60];
      StringJoin[
        ToString[h], If[h == 1, " hour", " hours"],
        If[m > 0, " " <> ToString[m] <> If[m == 1, " minute", " minutes"], ""]
      ]
  ]
];

(* Format duration for per-file rows (shorter format) *)
formatFileDuration[sec_?NumberQ] := Module[{ms},
  ms = sec * 1000;
  Which[
    ms < 1, "< 1 ms",
    ms < 1000, ToString[Round[ms, 0.1]] <> " ms",
    sec < 60, ToString[Round[sec, 0.1]] <> " s",
    True, ToString[Round[sec / 60, 0.1]] <> " min"
  ]
];

(* -------------------------------------------------------------------------- *)
(* Parse command-line arguments                                               *)
(* -------------------------------------------------------------------------- *)

$showHelp = hasFlag["--help", "-h"];
$verbose = hasFlag["--verbose", "-v"];
$runLocal = hasFlag["--local", "-l"];
$runSimulate = hasFlag["--simulate", "-s"];
$runCICD = hasFlag["--cicd", "-c"];
$runAll = hasFlag["--all", "-a"];
$debugMode = TrueQ[Interpreter["Boolean"][Environment["DEBUG"]]];
$runCoverage = hasFlag["--coverage"];
$coverageMode = Replace[getFlagValue["--coverage-mode"], None -> "Auto"];

(* Test category flag: core, extended, or all *)
$testCategory = Replace[getFlagValue["--test-category"], None -> "all"];

(* Internal flag: run in subprocess mode (skip spawning, run directly) *)
$subprocessMode = hasFlag["--subprocess"];

(* Validate coverage mode *)
If[$runCoverage && !MemberQ[{"Auto", "Baseline", "Execution"}, $coverageMode],
  printToStdout["Error: Invalid coverage mode '", $coverageMode, "'. Use Auto, Baseline, or Execution."];
  Exit[1]
];

(* Validate test category *)
If[!MemberQ[{"core", "extended", "all"}, $testCategory],
  printToStdout["Error: Invalid test category '", $testCategory, "'. Use core, extended, or all."];
  Exit[1]
];

(* Default to "core" in CI environment if no category specified *)
If[getFlagValue["--test-category"] === None && Environment["GITHUB_ACTIONS"] === "true",
  $testCategory = "core"
];

(* Show help and exit *)
If[$showHelp,
  printToStdout["Usage: wolframscript Tests/RunTests.wls [OPTIONS]"];
  printToStdout[""];
  printToStdout["Modalities:"];
  printToStdout["  --local, -l      Local testing with PacletDirectoryLoad (fastest)"];
  printToStdout["  --simulate, -s   PacletCICD environment simulation (catches context issues)"];
  printToStdout["  --cicd, -c       Full PacletCICD TestPaclet (matches GitHub Actions)"];
  printToStdout["  --all, -a        Run all three modalities sequentially (each in fresh kernel)"];
  printToStdout[""];
  printToStdout["Options:"];
  printToStdout["  --verbose, -v        Show detailed progress"];
  printToStdout["  --help, -h           Show this help message"];
  printToStdout["  --dir <path>         Test directory (relative to paclet root or absolute)"];
  printToStdout["  --test-category      Test category: core, extended, or all (default: all locally, core in CI)"];
  printToStdout["  --coverage           Enable coverage instrumentation (generates LCOV files)"];
  printToStdout["  --coverage-mode      Coverage mode: Auto, Baseline, or Execution (default: Auto)"];
  printToStdout[""];
  printToStdout["Test categories:"];
  printToStdout["  core       Fast tests (untagged) - run on every PR"];
  printToStdout["  extended   Slow tests (tagged with MetaInformation) - run manually"];
  printToStdout["  all        Run all tests regardless of category"];
  printToStdout[""];
  printToStdout["Coverage modes:"];
  printToStdout["  Auto       Try execution coverage; fall back to baseline if it fails"];
  printToStdout["  Baseline   Code structure only (no execution tracking)"];
  printToStdout["  Execution  Require execution coverage; fail if instrumentation fails"];
  printToStdout[""];
  printToStdout["Coverage output (build/coverage/):"];
  printToStdout["  baseline.lcov   Code structure (all instrumentable lines)"];
  printToStdout["  tests.lcov      Lines executed during tests"];
  printToStdout[""];
  printToStdout["Environment variables:"];
  printToStdout["  LONGRUNRISK_TESTS_DIR   Alternative to --dir"];
  printToStdout["  PACLET_CICD_VERSION     PacletCICD version (default: 0.36.2)"];
  printToStdout["  DEBUG                   Enable debug output"];
  printToStdout[""];
  printToStdout["Default: --cicd (for backward compatibility with CI)"];
  Exit[0]
];

(* Default to --cicd if no modality specified *)
If[!$runLocal && !$runSimulate && !$runCICD && !$runAll,
  $runCICD = True
];

(* --all enables all modalities *)
If[$runAll,
  $runLocal = True;
  $runSimulate = True;
  $runCICD = True;
];

(* Count how many modalities are requested *)
$modalityCount = Count[{$runLocal, $runSimulate, $runCICD}, True];

(* -------------------------------------------------------------------------- *)
(* Find paclet root and test directory                                        *)
(* -------------------------------------------------------------------------- *)

$scriptPath = $InputFileName;
$testsRoot = DirectoryName[$scriptPath];
$pacletRoot = $testsRoot;
While[
  !FileExistsQ[FileNameJoin[{$pacletRoot, "PacletInfo.wl"}]] &&
    $pacletRoot =!= DirectoryName[$pacletRoot],
  $pacletRoot = DirectoryName[$pacletRoot]
];

If[!FileExistsQ[FileNameJoin[{$pacletRoot, "PacletInfo.wl"}]],
  printToStdout["::error::Could not locate PacletInfo.wl"];
  Exit[1]
];

(* Get test directory from --dir flag, environment, or default *)
$testsDir = Module[{fromFlag, fromEnv, raw, abs, rel},
  fromFlag = getFlagValue["--dir"];
  fromEnv = Replace[Environment["LONGRUNRISK_TESTS_DIR"], Except[_String] -> None];
  raw = If[fromFlag =!= None, fromFlag, fromEnv];

  Which[
    raw === None,
      $pacletRoot,
    DirectoryQ[abs = ExpandFileName[raw]],
      abs,
    DirectoryQ[rel = FileNameJoin[{$pacletRoot, raw}]],
      rel,
    True,
      printToStdout["::error::Invalid test directory: ", raw];
      printToStdout["::error::Expected an existing directory (absolute or relative to paclet root)."];
      Exit[1]
  ]
];

(* -------------------------------------------------------------------------- *)
(* Coverage instrumentation support                                           *)
(* -------------------------------------------------------------------------- *)

(* Coverage paths - initialized when coverage is enabled *)
$kernelDir = FileNameJoin[{$pacletRoot, "Kernel"}];
$resourcesDir = FileNameJoin[{$pacletRoot, "Resources"}];
$instrumentedDir = FileNameJoin[{$pacletRoot, "build", "coverage-instrumented"}];
$instrumentedKernel = FileNameJoin[{$instrumentedDir, "Kernel"}];
$coverageDir = FileNameJoin[{$pacletRoot, "build", "coverage"}];

(* Coverage state *)
$coverageBaseline = None;
$coverageRunData = None;
$executionCoverageSuccess = False;

(* LCOV post-processing helper: adds DA:line,0 entries for FN lines missing DA entries.
   This fixes "unexpected category UNK" errors in genhtml. *)
fixLcovForGenhtml[lcovPath_String] := Module[{
    content, lines, currentFile, fnLines, daLines,
    result, fileFnLines, fileDALines, missingDALines, newDAEntries,
    totalFixed
  },
  If[!FileExistsQ[lcovPath],
    If[$verbose, printToStdout["Warning: LCOV file not found: ", lcovPath]];
    Return[$Failed]
  ];

  content = Import[lcovPath, "Text"];
  lines = StringSplit[content, "\n"];

  (* Track FN and DA lines per source file *)
  currentFile = None;
  fnLines = <||>;
  daLines = <||>;

  (* Parse LCOV to extract FN and DA line numbers per file *)
  Do[
    Which[
      StringStartsQ[line, "SF:"],
        currentFile = StringDrop[line, 3];
        If[!KeyExistsQ[fnLines, currentFile], fnLines[currentFile] = {}];
        If[!KeyExistsQ[daLines, currentFile], daLines[currentFile] = {}],
      StringStartsQ[line, "FN:"] && currentFile =!= None,
        Module[{parts, lineNum},
          parts = StringSplit[StringDrop[line, 3], ","];
          If[Length[parts] >= 1,
            lineNum = ToExpression[parts[[1]]];
            If[IntegerQ[lineNum], AppendTo[fnLines[currentFile], lineNum]]
          ]
        ],
      StringStartsQ[line, "FNL:"] && currentFile =!= None,
        Module[{parts, lineNum},
          parts = StringSplit[StringDrop[line, 4], ","];
          If[Length[parts] >= 2,
            lineNum = ToExpression[parts[[2]]];
            If[IntegerQ[lineNum], AppendTo[fnLines[currentFile], lineNum]]
          ]
        ],
      StringStartsQ[line, "DA:"] && currentFile =!= None,
        Module[{parts, lineNum},
          parts = StringSplit[StringDrop[line, 3], ","];
          If[Length[parts] >= 1,
            lineNum = ToExpression[parts[[1]]];
            If[IntegerQ[lineNum], AppendTo[daLines[currentFile], lineNum]]
          ]
        ],
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
      (StringStartsQ[line, "LF:"] || line === "end_of_record") && currentFile =!= None,
        fileFnLines = Lookup[fnLines, currentFile, {}];
        fileDALines = Lookup[daLines, currentFile, {}];
        missingDALines = Complement[fileFnLines, fileDALines];
        If[Length[missingDALines] > 0,
          newDAEntries = ("DA:" <> ToString[#] <> ",0") & /@ Sort[missingDALines];
          result = Join[result, newDAEntries];
          totalFixed += Length[missingDALines]
        ];
        AppendTo[result, line];
        If[line === "end_of_record", currentFile = None],
      True,
        AppendTo[result, line]
    ],
    {line, lines}
  ];

  Export[lcovPath, StringRiffle[result, "\n"], "Text"];
  totalFixed
];

(* Setup coverage instrumentation before tests run *)
setupCoverageInstrumentation[] := Module[{testSubdirs, instrumentedTestsDir},
  printToStdout[""];
  printToStdout["=== Setting up coverage instrumentation ==="];
  printToStdout["Coverage mode: ", $coverageMode];

  (* Clean and create output directories *)
  If[DirectoryQ[$instrumentedDir], DeleteDirectory[$instrumentedDir, DeleteContents -> True]];
  If[DirectoryQ[$coverageDir], DeleteDirectory[$coverageDir, DeleteContents -> True]];
  CreateDirectory[$instrumentedDir, CreateIntermediateDirectories -> True];
  CreateDirectory[$coverageDir, CreateIntermediateDirectories -> True];

  (* Copy PacletInfo.wl so paclet resolution works *)
  If[FailureQ[CopyFile[
    FileNameJoin[{$pacletRoot, "PacletInfo.wl"}],
    FileNameJoin[{$instrumentedDir, "PacletInfo.wl"}]
  ]],
    printToStdout["::error::Failed to copy PacletInfo.wl"];
    Return[$Failed]
  ];

  (* Copy Resources directory *)
  If[DirectoryQ[$resourcesDir],
    If[FailureQ[CopyDirectory[$resourcesDir, FileNameJoin[{$instrumentedDir, "Resources"}]]],
      printToStdout["::error::Failed to copy Resources directory"];
      Return[$Failed]
    ]
  ];

  (* Copy test data files (but not as instrumented code) *)
  instrumentedTestsDir = FileNameJoin[{$instrumentedDir, "Tests"}];
  CreateDirectory[instrumentedTestsDir, CreateIntermediateDirectories -> True];
  testSubdirs = Select[FileNames["*", $testsRoot], DirectoryQ];

  Do[
    Module[{subdirName, targetSubdir, subDataFiles},
      subdirName = FileBaseName[subdir];
      If[subdirName =!= "Resources",
        subDataFiles = FileNames["*.wl", subdir, 1];
        subDataFiles = Select[subDataFiles, !StringEndsQ[#, ".wlt"] &];
        If[Length[subDataFiles] > 0,
          targetSubdir = FileNameJoin[{instrumentedTestsDir, subdirName}];
          CreateDirectory[targetSubdir, CreateIntermediateDirectories -> True];
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
  ];

  (* Load Instrumentation package *)
  Needs["Instrumentation`"];
  If[$verbose,
    printToStdout["Instrumentation version: ", PacletFind["Instrumentation"][[1]]["Version"]]
  ];

  (* Instrument Kernel/ *)
  printToStdout["Instrumenting source files..."];
  $coverageBaseline = Instrumentation`CoverageInstrument[$kernelDir, $instrumentedKernel];

  If[FailureQ[$coverageBaseline],
    printToStdout["::error::CoverageInstrument failed: ", $coverageBaseline];
    Return[$Failed]
  ];

  (* Generate baseline LCOV *)
  printToStdout["Generating baseline coverage (code structure)..."];
  Instrumentation`CoverageProcess[$coverageBaseline, $coverageDir, "baseline.lcov"];
  fixLcovForGenhtml[FileNameJoin[{$coverageDir, "baseline.lcov"}]];

  (* Switch to instrumented paclet *)
  printToStdout["Switching to instrumented paclet..."];
  PacletDirectoryUnload[$pacletRoot];
  PacletDirectoryLoad[$instrumentedDir];

  printToStdout["Coverage instrumentation ready."];
  True
];

(* Finalize coverage after tests complete *)
finalizeCoverage[] := Module[{},
  printToStdout[""];
  printToStdout["=== Finalizing coverage ==="];

  If[$executionCoverageSuccess && MatchQ[$coverageRunData, _Instrumentation`CoverageData],
    printToStdout["Generating execution coverage data..."];
    Instrumentation`CoverageProcess[$coverageRunData, $coverageDir, "tests.lcov"];
    fixLcovForGenhtml[FileNameJoin[{$coverageDir, "tests.lcov"}]],
    (* Fall back: copy baseline as placeholder *)
    printToStdout["Using baseline as tests.lcov (no execution tracking)"];
    CopyFile[
      FileNameJoin[{$coverageDir, "baseline.lcov"}],
      FileNameJoin[{$coverageDir, "tests.lcov"}],
      OverwriteTarget -> True
    ]
  ];

  (* Restore original paclet *)
  PacletDirectoryUnload[$instrumentedDir];
  PacletDirectoryLoad[$pacletRoot];

  printToStdout["Coverage files generated:"];
  printToStdout["  ", FileNameJoin[{$coverageDir, "baseline.lcov"}]];
  printToStdout["  ", FileNameJoin[{$coverageDir, "tests.lcov"}]];
];

(* -------------------------------------------------------------------------- *)
(* Test category filtering via TestEvaluationFunction                         *)
(* -------------------------------------------------------------------------- *)

(* TestEvaluationFunction that skips tests based on category.
   Tests with MetaInformation -> <|"Category" -> "extended"|> are extended.
   Untagged tests (MetaInformation is None or missing Category) are core. *)
$categoryTestEvaluationFunction = Function[
  Module[{meta, rawCat, cat},
    meta = #["MetaInformation"];
    rawCat = If[AssociationQ[meta], Lookup[meta, "Category", "core"], "core"];
    (* Normalize to lowercase for comparison *)
    cat = ToLowerCase[ToString[rawCat]];
    If[
      $testCategory === "all" ||
      ($testCategory === "core" && cat === "core") ||
      ($testCategory === "extended" && cat === "extended"),
      TestEvaluate[#],
      #  (* Skip - return unevaluated *)
    ]
  ]
];

(* -------------------------------------------------------------------------- *)
(* Subprocess spawning for kernel isolation                                   *)
(* -------------------------------------------------------------------------- *)

runModalityInSubprocess[modalityFlag_, modalityName_] := Module[
  {args, dirFlag, result},

  printSection["MODALITY: " <> modalityName <> " (subprocess)"];
  printToStdout["Spawning fresh kernel..."];

  (* Build command-line arguments *)
  args = {"-file", $scriptPath, modalityFlag, "--subprocess"};

  (* Pass through --dir if specified *)
  dirFlag = getFlagValue["--dir"];
  If[dirFlag =!= None,
    args = Join[args, {"--dir", dirFlag}]
  ];

  (* Pass through --verbose if specified *)
  If[$verbose,
    args = Append[args, "--verbose"]
  ];

  (* Pass through --coverage if specified *)
  If[$runCoverage,
    args = Append[args, "--coverage"];
    args = Join[args, {"--coverage-mode", $coverageMode}]
  ];

  (* Pass through --test-category if specified *)
  args = Join[args, {"--test-category", $testCategory}];

  (* Run subprocess - inherits environment from parent *)
  result = RunProcess[Flatten[{"wolframscript", args}]];

  (* Print subprocess output *)
  If[StringLength[result["StandardOutput"]] > 0,
    WriteString["stdout", result["StandardOutput"]]
  ];
  If[StringLength[result["StandardError"]] > 0,
    WriteString["stderr", result["StandardError"]]
  ];

  result["ExitCode"] === 0
];

(* -------------------------------------------------------------------------- *)
(* Modality: Local Testing                                                   *)
(* -------------------------------------------------------------------------- *)

runLocalTests[] := Module[
  {testFiles, report, passed, failed, total, startTime, duration},

  printSection["MODALITY: Local Testing (PacletDirectoryLoad)"];

  (* Load paclet *)
  printToStdout["Loading paclet..."];
  If[FailureQ[PacletDirectoryLoad[$pacletRoot]],
    printToStdout["::error::Failed to load paclet"];
    Return[$Failed]
  ];

  (* Find test files *)
  testFiles = Sort[FileNames["*.wlt", $testsDir, Infinity]];
  If[Length[testFiles] == 0,
    printToStdout["::warning::No .wlt files found in ", $testsDir];
    Return[True]
  ];
  printToStdout["Found ", Length[testFiles], " test files"];

  (* Run tests *)
  startTime = AbsoluteTime[];
  report = TestReport[
    testFiles,
    "ProgressReporting" -> $verbose,
    TestEvaluationFunction -> $categoryTestEvaluationFunction
  ];
  duration = AbsoluteTime[] - startTime;

  (* Report results - count by outcome, excluding NotEvaluated (skipped) *)
  passed = report["TestsSucceededCount"];
  failed = report["TestsFailedCount"];
  skipped = Length[report["TestsNotEvaluatedIndices"]];
  total = passed + failed;

  printToStdout[""];
  printToStdout["Results: ", passed, "/", total, " passed (",
    ToString[NumberForm[100.0 * passed / Max[total, 1], {4, 1}]], "%)"];
  If[skipped > 0,
    printToStdout["Not requested: ", skipped, " tests (category: ", $testCategory, ")"]
  ];
  printToStdout["Duration: ", ToString[NumberForm[duration, {5, 2}]], " seconds"];

  If[failed > 0,
    printToStdout[""];
    printToStdout["Failed tests:"];
    Scan[printToStdout["  - ", #["TestID"]] &, Values[report["TestsFailed"]]];
  ];

  failed == 0
];

(* -------------------------------------------------------------------------- *)
(* Modality: PacletCICD Environment Simulation                               *)
(* -------------------------------------------------------------------------- *)

runSimulateTests[] := Module[
  {testFiles, report, passed, failed, skipped, total, startTime, duration,
   savedContext, savedContextPath, outcomeResults},

  printSection["MODALITY: PacletCICD Environment Simulation"];

  (* Load paclet first (needed for resource resolution) *)
  printToStdout["Loading paclet..."];
  If[FailureQ[PacletDirectoryLoad[$pacletRoot]],
    printToStdout["::error::Failed to load paclet"];
    Return[$Failed]
  ];

  (* Find test files *)
  testFiles = Sort[FileNames["*.wlt", $testsDir, Infinity]];
  If[Length[testFiles] == 0,
    printToStdout["::warning::No .wlt files found in ", $testsDir];
    Return[True]
  ];
  printToStdout["Found ", Length[testFiles], " test files"];
  printToStdout["Running with isolated context (simulating PacletCICD)..."];

  (* Save current context state *)
  savedContext = $Context;
  savedContextPath = $ContextPath;

  startTime = AbsoluteTime[];

  (* Run tests in isolated context like PacletCICD does *)
  report = WithCleanup[
    (* Set minimal context path like PacletCICD *)
    $Context = "PacletCICDSimulation`";
    $ContextPath = {"PacletCICDSimulation`", "System`"},

    (* Run tests *)
    TestReport[
      testFiles,
      "ProgressReporting" -> $verbose,
      TestEvaluationFunction -> $categoryTestEvaluationFunction
    ],

    (* Restore context *)
    $Context = savedContext;
    $ContextPath = savedContextPath
  ];

  duration = AbsoluteTime[] - startTime;

  (* Check results by outcome *)
  outcomeResults = report["ResultsByOutcome"];

  passed = report["TestsSucceededCount"];
  failed = report["TestsFailedCount"];
  skipped = Length[report["TestsNotEvaluatedIndices"]];
  total = passed + failed;

  printToStdout[""];
  printToStdout["Results: ", passed, "/", total, " passed (",
    ToString[NumberForm[100.0 * passed / Max[total, 1], {4, 1}]], "%)"];
  If[skipped > 0,
    printToStdout["Not requested: ", skipped, " tests (category: ", $testCategory, ")"]
  ];
  printToStdout["Duration: ", ToString[NumberForm[duration, {5, 2}]], " seconds"];

  (* Check for specific failure types *)
  If[Length[outcomeResults["MessagesFailure"]] > 0,
    printToStdout[""];
    printToStdout["Message failures (unexpected messages): ", Length[outcomeResults["MessagesFailure"]]];
    If[$verbose,
      Scan[printToStdout["  - ", #["TestID"]] &, outcomeResults["MessagesFailure"]]
    ];
  ];

  If[Length[outcomeResults["Failure"]] > 0,
    printToStdout[""];
    printToStdout["Test failures: ", Length[outcomeResults["Failure"]]];
    Scan[printToStdout["  - ", #["TestID"]] &, outcomeResults["Failure"]];
  ];

  failed == 0
];

(* -------------------------------------------------------------------------- *)
(* Modality: Full PacletCICD                                                  *)
(* -------------------------------------------------------------------------- *)

runCICDTests[] := Module[
  {pacletCICDVersion, existingPaclet, needsInstall, pacletURL,
   installed, pacletCICDPath, res, isGitHubActions, consoleType,
   useMarkdownSummary, useWorkflowValue,
   testFiles, report, passed, failed, skipped, total, startTime, duration},

  printSection["MODALITY: PacletCICD (Full CI Environment)"];

  (* Detect GitHub Actions environment *)
  isGitHubActions = Environment["GITHUB_ACTIONS"] === "true";

  (* Adjust options based on environment *)
  consoleType = If[isGitHubActions, "GitHub", "Terminal"];
  useMarkdownSummary = isGitHubActions;
  useWorkflowValue = isGitHubActions;

  If[!isGitHubActions,
    printToStdout["Running locally (not in GitHub Actions)"]
  ];

  (* Get PacletCICD version from environment or use default *)
  pacletCICDVersion = Replace[Environment["PACLET_CICD_VERSION"], Except[_String] -> "0.36.2"];

  (* Check if PacletCICD is installed and up to date *)
  existingPaclet = PacletFind["Wolfram/PacletCICD"];
  needsInstall = If[existingPaclet === {},
    True,
    !OrderedQ[{pacletCICDVersion, existingPaclet[[1]]["Version"]}, VersionOrder]
  ];

  If[needsInstall,
    printToStdout["Installing Wolfram/PacletCICD version ", pacletCICDVersion, "..."];
    pacletURL = "https://github.com/WolframResearch/PacletCICD/releases/download/v" <>
      pacletCICDVersion <> "/Wolfram__PacletCICD-" <> pacletCICDVersion <> ".paclet";
    printToStdout["From: ", pacletURL];
    installed = PacletInstall[pacletURL];
    printToStdout["Installed: ", installed];
  ];

  pacletCICDPath = FindFile["Wolfram`PacletCICD`"];
  printToStdout["Loading Wolfram`PacletCICD` from ", pacletCICDPath];

  If[pacletCICDPath === $Failed,
    printToStdout["::error::Failed to find Wolfram`PacletCICD` after installation"];
    Return[$Failed]
  ];

  Needs["Wolfram`PacletCICD`"];

  printToStdout["Testing paclet at: ", $pacletRoot];
  printToStdout["Test discovery directory: ", $testsDir];

  (* When category filtering is enabled, use TestReport directly instead of TestPaclet
     because TestPaclet doesn't support TestEvaluationFunction.
     We run per-file like TestPaclet does to get the same report structure for artifacts. *)
  If[$testCategory =!= "all",
    Module[{reportsAssoc, appendSummary, setWFOutput},

      printToStdout["Using TestReport with category filter: ", $testCategory];

      (* Load paclet *)
      If[FailureQ[PacletDirectoryLoad[$pacletRoot]],
        printToStdout["::error::Failed to load paclet"];
        Return[$Failed]
      ];

      (* Find test files *)
      testFiles = Sort[FileNames["*.wlt", $testsDir, Infinity]];
      If[Length[testFiles] == 0,
        printToStdout["::warning::No .wlt files found in ", $testsDir];
        Return[True]
      ];
      printToStdout["Found ", Length[testFiles], " test files"];

      (* Run tests per-file like TestPaclet does - this builds the report structure
         needed for CI artifacts while only running tests ONCE *)
      startTime = AbsoluteTime[];
      reportsAssoc = Association[
        Function[file,
          Module[{rel, fileReport},
            rel = FileNameDrop[file, FileNameDepth[$pacletRoot]];
            If[$verbose, printToStdout["Testing: ", rel]];
            fileReport = TestReport[
              file,
              "ProgressReporting" -> $verbose,
              TestEvaluationFunction -> $categoryTestEvaluationFunction
            ];
            rel -> fileReport
          ]
        ] /@ testFiles
      ];
      duration = AbsoluteTime[] - startTime;

      (* Aggregate results from all file reports *)
      passed = Total[#["TestsSucceededCount"] & /@ Values[reportsAssoc]];
      failed = Total[#["TestsFailedCount"] & /@ Values[reportsAssoc]];
      (* Use ResultsByOutcome to count skipped tests - TestsNotEvaluatedIndices doesn't
         capture tests skipped via TestEvaluationFunction *)
      skipped = Total[Lookup[Length /@ #["ResultsByOutcome"], "NotEvaluated", 0] & /@ Values[reportsAssoc]];
      total = passed + failed;

      printToStdout[""];
      printToStdout["Results: ", passed, "/", total, " passed (",
        ToString[NumberForm[100.0 * passed / Max[total, 1], {4, 1}]], "%)"];
      If[skipped > 0,
        printToStdout["Not requested: ", skipped, " tests (category: ", $testCategory, ")"]
      ];
      printToStdout["Duration: ", ToString[NumberForm[duration, {5, 2}]], " seconds"];

      If[failed > 0,
        printToStdout[""];
        printToStdout["Failed tests:"];
        KeyValueMap[
          Function[{file, rep},
            If[rep["TestsFailedCount"] > 0,
              Scan[
                Function[result,
                  Module[{tid},
                    tid = result["TestID"];
                    (* Handle Missing TestID gracefully *)
                    If[MissingQ[tid], tid = "(unknown test in " <> file <> ")"];
                    printToStdout["  - ", tid]
                  ]
                ],
                Values[rep["TestsFailed"]]
              ]
            ]
          ],
          reportsAssoc
        ]
      ];

      (* Generate CI artifacts using PacletCICD's mechanisms for consistency *)
      If[isGitHubActions,
        printToStdout[""];
        printToStdout["Generating CI artifacts via PacletCICD..."];

        (* Use PacletCICD's appendStepSummary for markdown *)
        appendSummary = Wolfram`PacletCICD`Private`appendStepSummary;

        (* Generate summary table matching TestPaclet format *)
        Module[{fileCount, testCount, passRate, failRate, totalTime, resultIcon, resultText},
          fileCount = Length[reportsAssoc];
          testCount = passed + failed;
          passRate = If[testCount > 0, percentForm[passed / testCount], "N/A"];
          failRate = If[testCount > 0, percentForm[failed / testCount], "N/A"];
          totalTime = formatDuration[duration];
          resultIcon = If[failed > 0, ":x:", ":white_check_mark:"];
          resultText = If[failed > 0, "Failure", "Success"];

          appendSummary[StringJoin[
            "\n|                 |                          |\n",
            "|-----------------|--------------------------|",
            "\n| **Result**      | ", resultText, " ", resultIcon, " |\n",
            "| **Total files** | ", ToString[fileCount], " |\n",
            "| **Total tests** | ", ToString[testCount], " |\n",
            "| **Passed**      | ", ToString[passed], " (", passRate, ") |\n",
            "| **Failed**      | ", ToString[failed], " (", failRate, ") |\n",
            "| **Not requested** | ", ToString[skipped], " (", $testCategory, " category) |\n",
            "| **Duration**    | ", totalTime, " |\n",
            "\n### Test files\n\n",
            "| | File | Passed | Failed | Duration |\n",
            "|-|------|--------|--------|----------|\n"
          ]];
        ];

        (* Generate per-file rows like TestPaclet does - with links and human-readable durations *)
        Module[{ghServer, ghRepo, ghSha, makeFileLink},
          ghServer = Environment["GITHUB_SERVER_URL"];
          ghRepo = Environment["GITHUB_REPOSITORY"];
          ghSha = Environment["GITHUB_SHA"];

          (* Create file link if GitHub environment variables are available *)
          makeFileLink[relPath_] := Module[{split, url},
            If[StringQ[ghServer] && StringQ[ghRepo] && StringQ[ghSha],
              split = DeleteCases[FileNameSplit[relPath], "."];
              url = URLBuild[Flatten[{ghServer, ghRepo, "blob", ghSha, split}]];
              "[" <> StringRiffle[split, "/"] <> "](" <> url <> ")",
              relPath  (* Fallback to plain path *)
            ]
          ];

          KeyValueMap[
            Function[{file, rep},
              Module[{icon, p, f, timeStr, fileLink},
                p = rep["TestsSucceededCount"];
                f = rep["TestsFailedCount"];
                timeStr = formatFileDuration[rep["TimeElapsed"]];
                icon = If[f > 0, ":x:", ":white_check_mark:"];
                fileLink = makeFileLink[file];
                appendSummary[StringJoin[
                  "| ", icon, " | ", fileLink, " | ", ToString[p], " | ", ToString[f], " | ", timeStr, " |\n"
                ]];
              ]
            ],
            reportsAssoc
          ]
        ];

        (* Add failed test details if any - using collapsible HTML like PacletCICD *)
        If[failed > 0,
          appendSummary["\n\n<details><summary><h3>Details</h3></summary>\n\n"];
          KeyValueMap[
            Function[{file, rep},
              If[rep["TestsFailedCount"] > 0,
                Module[{header, failedTests},
                  header = StringRiffle[DeleteCases[FileNameSplit[file], "."], "/"];
                  appendSummary[StringJoin["<details><summary><h3>", header, "</h3></summary>\n\n"]];
                  failedTests = Values[rep["TestsFailed"]];
                  Scan[
                    Function[result,
                      Module[{testID, outcome, icon, timeTaken, memUsed, input, expected, actual,
                              expMsgs, actMsgs, outIcon, msgIcon, outcomeText},
                        (* Handle Missing values gracefully *)
                        testID = Replace[result["TestID"], _Missing -> "(unknown)"];
                        outcome = Replace[result["Outcome"], _Missing -> "Unknown"];
                        timeTaken = Replace[result["AbsoluteTimeUsed"], _Missing -> 0];
                        memUsed = Replace[result["MemoryUsed"], _Missing -> 0];
                        input = Replace[result["Input"], _Missing -> HoldForm["(unavailable)"]];
                        expected = Replace[result["ExpectedOutput"], _Missing -> HoldForm["(unavailable)"]];
                        actual = Replace[result["ActualOutput"], _Missing -> HoldForm["(unavailable)"]];
                        expMsgs = Replace[result["ExpectedMessages"], _Missing -> {}];
                        actMsgs = Replace[result["ActualMessages"], _Missing -> {}];

                        (* Format outcome icon and text *)
                        icon = Switch[ToString[outcome],
                          "Success", ":white_check_mark:",
                          "Failure", ":x:",
                          "MessagesFailure", ":large_orange_diamond:",
                          _, ":large_blue_circle:"
                        ];
                        outcomeText = Switch[ToString[outcome],
                          "MessagesFailure", "Message failure",
                          _, ToString[outcome]
                        ];

                        (* Format duration and memory *)
                        timeTaken = If[NumberQ[timeTaken] && timeTaken < 0.001, "< 1 ms",
                          ToString[Round[timeTaken * 1000, 0.1]] <> " ms"];
                        memUsed = If[NumberQ[memUsed],
                          ToString[NumberForm[memUsed / 1000, {5, 3}]] <> " kilobytes",
                          "N/A"];

                        (* Convert code to string *)
                        input = ToString[input, InputForm];
                        expected = ToString[expected, InputForm];
                        actual = ToString[actual, InputForm];
                        expMsgs = ToString[expMsgs, InputForm];
                        actMsgs = ToString[actMsgs, InputForm];

                        (* Icons for mismatches *)
                        outIcon = If[expected =!= actual, " :x:", ""];
                        msgIcon = If[expMsgs =!= actMsgs, " :x:", ""];

                        (* Generate table row + details matching PacletCICD format *)
                        appendSummary[StringJoin[
                          "\n---\n\n",
                          "| | Result | TestID | Duration | Memory | Link |\n",
                          "|---|--------|--------|----------|--------|------|\n",
                          "| ", icon, " | ", outcomeText, " | ", ToString[testID], " | ", timeTaken, " | ", memUsed, " | :link: |\n\n",
                          "| | |\n",
                          "|---|---|\n",
                          "| **Input** | `", input, "` |\n",
                          "| **ExpectedOutput** | `", expected, "` |\n",
                          "| **ActualOutput**", outIcon, " | `", actual, "` |\n",
                          "| **ExpectedMessages** | `", expMsgs, "` |\n",
                          "| **ActualMessages**", msgIcon, " | `", actMsgs, "` |\n\n"
                        ]];
                      ]
                    ],
                    failedTests
                  ];
                  appendSummary["</details>\n\n"];
                ]
              ]
            ],
            reportsAssoc
          ];
          appendSummary["\n\n</details>\n\n"];
        ];

        (* Store test results via PacletCICD's WorkflowValue mechanism *)
        setWFOutput = Wolfram`PacletCICD`Private`ghSetWFOutput;
        setWFOutput["TestPaclet", reportsAssoc];
        printToStdout["Stored test results via WorkflowValue"];
        printToStdout["Generated markdown summary via appendStepSummary"];
      ];

      Return[failed == 0]
    ]
  ];

  (* Run all tests using PacletCICD TestPaclet *)
  res = Wolfram`PacletCICD`Private`noExit @ Block[
    {
      Print = printToStdout,
      DefinitionNotebookClient`BeginConsoleGroup,
      DefinitionNotebookClient`EndConsoleGroup
    },
    Wolfram`PacletCICD`TestPaclet[
      $testsDir,
      "AnnotateTestIDs" -> False,
      "Debug" -> $debugMode,
      "ConsoleType" -> consoleType,
      "MarkdownSummary" -> useMarkdownSummary,
      "SetWorkflowValue" -> useWorkflowValue
    ]
  ];

  !(FailureQ[res] || MatchQ[res, _Wolfram`PacletCICD`TestPaclet])
];

(* -------------------------------------------------------------------------- *)
(* Main execution                                                             *)
(* -------------------------------------------------------------------------- *)

$results = <||>;

(* Setup coverage instrumentation if enabled *)
If[$runCoverage,
  If[FailureQ[setupCoverageInstrumentation[]],
    printToStdout["::error::Coverage instrumentation setup failed"];
    Exit[1]
  ]
];

(* Determine execution mode:
   - If only one modality requested, or in subprocess mode: run directly
   - If multiple modalities requested: spawn subprocesses for isolation *)

If[$subprocessMode || $modalityCount == 1,
  (* Direct execution mode *)
  printToStdout["Paclet root: ", $pacletRoot];
  printToStdout["Test directory: ", $testsDir];
  printToStdout["Test category: ", $testCategory];
  If[$runCoverage, printToStdout["Coverage: enabled (mode: ", $coverageMode, ")"]];

  If[$runLocal,
    $results["Local"] = runLocalTests[];
  ];

  If[$runSimulate,
    $results["Simulate"] = runSimulateTests[];
  ];

  If[$runCICD,
    $results["CICD"] = runCICDTests[];
  ];
,
  (* Subprocess mode for kernel isolation *)
  printToStdout["Paclet root: ", $pacletRoot];
  printToStdout["Test directory: ", $testsDir];
  printToStdout["Test category: ", $testCategory];
  If[$runCoverage, printToStdout["Coverage: enabled (mode: ", $coverageMode, ")"]];
  printToStdout[""];
  printToStdout["Running ", $modalityCount, " modalities in separate kernels for isolation..."];

  If[$runLocal,
    $results["Local"] = runModalityInSubprocess["--local", "Local Testing"];
  ];

  If[$runSimulate,
    $results["Simulate"] = runModalityInSubprocess["--simulate", "PacletCICD Simulation"];
  ];

  If[$runCICD,
    $results["CICD"] = runModalityInSubprocess["--cicd", "PacletCICD"];
  ];
];

(* Finalize coverage if enabled *)
If[$runCoverage,
  finalizeCoverage[]
];

(* Final summary if multiple modalities were run *)
If[Length[$results] > 1,
  printSection["SUMMARY"];
  KeyValueMap[
    Function[{modality, result},
      printToStdout["  ", modality, ": ",
        Which[
          result === True, "PASSED",
          result === False, "FAILED",
          True, "ERROR"
        ]
      ]
    ],
    $results
  ];
];

(* Exit with appropriate code *)
If[AllTrue[$results, TrueQ],
  Exit[0],
  Exit[1]
];
