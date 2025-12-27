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
	TestID->"ComputeConditionalExpectations_20251223-PVOW6F@@Tests/ComputationalEngine/ComputeConditionalExpectations_test2.wlt:8,1-21,2"
]

$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`"];

End[]
EndTestSection[]
