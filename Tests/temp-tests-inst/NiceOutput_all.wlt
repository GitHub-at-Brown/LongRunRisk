BeginTestSection["NiceOutput"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`"]

(* Load a package to find paclet root *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];
On[General::shdw];

VerificationTest[
	Module[{pacletFile, pacletRoot},
		pacletFile = FindFile["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];
		pacletRoot = If[StringQ[pacletFile],
			DirectoryName[pacletFile, 3],
			If[StringQ[$InputFileName] && $InputFileName =!= "",
				DirectoryName[$InputFileName, 2],
				Directory[]
			]
		];
		FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`distributedPaclet = FileNameJoin[{
			pacletRoot, "Resources", "PacletizedResourceFunctions.paclet"
		}];
		If[FileExistsQ[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`distributedPaclet],
			PacletInstall[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`distributedPaclet, "IgnoreVersion" -> True];
		];
		True
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20251223-0M5X2B@@Tests/NiceOutput.wlt:9,1-33,2"
]
VerificationTest[
	Greater[Length @ PacletFind @ "PacletizedResourceFunctions", 0]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20251223-W4Y3IH@@Tests/NiceOutput.wlt:34,1-42,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20251223-VW18UF@@Tests/NiceOutput.wlt:43,1-52,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Models = Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
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
	TestID->"NiceOutput_20251223-XQJQF1@@Tests/NiceOutput.wlt:53,1-70,2"
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
	TestID->"NiceOutput_20251223-LVJFXU@@Tests/NiceOutput.wlt:71,1-81,2"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]}]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20251223-JUUTIC@@Tests/NiceOutput.wlt:82,1-90,2"
]
VerificationTest[
	!SameQ[Names @ "*info", {}]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20251223-K4B6I8@@Tests/NiceOutput.wlt:91,1-99,2"
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
	TestID->"NiceOutput_20251223-C58NLK@@Tests/NiceOutput.wlt:100,1-120,2"
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
	TestID->"NiceOutput_20251223-WJET5C@@Tests/NiceOutput.wlt:121,1-150,2"
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
	TestID->"NiceOutput_20251223-1LRLAE@@Tests/NiceOutput.wlt:151,1-178,2"
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
	TestID->"NiceOutput_20251223-TZN6TZ@@Tests/NiceOutput.wlt:179,1-212,2"
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
	TestID->"NiceOutput_20251223-SFQJ4X@@Tests/NiceOutput.wlt:213,1-226,2"
] 
VerificationTest[
  $ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ]; True,
  True,
  TestID -> "Untitled-16@@Tests/NiceOutput.wlt:227,1-231,2"
]
End[]
EndTestSection[]
