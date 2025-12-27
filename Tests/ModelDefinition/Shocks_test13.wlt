BeginTestSection["Shocks"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Shocks`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`Shocks`";

VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[SameQ[NewContext`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], 0],
					{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
				],
				Table[SameQ[NewContext`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], 0],
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
	TestID->"Shocks_20251223-DD6HSL@@Tests/ModelDefinition/Shocks_test13.wlt:6,1-25,2"
]

End[]
EndTestSection[]
