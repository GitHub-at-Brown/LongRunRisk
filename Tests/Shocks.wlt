BeginTestSection["Shocks"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Shocks`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Shocks`";
	True
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-UHA7PK@@Tests/Shocks.wlt:3,1-12,2"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Shocks`"]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-S9E4MT@@Tests/Shocks.wlt:13,1-21,2"
]
VerificationTest[
	!SameQ[Names @ "*rulesE", {}]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-ZWDJXA@@Tests/Shocks.wlt:22,1-30,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], 0],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], 0],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-2QHZUK@@Tests/Shocks.wlt:31,1-50,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t] ^ 2) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], 1],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii] ^ 2) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], 1],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-XHVCXJ@@Tests/Shocks.wlt:51,1-70,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t] ^ 3) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], 0],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii] ^ 3) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], 0],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-JMXJTY@@Tests/Shocks.wlt:71,1-90,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t] ^ 4) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], 3],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii] ^ 4) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], 3],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-AV3ZYZ@@Tests/Shocks.wlt:91,1-110,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[
					SameQ[0,
						If[SameQ[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`g],
							0,
							(FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`g][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]
						]
					],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}},
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`g, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[
					SameQ[0,
						(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii] * FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]
					],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}},
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-59W1EY@@Tests/Shocks.wlt:111,1-141,2"
]
VerificationTest[
	With[
		{
			FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tb = Table[
				(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t],
				{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}
			]
		},
		SameQ[
			{
				Map[SymbolName @* Head, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tb],
				Map[
					Composition[
						Function @ If[
							NumberQ[#], ToString @ #, If[Developer`HoldSymbolQ[#], SymbolName @ #, ""]
						],
						First
					],
					FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tb
				]
			},
			{{"taugd", "taugd", "taugd"}, {"1", "i", "j"}}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-MYY97J@@Tests/Shocks.wlt:142,1-172,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr],
					{
						FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + 1],
							{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
						]
					}
				],
				Table[SameQ[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr],
					{
						FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[ToExpression @ FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t],
							{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
						]
					}
				],
				Table[SameQ[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr],
					{
						FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr,
						{FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i], FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`dd][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i]}
					}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-994W6E@@Tests/Shocks.wlt:173,1-208,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr],
					{
						FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps @ FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f,
							{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
						]
					}
				],
				Table[SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], FernandoDuarte`LongRunRisk`Model`Shocks`eps @ "dd"],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-9XB7Z0@@Tests/Shocks.wlt:209,1-233,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr],
					{
						FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps @ FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f,
							{
								FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f,
								{"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"}
							}
						]
					}
				],
				Table[SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps["ddd"] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], FernandoDuarte`LongRunRisk`Model`Shocks`eps @ "ddd"],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-3LHKAB@@Tests/Shocks.wlt:234,1-261,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr],
					{
						FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tt],
							{
								FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f,
								{"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"}
							},
							{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tt, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t - 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`s, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + FernandoDuarte`LongRunRisk`Tests`Model`Shocks`h}}
						]
					}
				],
				Table[SameQ[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr],
					{
						FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tt, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii],
							{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}},
							{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tt, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t - 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`s, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + FernandoDuarte`LongRunRisk`Tests`Model`Shocks`h}}
						]
					}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-7XW24U@@Tests/Shocks.wlt:262,1-296,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[NewContext`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], 0],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[SameQ[NewContext`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], 0],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-21BAID@@Tests/Shocks.wlt:297,1-316,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`Private`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t] ^ 2) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], 1],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`Private`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii] ^ 2) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], 1],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251215-1T7V4C@@Tests/Shocks.wlt:317,1-336,2"
] 
VerificationTest[
  $ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ]; True,
  True,
  TestID -> "Untitled-16@@Tests/Shocks.wlt:337,1-345,8"
]
End[]
EndTestSection[]
