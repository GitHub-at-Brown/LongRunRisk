#!/usr/bin/env wolframscript

SetDirectory["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-options-refactor"];

Get["Kernel/LongRunRisk.wl"];

Print["Testing internal buildModels directly:\n"];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config = <|config, "Build" -> <|config["Build"], "Models" -> {}|>|>;

Print["Config has Build key: ", KeyExistsQ[config, "Build"]];
Print["Config has Symbolic key: ", KeyExistsQ[config, "Symbolic"]];
Print["Pattern condition: ", KeyExistsQ[config, "Build"] && KeyExistsQ[config, "Symbolic"]];

Print["\nCalling internal buildModels:"];
result1 = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels[config];
Print["Result type: ", Head[result1]];
Print["Is Association: ", AssociationQ[result1]];

Print["\nCalling public BuildModels:"];
result2 = FernandoDuarte`LongRunRisk`BuildModels[config];
Print["Result type: ", Head[result2]];
Print["Is Association: ", AssociationQ[result2]];

Print["\nChecking DownValues:"];
Print["Internal buildModels has ", Length[DownValues[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels]], " definitions"];
Print["Public BuildModels has ", Length[DownValues[FernandoDuarte`LongRunRisk`BuildModels]], " definitions"];
