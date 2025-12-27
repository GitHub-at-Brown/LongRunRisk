BeginTestSection["ExogenousEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`";

VerificationTest[
	!SameQ[Names @ "*xeq", {}]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20251223-ZYM4OJ@@Tests/ModelDefinition/ExogenousEq_test1.wlt:6,1-14,2"
]

End[]
EndTestSection[]
