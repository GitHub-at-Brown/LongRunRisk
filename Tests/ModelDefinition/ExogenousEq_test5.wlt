BeginTestSection["ExogenousEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`";

VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
			Map[Context,
				Cases[Map[Slot[1][FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars]],
					RuleDelayed[
						PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
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
	TestID->"ExogenousEq_20251223-A7X3P4@@Tests/ExogenousEq.wlt:232,1-252,2"
]

End[]
EndTestSection[]
