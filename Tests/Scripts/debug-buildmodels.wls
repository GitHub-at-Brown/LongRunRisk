#!/usr/bin/env wolframscript

SetDirectory["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-options-refactor"];

Get["Kernel/LongRunRisk.wl"];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
Print["Config type: ", Head[config]];
Print["Is Association: ", AssociationQ[config]];
Print["Is normalized: ", FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`isNormalized[config]];

(* Modify config *)
config2 = config;
config2["Build"]["Models"] = {};
Print["\nAfter modification:"];
Print["Config type: ", Head[config2]];
Print["Is Association: ", AssociationQ[config2]];
Print["Is normalized: ", FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`isNormalized[config2]];

(* Test pattern matching *)
Print["\nTesting pattern matching:"];
testFunc[c_Association /; FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`isNormalized[c]] := "Matched normalized config";
testFunc[_] := "Didn't match";
Print["Result: ", testFunc[config2]];
