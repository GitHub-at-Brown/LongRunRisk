BeginTestSection["NiceOutput"] 
Begin["Tools`NiceOutput`"]
VerificationTest[
	Tools`NiceOutput`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231010-CSDOMC"
]
VerificationTest[
	Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
	Tools`NiceOutput`msp = If[
		Tools`NiceOutput`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC", "DES", "NRCStochVol"}]
	];
	Tools`NiceOutput`modBY = Tools`NiceOutput`msp @ "BY";
	Tools`NiceOutput`modBKY = Tools`NiceOutput`msp @ "BKY";
	Tools`NiceOutput`modNRC = Tools`NiceOutput`msp @ "NRC";
	Tools`NiceOutput`modDES = Tools`NiceOutput`msp @ "DES";
	Tools`NiceOutput`modNRCStochVol = Tools`NiceOutput`msp @ "NRCStochVol";
	True
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231010-SZ1YXW"
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
	TestID->"NiceOutput_20231010-W3EDPT"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]}]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231010-XBKBUS"
]
VerificationTest[
	!SameQ[Names @ "*info", {}]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231010-BFL7AF"
]
VerificationTest[
	Tools`NiceOutput`myModelsInfo = PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Tools`NiceOutput`info @ Tools`NiceOutput`msp;
	Apply[And,
		{
			SameQ[Head @ Tools`NiceOutput`myModelsInfo, Column],
			SameQ[Head[Tools`NiceOutput`myModelsInfo[[1]]], List],
			SameQ[Head[Tools`NiceOutput`myModelsInfo[[1, 1]]], OpenerView],
			Apply[And,
				Map[MatchQ[#, Grid]&,
					Map[Head, Tools`NiceOutput`myModelsInfo[[1, 1;;, 1, 2]]]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231010-08E57N"
]
VerificationTest[
	Tools`NiceOutput`justBY = <|"BY" -> Tools`NiceOutput`msp["BY"]|>;
	Tools`NiceOutput`infoBY = PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Tools`NiceOutput`info @ Tools`NiceOutput`justBY;
	Tools`NiceOutput`newBY = <|"myModel" -> Tools`NiceOutput`msp["BY"]|>;
	Tools`NiceOutput`infoNewBY = PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Tools`NiceOutput`info @ Tools`NiceOutput`newBY;
	Apply[And,
		{
			Equal[Tools`NiceOutput`infoBY[[1, 1, 1, 1]], "BY"],
			SameQ[Tools`NiceOutput`infoBY[[1, 1, 1, 2, 1, 4, 1, 1, 2, 1, 1, 1, 1]],
				Tools`NiceOutput`x @ Tools`NiceOutput`t
			],
			Equal[Tools`NiceOutput`infoNewBY[[1, 1, 1, 1]], "BY"],
			SameQ[Tools`NiceOutput`infoNewBY[[1, 1, 1, 2, 1, 4, 1, 1, 2, 1, 1, 1, 1]],
				Tools`NiceOutput`x @ Tools`NiceOutput`t
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231010-2ALCRK"
]
VerificationTest[
	Apply[And,
		{
			SameQ[Head @ Tools`NiceOutput`infoBY, Column],
			SameQ[Head[Tools`NiceOutput`infoBY[[1]]], List],
			SameQ[Head[Tools`NiceOutput`infoBY[[1, 1]]], OpenerView],
			Apply[And,
				Map[MatchQ[#, Grid]&,
					Map[Head, Tools`NiceOutput`infoBY[[1, 1;;, 1, 2]]]
				]
			],
			SameQ[Head @ Tools`NiceOutput`infoNewBY, Column],
			SameQ[Head[Tools`NiceOutput`infoNewBY[[1]]], List],
			SameQ[Head[Tools`NiceOutput`infoNewBY[[1, 1]]], OpenerView],
			Apply[And,
				Map[MatchQ[#, Grid]&,
					Map[Head, Tools`NiceOutput`infoNewBY[[1, 1;;, 1, 2]]]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20231010-WRGBND"
]
VerificationTest[
	SameQ[
		With[{Tools`NiceOutput`localPi = 3.14},
			{
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ 3.14,
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14, NumberMarks -> True],
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14, NumberMarks -> False],
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ Tools`NiceOutput`localPi,
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[Tools`NiceOutput`localPi, NumberMarks -> True],
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[Tools`NiceOutput`localPi, NumberMarks -> False],
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ Tools`NiceOutput`\[CapitalPi],
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[Tools`NiceOutput`\[CapitalPi], CharacterEncoding -> "ASCII"],
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ Pi,
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ N @ Pi,
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14 * 10 ^ -7],
				FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[
					Flatten[
						{ReplaceAll[FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stripContext[Tools`NiceOutput`delta] / 2, FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stripContext[{Tools`NiceOutput`delta -> 0.99}]]}
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
	TestID->"NiceOutput_20231010-MIKOL2"
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
	TestID->"NiceOutput_20231010-BCSCQH"
] 
End[]
EndTestSection[]
