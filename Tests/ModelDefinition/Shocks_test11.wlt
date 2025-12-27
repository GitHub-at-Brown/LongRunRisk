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
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps @ FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f,
							{
								FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f,
								{"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"}
							}
						]
					}
				],
				Table[SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps["ddd"] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], FernandoDuarte`LongRunRisk`Model`Shocks`eps @ "ddd"],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251223-7O3J7T@@Tests/ModelDefinition/Shocks_test11.wlt:6,1-33,2"
]

End[]
EndTestSection[]
