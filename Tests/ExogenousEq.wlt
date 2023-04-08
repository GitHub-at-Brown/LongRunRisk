BeginTestSection["ExogenousEq"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"ExogenousEq_20230408-U7NNF8"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`"]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20230408-K6BHUV"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`"
	,
	Null
	,
	{}
	,
	TestID->"ExogenousEq_20230408-D48DJQ"
]


VerificationTest[
	!SameQ[Names @ "*xeq", {}]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20230408-K05CXT"
]


VerificationTest[
	SetSymbolsContext = ResourceFunction @ "SetSymbolsContext";
	SetSymbolsContext @ Evaluate @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ t
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
	TestID->"ExogenousEq_20230408-8ZMOEI"
]


EndTestSection[]
