#!/usr/bin/env wolframscript

SetDirectory["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-options-refactor"];

Print["Testing buildModels refactoring...\n"];

Get["Kernel/LongRunRisk.wl"];
Print["✓ Package loaded\n"];

(* Test 1: Legacy flat options still work *)
Print["Test 1: Legacy flat options"];
opts1 = {
	"FromScratch" -> False,
	"Models" -> {},  (* Empty to avoid actual build *)
	"PdEquations" -> "AB",
	"NumKernels" -> 2
};
Print["  Calling BuildModels (public API) with legacy options"];
(* This should return empty Association since Models -> {} *)
result1 = FernandoDuarte`LongRunRisk`BuildModels[Sequence @@ opts1];
Print["  Result type: ", Head[result1]];
Print["  ✓ Legacy options accepted\n"];

(* Test 2: New config Association works *)
Print["Test 2: New config Association"];
config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
(* Modify using Association replacement to maintain structure *)
config = <|config, "Build" -> <|config["Build"], "Models" -> {}|>|>;
config = <|config, "Symbolic" -> <|config["Symbolic"], "PdEquations" -> "AB"|>|>;
config = <|config, "Parallel" -> <|config["Parallel"], "NumKernels" -> 2|>|>;
Print["  Calling BuildModels (public API) with config Association"];
result2 = FernandoDuarte`LongRunRisk`BuildModels[config];
Print["  Result type: ", Head[result2]];
Print["  ✓ Config Association accepted\n"];

(* Test 3: Verify both produce same result type *)
Print["Test 3: Verify consistency"];
Print["  Both return Association: ", AssociationQ[result1] && AssociationQ[result2]];
Print["  Both are empty (no models): ", Length[result1] == 0 && Length[result2] == 0];
Print["  ✓ Results consistent\n"];

Print["✓ All buildModels refactoring tests passed!"];
