BeginTestSection["ExogenousEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`";

VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
			Map[Context,
				Cases[Map[Slot[1][FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars]],
					RuleDelayed[
						PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
						FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var
					],
					Infinity
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20251223-GBWLQP@@Tests/ExogenousEq.wlt:211,1-231,2"
]

End[]
EndTestSection[]
