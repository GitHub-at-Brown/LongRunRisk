#!/usr/bin/env wolframscript
(* ::Package:: *)

(* RegenerateFromGenerators.wls
   Regenerate all .wlt files from their .wl generators.

   Usage: wolframscript Tests/RegenerateFromGenerators.wls

   This script:
   - Finds all .wl generator files in Tests/Generators/
   - Runs each generator in a subprocess to avoid context collisions
   - Regenerates the corresponding .wlt file
*)

$testsRoot = DirectoryName[$InputFileName];
$generatorRoot = FileNameJoin[{$testsRoot, "Generators"}];

(* Find all generator files, excluding the WLTTestRefactor.wl package *)
$generatorFiles = Select[
    FileNames["*.wl", $generatorRoot, Infinity],
    !StringContainsQ[#, "WLTTestRefactor.wl"] &
];

Print["Found ", Length[$generatorFiles], " generator files"];
Print[""];

$successes = 0;
$failures = {};

Do[
    Print["Processing: ", FileNameTake[genFile, -2]];

    (* Run each generator in a subprocess to avoid context collisions *)
    With[{result = RunProcess[
        {"wolframscript", "-code",
            "Get[\"" <> genFile <> "\"]; " <>
            "With[{ctxs = Select[Contexts[\"WLTGenerated`*`\"], StringEndsQ[#, \"`\"] &]}, " <>
            "  If[Length[ctxs] > 0, " <>
            "    ToExpression[First[ctxs] <> \"GenerateWLT[]\"]" <>
            "  ]" <>
            "]"
        }
    ]},
        If[result["ExitCode"] === 0,
            $successes++;
            ,
            AppendTo[$failures, genFile];
            Print["  ERROR: Exit code ", result["ExitCode"]];
            If[result["StandardError"] =!= "", Print["  ", result["StandardError"]]];
        ]
    ],
    {genFile, $generatorFiles}
];

Print[""];
Print["Regeneration complete:"];
Print["  Successes: ", $successes];
Print["  Failures: ", Length[$failures]];

If[Length[$failures] > 0,
    Print[""];
    Print["Failed files:"];
    Scan[Print["  ", #] &, $failures]
];

Exit[If[Length[$failures] > 0, 1, 0]]
