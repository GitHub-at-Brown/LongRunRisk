#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Test runner using Wolfram PacletCICD for full GitHub Actions integration.
   Installs PacletCICD if needed and delegates to Wolfram`PacletCICD`TestPaclet. *)

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

(* Load the paclet *)
PacletDirectoryLoad[$pacletRoot];

(* Get debug flag from environment *)
$debug = TrueQ[Interpreter["Boolean"][Environment["DEBUG"]]];

print["Testing paclet at: ", $pacletRoot];

(* Run tests using PacletCICD TestPaclet *)
$result = Block[
  {Print = print},
  Wolfram`PacletCICD`TestPaclet[
    $pacletRoot,
    "AnnotateTestIDs" -> True,
    "Debug" -> $debug,
    "ConsoleType" -> "GitHub"
  ]
];

print[$result];

(* Exit with appropriate code *)
If[FailureQ[$result] || MatchQ[$result, _Wolfram`PacletCICD`TestPaclet],
  Exit[1],
  Exit[0]
];
