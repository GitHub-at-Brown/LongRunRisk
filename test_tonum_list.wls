#!/usr/bin/env wolframscript

Needs["PacletTools`"];
PacletDirectoryLoad["."];

(* Load test helpers to get models *)
Get["Tests/TestHelpers.wl"];
Get["Tests/Tools/ToolsTestHelpers.wl"];

(* Load ToNumber package *)
Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];

(* Test with a simple list *)
Print["=== Testing toNum with a list ==="];
testList = {wc[t], pd[t, 1]};
Print["Input list: ", testList];

result = toNum[testList, $modNRC];
Print["Type of result: ", Head[result]];
Print["Result: ", Short[result, 3]];

(* Now test with getNumModel *)
getNumModel[mod_] := Module[{stateVarPatterns},
    stateVarPatterns = Map[
        #[_] &,
        DeleteDuplicates[
            DeleteCases[
                Cases[Variables[mod["stateVars"][t]], x_[_] :> x],
                0
            ]
        ]
    ];
    Join[
        Thread[stateVarPatterns -> 1.],
        {
            FernandoDuarte`LongRunRisk`Model`Shocks`eps[_][_] -> 1.,
            FernandoDuarte`LongRunRisk`Model`Shocks`eps[_][_, _] -> 1.,
            mu -> 0.2,
            AA -> -1.,
            BB[__] -> 1.
        }
    ]
];

numMod = getNumModel[$modNRC];
Print["\n=== Applying numeric replacements ==="];
replaced = result //. numMod;
Print["After replacement: ", Short[replaced, 3]];
Print["Flattened: ", Flatten[{replaced}]];
Print["All numeric? ", AllTrue[Flatten[{replaced}], NumericQ]];
