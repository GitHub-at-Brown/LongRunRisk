BeginTestSection["ExogenousEq"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`"
	,
	Null
	,
	{}
	,
	TestID->"ExogenousEq_20230415-K9KEIO"
]


VerificationTest[
	!SameQ[Names @ "*xeq", {}]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20230415-LP9RUW"
]


VerificationTest[
	FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ t
	,
	Plus[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`rhoxpbar * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pibar[t - 1] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`mupbar),
		Plus[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`rhox * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`x[t - 1],
			Plus[
				Times[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`phixc,
					Times[((FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`Esc ^ 2) + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sc[t - 1]) ^ Rational[1, 2],
						FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`eps["dc"][t]
					]
				],
				Times[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`phix,
					Times[((FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`Esx ^ 2) + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sx[t - 1]) ^ Rational[1, 2],
						FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`eps["x"][t]
					]
				]
			]
		]
	]
	,
	{}
	,
	TestID->"ExogenousEq_20230415-HYQAKH"
]


VerificationTest[
	PacletizedResourceFunctions`SetSymbolsContext @ Evaluate @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ t
	,
	Plus[rhoxpbar * (pibar[t - 1] - mupbar),
		Plus[rhox * x[t - 1],
			Plus[
				Times[phixc,
					Times[((Esc ^ 2) + sc[t - 1]) ^ Rational[1, 2],
						eps["dc"][t]
					]
				],
				Times[phix,
					Times[((Esx ^ 2) + sx[t - 1]) ^ Rational[1, 2],
						eps["x"][t]
					]
				]
			]
		]
	]
	,
	{}
	,
	TestID->"ExogenousEq_20230415-YL370Q"
]


EndTestSection[]
