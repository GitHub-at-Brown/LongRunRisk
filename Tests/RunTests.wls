#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Test runner using Wolfram PacletCICD for full GitHub Actions integration.
   Installs PacletCICD if needed and delegates to Wolfram`PacletCICD`TestPaclet.

   This script mirrors the behavior of WolframResearch/test-paclet action:
   - Uses ConsoleType -> "GitHub" for proper GitHub Actions annotations
   - Enables MarkdownSummary for job summary tab output
   - Blocks DefinitionNotebookClient console functions to prevent conflicts
   - Does NOT print raw results; lets TestPaclet handle all output *)

print[a___] := WriteString["stdout", a, "\n"];

(* Get PacletCICD version from environment or use default *)
$pacletCICDVersion = Replace[Environment["PACLET_CICD_VERSION"], Except[_String] -> "0.36.2"];

(* Check if PacletCICD is installed and up to date *)
$existingPaclet = PacletFind["Wolfram/PacletCICD"];
$needsInstall = If[$existingPaclet === {},
  True,
  (* Check version *)
  !OrderedQ[{$pacletCICDVersion, $existingPaclet[[1]]["Version"]}, VersionOrder]
];

If[$needsInstall,
  print["Installing Wolfram/PacletCICD version ", $pacletCICDVersion, "..."];
  $pacletURL = "https://github.com/WolframResearch/PacletCICD/releases/download/v" <>
    $pacletCICDVersion <> "/Wolfram__PacletCICD-" <> $pacletCICDVersion <> ".paclet";
  print["From: ", $pacletURL];
  $installed = PacletInstall[$pacletURL];
  print["Installed: ", $installed];
];

$pacletCICDPath = FindFile["Wolfram`PacletCICD`"];
print["Loading Wolfram`PacletCICD` from ", $pacletCICDPath];

If[$pacletCICDPath === $Failed,
  print["::error::Failed to find Wolfram`PacletCICD` after installation"];
  Exit[1]
];

Needs["Wolfram`PacletCICD`"];

(* Find paclet root *)
$testsRoot = DirectoryName[$InputFileName];
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

(* Choose which directory to search for *.wlt files.
   Default is the paclet root (matches Wolfram/PacletCICD action behavior).
   Set LONGRUNRISK_TESTS_DIR to a relative path (from paclet root) or an
   absolute path to speed up debugging. *)
$testsDir = Module[{raw, abs, rel},
   raw = Replace[Environment["LONGRUNRISK_TESTS_DIR"], Except[_String] -> Automatic];
   Which[
     raw === Automatic,
       $pacletRoot,
     DirectoryQ[abs = ExpandFileName[raw]],
       abs,
     DirectoryQ[rel = FileNameJoin[{$pacletRoot, raw}]],
       rel,
     True,
       print["::error::Invalid LONGRUNRISK_TESTS_DIR: ", raw];
       print["::error::Expected an existing directory (absolute or relative to paclet root)."];
       Exit[1]
   ]
];

(* Get debug flag from environment *)
$debug = TrueQ[Interpreter["Boolean"][Environment["DEBUG"]]];

print["Testing paclet at: ", $pacletRoot];
print["Test discovery directory: ", $testsDir];

getTestReports[res_] := Which[
  AssociationQ[res], res,
  MatchQ[res, _Failure | _Success], res["Result"],
  True, $Failed
];

writeGitHubSummary[reports_Association] := Module[{summaryFile},
  summaryFile = Environment["GITHUB_STEP_SUMMARY"];
  If[! StringQ[summaryFile] || StringTrim[summaryFile] === "", Return[Null]];
  Block[
    {
      Wolfram`PacletCICD`Private`$gitHub = True,
      Wolfram`PacletCICD`Private`$markdownSummary = True,
      Wolfram`PacletCICD`Private`$gitHubStepSummary =
        Wolfram`PacletCICD`Private`getGitHubSS[ ]
    },
    Wolfram`PacletCICD`Private`generateTestSummary[reports]
  ];
];

(* Run tests using PacletCICD TestPaclet
   Block console group functions to match test-paclet action behavior
   Use With to ensure result is consumed and not printed to stdout *)
With[
  {
    res = Wolfram`PacletCICD`Private`noExit @ Block[
      {
        Print = print,
        DefinitionNotebookClient`BeginConsoleGroup = Null &,
        DefinitionNotebookClient`EndConsoleGroup = Null &
      },
      Wolfram`PacletCICD`TestPaclet[
        $testsDir,
        "AnnotateTestIDs" -> True,
        "Debug" -> $debug,
        "ConsoleType" -> "GitHub",
        "MarkdownSummary" -> False,
        "SetWorkflowValue" -> True
      ]
    ]
  },
  Module[{reports},
    reports = getTestReports[res];
    If[AssociationQ[reports],
      Quiet @ writeGitHubSummary[reports]
    ]
  ];
  (* Exit with appropriate code based on result *)
  If[FailureQ[res] || MatchQ[res, _Wolfram`PacletCICD`TestPaclet],
    Exit[1],
    Exit[0]
  ]
];
