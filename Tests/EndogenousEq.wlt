BeginTestSection["EndogenousEq"] 
Begin["EndogenousEq`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`"
	,
	Null
	,
	{}
	,
	TestID->"EndogenousEq_20230423-BIU5WK"
]
VerificationTest[
	!SameQ[Names @ "*pdeq", {}]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20230423-C5F1AR"
] 
End[]
EndTestSection[]
