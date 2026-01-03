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
     DEBUG                   Enable debug output

   Examples:
     wolframscript Tests/RunTests.wls --local
     wolframscript Tests/RunTests.wls --simulate --verbose
     wolframscript Tests/RunTests.wls --cicd --dir Tests/FindRootOptim
     wolframscript Tests/RunTests.wls --all
     wolframscript Tests/RunTests.wls                 # defaults to --cicd

   Exit codes:
     0 - All tests passed in all requested modalities
     1 - One or more tests failed or error occurred

   Note: When multiple modalities are requested (--all or combinations),
   each runs in a separate kernel process for true isolation.
*)

(* -------------------------------------------------------------------------- *)
(* Utilities                                                                  *)
(* -------------------------------------------------------------------------- *)

print[a___] := WriteString["stdout", a, "\n"];

printSection[title_] := (
  print[""];
  print[StringJoin[Table["=", 70]]];
  print["  ", title];
  print[StringJoin[Table["=", 70]]];
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
  print["Usage: wolframscript Tests/RunTests.wls [OPTIONS]"];
  print[""];
  print["Modalities:"];
  print["  --local, -l      Local testing with PacletDirectoryLoad (fastest)"];
  print["  --simulate, -s   PacletCICD environment simulation (catches context issues)"];
  print["  --cicd, -c       Full PacletCICD TestPaclet (matches GitHub Actions)"];
  print["  --all, -a        Run all three modalities sequentially (each in fresh kernel)"];
  print[""];
  print["Options:"];
  print["  --verbose, -v    Show detailed progress"];
  print["  --help, -h       Show this help message"];
  print["  --dir <path>     Test directory (relative to paclet root or absolute)"];
  print[""];
  print["Environment variables:"];
  print["  LONGRUNRISK_TESTS_DIR   Alternative to --dir"];
  print["  PACLET_CICD_VERSION     PacletCICD version (default: 0.36.2)"];
  print["  DEBUG                   Enable debug output"];
  print[""];
  print["Default: --cicd (for backward compatibility with CI)"];
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
  print["::error::Could not locate PacletInfo.wl"];
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
      print["::error::Invalid test directory: ", raw];
      print["::error::Expected an existing directory (absolute or relative to paclet root)."];
      Exit[1]
  ]
];

(* -------------------------------------------------------------------------- *)
(* Subprocess spawning for kernel isolation                                   *)
(* -------------------------------------------------------------------------- *)

runModalityInSubprocess[modalityFlag_, modalityName_] := Module[
  {args, dirFlag, result},

  printSection["MODALITY: " <> modalityName <> " (subprocess)"];
  print["Spawning fresh kernel..."];

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
  print["Loading paclet..."];
  If[FailureQ[PacletDirectoryLoad[$pacletRoot]],
    print["::error::Failed to load paclet"];
    Return[$Failed]
  ];

  (* Find test files *)
  testFiles = Sort[FileNames["*.wlt", $testsDir, Infinity]];
  If[Length[testFiles] == 0,
    print["::warning::No .wlt files found in ", $testsDir];
    Return[True]
  ];
  print["Found ", Length[testFiles], " test files"];

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

  print[""];
  print["Results: ", passed, "/", total, " passed (",
    ToString[NumberForm[100.0 * passed / Max[total, 1], {4, 1}]], "%)"];
  print["Duration: ", ToString[NumberForm[duration, {5, 2}]], " seconds"];

  If[failed > 0,
    print[""];
    print["Failed tests:"];
    Scan[print["  - ", #["TestID"]] &, Values[report["TestsFailed"]]];
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
  print["Loading paclet..."];
  If[FailureQ[PacletDirectoryLoad[$pacletRoot]],
    print["::error::Failed to load paclet"];
    Return[$Failed]
  ];

  (* Find test files *)
  testFiles = Sort[FileNames["*.wlt", $testsDir, Infinity]];
  If[Length[testFiles] == 0,
    print["::warning::No .wlt files found in ", $testsDir];
    Return[True]
  ];
  print["Found ", Length[testFiles], " test files"];
  print["Running with isolated context (simulating PacletCICD)..."];

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

  print[""];
  print["Results: ", passed, "/", total, " passed (",
    ToString[NumberForm[100.0 * passed / Max[total, 1], {4, 1}]], "%)"];
  print["Duration: ", ToString[NumberForm[duration, {5, 2}]], " seconds"];

  (* Check for specific failure types *)
  If[Length[outcomeResults["MessagesFailure"]] > 0,
    print[""];
    print["Message failures (unexpected messages): ", Length[outcomeResults["MessagesFailure"]]];
    If[$verbose,
      Scan[print["  - ", #["TestID"]] &, outcomeResults["MessagesFailure"]]
    ];
  ];

  If[Length[outcomeResults["Failure"]] > 0,
    print[""];
    print["Test failures: ", Length[outcomeResults["Failure"]]];
    Scan[print["  - ", #["TestID"]] &, outcomeResults["Failure"]];
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
    print["Running locally (not in GitHub Actions)"]
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
    print["Installing Wolfram/PacletCICD version ", pacletCICDVersion, "..."];
    pacletURL = "https://github.com/WolframResearch/PacletCICD/releases/download/v" <>
      pacletCICDVersion <> "/Wolfram__PacletCICD-" <> pacletCICDVersion <> ".paclet";
    print["From: ", pacletURL];
    installed = PacletInstall[pacletURL];
    print["Installed: ", installed];
  ];

  pacletCICDPath = FindFile["Wolfram`PacletCICD`"];
  print["Loading Wolfram`PacletCICD` from ", pacletCICDPath];

  If[pacletCICDPath === $Failed,
    print["::error::Failed to find Wolfram`PacletCICD` after installation"];
    Return[$Failed]
  ];

  Needs["Wolfram`PacletCICD`"];

  print["Testing paclet at: ", $pacletRoot];
  print["Test discovery directory: ", $testsDir];

  (* Run tests using PacletCICD TestPaclet *)
  res = Wolfram`PacletCICD`Private`noExit @ Block[
    {
      Print = print,
      DefinitionNotebookClient`BeginConsoleGroup,
      DefinitionNotebookClient`EndConsoleGroup
    },
    Wolfram`PacletCICD`TestPaclet[
      $testsDir,
      "AnnotateTestIDs" -> True,
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
  print["Paclet root: ", $pacletRoot];
  print["Test directory: ", $testsDir];

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
  print["Paclet root: ", $pacletRoot];
  print["Test directory: ", $testsDir];
  print[""];
  print["Running ", $modalityCount, " modalities in separate kernels for isolation..."];

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
      print["  ", modality, ": ",
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
