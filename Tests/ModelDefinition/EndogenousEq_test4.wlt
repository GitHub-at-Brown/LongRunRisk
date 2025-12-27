BeginTestSection["EndogenousEq"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";
Needs @ "FernandoDuarte`LongRunRisk`Model`Parameters`";

VerificationTest[
	(* Test that parameters appearing in endogenous variables are in Parameters context *)
	(* Use Block to ensure Parameters context is searched when resolving Symbol names *)
	Block[{$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Parameters`"]},
		Apply[And,
			Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
				Map[Context,
					Cases[Map[Slot[1][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars]],
						RuleDelayed[
							PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var
						],
						Infinity
					]
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20251223-077TRW@@Tests/EndogenousEq.wlt:72,1-92,2"
]

End[]
EndTestSection[]
