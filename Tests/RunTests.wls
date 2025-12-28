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

(* GitHub Actions Summary rendering can show code blocks inside HTML tables
   with a very narrow value column (appearing like only the first character is
   shown).  Make the generated tables full-width and force the code-value
   column to expand. *)
fixGitHubStepSummaryLayout[ ] := Module[{file, str, out},
  file = Environment["GITHUB_STEP_SUMMARY"];
  If[! StringQ[file] || StringTrim[file] === "" || ! FileExistsQ[file], Return[Null]];
  (* PacletCICD keeps the summary stream open; close it so we can safely rewrite. *)
  Quiet[Close /@ Streams[file]];
  str = ReadString[file];
  If[! StringQ[str], Return[Null]];

  out = StringReplace[
    str,
    {
      "<table>" -> "<table width=\"100%\">",
      "<td><pre" -> "<td width=\"100%\"><pre"
    }
  ];

  If[out =!= str,
    Export[file, out, "String"]
  ];
];

saveStepSummaryCopy[ ] := Module[{src, dest},
  src = Environment["GITHUB_STEP_SUMMARY"];
  If[! StringQ[src] || StringTrim[src] === "" || ! FileExistsQ[src], Return[Null]];
  dest = FileNameJoin[{$pacletRoot, "build", "test-results", "step-summary.md"}];
  Quiet @ CreateDirectory[DirectoryName[dest], CreateIntermediateDirectories -> True];
  Quiet @ CopyFile[src, dest, OverwriteTarget -> True];
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
        "MarkdownSummary" -> True,
        "SetWorkflowValue" -> True
      ]
    ]
  },
  Quiet @ fixGitHubStepSummaryLayout[ ];
  Quiet @ saveStepSummaryCopy[ ];
  (* Exit with appropriate code based on result *)
  If[FailureQ[res] || MatchQ[res, _Wolfram`PacletCICD`TestPaclet],
    Exit[1],
    Exit[0]
  ]
];
