BeginTestSection["Shocks"] 
Begin["Shocks`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Shocks`"
	,
	Null
	,
	{}
	,
	TestID->"Shocks_20230423-IHQJK4"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Shocks`"]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20230423-T76QG1"
]
VerificationTest[
	!SameQ[Names @ "*rulesE", {}]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20230423-Z7THCB"
]
VerificationTest[
	{
		Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[Shocks`f][Shocks`t] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
			{Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Shocks`t, Shocks`ii] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
			{Shocks`ii, {1, Shocks`i, Shocks`j}}
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
	TestID->"Shocks_20230423-61UISN"
]
VerificationTest[
	{
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[Shocks`f][Shocks`t] ^ 2) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
			{Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Shocks`t, Shocks`ii] ^ 2) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
			{Shocks`ii, {1, Shocks`i, Shocks`j}}
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
	TestID->"Shocks_20230423-1FK99V"
]
VerificationTest[
	{
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[Shocks`f][Shocks`t] ^ 3) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
			{Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Shocks`t, Shocks`ii] ^ 3) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
			{Shocks`ii, {1, Shocks`i, Shocks`j}}
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
	TestID->"Shocks_20230423-GCD6M8"
]
VerificationTest[
	{
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[Shocks`f][Shocks`t] ^ 4) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
			{Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Shocks`t, Shocks`ii] ^ 4) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
			{Shocks`ii, {1, Shocks`i, Shocks`j}}
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
	TestID->"Shocks_20230423-5M2ZIS"
]
VerificationTest[
	{
		Table[
			If[SameQ[Shocks`f, Shocks`g],
				0,
				(FernandoDuarte`LongRunRisk`Model`Shocks`eps[Shocks`f][Shocks`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps[Shocks`g][Shocks`t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t]
			],
			{Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}},
			{Shocks`g, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Shocks`t, Shocks`ii] * FernandoDuarte`LongRunRisk`Model`Shocks`eps[Shocks`f][Shocks`t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
			{Shocks`ii, {1, Shocks`i, Shocks`j}},
			{Shocks`f, {"x", "pi", "pibar", "sg", "sx", "sc", "sp"}}
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
	TestID->"Shocks_20230423-GRAH6T"
]
VerificationTest[
	Map[
		Function[
			StringDelete[#, StringExpression["FernandoDuarte" | "`", __, "`"]]
		],
		Table[ToString[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Shocks`t, Shocks`ii] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][Shocks`t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t]],
			{Shocks`ii, {1, Shocks`i, Shocks`j}}
		]
	]
	,
	{"taugd[1]", "taugd[i]", "taugd[j]"}
	,
	{}
	,
	TestID->"Shocks_20230423-OJ48WS"
]
VerificationTest[
	{
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[Shocks`f][Shocks`t] ^ 4) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
			{Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Shocks`t, Shocks`ii] ^ 4) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
			{Shocks`ii, {1, Shocks`i, Shocks`j}}
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
	TestID->"Shocks_20230423-JZK1JZ"
]
VerificationTest[
	{
		Table[
			If[SameQ[Shocks`f, Shocks`g],
				0,
				((FernandoDuarte`LongRunRisk`Model`Shocks`eps[Shocks`f][Shocks`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps[Shocks`g][Shocks`t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t]
			],
			{Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}},
			{Shocks`g, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[((FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Shocks`t, Shocks`ii] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps[Shocks`f][Shocks`t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
			{Shocks`ii, {1, Shocks`i, Shocks`j}},
			{Shocks`f, {"x", "pi", "pibar", "sg", "sx", "sc", "sp"}}
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
	TestID->"Shocks_20230423-D59F0Z"
]
VerificationTest[
	{
		Table[SameQ[Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t], Shocks`expr],
			{
				Shocks`expr,
				Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[Shocks`f][Shocks`t + 1],
					{Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				]
			}
		],
		Table[SameQ[Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t], Shocks`expr],
			{
				Shocks`expr,
				Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[ToExpression @ Shocks`f][Shocks`t],
					{Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				]
			}
		],
		Table[SameQ[Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t], Shocks`expr],
			{
				Shocks`expr,
				{FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Shocks`t + 1, Shocks`i], FernandoDuarte`LongRunRisk`Model`Shocks`eps[Shocks`dd][Shocks`t, Shocks`i]}
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
	TestID->"Shocks_20230423-ATA7T3"
]
VerificationTest[
	{
		Table[SameQ[Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t], Shocks`expr],
			{
				Shocks`expr,
				Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps @ Shocks`f,
					{Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				]
			}
		],
		Table[SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t], FernandoDuarte`LongRunRisk`Model`Shocks`eps @ "dd"],
			{Shocks`ii, {1, Shocks`i, Shocks`j}}
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
	TestID->"Shocks_20230423-X5G6EC"
]
VerificationTest[
	{
		Table[SameQ[Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t], Shocks`expr],
			{
				Shocks`expr,
				Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps @ Shocks`f,
					{
						Shocks`f,
						{"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"}
					}
				]
			}
		],
		Table[SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps["ddd"] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t], FernandoDuarte`LongRunRisk`Model`Shocks`eps @ "ddd"],
			{Shocks`ii, {1, Shocks`i, Shocks`j}}
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
	TestID->"Shocks_20230423-DYXIFA"
]
VerificationTest[
	{
		Table[SameQ[Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t], Shocks`expr],
			{
				Shocks`expr,
				Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[Shocks`f][Shocks`tt],
					{
						Shocks`f,
						{"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"}
					},
					{Shocks`tt, {Shocks`t + 1, Shocks`t - 1, Shocks`s, Shocks`t + Shocks`h}}
				]
			}
		],
		Table[SameQ[Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t], Shocks`expr],
			{
				Shocks`expr,
				Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Shocks`tt, Shocks`ii],
					{Shocks`ii, {1, Shocks`i, Shocks`j}},
					{Shocks`tt, {Shocks`t + 1, Shocks`t - 1, Shocks`s, Shocks`t + Shocks`h}}
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
	TestID->"Shocks_20230423-M1OPE2"
] 
End[]
EndTestSection[]
