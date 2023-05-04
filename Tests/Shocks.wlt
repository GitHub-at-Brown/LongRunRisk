BeginTestSection["Shocks"] 
Begin["Shocks`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Shocks`"
	,
	Null
	,
	{}
	,
	TestID->"Shocks_20230503-RNOUX5"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Shocks`"]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20230503-JDVNNJ"
]
VerificationTest[
	!SameQ[Names @ "*rulesE", {}]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20230503-NFFJHZ"
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
	TestID->"Shocks_20230503-3BRJQN"
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
	TestID->"Shocks_20230503-2O3ZJ4"
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
	TestID->"Shocks_20230503-WTI85K"
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
	TestID->"Shocks_20230503-VRZEKL"
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
	TestID->"Shocks_20230503-Q00MJG"
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
	TestID->"Shocks_20230503-TL5UBK"
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
	TestID->"Shocks_20230503-FK75YS"
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
	TestID->"Shocks_20230503-J2ZKFP"
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
	TestID->"Shocks_20230503-4LCSM3"
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
	TestID->"Shocks_20230503-MVL927"
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
	TestID->"Shocks_20230503-115E06"
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
	TestID->"Shocks_20230503-CG0EJO"
]
VerificationTest[
	{
		Table[NewContext`eps[Shocks`f][Shocks`t] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
			{Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[NewContext`eps["dd"][Shocks`t, Shocks`ii] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
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
	TestID->"Shocks_20230503-HD5ME8"
]
VerificationTest[
	{
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`Private`eps[Shocks`f][Shocks`t] ^ 2) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
			{Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
		],
		Table[(FernandoDuarte`LongRunRisk`Model`Shocks`Private`eps["dd"][Shocks`t, Shocks`ii] ^ 2) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Shocks`t],
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
	TestID->"Shocks_20230503-RH2XUN"
] 
End[]
EndTestSection[]
