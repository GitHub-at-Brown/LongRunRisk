BeginTestSection["NiceOutput"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`"]

(* Load a package to find paclet root *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];
On[General::shdw];

FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False;
Needs @ "FernandoDuarte`LongRunRisk`Tools`NiceOutput`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"];

VerificationTest[
	Greater[Length @ PacletFind @ "PacletizedResourceFunctions", 0]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20251223-W4Y3IH@@Tests/OutputFormatting/NiceOutput_test2.wlt:13,1-21,2"
]

$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"];

End[]
EndTestSection[]
