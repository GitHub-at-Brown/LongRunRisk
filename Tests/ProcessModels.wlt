BeginTestSection["ProcessModels"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
	True
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-RIXX8A@@Tests/ProcessModels.wlt:3,1-13,2"
]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	True
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-49L5PF@@Tests/ProcessModels.wlt:14,1-23,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-9ZWZ6M@@Tests/ProcessModels.wlt:24,1-33,2"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"], MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"]}]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-QOZJK3@@Tests/ProcessModels.wlt:34,1-42,2"
]
VerificationTest[
	Apply[And,
		{
			!SameQ[Names @ "*processModels", {}],
			!SameQ[Names @ "*models", {}]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-OISCBO@@Tests/ProcessModels.wlt:43,1-56,2"
]
VerificationTest[
	Needs @ "PacletizedResourceFunctions`";
	FernandoDuarte`LongRunRisk`Models = Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
	FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest = If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Model`Catalog`models, KeyTake[FernandoDuarte`LongRunRisk`Model`Catalog`models, {"BY", "BKY", "NRC"}]];
	FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP = If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC"}]];
	True
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-KPUAP3@@Tests/ProcessModels.wlt:57,1-69,2"
]
VerificationTest[
	Apply[And, Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP]]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-U1E50R@@Tests/ProcessModels.wlt:70,1-78,2"
]
VerificationTest[
	Apply[And,
		Map[StringQ,
			Flatten[
				Map[
					Function @ {
						FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["name"],
						FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["shortname"],
						FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["bibRef"],
						FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["desc"],
						FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["exogenousVars"],
						FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousVars"]
					},
					Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-SXLDZY@@Tests/ProcessModels.wlt:79,1-103,2"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[NumberQ,
					Flatten[
						Map[
							Function[
								Values[
									N[
										Association[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest[#]["parameters"]] //. FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest[#]["parameters"]
									]
								]
							],
							Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest
						]
					]
				]
			],
			Apply[And,
				Map[NumberQ,
					Flatten[
						Map[
							Function[
								Values[
									N[
										Association[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["parameters"]] //. FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["parameters"]
									]
								]
							],
							Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
						]
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-JKBDQ6@@Tests/ProcessModels.wlt:104,1-147,2"
]
VerificationTest[
	Apply[And,
		{
			Apply[And, Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest], #]&, {"BY", "BKY"}]],
			Apply[And, Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP], #]&, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-37N3EN@@Tests/ProcessModels.wlt:148,1-161,2"
]
VerificationTest[
	Apply[And,
		{
			AllTrue[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest, AssociationQ],
			AllTrue[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP, AssociationQ],
			AllTrue[Map[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest[#]&, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest], AssociationQ],
			AllTrue[Map[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]&, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP], AssociationQ]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-G0EDGG@@Tests/ProcessModels.wlt:162,1-177,2"
]
VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest,
		Apply[And,
			{
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["stateVars"],
											RuleDelayed[
												PatternTest[
													FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol,
													Function[
														MemberQ[
															Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
															SymbolName[#]
														]
													]
												][__],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				],
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["modelAssumptions"],
											RuleDelayed[
												PatternTest[
													FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol,
													Function[
														MemberQ[
															Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
															SymbolName[#]
														]
													]
												][__],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				],
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["exogenousEq"],
											RuleDelayed[
												PatternTest[
													FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol,
													Function[
														MemberQ[
															Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
															SymbolName[#]
														]
													]
												][__],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				],
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"],
											RuleDelayed[
												PatternTest[
													FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol,
													Function[
														MemberQ[
															Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
															SymbolName[#]
														]
													]
												][__],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			}
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-J0OZEE@@Tests/ProcessModels.wlt:178,1-320,2"
]
VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest,
		Apply[And,
			{
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["stateVars"],
											RuleDelayed[
												PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				],
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["modelAssumptions"],
											RuleDelayed[
												PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				],
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["exogenousEq"],
											RuleDelayed[
												PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				],
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"],
											RuleDelayed[
												PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			}
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-D3T7VH@@Tests/ProcessModels.wlt:321,1-431,2"
]
VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest,
		Apply[And,
			{
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["parameters"],
											RuleDelayed[
												PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				],
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["stateVars"],
											RuleDelayed[
												PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				],
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["modelAssumptions"],
											RuleDelayed[
												PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				],
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["exogenousEq"],
											RuleDelayed[
												PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				],
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"],
											RuleDelayed[
												PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			}
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-0JOB4M@@Tests/ProcessModels.wlt:432,1-566,2"
]
VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest,
		Apply[And,
			{
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["modelAssumptions"],
											RuleDelayed[
												PatternTest[
													FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol,
													Function[
														MemberQ[
															Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
															SymbolName[#]
														]
													]
												][__],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				],
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"],
											RuleDelayed[
												PatternTest[
													FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol,
													Function[
														MemberQ[
															Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
															SymbolName[#]
														]
													]
												][__],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			}
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-0POS76@@Tests/ProcessModels.wlt:567,1-645,2"
]
VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest,
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`coefs = Apply[
			Alternatives,
			Map[SymbolName,
				{FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb}
			]
		];
		Apply[And,
			Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"]&,
				Flatten[
					Map[
						Function[
							Cases[
								FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["modelAssumptions"],
								RuleDelayed[
									Alternatives[
										PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`coefs]]],
										PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`coefs]]][__]
									],
									Context @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			]
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-5KM6ZN@@Tests/ProcessModels.wlt:646,1-684,2"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["stateVars"],
								RuleDelayed[
									PatternTest[
										FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
												SymbolName[#]
											]
										]
									][__],
									FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["exogenousEq"],
								RuleDelayed[
									PatternTest[
										FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
												SymbolName[#]
											]
										]
									][__],
									FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-5BLXSH@@Tests/ProcessModels.wlt:685,1-746,2"
]
VerificationTest[
	Apply[And,
		{
			SubsetQ[Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP],
			SubsetQ[Map[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest[#]["shortname"]&, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest],
				Map[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["shortname"]&, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-K4JYX7@@Tests/ProcessModels.wlt:747,1-762,2"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[Function, #]&,
					Map[Head, Map[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["stateVars"]&, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP]]
				]
			],
			Apply[And,
				Map[MatchQ[List, #]&,
					Map[Head, Map[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["stateVars"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]&, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP]]
				]
			],
			Apply[And,
				Map[MatchQ[1, #]&,
					Map[Length,
						Map[Part[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["stateVars"], 1]&, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP]
					]
				]
			],
			Apply[And,
				Map[MatchQ["t", #]&,
					Map[
						Function[Apply[SymbolName, Part[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["stateVars"], 1]]],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			],
			SameQ[Map[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["stateVars"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]&, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP],
				Map[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest[#]["stateVars"]&, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-S0HI2D@@Tests/ProcessModels.wlt:763,1-802,2"
]
VerificationTest[
	Apply[And,
		Map[NumberQ, Map[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["numStocks"]&, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP]]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-A7U14Y@@Tests/ProcessModels.wlt:803,1-813,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC = FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP @ "NRC";
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[myContext`t] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["exogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[myContext`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
						(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][myContext`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][myContext`t]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] /. FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["exogenousEq"], FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]],
			SameQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["exogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mud @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i,
					Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup) * FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i],
						(FernandoDuarte`LongRunRisk`Model`Parameters`phidc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]) + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`Parameters`xid[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0,
					Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[1] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
						Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[4] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								Times[
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 5,
									Subtract[
										(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) - (FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) / (1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2),
										FernandoDuarte`LongRunRisk`Model`Parameters`Esg ^ 2
									]
								],
								(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]) + FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
							]
						]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`pd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i][0],
					Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup) * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i][1],
						Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg) * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i][4],
							Plus[
								Times[
									Subtract[
										(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) - (FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) / (1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2),
										FernandoDuarte`LongRunRisk`Model`Parameters`Esg ^ 2
									],
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i][5]
								],
								Plus[
									FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i][2] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t],
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i][3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
								]
							]
						]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondexcret[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondret[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i, 1] - FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, 1]
			],
			SameQ[
				(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondexcret[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]]) /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]],
				(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, 1] + FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i - 1]) - FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-RHISME@@Tests/ProcessModels.wlt:814,1-887,2"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
								RuleDelayed[
									PatternTest[
										FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
												SymbolName[#]
											]
										]
									][__],
									FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
					Flatten[
						Map[
							Function[
								Cases[
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol,
											Function[
												MemberQ[
													Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
													SymbolName[#]
												]
											]
										][__],
										Context @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
						]
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
					Flatten[
						Map[
							Function[
								Cases[
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
										Context @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
						]
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
					Flatten[
						Map[
							Function[
								Cases[
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
										Context @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
						]
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-9LS8U8@@Tests/ProcessModels.wlt:888,1-989,2"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondexcret[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
								RuleDelayed[
									PatternTest[
										FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
												SymbolName[#]
											]
										]
									][__],
									FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
					Flatten[
						Map[
							Function[
								Cases[
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondexcret[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol,
											Function[
												MemberQ[
													Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
													SymbolName[#]
												]
											]
										][__],
										Context @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
						]
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
					Flatten[
						Map[
							Function[
								Cases[
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondexcret[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
										Context @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
						]
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
					Flatten[
						Map[
							Function[
								Cases[
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondexcret[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
										Context @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
						]
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-AG514Z@@Tests/ProcessModels.wlt:990,1-1091,2"
]
VerificationTest[
	Apply[And,
		{
			AllTrue[Map[Head, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP["BKY"]["exogenousEq"]],
				MatchQ[#, PatternTest]&
			],
			AllTrue[Map[Head, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP["BKY"]["endogenousEq"]],
				MatchQ[#, PatternTest]&
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-BU0I6P@@Tests/ProcessModels.wlt:1092,1-1109,2"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t,
								Head[
									ReplaceAll[
										FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t,
										Normal @ Join[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["exogenousEq"], FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i],
								Head[
									ReplaceAll[
										FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i],
										Normal @ Join[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["exogenousEq"], FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t,
								Head[
									ReplaceAll[
										FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t,
										Normal @ Join[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["exogenousEq"], FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`sdf @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t,
								Head[
									ReplaceAll[
										FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`sdf @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t,
										Normal @ Join[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["exogenousEq"], FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t,
								Head[
									ReplaceAll[
										FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t,
										Normal @ Join[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["exogenousEq"], FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-8ULNJ6@@Tests/ProcessModels.wlt:1110,1-1211,2"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[
					Function[
						SameQ[Head @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`notVar @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t,
							Head[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`notVar @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t,
									Normal @ Join[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["exogenousEq"], FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]]
								]
							]
						]
					],
					Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-9GHZX4@@Tests/ProcessModels.wlt:1212,1-1238,2"
]
VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest,
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBY = FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest @ "BY";
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBKY = FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest @ "BKY";
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBKYP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[<|"BKY" -> FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBKY|>];
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBYP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[<|"BY" -> FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBY|>];
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModels = <|"myModel" -> FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBKY, "BY" -> FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBY|>;
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsSameName = <|"BY" -> FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBY|>;
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsRename = <|"myModel" -> FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBY|>;
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModels;
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsSameNameP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsSameName;
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsRenameP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsRename;
		Apply[And,
			{
				Function[
					SameQ[
						Function[KeyDrop[#, "coeffsSolution"]][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsP @ "myModel"],
						KeyDrop[#, "coeffsSolution"]
					]
				][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBKYP @ "BKY"],
				Function[
					SameQ[
						Function[KeyDrop[#, "coeffsSolution"]][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsP @ "BY"],
						KeyDrop[#, "coeffsSolution"]
					]
				][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBYP @ "BY"],
				Function[
					SameQ[
						Function[KeyDrop[#, "coeffsSolution"]][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsSameNameP @ "BY"],
						KeyDrop[#, "coeffsSolution"]
					]
				][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBYP @ "BY"],
				Function[
					SameQ[
						Function[KeyDrop[#, "coeffsSolution"]][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsRenameP @ "myModel"],
						KeyDrop[#, "coeffsSolution"]
					]
				][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBYP @ "BY"]
			}
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-35DRFS@@Tests/ProcessModels.wlt:1239,1-1287,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			Map[
				Function[
					Map[NumberQ,
						Flatten[
							Map[
								Values,
								{
									Part[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["coeffsSolutionN"], 1, "A"],
									Part[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["coeffsSolutionN"], 1, "Stocks", 1, 1, "B"],
									Part[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["coeffsSolutionN"], 1, "Bond"],
									Part[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["coeffsSolutionN"], 1, "NomBond"]
								}
							]
						]
					]
				],
				Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-JR775W@@Tests/ProcessModels.wlt:1288,1-1317,2"
] 
VerificationTest[
  $ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ]; True,
  True,
  TestID -> "Untitled-20@@Tests/ProcessModels.wlt:1318,1-1322,2"
]
End[]
EndTestSection[]
