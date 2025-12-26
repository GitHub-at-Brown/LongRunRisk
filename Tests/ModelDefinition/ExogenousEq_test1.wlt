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
	TestID->"ExogenousEq_20251223-ZYM4OJ@@Tests/ExogenousEq.wlt:13,1-21,2"
]

End[]
EndTestSection[]
