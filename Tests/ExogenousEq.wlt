BeginTestSection["ExogenousEq"] 
Begin["ExogenousEq`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`"
	,
	Null
	,
	{}
	,
	TestID->"ExogenousEq_20230430-2RKQZT"
]
VerificationTest[
	!SameQ[Names @ "*xeq", {}]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20230430-NYA3HI"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ ExogenousEq`t
	,
	Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhoxpbar * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pibar[ExogenousEq`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mupbar),
		Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhox * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`x[ExogenousEq`t - 1],
			Plus[
				Times[FernandoDuarte`LongRunRisk`Model`Parameters`phixc,
					Times[((FernandoDuarte`LongRunRisk`Model`Parameters`Esc ^ 2) + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sc[ExogenousEq`t - 1]) ^ Rational[1, 2],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][ExogenousEq`t]
					]
				],
				Times[FernandoDuarte`LongRunRisk`Model`Parameters`phix,
					Times[((FernandoDuarte`LongRunRisk`Model`Parameters`Esx ^ 2) + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sx[ExogenousEq`t - 1]) ^ Rational[1, 2],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["x"][ExogenousEq`t]
					]
				]
			]
		]
	]
	,
	{}
	,
	TestID->"ExogenousEq_20230430-6FI1ZA"
]
VerificationTest[
	Module[{ExogenousEq`allShocks},
		ExogenousEq`allShocks = Cases[
			ResourceFunction["SetSymbolsContext"][
				Map[ToExpression, Map[StringJoin[#, "[t]"]&, FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars]]
			],
			ExogenousEq`eps[ExogenousEq`var_][ExogenousEq`t_] :> StringJoin[ToString[ExogenousEq`var], "eq"],
			Infinity
		];
		SubsetQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars, DeleteDuplicates @ ExogenousEq`allShocks]
	]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20230430-CH1YSN"
] 
End[]
EndTestSection[]
