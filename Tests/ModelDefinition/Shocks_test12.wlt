BeginTestSection["Shocks"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Shocks`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`Shocks`";

VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr],
					{
						FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tt],
							{
								FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f,
								{"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"}
							},
							{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tt, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t - 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`s, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + FernandoDuarte`LongRunRisk`Tests`Model`Shocks`h}}
						]
					}
				],
				Table[SameQ[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr],
					{
						FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tt, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii],
							{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}},
							{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tt, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t - 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`s, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + FernandoDuarte`LongRunRisk`Tests`Model`Shocks`h}}
						]
					}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251223-D9MOEK@@Tests/Shocks.wlt:262,1-296,2"
]

End[]
EndTestSection[]
