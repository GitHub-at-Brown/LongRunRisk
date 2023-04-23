BeginTestSection["ExogenousEq"] 
Begin["ExogenousEq`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`"
	,
	Null
	,
	{}
	,
	TestID->"ExogenousEq_20230423-VCKBIJ"
]
VerificationTest[
	!SameQ[Names @ "*xeq", {}]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20230423-1YBQDC"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ ExogenousEq`t
	,
	Plus[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`rhoxpbar * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pibar[ExogenousEq`t - 1] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`mupbar),
		Plus[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`rhox * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`x[ExogenousEq`t - 1],
			Plus[
				Times[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`phixc,
					Times[((FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`Esc ^ 2) + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sc[ExogenousEq`t - 1]) ^ Rational[1, 2],
						FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`eps["dc"][ExogenousEq`t]
					]
				],
				Times[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`phix,
					Times[((FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`Esx ^ 2) + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sx[ExogenousEq`t - 1]) ^ Rational[1, 2],
						FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`eps["x"][ExogenousEq`t]
					]
				]
			]
		]
	]
	,
	{}
	,
	TestID->"ExogenousEq_20230423-U6AG00"
] 
End[]
EndTestSection[]
