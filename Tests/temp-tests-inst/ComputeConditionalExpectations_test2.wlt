BeginTestSection["ComputeConditionalExpectations"] 
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`"]

Needs @ "FernandoDuarte`LongRunRisk`";
Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`"];

VerificationTest[
	Apply[And,
		{
			!SameQ[Names @ "*ev", {}],
			!SameQ[Names @ "lagStateVarst", {}]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20251223-PVOW6F@@Tests/ComputeConditionalExpectations.wlt:33,1-46,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
