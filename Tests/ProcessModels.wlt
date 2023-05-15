BeginTestSection["ProcessModels"] 
Begin["ProcessModels`"]
VerificationTest[
	Get @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
	,
	Null
	,
	{}
	,
	TestID->"ProcessModels_20230514-D8S6WK"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"], MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"]}]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230514-ZOZG38"
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
	TestID->"ProcessModels_20230514-7R7SYI"
]
VerificationTest[
	ProcessModels`ms = KeySelect[FernandoDuarte`LongRunRisk`Model`Catalog`models, MatchQ[#, "BKY" | "NRC"]&];
	ProcessModels`modelsP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ ProcessModels`ms;
	,
	Null
	,
	{}
	,
	TestID->"ProcessModels_20230514-64YZWR"
]
VerificationTest[
	Apply[And, Map[StringQ, Keys @ ProcessModels`modelsP]]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230514-74XJFA"
]
VerificationTest[
	Apply[And,
		Map[StringQ,
			Flatten[
				Map[
					Function @ {
						ProcessModels`modelsP[#]["name"],
						ProcessModels`modelsP[#]["shortname"],
						ProcessModels`modelsP[#]["bibRef"],
						ProcessModels`modelsP[#]["desc"],
						ProcessModels`modelsP[#]["exogenousVars"],
						ProcessModels`modelsP[#]["endogenousVars"]
					},
					Keys @ ProcessModels`modelsP
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230514-0BNCRB"
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
										Association[ProcessModels`modelsP[#]["parameters"]] //. ProcessModels`modelsP[#]["parameters"]
									]
								]
							],
							Keys @ ProcessModels`modelsP
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
	TestID->"ProcessModels_20230514-HL3356"
]
VerificationTest[
	Apply[And,
		{
			Apply[And, Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]],
			Apply[And, Map[MemberQ[Keys[ProcessModels`modelsP], #]&, Keys @ ProcessModels`modelsP]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230514-8BKI14"
]
VerificationTest[
	Apply[And,
		{
			AllTrue[FernandoDuarte`LongRunRisk`Model`Catalog`models, AssociationQ],
			AllTrue[ProcessModels`modelsP, AssociationQ],
			AllTrue[Map[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]&, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models], AssociationQ],
			AllTrue[Map[ProcessModels`modelsP[#]&, Keys @ ProcessModels`modelsP], AssociationQ]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230514-OG68SE"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["stateVars"],
										RuleDelayed[
											PatternTest[
												ProcessModels`var_Symbol,
												Function[
													MemberQ[
														Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
														SymbolName[#]
													]
												]
											][__],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			],
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["modelAssumptions"],
										RuleDelayed[
											PatternTest[
												ProcessModels`var_Symbol,
												Function[
													MemberQ[
														Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
														SymbolName[#]
													]
												]
											][__],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			],
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["exogenousEq"],
										RuleDelayed[
											PatternTest[
												ProcessModels`var_Symbol,
												Function[
													MemberQ[
														Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
														SymbolName[#]
													]
												]
											][__],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			],
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["endogenousEq"],
										RuleDelayed[
											PatternTest[
												ProcessModels`var_Symbol,
												Function[
													MemberQ[
														Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
														SymbolName[#]
													]
												]
											][__],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230514-9X1I6K"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["stateVars"],
										RuleDelayed[
											PatternTest[ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			],
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["modelAssumptions"],
										RuleDelayed[
											PatternTest[ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			],
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["exogenousEq"],
										RuleDelayed[
											PatternTest[ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			],
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["endogenousEq"],
										RuleDelayed[
											PatternTest[ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230514-I8AQY6"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["parameters"],
										RuleDelayed[
											PatternTest[ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			],
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["stateVars"],
										RuleDelayed[
											PatternTest[ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			],
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["modelAssumptions"],
										RuleDelayed[
											PatternTest[ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			],
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["exogenousEq"],
										RuleDelayed[
											PatternTest[ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			],
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["endogenousEq"],
										RuleDelayed[
											PatternTest[ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230514-BRHTBS"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["modelAssumptions"],
										RuleDelayed[
											PatternTest[
												ProcessModels`var_Symbol,
												Function[
													MemberQ[
														Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
														SymbolName[#]
													]
												]
											][__],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			],
			Apply[And,
				Map[
					Function[
						Apply[And,
							Map[
								SameQ[#, "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"]&,
								Map[
									Context,
									Cases[
										ProcessModels`modelsP[#]["endogenousEq"],
										RuleDelayed[
											PatternTest[
												ProcessModels`var_Symbol,
												Function[
													MemberQ[
														Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
														SymbolName[#]
													]
												]
											][__],
											ProcessModels`var
										],
										Infinity
									]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230514-8PFXX6"
]
VerificationTest[
	ProcessModels`coefs = Apply[Alternatives,
		Map[SymbolName,
			{FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb}
		]
	];
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"]&,
			Flatten[
				Map[
					Function[
						Cases[ProcessModels`modelsP[#]["modelAssumptions"],
							RuleDelayed[
								Alternatives[
									PatternTest[ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], ProcessModels`coefs]]],
									PatternTest[ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], ProcessModels`coefs]]][__]
								],
								Context @ ProcessModels`var
							],
							Infinity
						]
					],
					Keys @ ProcessModels`modelsP
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230514-3S3J0I"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								ProcessModels`modelsP[#]["stateVars"],
								RuleDelayed[
									PatternTest[
										ProcessModels`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
												SymbolName[#]
											]
										]
									][__],
									ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								ProcessModels`modelsP[#]["exogenousEq"],
								RuleDelayed[
									PatternTest[
										ProcessModels`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
												SymbolName[#]
											]
										]
									][__],
									ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ ProcessModels`modelsP
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
	TestID->"ProcessModels_20230514-P3S92O"
]
VerificationTest[
	Apply[And,
		{
			SameQ[Keys @ ProcessModels`modelsP, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models],
			SameQ[Map[ProcessModels`modelsP[#]["shortname"]&, Keys @ ProcessModels`modelsP],
				Map[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["shortname"]&, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]
			]
		}
	]
	,
	False
	,
	{}
	,
	TestID->"ProcessModels_20230514-J8Y1BU"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[Function, #]&,
					Map[Head, Map[ProcessModels`modelsP[#]["stateVars"]&, Keys @ ProcessModels`modelsP]]
				]
			],
			Apply[And,
				Map[MatchQ[List, #]&,
					Map[Head, Map[ProcessModels`modelsP[#]["stateVars"][ProcessModels`t]&, Keys @ ProcessModels`modelsP]]
				]
			],
			Apply[And,
				Map[MatchQ[1, #]&,
					Map[Length,
						Map[Part[ProcessModels`modelsP[#]["stateVars"], 1]&, Keys @ ProcessModels`modelsP]
					]
				]
			],
			Apply[And,
				Map[MatchQ["t", #]&,
					Map[
						Function[Apply[SymbolName, Part[ProcessModels`modelsP[#]["stateVars"], 1]]],
						Keys @ ProcessModels`modelsP
					]
				]
			],
			SameQ[Map[ProcessModels`modelsP[#]["stateVars"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]&, Keys @ ProcessModels`modelsP],
				Map[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["stateVars"]&, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]
			]
		}
	]
	,
	False
	,
	{}
	,
	TestID->"ProcessModels_20230514-AV4W98"
]
VerificationTest[
	Apply[And,
		Map[NumberQ, Map[ProcessModels`modelsP[#]["numStocks"]&, Keys @ ProcessModels`modelsP]]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230514-JS58KJ"
]
VerificationTest[
	ProcessModels`model = ProcessModels`modelsP @ "NRC";
	Apply[And,
		{
			SameQ[ProcessModels`pi[myContext`t] /. Normal[ProcessModels`model["exogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[myContext`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
						(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][myContext`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][myContext`t]
					]
				]
			],
			SameQ[ProcessModels`eps["dc"][ProcessModels`t] /. ProcessModels`model["exogenousEq"], ProcessModels`eps["dc"][ProcessModels`t]],
			SameQ[ProcessModels`dd[ProcessModels`t, ProcessModels`i] /. Normal[ProcessModels`model["exogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mud @ ProcessModels`i,
					Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ProcessModels`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup) * FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[ProcessModels`i],
						(FernandoDuarte`LongRunRisk`Model`Parameters`phidc[ProcessModels`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][ProcessModels`t]) + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[ProcessModels`t - 2] * FernandoDuarte`LongRunRisk`Model`Parameters`xid[ProcessModels`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ProcessModels`t - 1]
					]
				]
			],
			SameQ[ProcessModels`wc[ProcessModels`t] /. Normal[ProcessModels`model["endogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0,
					Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[1] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ProcessModels`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
						Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[4] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[ProcessModels`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								Times[
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 5,
									Subtract[
										(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[ProcessModels`t] ^ 2) - (FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) / (1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2),
										FernandoDuarte`LongRunRisk`Model`Parameters`Esg ^ 2
									]
								],
								(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ProcessModels`t]) + FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[ProcessModels`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ProcessModels`t]
							]
						]
					]
				]
			],
			SameQ[ProcessModels`pd[ProcessModels`t, ProcessModels`i] /. Normal[ProcessModels`model["endogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[ProcessModels`i][0],
					Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ProcessModels`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup) * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[ProcessModels`i][1],
						Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[ProcessModels`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg) * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[ProcessModels`i][4],
							Plus[
								Times[
									Subtract[
										(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[ProcessModels`t] ^ 2) - (FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) / (1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2),
										FernandoDuarte`LongRunRisk`Model`Parameters`Esg ^ 2
									],
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[ProcessModels`i][5]
								],
								Plus[
									FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[ProcessModels`t - 1] * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[ProcessModels`i][2] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ProcessModels`t],
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[ProcessModels`i][3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ProcessModels`t]
								]
							]
						]
					]
				]
			],
			SameQ[ProcessModels`bondexcret[ProcessModels`t, ProcessModels`i] /. Normal[ProcessModels`model["endogenousEq"]],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondret[ProcessModels`t, ProcessModels`i, 1] - FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield[ProcessModels`t - 1, 1]
			],
			SameQ[
				(ProcessModels`bondexcret[ProcessModels`t, ProcessModels`i] /. Normal[ProcessModels`model["endogenousEq"]]) /. Normal[ProcessModels`model["endogenousEq"]],
				(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[ProcessModels`t - 1, 1] + FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[ProcessModels`t, ProcessModels`i - 1]) - FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[ProcessModels`t - 1, ProcessModels`i]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230514-374SKP"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								ProcessModels`wc[ProcessModels`t] //. Normal[ProcessModels`modelsP[#]["endogenousEq"]],
								RuleDelayed[
									PatternTest[
										ProcessModels`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
												SymbolName[#]
											]
										]
									][__],
									ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
					Flatten[
						Map[
							Function[
								Cases[
									ProcessModels`wc[ProcessModels`t] //. Normal[ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[
											ProcessModels`var_Symbol,
											Function[
												MemberQ[
													Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
													SymbolName[#]
												]
											]
										][__],
										Context @ ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ ProcessModels`modelsP
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
									ProcessModels`wc[ProcessModels`t] //. Normal[ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
										Context @ ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ ProcessModels`modelsP
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
									ProcessModels`wc[ProcessModels`t] //. Normal[ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
										Context @ ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ ProcessModels`modelsP
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
	TestID->"ProcessModels_20230514-X1VH63"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								ProcessModels`bondexcret[ProcessModels`t, ProcessModels`i] //. Normal[ProcessModels`modelsP[#]["endogenousEq"]],
								RuleDelayed[
									PatternTest[
										ProcessModels`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
												SymbolName[#]
											]
										]
									][__],
									ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
					Flatten[
						Map[
							Function[
								Cases[
									ProcessModels`bondexcret[ProcessModels`t, ProcessModels`i] //. Normal[ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[
											ProcessModels`var_Symbol,
											Function[
												MemberQ[
													Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
													SymbolName[#]
												]
											]
										][__],
										Context @ ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ ProcessModels`modelsP
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
									ProcessModels`bondexcret[ProcessModels`t, ProcessModels`i] //. Normal[ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
										Context @ ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ ProcessModels`modelsP
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
									ProcessModels`bondexcret[ProcessModels`t, ProcessModels`i] //. Normal[ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
										Context @ ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ ProcessModels`modelsP
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
	TestID->"ProcessModels_20230514-7WH31Y"
]
VerificationTest[
	Apply[And,
		{
			AllTrue[Map[Head, Keys @ ProcessModels`modelsP["BKY"]["exogenousEq"]],
				MatchQ[#, PatternTest]&
			],
			AllTrue[Map[Head, Keys @ ProcessModels`modelsP["BKY"]["endogenousEq"]],
				MatchQ[#, PatternTest]&
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230514-F5VU4A"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ ProcessModels`dc @ ProcessModels`t,
								Head[
									ReplaceAll[
										ProcessModels`dc @ ProcessModels`t,
										Normal @ Join[ProcessModels`modelsP[#]["exogenousEq"], ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ ProcessModels`dd[ProcessModels`t, ProcessModels`i],
								Head[
									ReplaceAll[
										ProcessModels`dd[ProcessModels`t, ProcessModels`i],
										Normal @ Join[ProcessModels`modelsP[#]["exogenousEq"], ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ ProcessModels`wc @ ProcessModels`t,
								Head[
									ReplaceAll[
										ProcessModels`wc @ ProcessModels`t,
										Normal @ Join[ProcessModels`modelsP[#]["exogenousEq"], ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ ProcessModels`sdf @ ProcessModels`t,
								Head[
									ReplaceAll[
										ProcessModels`sdf @ ProcessModels`t,
										Normal @ Join[ProcessModels`modelsP[#]["exogenousEq"], ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head @ ProcessModels`bondyield @ ProcessModels`t,
								Head[
									ReplaceAll[
										ProcessModels`bondyield @ ProcessModels`t,
										Normal @ Join[ProcessModels`modelsP[#]["exogenousEq"], ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head[ProcessModels`euler[ProcessModels`retc @ ProcessModels`t, ProcessModels`t - 1]],
								Head[
									ReplaceAll[
										ProcessModels`euler[ProcessModels`retc @ ProcessModels`t, ProcessModels`t - 1],
										Normal @ Join[ProcessModels`modelsP[#]["exogenousEq"], ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[Not,
					Map[
						Function[
							SameQ[
								Head[ProcessModels`euler[ProcessModels`ret[ProcessModels`t, ProcessModels`i], ProcessModels`t - 1]],
								Head[
									ReplaceAll[
										ProcessModels`euler[ProcessModels`ret[ProcessModels`t, ProcessModels`i], ProcessModels`t - 1],
										Normal @ Join[ProcessModels`modelsP[#]["exogenousEq"], ProcessModels`modelsP[#]["endogenousEq"]]
									]
								]
							]
						],
						Keys @ ProcessModels`modelsP
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
	TestID->"ProcessModels_20230514-CNZUPQ"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[
					Function[
						SameQ[Head @ ProcessModels`notVar @ ProcessModels`t,
							Head[
								ReplaceAll[
									ProcessModels`notVar @ ProcessModels`t,
									Normal @ Join[ProcessModels`modelsP[#]["exogenousEq"], ProcessModels`modelsP[#]["endogenousEq"]]
								]
							]
						]
					],
					Keys @ ProcessModels`modelsP
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230514-IJ3TFU"
]
VerificationTest[
	ProcessModels`modelBY = FernandoDuarte`LongRunRisk`Model`Catalog`models @ "BY";
	ProcessModels`modelBKY = FernandoDuarte`LongRunRisk`Model`Catalog`models @ "BKY";
	ProcessModels`newModels = <|"myModel" -> ProcessModels`modelBKY, "BY" -> ProcessModels`modelBY|>;
	ProcessModels`newModelsSameName = <|"BY" -> ProcessModels`modelBY|>;
	ProcessModels`newModelsRename = <|"myModel" -> ProcessModels`modelBY|>;
	ProcessModels`newModelsP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ ProcessModels`newModels;
	ProcessModels`newModelsSameNameP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ ProcessModels`newModelsSameName;
	ProcessModels`newModelsRenameP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ ProcessModels`newModelsRename;
	Apply[And,
		{
			SameQ[ProcessModels`newModelsP @ "myModel", ProcessModels`modelsP @ "BKY"],
			SameQ[ProcessModels`newModelsP @ "BY", ProcessModels`modelsP @ "BY"],
			SameQ[ProcessModels`newModelsSameNameP @ "BY", ProcessModels`modelsP @ "BY"],
			SameQ[ProcessModels`newModelsRenameP @ "myModel", ProcessModels`modelsP @ "BY"]
		}
	]
	,
	False
	,
	{}
	,
	TestID->"ProcessModels_20230514-Z2KJBK"
] 
End[]
EndTestSection[]
