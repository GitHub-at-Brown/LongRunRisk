BeginTestSection["ExogenousEq"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"ExogenousEq_20230415-W1ZPTH"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`"]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20230415-QAT42Q"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`"
	,
	Null
	,
	{}
	,
	TestID->"ExogenousEq_20230415-QSA2P3"
]


VerificationTest[
	!SameQ[Names @ "*xeq", {}]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20230415-6MRB13"
]


EndTestSection[]
