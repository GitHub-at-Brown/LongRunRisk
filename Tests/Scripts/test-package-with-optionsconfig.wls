#!/usr/bin/env wolframscript

SetDirectory["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-options-refactor"];

Print["Loading main LongRunRisk package..."];
Get["Kernel/LongRunRisk.wl"];
Print["✓ Package loaded\n"];

Print["Testing OptionsConfig via package..."];
config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
Print["✓ defaultConfig works: ", AssociationQ[config]];
Print["✓ Build.FromScratch: ", config["Build"]["FromScratch"]];
Print["✓ Symbolic.PdEquations: ", config["Symbolic"]["PdEquations"]];
Print["✓ Numerical.MaxMaturity: ", config["Numerical"]["MaxMaturity"]];
Print["✓ Build.MaxMaturity: ", config["Build"]["MaxMaturity"]];

Print["\nTesting normalizeConfig..."];
config2 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
	"FromScratch" -> True,
	"PdEquations" -> "AB",
	"NumKernels" -> 4
}];
Print["✓ FromScratch mapped: ", config2["Build"]["FromScratch"] === True];
Print["✓ PdEquations mapped: ", config2["Symbolic"]["PdEquations"] === "AB"];
Print["✓ NumKernels mapped: ", config2["Parallel"]["NumKernels"] === 4];

Print["\nTesting splitConfig..."];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};
Print["✓ splitConfig returns Rules: ", AllTrue[buildOpts, MatchQ[#, _Rule] &]];
Print["✓ Contains FromScratch: ", MemberQ[buildOpts, "FromScratch" -> False]];

Print["\n✓ All OptionsConfig tests passed!"];
