BeginTestSection["NiceOutput"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`"]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`distributedPaclet = FileNameJoin @ {
		DirectoryName[$InputFileName, 2],
		"Resources", "PacletizedResourceFunctions.paclet"
	};
	If[FileExistsQ[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`distributedPaclet],
		PacletInstall[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`distributedPaclet, "IgnoreVersion" -> True];
	];
	True
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20251030-ALFIES@@Tests/NiceOutput.wlt:3,1-18,2"
]
VerificationTest[
	Greater[Length @ PacletFind @ "PacletizedResourceFunctions", 0]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20251030-YQVMBE@@Tests/NiceOutput.wlt:19,1-27,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20251030-ZST46A@@Tests/NiceOutput.wlt:28,1-37,2"
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
	TestID->"NiceOutput_20251030-P2MLRN@@Tests/NiceOutput.wlt:38,1-55,2"
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
	TestID->"NiceOutput_20251030-KL97V3@@Tests/NiceOutput.wlt:56,1-66,2"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]}]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20251030-SAY7EK@@Tests/NiceOutput.wlt:67,1-75,2"
]
VerificationTest[
	!SameQ[Names @ "*info", {}]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20251030-KYITQF@@Tests/NiceOutput.wlt:76,1-84,2"
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
	TestID->"NiceOutput_20251030-OMFQYZ@@Tests/NiceOutput.wlt:85,1-105,2"
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
	TestID->"NiceOutput_20251030-K369J3@@Tests/NiceOutput.wlt:106,1-135,2"
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
	TestID->"NiceOutput_20251030-E54MAB@@Tests/NiceOutput.wlt:136,1-163,2"
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
	TestID->"NiceOutput_20251030-F75PYK@@Tests/NiceOutput.wlt:164,1-197,2"
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
	TestID->"NiceOutput_20251030-F5OG7H@@Tests/NiceOutput.wlt:198,1-211,2"
] 
VerificationTest[
  $ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ]; True,
  True,
  TestID -> "Untitled-16@@Tests/NiceOutput.wlt:212,1-220,8"
]
End[]
EndTestSection[]
