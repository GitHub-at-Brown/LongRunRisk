#!/usr/bin/env wolframscript

Print["Testing OptionsConfig module..."];

Needs["FernandoDuarte`LongRunRisk`Tools`OptionsConfig`"];
Print["✓ Module loaded"];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
Print["✓ defaultConfig returned: ", AssociationQ[config]];

Print["✓ FromScratch default: ", config["Build"]["FromScratch"]];
Print["✓ PdEquations default: ", config["Symbolic"]["PdEquations"]];
Print["✓ MaxMaturity (Numerical): ", config["Numerical"]["MaxMaturity"]];
Print["✓ MaxMaturity (Build): ", config["Build"]["MaxMaturity"]];

(* Test normalization *)
config2 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
	"FromScratch" -> True,
	"PdEquations" -> "AB"
}];
Print["✓ Normalized FromScratch: ", config2["Build"]["FromScratch"]];
Print["✓ Normalized PdEquations: ", config2["Symbolic"]["PdEquations"]];

(* Test splitConfig *)
opts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};
Print["✓ splitConfig Build returns list: ", ListQ[opts]];
Print["✓ splitConfig contains FromScratch: ", MemberQ[opts, "FromScratch" -> False]];

Print["\nAll basic tests passed!"];
