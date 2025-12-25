BeginTestSection["ExogenousEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`";

VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
			Map[Context,
				Cases[Map[Slot[1][FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars]],
					RuleDelayed[
						PatternTest[
							FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol,
							Function[
								MemberQ[
									Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
									SymbolName[#]
								]
							]
						][__],
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
	TestID->"ExogenousEq_20251223-PWNV9J@@Tests/ExogenousEq.wlt:182,1-210,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
