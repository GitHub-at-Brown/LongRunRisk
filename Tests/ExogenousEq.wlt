BeginTestSection["ExogenousEq"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"ExogenousEq_20230408-543OW2"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`"]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20230408-XPAQDE"
]


EndTestSection[]
