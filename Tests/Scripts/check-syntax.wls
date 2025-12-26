#!/usr/bin/env wolframscript

SetDirectory["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-options-refactor"];

Print["Checking syntax of ManageResources.wl..."];

(* Try to Get the file and check for syntax errors *)
result = Quiet[Check[
	Get["Kernel/Tools/ManageResources.wl"],
	$Failed,
	{Get::noopen, Syntax::sntx}
]];

If[result === $Failed,
	Print["✗ Syntax error in file"],
	Print["✓ File loaded successfully"]
];

(* Check buildModels definitions *)
Print["\nChecking buildModels:"];
Print["Number of DownValues: ", Length[DownValues[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels]]];

Print["\nFirst few DownValues:"];
Do[
	Print["Definition ", i, ": ", Short[DownValues[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels][[i]], 3]],
	{i, Min[3, Length[DownValues[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels]]]}
];
