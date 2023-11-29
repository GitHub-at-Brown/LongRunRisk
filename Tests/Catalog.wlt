BeginTestSection["Catalog"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Catalog`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	True
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-6FZEWD@@Tests/Catalog.wlt:3,1-12,2"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-89QFKP@@Tests/Catalog.wlt:13,1-21,2"
]
VerificationTest[
	Apply[And, Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-J2YTMU@@Tests/Catalog.wlt:22,1-30,2"
]
VerificationTest[
	Apply[And,
		Map[StringQ,
			Flatten[
				Map[
					Function @ {
						FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["name"],
						FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["shortname"],
						FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["bibRef"],
						FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["desc"]
					},
					Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-JDIT5N@@Tests/Catalog.wlt:31,1-53,2"
]
VerificationTest[
	Apply[And,
		Map[NumberQ,
			Flatten[
				Map[
					Function[
						Part[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["parameters"], 1;;, 2] //. FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["parameters"]
					],
					Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-HP75LM@@Tests/Catalog.wlt:54,1-73,2"
]
VerificationTest[
	SameQ[FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"], {FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`x @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sx @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-6GSW63@@Tests/Catalog.wlt:74,1-82,2"
]
VerificationTest[
	Apply[And, Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-NJOE32@@Tests/Catalog.wlt:83,1-91,2"
]
VerificationTest[
	Apply[And,
		Map[MatchQ[Association, #]&,
			Flatten[
				{
					Head @ FernandoDuarte`LongRunRisk`Model`Catalog`models,
					Map[Function @ Head @ FernandoDuarte`LongRunRisk`Model`Catalog`models @ #, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]
				}
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-Y1CHS2@@Tests/Catalog.wlt:92,1-109,2"
]
VerificationTest[
	Apply[And,
		Map[
			Function[
				Apply[And,
					Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
						Map[Context,
							Cases[
								FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["stateVars"],
								RuleDelayed[
									PatternTest[
										FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
												SymbolName[#]
											]
										]
									][__],
									FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var
								],
								Infinity
							]
						]
					]
				]
			],
			Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-RK4UND@@Tests/Catalog.wlt:110,1-146,2"
]
VerificationTest[
	Apply[And,
		Map[
			Function[
				Apply[And,
					Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
						Map[Context,
							Cases[
								FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["stateVars"],
								RuleDelayed[
									PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
									FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var
								],
								Infinity
							]
						]
					]
				]
			],
			Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-PP7ZXQ@@Tests/Catalog.wlt:147,1-175,2"
]
VerificationTest[
	Apply[And,
		Map[
			Function[
				Apply[And,
					Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
						Map[Context,
							Cases[
								FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["parameters"],
								RuleDelayed[
									PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
									FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var
								],
								Infinity
							]
						]
					]
				]
			],
			Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-M2NP31@@Tests/Catalog.wlt:176,1-204,2"
]
VerificationTest[
	Apply[And,
		Map[
			Function[
				Apply[And,
					Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
						Map[Context,
							Cases[
								FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["stateVars"],
								RuleDelayed[
									PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
									FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var
								],
								Infinity
							]
						]
					]
				]
			],
			Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-R5564A@@Tests/Catalog.wlt:205,1-233,2"
]
VerificationTest[
	Apply[And,
		Map[MatchQ[{}, #]&,
			Map[
				Function[
					Cases[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["stateVars"],
						RuleDelayed[
							PatternTest[
								FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var_Symbol,
								Function[
									MemberQ[
										Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
										SymbolName[#]
									]
								]
							][__],
							FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var
						],
						Infinity
					]
				],
				Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-GQNPOC@@Tests/Catalog.wlt:234,1-265,2"
]
VerificationTest[
	Apply[And,
		{
			AllTrue[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo, AssociationQ],
			AllTrue[Map[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#]&, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo],
				AssociationQ
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-XWH93U@@Tests/Catalog.wlt:266,1-281,2"
]
VerificationTest[
	Apply[And, {SubsetQ[Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo]}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-WO21K2@@Tests/Catalog.wlt:282,1-290,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			Map[
				Function[
					If[KeyExistsQ[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo @ #, "initialGuess"],
						{
							If[
								KeyExistsQ[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#]["initialGuess"], "Ewc"],
								VectorQ["Ewc" /. FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#]["initialGuess"]],
								True
							],
							If[
								KeyExistsQ[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#]["initialGuess"], "Epd"],
								ArrayQ["Epd" /. FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#]["initialGuess"], 2],
								True
							]
						},
						True
					]
				],
				Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231129-M8F9IW@@Tests/Catalog.wlt:291,1-322,2"
] 
End[]
EndTestSection[]
