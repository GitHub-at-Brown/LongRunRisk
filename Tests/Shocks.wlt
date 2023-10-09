BeginTestSection["Shocks"] 
Begin["Model`Shocks`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Shocks`";
	True
	,
	True
	,
	{}
	,
	TestID->"Shocks_20231007-7Y2T7Y"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Shocks`"]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20231007-V0Z0JM"
]
VerificationTest[
	!SameQ[Names @ "*rulesE", {}]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20231007-U78NUC"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps[Model`Shocks`f][Model`Shocks`t] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], 0],
					{Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Model`Shocks`t, Model`Shocks`ii] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], 0],
					{Model`Shocks`ii, {1, Model`Shocks`i, Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20231007-LTX8WA"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[Model`Shocks`f][Model`Shocks`t] ^ 2) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], 1],
					{Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Model`Shocks`t, Model`Shocks`ii] ^ 2) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], 1],
					{Model`Shocks`ii, {1, Model`Shocks`i, Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20231007-84HPWC"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[Model`Shocks`f][Model`Shocks`t] ^ 3) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], 0],
					{Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Model`Shocks`t, Model`Shocks`ii] ^ 3) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], 0],
					{Model`Shocks`ii, {1, Model`Shocks`i, Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20231007-1AQ24U"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[Model`Shocks`f][Model`Shocks`t] ^ 4) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], 3],
					{Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Model`Shocks`t, Model`Shocks`ii] ^ 4) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], 3],
					{Model`Shocks`ii, {1, Model`Shocks`i, Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20231007-13B46Z"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[
					SameQ[0,
						If[SameQ[Model`Shocks`f, Model`Shocks`g],
							0,
							(FernandoDuarte`LongRunRisk`Model`Shocks`eps[Model`Shocks`f][Model`Shocks`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps[Model`Shocks`g][Model`Shocks`t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t]
						]
					],
					{Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}},
					{Model`Shocks`g, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[
					SameQ[0,
						(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Model`Shocks`t, Model`Shocks`ii] * FernandoDuarte`LongRunRisk`Model`Shocks`eps[Model`Shocks`f][Model`Shocks`t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t]
					],
					{Model`Shocks`ii, {1, Model`Shocks`i, Model`Shocks`j}},
					{Model`Shocks`f, {"x", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20231007-JAIJWX"
]
VerificationTest[
	SameQ[
		Map[
			Function[
				StringDelete[#, StringExpression["FernandoDuarte" | "`", __, "`"]]
			],
			Table[ToString[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Model`Shocks`t, Model`Shocks`ii] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][Model`Shocks`t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t]],
				{Model`Shocks`ii, {1, Model`Shocks`i, Model`Shocks`j}}
			]
		],
		{"taugd[1]", "taugd[i]", "taugd[j]"}
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20231007-RTEJ8P"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], Model`Shocks`expr],
					{
						Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[Model`Shocks`f][Model`Shocks`t + 1],
							{Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
						]
					}
				],
				Table[SameQ[Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], Model`Shocks`expr],
					{
						Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[ToExpression @ Model`Shocks`f][Model`Shocks`t],
							{Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
						]
					}
				],
				Table[SameQ[Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], Model`Shocks`expr],
					{
						Model`Shocks`expr,
						{FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Model`Shocks`t + 1, Model`Shocks`i], FernandoDuarte`LongRunRisk`Model`Shocks`eps[Model`Shocks`dd][Model`Shocks`t, Model`Shocks`i]}
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
	TestID->"Shocks_20231007-AB2KMZ"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], Model`Shocks`expr],
					{
						Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps @ Model`Shocks`f,
							{Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
						]
					}
				],
				Table[SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], FernandoDuarte`LongRunRisk`Model`Shocks`eps @ "dd"],
					{Model`Shocks`ii, {1, Model`Shocks`i, Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20231007-GN2PEF"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], Model`Shocks`expr],
					{
						Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps @ Model`Shocks`f,
							{
								Model`Shocks`f,
								{"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"}
							}
						]
					}
				],
				Table[SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps["ddd"] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], FernandoDuarte`LongRunRisk`Model`Shocks`eps @ "ddd"],
					{Model`Shocks`ii, {1, Model`Shocks`i, Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20231007-Y35BZB"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], Model`Shocks`expr],
					{
						Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[Model`Shocks`f][Model`Shocks`tt],
							{
								Model`Shocks`f,
								{"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"}
							},
							{Model`Shocks`tt, {Model`Shocks`t + 1, Model`Shocks`t - 1, Model`Shocks`s, Model`Shocks`t + Model`Shocks`h}}
						]
					}
				],
				Table[SameQ[Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], Model`Shocks`expr],
					{
						Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][Model`Shocks`tt, Model`Shocks`ii],
							{Model`Shocks`ii, {1, Model`Shocks`i, Model`Shocks`j}},
							{Model`Shocks`tt, {Model`Shocks`t + 1, Model`Shocks`t - 1, Model`Shocks`s, Model`Shocks`t + Model`Shocks`h}}
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
	TestID->"Shocks_20231007-DGPHWZ"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[NewContext`eps[Model`Shocks`f][Model`Shocks`t] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], 0],
					{Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[SameQ[NewContext`eps["dd"][Model`Shocks`t, Model`Shocks`ii] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], 0],
					{Model`Shocks`ii, {1, Model`Shocks`i, Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20231007-GZIC0T"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`Private`eps[Model`Shocks`f][Model`Shocks`t] ^ 2) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], 1],
					{Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[SameQ[(FernandoDuarte`LongRunRisk`Model`Shocks`Private`eps["dd"][Model`Shocks`t, Model`Shocks`ii] ^ 2) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[Model`Shocks`t], 1],
					{Model`Shocks`ii, {1, Model`Shocks`i, Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20231007-JPYKSE"
]
EndTestSection[]
