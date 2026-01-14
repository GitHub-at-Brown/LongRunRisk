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

(* -------------------------------------------------------------------------- *)
(* Parse command-line arguments                                               *)
(* -------------------------------------------------------------------------- *)

$showHelp = hasFlag["--help", "-h"];
$verbose = hasFlag["--verbose", "-v"];
$runLocal = hasFlag["--local", "-l"];
$runSimulate = hasFlag["--simulate", "-s"];
$runCICD = hasFlag["--cicd", "-c"];
$runAll = hasFlag["--all", "-a"];
$debug = TrueQ[Interpreter["Boolean"][Environment["DEBUG"]]];

(* Internal flag: run in subprocess mode (skip spawning, run directly) *)
$subprocessMode = hasFlag["--subprocess"];

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
  printToStdout["  --verbose, -v    Show detailed progress"];
  printToStdout["  --help, -h       Show this help message"];
  printToStdout["  --dir <path>     Test directory (relative to paclet root or absolute)"];
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
    "ProgressReporting" -> $verbose
  ];
  duration = AbsoluteTime[] - startTime;

  (* Report results *)
  passed = report["TestsSucceededCount"];
  failed = report["TestsFailedCount"];
  total = passed + failed;

  printToStdout[""];
  printToStdout["Results: ", passed, "/", total, " passed (",
    ToString[NumberForm[100.0 * passed / Max[total, 1], {4, 1}]], "%)"];
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
  {testFiles, report, passed, failed, total, startTime, duration,
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
    TestReport[testFiles, "ProgressReporting" -> $verbose],

    (* Restore context *)
    $Context = savedContext;
    $ContextPath = savedContextPath
  ];

  duration = AbsoluteTime[] - startTime;

  (* Check results by outcome *)
  outcomeResults = report["ResultsByOutcome"];

  passed = report["TestsSucceededCount"];
  failed = report["TestsFailedCount"];
  total = passed + failed;

  printToStdout[""];
  printToStdout["Results: ", passed, "/", total, " passed (",
    ToString[NumberForm[100.0 * passed / Max[total, 1], {4, 1}]], "%)"];
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
   useMarkdownSummary, useWorkflowValue},

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

  (* Run tests using PacletCICD TestPaclet *)
  res = Wolfram`PacletCICD`Private`noExit @ Block[
    {
      Print = printToStdout,
      DefinitionNotebookClient`BeginConsoleGroup,
      DefinitionNotebookClient`EndConsoleGroup
    },
    Wolfram`PacletCICD`TestPaclet[
      $testsDir,
      "AnnotateTestIDs" -> False,
      "Debug" -> $debug,
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

(* Determine execution mode:
   - If only one modality requested, or in subprocess mode: run directly
   - If multiple modalities requested: spawn subprocesses for isolation *)

If[$subprocessMode || $modalityCount == 1,
  (* Direct execution mode *)
  printToStdout["Paclet root: ", $pacletRoot];
  printToStdout["Test directory: ", $testsDir];

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
