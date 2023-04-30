BeginTestSection["NiceOutput"] 
Begin["NiceOutput`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Tools`NiceOutput`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
	Needs @ "PacletizedResourceFunctions`";
	Get @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	Needs @ "MaTeX`";
	,
	Null
	,
	{}
	,
	TestID->"NiceOutput_20230430-ZCQFAM"
]
VerificationTest[
	Apply[And,
		{
			MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"],
			MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"],
			MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"],
			MemberQ[$ContextPath, "PacletizedResourceFunctions`"]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20230430-H5Y998"
]
VerificationTest[
	!SameQ[Names @ "*Info", {}]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20230430-QKXM6S"
]
VerificationTest[
	Apply[And,
		{
			!SameQ[Names @ "*processModels", {}],
			!SameQ[Names @ "*models", {}]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20230430-RT7KCF"
]
VerificationTest[
	NiceOutput`myModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;
	{
		Head @ NiceOutput`myModels["BKY"]["numStocks"],
		Part[NiceOutput`myModels["BKY"]["parameters"], 1]
	}
	,
	{Missing, FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9989}
	,
	{}
	,
	TestID->"NiceOutput_20230430-GSTQDK"
]
VerificationTest[
	NiceOutput`myModelsInfo = FernandoDuarte`LongRunRisk`Tools`NiceOutput`Info @ NiceOutput`myModels;
	Apply[And,
		{
			SameQ[Head @ NiceOutput`myModelsInfo, Column],
			SameQ[Head[NiceOutput`myModelsInfo[[1]]], List],
			SameQ[Head[NiceOutput`myModelsInfo[[1, 1]]], OpenerView],
			Apply[And,
				Map[MatchQ[#, Grid]&,
					Map[Head, NiceOutput`myModelsInfo[[1, 1;;, 1, 2]]]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20230430-IW2FAF"
]
VerificationTest[
	NiceOutput`newBY = <|"myModel" -> NiceOutput`myModels["BY"]|>;
	NiceOutput`newBYInfo = PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Tools`NiceOutput`Info @ NiceOutput`newBY;
	NiceOutput`newBYproc = PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ NiceOutput`newBY;
	NiceOutput`newBYprocInfo = FernandoDuarte`LongRunRisk`Tools`NiceOutput`Info @ NiceOutput`newBYproc;
	Apply[And,
		{
			SameQ[NiceOutput`newBYInfo[[1, 1, 1, 1]], "BY"],
			SameQ[
				ToString[
					NiceOutput`newBYInfo[[1, 1, 1, 2, 1, 4, 1, 1, 2, 1, 1, 1, 1]]
				],
				"x[t]"
			],
			SameQ[NiceOutput`newBYprocInfo[[1, 1, 1, 1]], "BY"],
			SameQ[
				ToString[
					NiceOutput`newBYprocInfo[[1, 1, 1, 2, 1, 4, 1, 1, 2, 1, 1, 1, 1]]
				],
				"x[t]"
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20230430-D66RE9"
]
VerificationTest[
	Apply[And,
		{
			SameQ[Head @ NiceOutput`newBYInfo, Column],
			SameQ[Head[NiceOutput`newBYInfo[[1]]], List],
			SameQ[Head[NiceOutput`newBYInfo[[1, 1]]], OpenerView],
			Apply[And,
				Map[MatchQ[#, Grid]&,
					Map[Head, NiceOutput`newBYInfo[[1, 1;;, 1, 2]]]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20230430-78KH9K"
]
VerificationTest[
	With[{NiceOutput`localPi = 3.14},
		{
			FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ 3.14,
			FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14, NumberMarks -> True],
			FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14, NumberMarks -> False],
			FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ NiceOutput`localPi,
			FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[NiceOutput`localPi, NumberMarks -> True],
			FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[NiceOutput`localPi, NumberMarks -> False],
			FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ NiceOutput`\[CapitalPi],
			FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[NiceOutput`\[CapitalPi], CharacterEncoding -> "ASCII"],
			FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ Pi,
			FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ N @ Pi,
			FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14 * 10 ^ -7],
			FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[
				Flatten[
					{ReplaceAll[FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stripContext[NiceOutput`delta] / 2, FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stripContext[{NiceOutput`delta -> 0.99}]]}
				]
			]
		}
	]
	,
	{
		"3.14", "3.14`", "3.14", "3.14", "3.14`", "3.14", "\[CapitalPi]", "\\[CapitalPi]", "3.141592653589793",
		"3.141592653589793", "3.14*^-7", "{0.495}"
	}
	,
	{}
	,
	TestID->"NiceOutput_20230430-3HYGZ7"
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
	TestID->"NiceOutput_20230430-UH3CPJ"
] 
End[]
EndTestSection[]
