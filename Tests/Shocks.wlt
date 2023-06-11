BeginTestSection["Shocks"] 
Begin["Shocks`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Shocks`"
	,
	Null
	,
	{}
	,
	TestID->"Shocks_20230610-7XMM72"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Shocks`"]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20230610-PJZSVW"
]
VerificationTest[
	!SameQ[Names @ "*rulesE", {}]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20230610-R3SZX4"
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
	TestID->"Shocks_20230610-LCIGAM"
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
	TestID->"Shocks_20230610-B7YF3O"
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
	TestID->"Shocks_20230610-5O0ERJ"
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
	TestID->"Shocks_20230610-6K6OZX"
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
	TestID->"Shocks_20230610-8KJ8DP"
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
	TestID->"Shocks_20230610-Z8UMT4"
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
	TestID->"Shocks_20230610-DQXRBH"
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
	TestID->"Shocks_20230610-S35S1M"
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
	TestID->"Shocks_20230610-EHYH2J"
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
	TestID->"Shocks_20230610-0H61YL"
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
	TestID->"Shocks_20230610-JVI7UX"
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
	TestID->"Shocks_20230610-QQ63CQ"
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
	TestID->"Shocks_20230610-BFE4LW"
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
	TestID->"Shocks_20230610-Q6UEUJ"
] 
End[]
EndTestSection[]
