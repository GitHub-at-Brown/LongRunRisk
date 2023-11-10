BeginTestSection["ExogenousEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`";
	True
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20231109-E4CXDK"
]
VerificationTest[
	!SameQ[Names @ "*xeq", {}]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20231109-ROI2PT"
]
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
	TestID->"ExogenousEq_20231109-1FTYXC"
]
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
	TestID->"ExogenousEq_20231109-8GNK2A"
]
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
	TestID->"ExogenousEq_20231109-IZMKKN"
]
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
	TestID->"ExogenousEq_20231109-S2XO45"
]
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
	TestID->"ExogenousEq_20231109-N89GAG"
] 
End[]
EndTestSection[]
