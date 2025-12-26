BeginTestSection["EndogenousEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";

VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"]&,
			Map[Context,
				Cases[Map[Slot[1][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars]],
					RuleDelayed[
						PatternTest[
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var_Symbol,
							Function[
								MemberQ[
									Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
									SymbolName[#]
								]
							]
						][__],
						FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var
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
	TestID->"EndogenousEq_20251223-72QAYI@@Tests/EndogenousEq.wlt:93,1-121,2"
]

End[]
EndTestSection[]
