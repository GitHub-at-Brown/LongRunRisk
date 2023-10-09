BeginTestSection["ExogenousEq"] 
Begin["Model`ExogenousEq`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`";
	True
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20231007-NIGA55"
]
VerificationTest[
	!SameQ[Names @ "*xeq", {}]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20231007-E0I1JF"
]
VerificationTest[
	Apply[And,
		{
			MemberQ[
				DeleteDuplicates[
					Map[Context,
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ Model`ExogenousEq`t,
							RuleDelayed[
								PatternTest[Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "x"]]][___],
								Model`ExogenousEq`var
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
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`pieq @ Model`ExogenousEq`t,
							RuleDelayed[
								PatternTest[Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "pi"]]][___],
								Model`ExogenousEq`var
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
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`pibareq @ Model`ExogenousEq`t,
							RuleDelayed[
								PatternTest[Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "pibar"]]][___],
								Model`ExogenousEq`var
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
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`sgeq @ Model`ExogenousEq`t,
							RuleDelayed[
								PatternTest[Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "sg"]]][___],
								Model`ExogenousEq`var
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
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`sxeq @ Model`ExogenousEq`t,
							RuleDelayed[
								PatternTest[Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "sx"]]][___],
								Model`ExogenousEq`var
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
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`sceq @ Model`ExogenousEq`t,
							RuleDelayed[
								PatternTest[Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "sc"]]][___],
								Model`ExogenousEq`var
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
						Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`speq @ Model`ExogenousEq`t,
							RuleDelayed[
								PatternTest[Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "sp"]]][___],
								Model`ExogenousEq`var
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
							PatternTest[Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "dc"]]],
							Model`ExogenousEq`var
						],
						Infinity
					]
				]
			],
			Not[
				SameQ[{},
					Cases[Map[Symbol, Names @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"],
						RuleDelayed[
							PatternTest[Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "dd"]]],
							Model`ExogenousEq`var
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
								PatternTest[Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "dc"]]],
								Model`ExogenousEq`var
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
								PatternTest[Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "dd"]]],
								Model`ExogenousEq`var
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
	TestID->"ExogenousEq_20231007-7R20E8"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
			Map[Context,
				Cases[Map[Slot[1][Model`ExogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars]],
					RuleDelayed[
						PatternTest[
							Model`ExogenousEq`var_Symbol,
							Function[
								MemberQ[
									Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
									SymbolName[#]
								]
							]
						][__],
						Model`ExogenousEq`var
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
	TestID->"ExogenousEq_20231007-NBIB7Y"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
			Map[Context,
				Cases[Map[Slot[1][Model`ExogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars]],
					RuleDelayed[
						PatternTest[Model`ExogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
						Model`ExogenousEq`var
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
	TestID->"ExogenousEq_20231007-YFUEVW"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
			Map[Context,
				Cases[Map[Slot[1][Model`ExogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars]],
					RuleDelayed[
						PatternTest[Model`ExogenousEq`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
						Model`ExogenousEq`var
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
	TestID->"ExogenousEq_20231007-TNAM0Y"
]
VerificationTest[
	Apply[And,
		{
			FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ Model`ExogenousEq`t, foo`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ Model`ExogenousEq`t, Model`ExogenousEq`t],
			FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ foo`t, Model`ExogenousEq`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ foo`t, foo`t],
			!SameQ[foo`xeq @ Model`ExogenousEq`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ Model`ExogenousEq`t],
			!SameQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ Model`ExogenousEq`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ foo`t]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20231007-924CFO"
] 
End[]
EndTestSection[]
