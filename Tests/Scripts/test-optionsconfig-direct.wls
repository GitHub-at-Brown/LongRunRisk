#!/usr/bin/env wolframscript

SetDirectory["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-options-refactor"];

Print["Testing direct Get of OptionsConfig.wl..."];
Get["Kernel/Tools/OptionsConfig.wl"];
Print["â File loaded successfully"];

Print["Testing defaultConfig..."];
config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
Print["â defaultConfig returned: ", AssociationQ[config]];
Print["â FromScratch: ", config["Build"]["FromScratch"]];
Print["â PdEquations: ", config["Symbolic"]["PdEquations"]];

Print["\nAll tests passed!"];
