BeginTestSection["ComputeConditionalExpectations"] 
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`"]

Needs @ "FernandoDuarte`LongRunRisk`";
Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`"];

VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"]}]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20251223-KBKW2Z@@Tests/ComputeConditionalExpectations.wlt:24,1-32,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
