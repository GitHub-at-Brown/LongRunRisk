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
	TestID->"NiceOutput_20251223-W4Y3IH@@Tests/NiceOutput.wlt:34,1-42,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
