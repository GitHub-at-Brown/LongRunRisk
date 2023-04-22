BeginTestSection["ExogenousEq"] 
Begin["ExogenousEq`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`"
	,
	Null
	,
	{}
	,
	TestID->"ExogenousEq_20230422-CEAWIR"
]
VerificationTest[
	!SameQ[Names @ "*xeq", {}]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20230422-Z5NJPK"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ ProcessModels`t
	,
	Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhoxpbar * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pibar[ProcessModels`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mupbar),
		Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhox * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`x[ProcessModels`t - 1],
			Plus[
				Times[FernandoDuarte`LongRunRisk`Model`Parameters`phixc,
					Times[((FernandoDuarte`LongRunRisk`Model`Parameters`Esc ^ 2) + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sc[ProcessModels`t - 1]) ^ Rational[1, 2],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][ProcessModels`t]
					]
				],
				Times[FernandoDuarte`LongRunRisk`Model`Parameters`phix,
					Times[((FernandoDuarte`LongRunRisk`Model`Parameters`Esx ^ 2) + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sx[ProcessModels`t - 1]) ^ Rational[1, 2],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["x"][ProcessModels`t]
					]
				]
			]
		]
	]
	,
	{}
	,
	TestID->"ExogenousEq_20230422-3FVK6U"
] 
End[]
EndTestSection[]
