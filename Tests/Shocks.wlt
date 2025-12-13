BeginTestSection["Shocks"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Shocks`"]

(* Find paclet root and set up paths for TestPaclet compatibility *)
Module[{start, d},
	start = If[StringQ[$InputFileName] && $InputFileName =!= "",
		DirectoryName[$InputFileName],
		Directory[]
	];
	d = start;
	While[!FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d],
		d = DirectoryName[d]
	];
	FernandoDuarte`LongRunRisk`Tests`Model`Shocks`$pacletRoot = d;
	PacletDirectoryLoad[d];
];

VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Shocks`";
	True
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251213-S5Y1B1@@Tests/Shocks.wlt:18,1-27,2"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Shocks`"]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251213-9HRQH4@@Tests/Shocks.wlt:28,1-36,2"
]
VerificationTest[
	!SameQ[Names @ "*rulesE", {}]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251213-AZ73XN@@Tests/Shocks.wlt:37,1-45,2"
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
	TestID->"Shocks_20251213-1LWUFR@@Tests/Shocks.wlt:46,1-65,2"
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
	TestID->"Shocks_20251213-83GHTR@@Tests/Shocks.wlt:66,1-85,2"
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
	TestID->"Shocks_20251213-UVFRWJ@@Tests/Shocks.wlt:86,1-105,2"
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
	TestID->"Shocks_20251213-1803WC@@Tests/Shocks.wlt:106,1-125,2"
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
	TestID->"Shocks_20251213-GY6T2L@@Tests/Shocks.wlt:126,1-156,2"
]
VerificationTest[
	SameQ[
		Map[
			Function[
				StringDelete[#, StringExpression["FernandoDuarte" | "`", __, "`"]]
			],
			Table[ToString[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]],
				{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}
			]
		],
		{"taugd[1]", "taugd[i]", "taugd[j]"}
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251213-B6K85X@@Tests/Shocks.wlt:157,1-175,2"
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
	TestID->"Shocks_20251213-GTQB7H@@Tests/Shocks.wlt:176,1-211,2"
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
	TestID->"Shocks_20251213-C3OK8H@@Tests/Shocks.wlt:212,1-236,2"
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
	TestID->"Shocks_20251213-Z1LEK4@@Tests/Shocks.wlt:237,1-264,2"
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
	TestID->"Shocks_20251213-T7LWAM@@Tests/Shocks.wlt:265,1-299,2"
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
	TestID->"Shocks_20251213-UM1NQ4@@Tests/Shocks.wlt:300,1-319,2"
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
	TestID->"Shocks_20251213-ND4BPE@@Tests/Shocks.wlt:320,1-339,2"
] 
VerificationTest[
  $ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ]; True,
  True,
  TestID -> "Untitled-22@@Tests/Shocks.wlt:340,1-344,2"
]
End[]
EndTestSection[]
