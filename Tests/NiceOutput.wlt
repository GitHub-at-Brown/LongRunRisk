BeginTestSection["NiceOutput"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"NiceOutput_20230415-LZF7W3"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`"]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20230415-L8TNC8"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`NiceOutput`"
	,
	Null
	,
	{}
	,
	TestID->"NiceOutput_20230415-N9FXDW"
]


VerificationTest[
	!SameQ[Names @ "*formatModels", {}]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20230415-QHOU6W"
]


VerificationTest[
	With[{localPi = 3.14},
		{
			FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`numberFormattingTemplate @ 3.14,
			FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`numberFormattingTemplate[3.14, NumberMarks -> True],
			FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`numberFormattingTemplate[3.14, NumberMarks -> False],
			FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`numberFormattingTemplate @ localPi,
			FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`numberFormattingTemplate[localPi, NumberMarks -> True],
			FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`numberFormattingTemplate[localPi, NumberMarks -> False],
			FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`numberFormattingTemplate @ \[CapitalPi],
			FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`numberFormattingTemplate[\[CapitalPi], CharacterEncoding -> "ASCII"],
			FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`numberFormattingTemplate @ Pi,
			FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`numberFormattingTemplate @ N @ Pi,
			FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`numberFormattingTemplate[3.14 * 10 ^ -7],
			FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`numberFormattingTemplate @ FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`stripContext @ {3.14*10^-7},
			FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`numberFormattingTemplate[
				Flatten[
					{ReplaceAll[FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`stripContext[delta] / 2, FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`stripContext[{delta -> 0.99}]]}
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
	TestID->"NiceOutput_20230415-IXG0ZW"
]


VerificationTest[
	FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`stringFormattingTemplate @ "Long-run risk model with stochastic volatility in the original 2004 paper by Bansal and Yaron"
	,
	"Long-run risk model with stochastic\n\t\t\tvolatility in the original 2004 paper by\n\t\t\tBansal and Yaron"
	,
	{}
	,
	TestID->"NiceOutput_20230415-BEG1EJ"
]


EndTestSection[]
