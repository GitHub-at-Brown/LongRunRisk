BeginTestSection["NiceOutput"] 
Begin["NiceOutput`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"
	,
	Null
	,
	{}
	,
	TestID->"NiceOutput_20230422-L305K0"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20230422-4FKIS8"
]
VerificationTest[
	!SameQ[Names @ "*Info", {}]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20230422-L2JQBJ"
]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
	Apply[And,
		{
			!SameQ[Names @ "*models", {}],
			!SameQ[Names @ "*processModels", {}]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20230422-TC2NKC"
]
VerificationTest[
	NiceOutput`newBY = <|"myModel" -> FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]|>;
	NiceOutput`newBYInfo = FernandoDuarte`LongRunRisk`Tools`NiceOutput`Info @ NiceOutput`newBY;
	NiceOutput`newBYproc = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ NiceOutput`newBY;
	NiceOutput`newBYprocInfo = FernandoDuarte`LongRunRisk`Tools`NiceOutput`Info @ NiceOutput`newBYproc;
	Apply[And,
		{
			SameQ[NiceOutput`newBYInfo[[1, 1, 1, 1]], "BY"],
			SameQ[NiceOutput`newBYInfo[[1, 1, 1, 2, 1, 4, 1, 1, 2, 1, 1, 1, 1]],
				NiceOutput`x @ NiceOutput`t
			],
			SameQ[NiceOutput`newBYprocInfo[[1, 1, 1, 1]], "BY"],
			SameQ[
				NiceOutput`newBYprocInfo[[1, 1, 1, 2, 1, 4, 1, 1, 2, 1, 1, 1, 1]],
				NiceOutput`x @ NiceOutput`t
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20230422-97F6HY"
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
			FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate @ FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stripContext @ {3.14*10^-7},
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
		"3.141592653589793", "3.14*^-7", "{}", "{0.495}"
	}
	,
	{}
	,
	TestID->"NiceOutput_20230422-CVC92U"
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
	TestID->"NiceOutput_20230422-34A8FL"
] 
End[]
EndTestSection[]
