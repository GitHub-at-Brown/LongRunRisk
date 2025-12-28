#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Test runner using Wolfram PacletCICD for full GitHub Actions integration.
   Installs PacletCICD if needed and delegates to Wolfram`PacletCICD`TestPaclet. *)

print[a___] := WriteString["stdout", a, "\n"];

(* Get PacletCICD version from environment or use default *)
$pacletCICDVersion = Replace[Environment["PACLET_CICD_VERSION"], Except[_String] -> "0.36.2"];

(* Install PacletCICD if not already available *)
If[!PacletNewerQ[PacletObject["Wolfram/PacletCICD"], $pacletCICDVersion],
  print["Installing Wolfram/PacletCICD version ", $pacletCICDVersion, "..."];
  PacletInstall[
    "https://github.com/WolframResearch/PacletCICD/releases/download/v" <>
      $pacletCICDVersion <> "/Wolfram__PacletCICD-" <> $pacletCICDVersion <> ".paclet"
  ];
];

print["Loading Wolfram`PacletCICD` from ", FindFile["Wolfram`PacletCICD`"]];
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
    Directory[$pacletRoot],
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
