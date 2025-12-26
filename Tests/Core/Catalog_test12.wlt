BeginTestSection["Catalog"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Catalog`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

VerificationTest[
	Apply[And,
		Map[
			Function[
				Apply[And,
					Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
						Map[Context,
							Cases[
								FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["stateVars"],
								RuleDelayed[
									PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
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
	TestID->"Catalog_20251223-2IK0IQ@@Tests/Catalog.wlt:218,1-246,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
