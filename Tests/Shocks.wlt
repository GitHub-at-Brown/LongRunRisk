BeginTestSection["Shocks"] 
Begin["Shocks`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Shocks`"
	,
	Null
	,
	{}
	,
	TestID->"Shocks_20230513-RTHEQT"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Shocks`"]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20230513-RWER95"
]
VerificationTest[
	!SameQ[Names @ "*rulesE", {}]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20230513-0CB0EJ"
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
	TestID->"Shocks_20230513-RYFRF8"
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
	TestID->"Shocks_20230513-ATZUO7"
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
	TestID->"Shocks_20230513-SI4RFZ"
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
	TestID->"Shocks_20230513-LVTRPW"
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
	TestID->"Shocks_20230513-A2FCFA"
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
	TestID->"Shocks_20230513-BHY2DX"
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
	TestID->"Shocks_20230513-XKVDH2"
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
	TestID->"Shocks_20230513-0L5SWT"
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
	TestID->"Shocks_20230513-OBLU0S"
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
	TestID->"Shocks_20230513-U53FKY"
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
	TestID->"Shocks_20230513-90GJZ1"
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
	TestID->"Shocks_20230513-OI2ALR"
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
	TestID->"Shocks_20230513-R7KHFO"
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
	TestID->"Shocks_20230513-RV3RPP"
] 
End[]
EndTestSection[]
