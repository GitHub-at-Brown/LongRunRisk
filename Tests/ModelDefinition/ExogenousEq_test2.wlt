BeginTestSection["ExogenousEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`";

VerificationTest[
	Apply[And,
		{
			MemberQ[
				DeleteDuplicates[
					Map[Context,
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t,
							RuleDelayed[
								PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "x"]]][___],
								FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var
							],
							Infinity
						]
					]
				],
				"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"
			],
			MemberQ[
				DeleteDuplicates[
					Map[Context,
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`pieq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t,
							RuleDelayed[
								PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "pi"]]][___],
								FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var
							],
							Infinity
						]
					]
				],
				"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"
			],
			MemberQ[
				DeleteDuplicates[
					Map[Context,
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`pibareq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t,
							RuleDelayed[
								PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "pibar"]]][___],
								FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var
							],
							Infinity
						]
					]
				],
				"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"
			],
			MemberQ[
				DeleteDuplicates[
					Map[Context,
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`sgeq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t,
							RuleDelayed[
								PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "sg"]]][___],
								FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var
							],
							Infinity
						]
					]
				],
				"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"
			],
			MemberQ[
				DeleteDuplicates[
					Map[Context,
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`sxeq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t,
							RuleDelayed[
								PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "sx"]]][___],
								FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var
							],
							Infinity
						]
					]
				],
				"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"
			],
			MemberQ[
				DeleteDuplicates[
					Map[Context,
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`sceq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t,
							RuleDelayed[
								PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "sc"]]][___],
								FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var
							],
							Infinity
						]
					]
				],
				"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"
			],
			MemberQ[
				DeleteDuplicates[
					Map[Context,
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`speq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t,
							RuleDelayed[
								PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "sp"]]][___],
								FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var
							],
							Infinity
						]
					]
				],
				"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"
			],
			Not[
				SameQ[{},
					Cases[Map[Symbol, Names @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"],
						RuleDelayed[
							PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "dc"]]],
							FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var
						],
						Infinity
					]
				]
			],
			Not[
				SameQ[{},
					Cases[Map[Symbol, Names @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"],
						RuleDelayed[
							PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "dd"]]],
							FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var
						],
						Infinity
					]
				]
			],
			MemberQ[
				DeleteDuplicates[
					Map[Context,
						Cases[Map[Symbol, Names @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"],
							RuleDelayed[
								PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "dc"]]],
								FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var
							],
							Infinity
						]
					]
				],
				"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"
			],
			MemberQ[
				DeleteDuplicates[
					Map[Context,
						Cases[Map[Symbol, Names @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"],
							RuleDelayed[
								PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "dd"]]],
								FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var
							],
							Infinity
						]
					]
				],
				"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20251223-H81EM4@@Tests/ExogenousEq.wlt:22,1-181,2"
]

End[]
EndTestSection[]
