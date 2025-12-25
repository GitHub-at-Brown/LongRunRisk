BeginTestSection["Shocks"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Shocks`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`Shocks`";

VerificationTest[
	With[
		{
			FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tb = Table[
				(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t],
				{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}
			]
		},
		SameQ[
			{
				Map[SymbolName @* Head, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tb],
				Map[
					Composition[
						Function @ If[
							NumberQ[#], ToString @ #, If[Developer`HoldSymbolQ[#], SymbolName @ #, ""]
						],
						First
					],
					FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tb
				]
			},
			{{"taugd", "taugd", "taugd"}, {"1", "i", "j"}}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251223-XDJQWX@@Tests/Shocks.wlt:142,1-172,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
