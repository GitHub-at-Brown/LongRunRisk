BeginTestSection["NiceOutput"] 
Begin["NiceOutput`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"
	,
	Null
	,
	{}
	,
	TestID->"NiceOutput_20230423-WK0Y9W"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20230423-Z8P6SU"
]
VerificationTest[
	!SameQ[Names @ "*Info", {}]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20230423-7S9DNO"
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
	TestID->"NiceOutput_20230423-YI2YLB"
]
VerificationTest[
	NiceOutput`newBY = <|"myModel" -> FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]|>;
	NiceOutput`newBYInfo = FernandoDuarte`LongRunRisk`Tools`NiceOutput`Info @ NiceOutput`newBY;
	NiceOutput`newBYproc = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ NiceOutput`newBY;
	NiceOutput`newBYprocInfo = FernandoDuarte`LongRunRisk`Tools`NiceOutput`Info @ NiceOutput`newBYproc;
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
	,
	{True, True, True, True}
	,
	{}
	,
	TestID->"NiceOutput_20230423-8MH542"
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
	TestID->"NiceOutput_20230423-4ZW713"
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
	TestID->"NiceOutput_20230423-42E703"
] 
End[]
EndTestSection[]
