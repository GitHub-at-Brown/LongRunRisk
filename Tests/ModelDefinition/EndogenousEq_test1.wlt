BeginTestSection["EndogenousEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";

VerificationTest[
	!SameQ[Names @ "*pdeq", {}]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20251223-C3LW7Z@@Tests/EndogenousEq.wlt:13,1-21,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
