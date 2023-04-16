BeginTestSection["Shocks"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"Shocks_20230415-TZW13P"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`"]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20230415-C18W02"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Shocks`"
	,
	Null
	,
	{}
	,
	TestID->"Shocks_20230415-WH30WY"
]


VerificationTest[
	!SameQ[Names @ "*rulesE", {}]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20230415-1NLW9H"
]


VerificationTest[
	{
		Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[f][t] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t],
			{f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][t, ii] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t],
			{ii, {1, i, j}}
		]
	}
	,
	{
		{0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0}
	}
	,
	{}
	,
	TestID->"Shocks_20230415-ZUK8A8"
]


EndTestSection[]
