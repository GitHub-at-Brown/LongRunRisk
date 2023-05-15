BeginTestSection["ExogenousEq"] 
Begin["ExogenousEq`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`"
	,
	Null
	,
	{}
	,
	TestID->"ExogenousEq_20230513-ZCEH03"
]
VerificationTest[
	!SameQ[Names @ "*xeq", {}]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20230513-GYWIO2"
]
VerificationTest[
	Apply[And,
		{
			MemberQ[
				DeleteDuplicates[
					Map[Context,
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ ExogenousEq`t,
							RuleDelayed[
								PatternTest[ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "x"]]][___],
								ExogenousEq`var
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
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`pieq @ ExogenousEq`t,
							RuleDelayed[
								PatternTest[ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "pi"]]][___],
								ExogenousEq`var
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
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`pibareq @ ExogenousEq`t,
							RuleDelayed[
								PatternTest[ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "pibar"]]][___],
								ExogenousEq`var
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
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`sgeq @ ExogenousEq`t,
							RuleDelayed[
								PatternTest[ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "sg"]]][___],
								ExogenousEq`var
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
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`sxeq @ ExogenousEq`t,
							RuleDelayed[
								PatternTest[ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "sx"]]][___],
								ExogenousEq`var
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
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`sceq @ ExogenousEq`t,
							RuleDelayed[
								PatternTest[ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "sc"]]][___],
								ExogenousEq`var
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
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`speq @ ExogenousEq`t,
							RuleDelayed[
								PatternTest[ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "sp"]]][___],
								ExogenousEq`var
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
							PatternTest[ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "dc"]]],
							ExogenousEq`var
						],
						Infinity
					]
				]
			],
			Not[
				SameQ[{},
					Cases[Map[Symbol, Names @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"],
						RuleDelayed[
							PatternTest[ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "dd"]]],
							ExogenousEq`var
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
								PatternTest[ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "dc"]]],
								ExogenousEq`var
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
								PatternTest[ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "dd"]]],
								ExogenousEq`var
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
	TestID->"ExogenousEq_20230513-9RRRF8"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
			Map[Context,
				Cases[Map[Slot[1][ExogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars]],
					RuleDelayed[
						PatternTest[
							ExogenousEq`var_Symbol,
							Function[
								MemberQ[
									Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
									SymbolName[#]
								]
							]
						][__],
						ExogenousEq`var
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
	TestID->"ExogenousEq_20230513-NXOTIG"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
			Map[Context,
				Cases[Map[Slot[1][ExogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars]],
					RuleDelayed[
						PatternTest[ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
						ExogenousEq`var
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
	TestID->"ExogenousEq_20230513-BVWWMZ"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
			Map[Context,
				Cases[Map[Slot[1][ExogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars]],
					RuleDelayed[
						PatternTest[ExogenousEq`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
						ExogenousEq`var
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
	TestID->"ExogenousEq_20230513-BV43YV"
]
VerificationTest[
	Apply[And,
		{
			FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ ExogenousEq`t, foo`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ ExogenousEq`t, ExogenousEq`t],
			FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ foo`t, ExogenousEq`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ foo`t, foo`t],
			!SameQ[foo`xeq @ ExogenousEq`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ ExogenousEq`t],
			!SameQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ ExogenousEq`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ foo`t]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20230513-8RJUH2"
] 
End[]
EndTestSection[]
