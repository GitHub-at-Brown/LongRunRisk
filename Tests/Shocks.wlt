BeginTestSection["Shocks"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"Shocks_20230408-H12AHM"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`"]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20230408-E9JJ1R"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Shocks`"
	,
	Null
	,
	{}
	,
	TestID->"Shocks_20230408-IZ9MRN"
]


VerificationTest[
	!SameQ[Names @ "*rulesE", {}]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20230408-VTPGYO"
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
	TestID->"Shocks_20230408-PPLC9Z"
]


VerificationTest[
	{
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[f][t] ^ 2) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t],
			{f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][t, ii] ^ 2) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t],
			{ii, {1, i, j}}
		]
	}
	,
	{
		{1, 1, 1, 1, 1, 1, 1, 1},
		{1, 1, 1}
	}
	,
	{}
	,
	TestID->"Shocks_20230408-M8ADWA"
]


VerificationTest[
	{
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[f][t] ^ 3) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t],
			{f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][t, ii] ^ 3) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t],
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
	TestID->"Shocks_20230408-KHMHIP"
]


VerificationTest[
	{
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[f][t] ^ 4) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t],
			{f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][t, ii] ^ 4) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t],
			{ii, {1, i, j}}
		]
	}
	,
	{
		{3, 3, 3, 3, 3, 3, 3, 3},
		{3, 3, 3}
	}
	,
	{}
	,
	TestID->"Shocks_20230408-G3HCTK"
]


VerificationTest[
	{
		Table[
			If[SameQ[f, g],
				0,
				(FernandoDuarte`LongRunRisk`Model`Shocks`eps[f][t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps[g][t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t]
			],
			{f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}},
			{g, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][t, ii] * FernandoDuarte`LongRunRisk`Model`Shocks`eps[f][t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t],
			{ii, {1, i, j}},
			{f, {"x", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		]
	}
	,
	{
		{
			{0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0}
		},
		{
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0}
		}
	}
	,
	{}
	,
	TestID->"Shocks_20230408-QJ3KNV"
]


VerificationTest[
	Map[
		Function[
			StringDelete[#, StringExpression["FernandoDuarte" | "`", __, "`"]]
		],
		Table[ToString[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][t, ii] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t]],
			{ii, {1, i, j}}
		]
	]
	,
	{"taugd[1]", "taugd[i]", "taugd[j]"}
	,
	{}
	,
	TestID->"Shocks_20230408-K3NK2J"
]


VerificationTest[
	{
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[f][t] ^ 4) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t],
			{f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][t, ii] ^ 4) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t],
			{ii, {1, i, j}}
		]
	}
	,
	{
		{3, 3, 3, 3, 3, 3, 3, 3},
		{3, 3, 3}
	}
	,
	{}
	,
	TestID->"Shocks_20230408-7OSUOB"
]


VerificationTest[
	{
		Table[
			If[SameQ[f, g],
				0,
				((FernandoDuarte`LongRunRisk`Model`Shocks`eps[f][t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps[g][t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t]
			],
			{f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}},
			{g, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[((FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][t, ii] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps[f][t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t],
			{ii, {1, i, j}},
			{f, {"x", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		]
	}
	,
	{
		{
			{0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0, 0}
		},
		{
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0},
			{0, 0, 0, 0, 0, 0, 0}
		}
	}
	,
	{}
	,
	TestID->"Shocks_20230408-U4V6N9"
]


VerificationTest[
	{
		Table[SameQ[expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t], expr],
			{
				expr,
				Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[f][t + 1],
					{f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				]
			}
		],
		Table[SameQ[expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t], expr],
			{
				expr,
				Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[ToExpression @ f][t],
					{f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				]
			}
		],
		Table[SameQ[expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t], expr],
			{
				expr,
				{FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][t + 1, i], FernandoDuarte`LongRunRisk`Model`Shocks`eps[dd][t, i]}
			}
		]
	}
	,
	{
		{True, True, True, True, True, True, True, True},
		{True, True, True, True, True, True, True, True},
		{True, True}
	}
	,
	{}
	,
	TestID->"Shocks_20230408-HLCAWK"
]


VerificationTest[
	{
		Table[SameQ[expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t], expr],
			{
				expr,
				Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps @ f,
					{f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				]
			}
		],
		Table[SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t], FernandoDuarte`LongRunRisk`Model`Shocks`eps @ "dd"],
			{ii, {1, i, j}}
		]
	}
	,
	{
		{True, True, True, True, True, True, True, True},
		{True, True, True}
	}
	,
	{}
	,
	TestID->"Shocks_20230408-RNKGP6"
]


VerificationTest[
	{
		Table[SameQ[expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t], expr],
			{
				expr,
				Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps @ f,
					{
						f,
						{"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"}
					}
				]
			}
		],
		Table[SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps["ddd"] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t], FernandoDuarte`LongRunRisk`Model`Shocks`eps @ "ddd"],
			{ii, {1, i, j}}
		]
	}
	,
	{
		{True, True, True, True, True, True, True, True},
		{True, True, True}
	}
	,
	{}
	,
	TestID->"Shocks_20230408-QRGEH2"
]


VerificationTest[
	{
		Table[SameQ[expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t], expr],
			{
				expr,
				Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[f][tt],
					{
						f,
						{"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"}
					},
					{tt, {t + 1, t - 1, s, t + h}}
				]
			}
		],
		Table[SameQ[expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t], expr],
			{
				expr,
				Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][tt, ii],
					{ii, {1, i, j}},
					{tt, {t + 1, t - 1, s, t + h}}
				]
			}
		]
	}
	,
	{
		{True, True, True, True, True, True, True, True},
		{True, True, True}
	}
	,
	{}
	,
	TestID->"Shocks_20230408-K7BGU2"
]


EndTestSection[]
