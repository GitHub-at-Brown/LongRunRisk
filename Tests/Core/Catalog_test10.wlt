BeginTestSection["Catalog"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Catalog`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

VerificationTest[
	Apply[And,
		Map[
			Function[
				Apply[And,
					Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
						Map[Context,
							Cases[
								FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["stateVars"],
								RuleDelayed[
									PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
									FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var
								],
								Infinity
							]
						]
					]
				]
			],
			Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20251223-CW7BLD@@Tests/Catalog.wlt:160,1-188,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
