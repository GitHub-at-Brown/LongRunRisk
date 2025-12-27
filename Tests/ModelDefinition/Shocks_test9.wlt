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
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + 1],
							{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
						]
					}
				],
				Table[SameQ[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr],
					{
						FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr,
						Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[ToExpression @ FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t],
							{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
						]
					}
				],
				Table[SameQ[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr],
					{
						FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr,
						{FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i], FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`dd][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i]}
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
	TestID->"Shocks_20251223-U3G5UH@@Tests/ModelDefinition/Shocks_test9.wlt:6,1-41,2"
]

End[]
EndTestSection[]
