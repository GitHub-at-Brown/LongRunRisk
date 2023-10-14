BeginTestSection["ProcessModels"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
	True
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231014-Y25BMT@@Tests/ProcessModels.wlt:3,1-12,2"
]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	True
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231014-98J13F@@Tests/ProcessModels.wlt:13,1-22,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231014-CXCQYU@@Tests/ProcessModels.wlt:23,1-32,2"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"], MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"]}]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231014-R44QGA@@Tests/ProcessModels.wlt:33,1-41,2"
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
	TestID->"ProcessModels_20231014-YX56F3@@Tests/ProcessModels.wlt:42,1-55,2"
]
VerificationTest[
	Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
	FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest = If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Model`Catalog`models, KeyTake[FernandoDuarte`LongRunRisk`Model`Catalog`models, {"BY", "BKY", "NRC"}]];
	FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP = If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC"}]];
	True
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231014-J00FV4@@Tests/ProcessModels.wlt:56,1-67,2"
]
VerificationTest[
	Apply[And, Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP]]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231014-6Y0B5I@@Tests/ProcessModels.wlt:68,1-76,2"
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
	TestID->"ProcessModels_20231014-4VXGH7@@Tests/ProcessModels.wlt:77,1-101,2"
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
	TestID->"ProcessModels_20231014-F4NWS6@@Tests/ProcessModels.wlt:102,1-145,2"
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
	TestID->"ProcessModels_20231014-JOCP5A@@Tests/ProcessModels.wlt:146,1-159,2"
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
	TestID->"ProcessModels_20231014-SR0UGG@@Tests/ProcessModels.wlt:160,1-175,2"
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
	TestID->"ProcessModels_20231014-7W806Q@@Tests/ProcessModels.wlt:176,1-318,2"
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
	TestID->"ProcessModels_20231014-D73JP5@@Tests/ProcessModels.wlt:319,1-429,2"
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
	TestID->"ProcessModels_20231014-FU3A46@@Tests/ProcessModels.wlt:430,1-564,2"
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
	TestID->"ProcessModels_20231014-H0CZPK@@Tests/ProcessModels.wlt:565,1-643,2"
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
	TestID->"ProcessModels_20231014-2U35BF@@Tests/ProcessModels.wlt:644,1-682,2"
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
	TestID->"ProcessModels_20231014-FNX1QP@@Tests/ProcessModels.wlt:683,1-744,2"
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
	TestID->"ProcessModels_20231014-HCSFR4@@Tests/ProcessModels.wlt:745,1-760,2"
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
					Map[Head, Map[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["stateVars"][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t]&, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP]]
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
	TestID->"ProcessModels_20231014-TB0ZTR@@Tests/ProcessModels.wlt:761,1-800,2"
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
	TestID->"ProcessModels_20231014-YNQK3N@@Tests/ProcessModels.wlt:801,1-811,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC = FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP @ "NRC";
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`pi[myContext`t] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["exogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[myContext`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
						(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][myContext`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][myContext`t]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`eps["dc"][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t] /. FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["exogenousEq"], FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`eps["dc"][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t]],
			SameQ[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`dd[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t, FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["exogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mud @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i,
					Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup) * FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i],
						(FernandoDuarte`LongRunRisk`Model`Parameters`phidc[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t]) + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t - 2] * FernandoDuarte`LongRunRisk`Model`Parameters`xid[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t - 1]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`wc[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0,
					Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[1] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
						Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[4] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								Times[
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 5,
									Subtract[
										(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t] ^ 2) - (FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) / (1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2),
										FernandoDuarte`LongRunRisk`Model`Parameters`Esg ^ 2
									]
								],
								(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t]) + FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t]
							]
						]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`pd[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t, FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i][0],
					Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup) * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i][1],
						Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg) * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i][4],
							Plus[
								Times[
									Subtract[
										(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t] ^ 2) - (FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) / (1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2),
										FernandoDuarte`LongRunRisk`Model`Parameters`Esg ^ 2
									],
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i][5]
								],
								Plus[
									FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t - 1] * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i][2] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t],
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i][3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t]
								]
							]
						]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`bondexcret[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t, FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondret[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t, FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i, 1] - FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t - 1, 1]
			],
			SameQ[
				(FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`bondexcret[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t, FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]]) /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]],
				(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t - 1, 1] + FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t, FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i - 1]) - FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t - 1, FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231014-AJ4E7K@@Tests/ProcessModels.wlt:812,1-885,2"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`wc[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
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
									FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`wc[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
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
									FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`wc[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
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
									FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`wc[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
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
	TestID->"ProcessModels_20231014-CETFBD@@Tests/ProcessModels.wlt:886,1-987,2"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`bondexcret[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t, FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
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
									FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`bondexcret[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t, FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
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
									FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`bondexcret[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t, FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
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
									FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`bondexcret[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t, FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
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
	TestID->"ProcessModels_20231014-YX9SOE@@Tests/ProcessModels.wlt:988,1-1089,2"
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
	TestID->"ProcessModels_20231014-K3DTXE@@Tests/ProcessModels.wlt:1090,1-1107,2"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`dc @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t,
								Head[
									ReplaceAll[
										FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`dc @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t,
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
								Head @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`dd[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t, FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i],
								Head[
									ReplaceAll[
										FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`dd[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t, FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`i],
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
								Head @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`wc @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t,
								Head[
									ReplaceAll[
										FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`wc @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t,
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
								Head @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`sdf @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t,
								Head[
									ReplaceAll[
										FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`sdf @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t,
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
								Head @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`bondyield @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t,
								Head[
									ReplaceAll[
										FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`bondyield @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t,
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
	TestID->"ProcessModels_20231014-K2KLO0@@Tests/ProcessModels.wlt:1108,1-1209,2"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[
					Function[
						SameQ[Head @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`notVar @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t,
							Head[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`notVar @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`t,
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
	TestID->"ProcessModels_20231014-PXM1XE@@Tests/ProcessModels.wlt:1210,1-1236,2"
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
	TestID->"ProcessModels_20231014-RKJTVU@@Tests/ProcessModels.wlt:1237,1-1285,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Map[
					Function[
						Apply[And, Map[NumberQ, Values @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["coeffsSolutionN"]]]
					],
					Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231014-7WFAJD@@Tests/ProcessModels.wlt:1286,1-1305,2"
] 
End[]
EndTestSection[]
