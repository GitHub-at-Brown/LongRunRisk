BeginTestSection["NiceOutput"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`"]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231109-4Z7RYM"
]
VerificationTest[
	Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp = If[
		FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC", "DES", "NRCStochVol"}]
	];
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp @ "BY";
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBKY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp @ "BKY";
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRC = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp @ "NRC";
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modDES = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp @ "DES";
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRCStochVol = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp @ "NRCStochVol";
	True
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231109-VJQXIA"
]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Tools`NiceOutput`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"];
	True
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231109-MYOB68"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]}]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231109-5NNMUY"
]
VerificationTest[
	!SameQ[Names @ "*info", {}]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231109-J3QV9W"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo = PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Tools`NiceOutput`info @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp;
	Apply[And,
		{
			SameQ[Head @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo, Column],
			SameQ[Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo[[1]]], List],
			SameQ[Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo[[1, 1]]], OpenerView],
			Apply[And,
				Map[MatchQ[#, Grid]&,
					Map[Head, FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo[[1, 1;;, 1, 2]]]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231109-3A35JA"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`justBY = <|"BY" -> FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]|>;
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY = PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Tools`NiceOutput`info @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`justBY;
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`newBY = <|"myModel" -> FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]|>;
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY = PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Tools`NiceOutput`info @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`newBY;
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY[[1, 1, 1, 1]], "BY"],
			SameQ[
				PacletizedResourceFunctions`SetSymbolsContext[
					FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY[[1, 1, 1, 2, 1, 4, 1, 1, 2, 1, 1, 1, 1]]
				],
				PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`x @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`t
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY[[1, 1, 1, 1]], "BY"],
			SameQ[
				PacletizedResourceFunctions`SetSymbolsContext[
					FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY[[1, 1, 1, 2, 1, 4, 1, 1, 2, 1, 1, 1, 1]]
				],
				PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`x @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`t
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231109-O9TNP8"
]
VerificationTest[
	Apply[And,
		{
			SameQ[Head @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY, Column],
			SameQ[Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY[[1]]], List],
			SameQ[Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY[[1, 1]]], OpenerView],
			Apply[And,
				Map[MatchQ[#, Grid]&,
					Map[Head, FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY[[1, 1;;, 1, 2]]]
				]
			],
			SameQ[Head @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY, Column],
			SameQ[Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY[[1]]], List],
			SameQ[Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY[[1, 1]]], OpenerView],
			Apply[And,
				Map[MatchQ[#, Grid]&,
					Map[Head, FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY[[1, 1;;, 1, 2]]]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231109-KO928N"
]
VerificationTest[
	SameQ[
		With[{FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`localPi = 3.14},
			{
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ 3.14,
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14, NumberMarks -> True],
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14, NumberMarks -> False],
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`localPi,
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`localPi, NumberMarks -> True],
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`localPi, NumberMarks -> False],
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`\[CapitalPi],
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`\[CapitalPi], CharacterEncoding -> "ASCII"],
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ Pi,
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ N @ Pi,
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14 * 10 ^ -7],
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[
					Flatten[
						{ReplaceAll[FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stripContext[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`delta] / 2, FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stripContext[{FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`delta -> 0.99}]]}
					]
				]
			}
		],
		{
			"3.14", "3.14`", "3.14", "3.14", "3.14`", "3.14", "\[CapitalPi]", "\\[CapitalPi]", "3.141592653589793",
			"3.141592653589793", "3.14*^-7", "{0.495}"
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231109-SZZTU8"
]
VerificationTest[
	Not[
		StringFreeQ[
			FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stringFormattingTemplate @ "Long-run risk model with stochastic volatility in the original 2004 paper by Bansal and Yaron",
			"\t" | "\n"
		]
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231109-DD1AHQ"
] 
End[]
EndTestSection[]
