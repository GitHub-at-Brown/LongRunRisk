BeginTestSection["EndogenousEq"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"EndogenousEq_20230415-VODUVG"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`"]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20230415-SIZYAQ"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`"
	,
	Null
	,
	{}
	,
	TestID->"EndogenousEq_20230415-6HFZQ1"
]


VerificationTest[
	!SameQ[Names @ "*pdeq", {}]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20230415-B9GRGJ"
]


EndTestSection[]
