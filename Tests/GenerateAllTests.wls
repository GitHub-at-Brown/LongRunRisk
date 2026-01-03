#!/usr/bin/env wolframscript
(* ::Package:: *)

(* GenerateAllTests.wls
   Master script to generate all .wl generator files from existing .wlt tests.

   Usage: wolframscript Tests/GenerateAllTests.wls

   This script:
   - Finds all .wlt files under Tests/ (excluding Generators/)
   - Creates corresponding .wl generator files in Tests/Generators/
   - Each generator can regenerate its .wlt file via GenerateWLT[]
*)

$testsRoot = DirectoryName[$InputFileName];

(* Load the refactoring package *)
Get[FileNameJoin[{$testsRoot, "Generators", "WLTTestRefactor.wl"}]];

(* Find all .wlt files, excluding Generators directory *)
$wltFiles = Select[
    FileNames["*.wlt", $testsRoot, Infinity],
    !StringContainsQ[#, "Generators"] &
];

Print["Found ", Length[$wltFiles], " .wlt files to process"];

$generatorRoot = FileNameJoin[{$testsRoot, "Generators"}];

(* Generate all generator files *)
$results = WriteWLTGenerators[
    $wltFiles,
    $generatorRoot,
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "OverwriteTarget" -> True,
    "TestsRoot" -> $testsRoot
];

(* Report results *)
$successes = Count[$results, _String];
$failures = Count[$results, $Failed];

Print[""];
Print["Generation complete:"];
Print["  Successes: ", $successes];
Print["  Failures: ", $failures];

If[$failures > 0,
    Print[""];
    Print["Failed files:"];
    MapThread[
        If[#2 === $Failed, Print["  ", #1]] &,
        {$wltFiles, $results}
    ]
];

(* Exit with appropriate code *)
Exit[If[$failures > 0, 1, 0]]
