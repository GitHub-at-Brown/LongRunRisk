BeginTestSection["EndogenousEq"] 
Begin["EndogenousEq`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`"
	,
	Null
	,
	{}
	,
	TestID->"EndogenousEq_20230423-TLTBLI"
]
VerificationTest[
	!SameQ[Names @ "*pdeq", {}]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20230423-9GM2JT"
] 
End[]
EndTestSection[]
