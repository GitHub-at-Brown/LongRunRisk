BeginTestSection["Shocks"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"Shocks_20230415-HR80CB"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`"]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20230415-69DYMJ"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Shocks`"
	,
	Null
	,
	{}
	,
	TestID->"Shocks_20230415-PAE5Z4"
]


VerificationTest[
	!SameQ[Names @ "*rulesE", {}]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20230415-UPTBSZ"
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
	TestID->"Shocks_20230415-IVWSJ2"
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
	TestID->"Shocks_20230415-6S2KYN"
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
	TestID->"Shocks_20230415-5SWVBC"
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
	TestID->"Shocks_20230415-F7CLQW"
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
	TestID->"Shocks_20230415-PFUHMX"
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
	TestID->"Shocks_20230415-ZQA0RT"
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
	TestID->"Shocks_20230415-EDOOHQ"
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
	TestID->"Shocks_20230415-5MKL2S"
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
	TestID->"Shocks_20230415-T5G1BE"
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
	TestID->"Shocks_20230415-L6HEVF"
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
	TestID->"Shocks_20230415-S45CJF"
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
	TestID->"Shocks_20230415-U4ZF7F"
]


EndTestSection[]
