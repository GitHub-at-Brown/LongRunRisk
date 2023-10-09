BeginTestSection["Catalog"] 
Begin["Model`Catalog`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	True
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231007-WMCGR2"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231007-9OYMAA"
]
VerificationTest[
	Apply[And, Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231007-4PW9Q8"
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
	TestID->"Catalog_20231007-KBDRFP"
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
	TestID->"Catalog_20231007-L6CURG"
]
VerificationTest[
	SameQ[FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"], {FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`x @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sx @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231007-OTAOFY"
]
VerificationTest[
	Apply[And, Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231007-G5R6EN"
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
	TestID->"Catalog_20231007-ADRCW8"
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
										Model`Catalog`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
												SymbolName[#]
											]
										]
									][__],
									Model`Catalog`var
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
	TestID->"Catalog_20231007-UR77BA"
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
									PatternTest[Model`Catalog`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
									Model`Catalog`var
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
	TestID->"Catalog_20231007-M9817Y"
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
									PatternTest[Model`Catalog`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
									Model`Catalog`var
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
	TestID->"Catalog_20231007-SYKS8I"
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
									PatternTest[Model`Catalog`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
									Model`Catalog`var
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
	TestID->"Catalog_20231007-202AXM"
]
VerificationTest[
	Apply[And,
		Map[MatchQ[{}, #]&,
			Map[
				Function[
					Cases[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["stateVars"],
						RuleDelayed[
							PatternTest[
								Model`Catalog`var_Symbol,
								Function[
									MemberQ[
										Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
										SymbolName[#]
									]
								]
							][__],
							Model`Catalog`var
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
	TestID->"Catalog_20231007-B84UK6"
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
	TestID->"Catalog_20231007-GX0TLL"
]
VerificationTest[
	Apply[And, {SubsetQ[Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo]}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20231007-ET7U5Q"
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
	TestID->"Catalog_20231007-7BZ2P8"
] 
End[]
EndTestSection[]