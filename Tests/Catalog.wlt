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
	TestID->"Catalog_20260103-8JV5GU@@Tests/Catalog.wlt:3,1-12,2"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20260103-TPW32O@@Tests/Catalog.wlt:13,1-21,2"
]
VerificationTest[
	Apply[And, Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20260103-CW5YE7@@Tests/Catalog.wlt:22,1-30,2"
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
	TestID->"Catalog_20260103-3SRLVN@@Tests/Catalog.wlt:31,1-53,2"
]
VerificationTest[
	Apply[And,
		Map[BooleanQ,
			Flatten[Map[{FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["enabled"]}&, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20260103-LMBIWB@@Tests/Catalog.wlt:54,1-66,2"
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
	TestID->"Catalog_20260103-WJ3OBP@@Tests/Catalog.wlt:67,1-86,2"
]
VerificationTest[
	SameQ[FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"], {FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`x @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sx @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20260103-YC8RJJ@@Tests/Catalog.wlt:87,1-95,2"
]
VerificationTest[
	Apply[And, Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20260103-G79ZCI@@Tests/Catalog.wlt:96,1-104,2"
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
	TestID->"Catalog_20260103-YU2LCT@@Tests/Catalog.wlt:105,1-122,2"
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
	TestID->"Catalog_20260103-YZIVT2@@Tests/Catalog.wlt:123,1-159,2"
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
	TestID->"Catalog_20260103-0G2UAS@@Tests/Catalog.wlt:160,1-188,2"
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
	TestID->"Catalog_20260103-WBXSYG@@Tests/Catalog.wlt:189,1-217,2"
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
	TestID->"Catalog_20260103-4EWAHG@@Tests/Catalog.wlt:218,1-246,2"
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
	TestID->"Catalog_20260103-4F5FR7@@Tests/Catalog.wlt:247,1-278,2"
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
	TestID->"Catalog_20260103-RQJLTW@@Tests/Catalog.wlt:279,1-294,2"
]
VerificationTest[
	Apply[And, {SubsetQ[Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo]}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20260103-XMQJP8@@Tests/Catalog.wlt:295,1-303,2"
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
	TestID->"Catalog_20260103-NAH0O3@@Tests/Catalog.wlt:304,1-335,2"
] 
VerificationTest[
  $ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ]; True,
  True,
  TestID -> "Untitled-2@@Tests/Catalog.wlt:336,1-340,2"
]
End[]
EndTestSection[]
