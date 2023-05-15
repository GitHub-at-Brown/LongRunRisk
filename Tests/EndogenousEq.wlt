BeginTestSection["EndogenousEq"] 
Begin["EndogenousEq`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`"
	,
	Null
	,
	{}
	,
	TestID->"EndogenousEq_20230513-89C0QX"
]
VerificationTest[
	!SameQ[Names @ "*pdeq", {}]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20230513-NDFY41"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
			Map[Context,
				Cases[Map[Slot[1][EndogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars]],
					RuleDelayed[
						PatternTest[
							EndogenousEq`var_Symbol,
							Function[
								MemberQ[
									Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
									SymbolName[#]
								]
							]
						][__],
						EndogenousEq`var
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
	TestID->"EndogenousEq_20230513-KZJVAE"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
			Map[Context,
				Cases[Map[Slot[1][EndogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars]],
					RuleDelayed[
						PatternTest[EndogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
						EndogenousEq`var
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
	TestID->"EndogenousEq_20230513-G7IZ6Q"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
			Map[Context,
				Cases[Map[Slot[1][EndogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars]],
					RuleDelayed[
						PatternTest[EndogenousEq`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
						EndogenousEq`var
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
	TestID->"EndogenousEq_20230513-S5IGT4"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"]&,
			Map[Context,
				Cases[Map[Slot[1][EndogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars]],
					RuleDelayed[
						PatternTest[
							EndogenousEq`var_Symbol,
							Function[
								MemberQ[
									Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
									SymbolName[#]
								]
							]
						][__],
						EndogenousEq`var
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
	TestID->"EndogenousEq_20230513-XV7I84"
]
VerificationTest[
	Apply[And,
		{
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[EndogenousEq`t, EndogenousEq`m], foo`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[EndogenousEq`t, EndogenousEq`m], EndogenousEq`t],
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, EndogenousEq`m], EndogenousEq`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, EndogenousEq`m], foo`t],
			!SameQ[foo`bondyieldeq[EndogenousEq`t, EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[EndogenousEq`t, EndogenousEq`m]],
			!SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[EndogenousEq`t, EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, EndogenousEq`m]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20230513-OO9CYD"
]
VerificationTest[
	Apply[And,
		{
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[EndogenousEq`t, EndogenousEq`m], foo`m],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[EndogenousEq`t, EndogenousEq`m], EndogenousEq`m],
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[EndogenousEq`t, foo`m], EndogenousEq`m],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[EndogenousEq`t, foo`m], foo`m],
			!SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[EndogenousEq`t, EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[EndogenousEq`t, foo`m]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20230513-XXGBCK"
]
VerificationTest[
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfweq[EndogenousEq`t, EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfweq[EndogenousEq`t, EndogenousEq`m, 1]],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondreteq[EndogenousEq`t, EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondreteq[EndogenousEq`t, EndogenousEq`m, 1]],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfwspreadeq[EndogenousEq`t, EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfwspreadeq[EndogenousEq`t, EndogenousEq`m, 1]],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondexcreteq[EndogenousEq`t, EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondexcreteq[EndogenousEq`t, EndogenousEq`m, 1]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20230513-AM21FJ"
] 
End[]
EndTestSection[]
