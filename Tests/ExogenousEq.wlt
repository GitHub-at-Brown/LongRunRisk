BeginTestSection["ExogenousEq"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`"
	,
	Null
	,
	{}
	,
	TestID->"ExogenousEq_20230416-87JI0J"
]


VerificationTest[
	!SameQ[Names @ "*xeq", {}]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20230416-B57RI4"
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
	TestID->"ExogenousEq_20230416-5MKM6G"
]


EndTestSection[]
