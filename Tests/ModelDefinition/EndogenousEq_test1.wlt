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
	TestID->"EndogenousEq_20251223-C3LW7Z@@Tests/ModelDefinition/EndogenousEq_test1.wlt:6,1-14,2"
]

End[]
EndTestSection[]
