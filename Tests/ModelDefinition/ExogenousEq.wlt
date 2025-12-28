BeginTestSection["ExogenousEq Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`"]

(* --- merged from: ExogenousEq_test1.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`";

VerificationTest[
	!SameQ[Names @ "*xeq", {}]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20251223-ZYM4OJ@@Tests/ModelDefinition/ExogenousEq.wlt:7,1-15,2"
]

(* --- merged from: ExogenousEq_test2.wlt --- *)
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
	TestID->"ExogenousEq_20251223-H81EM4@@Tests/ModelDefinition/ExogenousEq.wlt:20,1-179,2"
]

(* --- merged from: ExogenousEq_test3.wlt --- *)
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
	TestID->"ExogenousEq_20251223-PWNV9J@@Tests/ModelDefinition/ExogenousEq.wlt:184,1-212,2"
]

(* --- merged from: ExogenousEq_test4.wlt --- *)
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
	TestID->"ExogenousEq_20251223-GBWLQP@@Tests/ModelDefinition/ExogenousEq.wlt:217,1-237,2"
]

(* --- merged from: ExogenousEq_test5.wlt --- *)
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
	TestID->"ExogenousEq_20251223-A7X3P4@@Tests/ModelDefinition/ExogenousEq.wlt:242,1-262,2"
]

(* --- merged from: ExogenousEq_test6.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`";

VerificationTest[
	Apply[And,
		{
			FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t, foo`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t],
			FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ foo`t, FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ foo`t, foo`t],
			!SameQ[foo`xeq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t],
			!SameQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ foo`t]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20251223-0DJU31@@Tests/ModelDefinition/ExogenousEq.wlt:267,1-284,2"
]

End[]
EndTestSection[]
