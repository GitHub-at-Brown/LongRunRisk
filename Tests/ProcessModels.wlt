BeginTestSection["ProcessModels"] 
Begin["Model`ProcessModels`"]
VerificationTest[
	Model`ProcessModels`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-116DCE"
]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
	True
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-K6S5F5"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"], MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"]}]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-8B36RO"
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
	TestID->"ProcessModels_20231010-HPANYO"
]
VerificationTest[
	Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
	FernandoDuarte`LongRunRisk`Model`Catalog`models = If[Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Model`Catalog`models, KeyTake[FernandoDuarte`LongRunRisk`Model`Catalog`models, {"BY", "BKY", "NRC"}]];
	Model`ProcessModels`modelsP = If[Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC"}]];
	True
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-01INLQ"
]
VerificationTest[
	Apply[And, Map[StringQ, Keys @ Model`ProcessModels`modelsP]]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-Q8F8Y7"
]
VerificationTest[
	Apply[And,
		Map[StringQ,
			Flatten[
				Map[
					Function @ {
						Model`ProcessModels`modelsP[#]["name"],
						Model`ProcessModels`modelsP[#]["shortname"],
						Model`ProcessModels`modelsP[#]["bibRef"],
						Model`ProcessModels`modelsP[#]["desc"],
						Model`ProcessModels`modelsP[#]["exogenousVars"],
						Model`ProcessModels`modelsP[#]["endogenousVars"]
					},
					Keys @ Model`ProcessModels`modelsP
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-XCSPNR"
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
										Association[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["parameters"]] //. FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["parameters"]
									]
								]
							],
							Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models
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
										Association[Model`ProcessModels`modelsP[#]["parameters"]] //. Model`ProcessModels`modelsP[#]["parameters"]
									]
								]
							],
							Keys @ Model`ProcessModels`modelsP
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
	TestID->"ProcessModels_20231010-8V68GY"
]
VerificationTest[
	Apply[And,
		{
			Apply[And, Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]],
			Apply[And, Map[MemberQ[Keys[Model`ProcessModels`modelsP], #]&, Keys @ Model`ProcessModels`modelsP]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-NR97KO"
]
VerificationTest[
	Apply[And,
		{
			AllTrue[FernandoDuarte`LongRunRisk`Model`Catalog`models, AssociationQ],
			AllTrue[Model`ProcessModels`modelsP, AssociationQ],
			AllTrue[Map[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]&, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models], AssociationQ],
			AllTrue[Map[Model`ProcessModels`modelsP[#]&, Keys @ Model`ProcessModels`modelsP], AssociationQ]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-3CEC3Q"
]
VerificationTest[
	If[Model`ProcessModels`longTest,
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
											Model`ProcessModels`modelsP[#]["stateVars"],
											RuleDelayed[
												PatternTest[
													Model`ProcessModels`var_Symbol,
													Function[
														MemberQ[
															Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
															SymbolName[#]
														]
													]
												][__],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
											Model`ProcessModels`modelsP[#]["modelAssumptions"],
											RuleDelayed[
												PatternTest[
													Model`ProcessModels`var_Symbol,
													Function[
														MemberQ[
															Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
															SymbolName[#]
														]
													]
												][__],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
											Model`ProcessModels`modelsP[#]["exogenousEq"],
											RuleDelayed[
												PatternTest[
													Model`ProcessModels`var_Symbol,
													Function[
														MemberQ[
															Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
															SymbolName[#]
														]
													]
												][__],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
											Model`ProcessModels`modelsP[#]["endogenousEq"],
											RuleDelayed[
												PatternTest[
													Model`ProcessModels`var_Symbol,
													Function[
														MemberQ[
															Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
															SymbolName[#]
														]
													]
												][__],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
	TestID->"ProcessModels_20231010-AXC0ST"
]
VerificationTest[
	If[Model`ProcessModels`longTest,
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
											Model`ProcessModels`modelsP[#]["stateVars"],
											RuleDelayed[
												PatternTest[Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
											Model`ProcessModels`modelsP[#]["modelAssumptions"],
											RuleDelayed[
												PatternTest[Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
											Model`ProcessModels`modelsP[#]["exogenousEq"],
											RuleDelayed[
												PatternTest[Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
											Model`ProcessModels`modelsP[#]["endogenousEq"],
											RuleDelayed[
												PatternTest[Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
	TestID->"ProcessModels_20231010-S2DU7N"
]
VerificationTest[
	If[Model`ProcessModels`longTest,
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
											Model`ProcessModels`modelsP[#]["parameters"],
											RuleDelayed[
												PatternTest[Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
											Model`ProcessModels`modelsP[#]["stateVars"],
											RuleDelayed[
												PatternTest[Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
											Model`ProcessModels`modelsP[#]["modelAssumptions"],
											RuleDelayed[
												PatternTest[Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
											Model`ProcessModels`modelsP[#]["exogenousEq"],
											RuleDelayed[
												PatternTest[Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
											Model`ProcessModels`modelsP[#]["endogenousEq"],
											RuleDelayed[
												PatternTest[Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
	TestID->"ProcessModels_20231010-C1WRNJ"
]
VerificationTest[
	If[Model`ProcessModels`longTest,
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
											Model`ProcessModels`modelsP[#]["modelAssumptions"],
											RuleDelayed[
												PatternTest[
													Model`ProcessModels`var_Symbol,
													Function[
														MemberQ[
															Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
															SymbolName[#]
														]
													]
												][__],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
											Model`ProcessModels`modelsP[#]["endogenousEq"],
											RuleDelayed[
												PatternTest[
													Model`ProcessModels`var_Symbol,
													Function[
														MemberQ[
															Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
															SymbolName[#]
														]
													]
												][__],
												Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
	TestID->"ProcessModels_20231010-LV3Y1V"
]
VerificationTest[
	If[Model`ProcessModels`longTest,
		Model`ProcessModels`coefs = Apply[
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
								Model`ProcessModels`modelsP[#]["modelAssumptions"],
								RuleDelayed[
									Alternatives[
										PatternTest[Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], Model`ProcessModels`coefs]]],
										PatternTest[Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], Model`ProcessModels`coefs]]][__]
									],
									Context @ Model`ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
	TestID->"ProcessModels_20231010-TEO87Q"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								Model`ProcessModels`modelsP[#]["stateVars"],
								RuleDelayed[
									PatternTest[
										Model`ProcessModels`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
												SymbolName[#]
											]
										]
									][__],
									Model`ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								Model`ProcessModels`modelsP[#]["exogenousEq"],
								RuleDelayed[
									PatternTest[
										Model`ProcessModels`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
												SymbolName[#]
											]
										]
									][__],
									Model`ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
	TestID->"ProcessModels_20231010-L6QYTE"
]
VerificationTest[
	Apply[And,
		{
			SubsetQ[Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models, Keys @ Model`ProcessModels`modelsP],
			SubsetQ[Map[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["shortname"]&, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models],
				Map[Model`ProcessModels`modelsP[#]["shortname"]&, Keys @ Model`ProcessModels`modelsP]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-INNT84"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[Function, #]&,
					Map[Head, Map[Model`ProcessModels`modelsP[#]["stateVars"]&, Keys @ Model`ProcessModels`modelsP]]
				]
			],
			Apply[And,
				Map[MatchQ[List, #]&,
					Map[Head, Map[Model`ProcessModels`modelsP[#]["stateVars"][Model`ProcessModels`t]&, Keys @ Model`ProcessModels`modelsP]]
				]
			],
			Apply[And,
				Map[MatchQ[1, #]&,
					Map[Length,
						Map[Part[Model`ProcessModels`modelsP[#]["stateVars"], 1]&, Keys @ Model`ProcessModels`modelsP]
					]
				]
			],
			Apply[And,
				Map[MatchQ["t", #]&,
					Map[
						Function[Apply[SymbolName, Part[Model`ProcessModels`modelsP[#]["stateVars"], 1]]],
						Keys @ Model`ProcessModels`modelsP
					]
				]
			],
			SameQ[Map[Model`ProcessModels`modelsP[#]["stateVars"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]&, Keys @ Model`ProcessModels`modelsP],
				Map[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["stateVars"]&, Keys @ Model`ProcessModels`modelsP]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-YYJQ1J"
]
VerificationTest[
	Apply[And,
		Map[NumberQ, Map[Model`ProcessModels`modelsP[#]["numStocks"]&, Keys @ Model`ProcessModels`modelsP]]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-CO6JXI"
]
VerificationTest[
	Model`ProcessModels`model = Model`ProcessModels`modelsP @ "NRC";
	Apply[And,
		{
			SameQ[Model`ProcessModels`pi[myContext`t] /. Normal[Model`ProcessModels`model["exogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[myContext`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
						(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][myContext`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][myContext`t]
					]
				]
			],
			SameQ[Model`ProcessModels`eps["dc"][Model`ProcessModels`t] /. Model`ProcessModels`model["exogenousEq"], Model`ProcessModels`eps["dc"][Model`ProcessModels`t]],
			SameQ[Model`ProcessModels`dd[Model`ProcessModels`t, Model`ProcessModels`i] /. Normal[Model`ProcessModels`model["exogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mud @ Model`ProcessModels`i,
					Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[Model`ProcessModels`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup) * FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[Model`ProcessModels`i],
						(FernandoDuarte`LongRunRisk`Model`Parameters`phidc[Model`ProcessModels`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][Model`ProcessModels`t]) + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[Model`ProcessModels`t - 2] * FernandoDuarte`LongRunRisk`Model`Parameters`xid[Model`ProcessModels`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][Model`ProcessModels`t - 1]
					]
				]
			],
			SameQ[Model`ProcessModels`wc[Model`ProcessModels`t] /. Normal[Model`ProcessModels`model["endogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0,
					Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[1] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[Model`ProcessModels`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
						Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[4] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[Model`ProcessModels`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								Times[
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 5,
									Subtract[
										(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[Model`ProcessModels`t] ^ 2) - (FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) / (1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2),
										FernandoDuarte`LongRunRisk`Model`Parameters`Esg ^ 2
									]
								],
								(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][Model`ProcessModels`t]) + FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[Model`ProcessModels`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][Model`ProcessModels`t]
							]
						]
					]
				]
			],
			SameQ[Model`ProcessModels`pd[Model`ProcessModels`t, Model`ProcessModels`i] /. Normal[Model`ProcessModels`model["endogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[Model`ProcessModels`i][0],
					Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[Model`ProcessModels`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup) * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[Model`ProcessModels`i][1],
						Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[Model`ProcessModels`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg) * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[Model`ProcessModels`i][4],
							Plus[
								Times[
									Subtract[
										(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[Model`ProcessModels`t] ^ 2) - (FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) / (1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2),
										FernandoDuarte`LongRunRisk`Model`Parameters`Esg ^ 2
									],
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[Model`ProcessModels`i][5]
								],
								Plus[
									FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[Model`ProcessModels`t - 1] * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[Model`ProcessModels`i][2] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][Model`ProcessModels`t],
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[Model`ProcessModels`i][3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][Model`ProcessModels`t]
								]
							]
						]
					]
				]
			],
			SameQ[Model`ProcessModels`bondexcret[Model`ProcessModels`t, Model`ProcessModels`i] /. Normal[Model`ProcessModels`model["endogenousEq"]],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondret[Model`ProcessModels`t, Model`ProcessModels`i, 1] - FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield[Model`ProcessModels`t - 1, 1]
			],
			SameQ[
				(Model`ProcessModels`bondexcret[Model`ProcessModels`t, Model`ProcessModels`i] /. Normal[Model`ProcessModels`model["endogenousEq"]]) /. Normal[Model`ProcessModels`model["endogenousEq"]],
				(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[Model`ProcessModels`t - 1, 1] + FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[Model`ProcessModels`t, Model`ProcessModels`i - 1]) - FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[Model`ProcessModels`t - 1, Model`ProcessModels`i]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-RI0LE2"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								Model`ProcessModels`wc[Model`ProcessModels`t] //. Normal[Model`ProcessModels`modelsP[#]["endogenousEq"]],
								RuleDelayed[
									PatternTest[
										Model`ProcessModels`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
												SymbolName[#]
											]
										]
									][__],
									Model`ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
					Flatten[
						Map[
							Function[
								Cases[
									Model`ProcessModels`wc[Model`ProcessModels`t] //. Normal[Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[
											Model`ProcessModels`var_Symbol,
											Function[
												MemberQ[
													Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
													SymbolName[#]
												]
											]
										][__],
										Context @ Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ Model`ProcessModels`modelsP
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
									Model`ProcessModels`wc[Model`ProcessModels`t] //. Normal[Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
										Context @ Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ Model`ProcessModels`modelsP
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
									Model`ProcessModels`wc[Model`ProcessModels`t] //. Normal[Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
										Context @ Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ Model`ProcessModels`modelsP
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
	TestID->"ProcessModels_20231010-W55HXX"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								Model`ProcessModels`bondexcret[Model`ProcessModels`t, Model`ProcessModels`i] //. Normal[Model`ProcessModels`modelsP[#]["endogenousEq"]],
								RuleDelayed[
									PatternTest[
										Model`ProcessModels`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
												SymbolName[#]
											]
										]
									][__],
									Model`ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
					Flatten[
						Map[
							Function[
								Cases[
									Model`ProcessModels`bondexcret[Model`ProcessModels`t, Model`ProcessModels`i] //. Normal[Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[
											Model`ProcessModels`var_Symbol,
											Function[
												MemberQ[
													Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
													SymbolName[#]
												]
											]
										][__],
										Context @ Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ Model`ProcessModels`modelsP
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
									Model`ProcessModels`bondexcret[Model`ProcessModels`t, Model`ProcessModels`i] //. Normal[Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
										Context @ Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ Model`ProcessModels`modelsP
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
									Model`ProcessModels`bondexcret[Model`ProcessModels`t, Model`ProcessModels`i] //. Normal[Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
										Context @ Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ Model`ProcessModels`modelsP
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
	TestID->"ProcessModels_20231010-GCQIGS"
]
VerificationTest[
	Apply[And,
		{
			AllTrue[Map[Head, Keys @ Model`ProcessModels`modelsP["BKY"]["exogenousEq"]],
				MatchQ[#, PatternTest]&
			],
			AllTrue[Map[Head, Keys @ Model`ProcessModels`modelsP["BKY"]["endogenousEq"]],
				MatchQ[#, PatternTest]&
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-ZAMP0W"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ Model`ProcessModels`dc @ Model`ProcessModels`t,
								Head[
									ReplaceAll[
										Model`ProcessModels`dc @ Model`ProcessModels`t,
										Normal @ Join[Model`ProcessModels`modelsP[#]["exogenousEq"], Model`ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ Model`ProcessModels`dd[Model`ProcessModels`t, Model`ProcessModels`i],
								Head[
									ReplaceAll[
										Model`ProcessModels`dd[Model`ProcessModels`t, Model`ProcessModels`i],
										Normal @ Join[Model`ProcessModels`modelsP[#]["exogenousEq"], Model`ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ Model`ProcessModels`wc @ Model`ProcessModels`t,
								Head[
									ReplaceAll[
										Model`ProcessModels`wc @ Model`ProcessModels`t,
										Normal @ Join[Model`ProcessModels`modelsP[#]["exogenousEq"], Model`ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ Model`ProcessModels`sdf @ Model`ProcessModels`t,
								Head[
									ReplaceAll[
										Model`ProcessModels`sdf @ Model`ProcessModels`t,
										Normal @ Join[Model`ProcessModels`modelsP[#]["exogenousEq"], Model`ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ Model`ProcessModels`bondyield @ Model`ProcessModels`t,
								Head[
									ReplaceAll[
										Model`ProcessModels`bondyield @ Model`ProcessModels`t,
										Normal @ Join[Model`ProcessModels`modelsP[#]["exogenousEq"], Model`ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ Model`ProcessModels`modelsP
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
	TestID->"ProcessModels_20231010-FZJF95"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[
					Function[
						SameQ[Head @ Model`ProcessModels`notVar @ Model`ProcessModels`t,
							Head[
								ReplaceAll[
									Model`ProcessModels`notVar @ Model`ProcessModels`t,
									Normal @ Join[Model`ProcessModels`modelsP[#]["exogenousEq"], Model`ProcessModels`modelsP[#]["endogenousEq"]]
								]
							]
						]
					],
					Keys @ Model`ProcessModels`modelsP
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-1ZAJZL"
]
VerificationTest[
	If[Model`ProcessModels`longTest,
		Model`ProcessModels`modelBY = FernandoDuarte`LongRunRisk`Model`Catalog`models @ "BY";
		Model`ProcessModels`modelBKY = FernandoDuarte`LongRunRisk`Model`Catalog`models @ "BKY";
		Model`ProcessModels`modelBKYP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[<|"BKY" -> Model`ProcessModels`modelBKY|>];
		Model`ProcessModels`modelBYP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[<|"BY" -> Model`ProcessModels`modelBY|>];
		Model`ProcessModels`newModels = <|"myModel" -> Model`ProcessModels`modelBKY, "BY" -> Model`ProcessModels`modelBY|>;
		Model`ProcessModels`newModelsSameName = <|"BY" -> Model`ProcessModels`modelBY|>;
		Model`ProcessModels`newModelsRename = <|"myModel" -> Model`ProcessModels`modelBY|>;
		Model`ProcessModels`newModelsP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ Model`ProcessModels`newModels;
		Model`ProcessModels`newModelsSameNameP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ Model`ProcessModels`newModelsSameName;
		Model`ProcessModels`newModelsRenameP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ Model`ProcessModels`newModelsRename;
		Apply[And,
			{
				Function[
					SameQ[
						Function[KeyDrop[#, "coeffsSolution"]][Model`ProcessModels`newModelsP @ "myModel"],
						KeyDrop[#, "coeffsSolution"]
					]
				][Model`ProcessModels`modelBKYP @ "BKY"],
				Function[
					SameQ[
						Function[KeyDrop[#, "coeffsSolution"]][Model`ProcessModels`newModelsP @ "BY"],
						KeyDrop[#, "coeffsSolution"]
					]
				][Model`ProcessModels`modelBYP @ "BY"],
				Function[
					SameQ[
						Function[KeyDrop[#, "coeffsSolution"]][Model`ProcessModels`newModelsSameNameP @ "BY"],
						KeyDrop[#, "coeffsSolution"]
					]
				][Model`ProcessModels`modelBYP @ "BY"],
				Function[
					SameQ[
						Function[KeyDrop[#, "coeffsSolution"]][Model`ProcessModels`newModelsRenameP @ "myModel"],
						KeyDrop[#, "coeffsSolution"]
					]
				][Model`ProcessModels`modelBYP @ "BY"]
			}
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-EU88H5"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Map[
					Function[
						Apply[And, Map[NumberQ, Values @ Model`ProcessModels`modelsP[#]["coeffsSolutionN"]]]
					],
					Keys @ Model`ProcessModels`modelsP
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20231010-QE7U4H"
] 
End[]
EndTestSection[]
