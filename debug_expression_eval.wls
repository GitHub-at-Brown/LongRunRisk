#!/usr/bin/env wolframscript

Needs["PacletTools`"];
PacletDirectoryLoad["."];

Get["Tests/TestHelpers.wl"];
Get["Tests/Tools/ToolsTestHelpers.wl"];
Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];

(* Define getNumModel as in the test file *)
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
    Print["State var patterns: ", stateVarPatterns];
    Join[
        Thread[stateVarPatterns -> 1.],
        {
            FernandoDuarte`LongRunRisk`Model`Shocks`eps[_][_] -> 1.,
            FernandoDuarte`LongRunRisk`Model`Shocks`eps[_][_, _] -> 1.,
            mu -> 0.2,
            AA -> -1.,
            BB -> 3.,
            FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc -> 1.,
            FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[_] -> 1.
        }
    ]
];

(* Test with full list from failing test *)
Print["=== Testing full expression list ==="];
numMod = getNumModel[$modNRC];
allExprs = {
    wc[t], pd[t, 1], bond[t, 3], nombond[t, 3], bondexcret[t, 3], bondfw[t, 3],
    bondfwspread[t, 3], bondret[t, 3], bondyield[t, 3], excretc[t], excret[t, 1],
    kappa0[1], kappa1[1], nombondexcret[t, 3], nombondfw[t, 3], nombondfwspread[t, 3],
    nombondret[t, 3], nombondyield[t, 3], nomrf[t], nomsdf[t], retc[t], ret[t, 1],
    rf[t], sdf[t], pi[t], dc[t]
};
result = toNum[allExprs, $modNRC] //. numMod;
Print["Result length: ", Length[Flatten[{result}]]];
Print["All numeric? ", AllTrue[Flatten[{result}], NumericQ]];
nonNumeric = Select[Flatten[{result}], !NumericQ[#]&];
Print["Non-numeric count: ", Length[nonNumeric]];
If[Length[nonNumeric] > 0,
  Print["\nFirst 3 non-numeric expressions:"];
  Do[
    Print[i, ". ", nonNumeric[[i]]];
    Print["   Variables: ", Variables[nonNumeric[[i]]]];
    ,
    {i, 1, Min[3, Length[nonNumeric]]}
  ];
];
