BeginTestSection["Catalog Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Catalog`"]

(* --- merged from: Catalog_test1.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20251223-CVYMGR@@Tests/Core/Catalog.wlt:7,1-15,2"
]

(* --- merged from: Catalog_test2.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

VerificationTest[
	Apply[And, Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20251223-ZQHUJ0@@Tests/Core/Catalog.wlt:20,1-28,2"
]

(* --- merged from: Catalog_test3.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

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
	TestID->"Catalog_20251223-N0A4JV@@Tests/Core/Catalog.wlt:33,1-55,2"
]

(* --- merged from: Catalog_test4.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

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
	TestID->"Catalog_20251223-OX2LLT@@Tests/Core/Catalog.wlt:60,1-72,2"
]

(* --- merged from: Catalog_test5.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

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
	TestID->"Catalog_20251223-TQC5UV@@Tests/Core/Catalog.wlt:77,1-96,2"
]

(* --- merged from: Catalog_test6.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

VerificationTest[
	SameQ[FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"], {FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`x @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sx @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20251223-RMOIJN@@Tests/Core/Catalog.wlt:101,1-109,2"
]

(* --- merged from: Catalog_test7.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

VerificationTest[
	Apply[And, Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20251223-AWF8GZ@@Tests/Core/Catalog.wlt:114,1-122,2"
]

(* --- merged from: Catalog_test8.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

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
	TestID->"Catalog_20251223-L8VWTP@@Tests/Core/Catalog.wlt:127,1-144,2"
]

(* --- merged from: Catalog_test9.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

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
	TestID->"Catalog_20251223-1G21CC@@Tests/Core/Catalog.wlt:149,1-185,2"
]

(* --- merged from: Catalog_test10.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

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
	TestID->"Catalog_20251223-CW7BLD@@Tests/Core/Catalog.wlt:190,1-218,2"
]

(* --- merged from: Catalog_test11.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

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
	TestID->"Catalog_20251223-USIK1Y@@Tests/Core/Catalog.wlt:223,1-251,2"
]

(* --- merged from: Catalog_test12.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

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
	TestID->"Catalog_20251223-2IK0IQ@@Tests/Core/Catalog.wlt:256,1-284,2"
]

(* --- merged from: Catalog_test13.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

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
	TestID->"Catalog_20251223-16V8HS@@Tests/Core/Catalog.wlt:289,1-320,2"
]

(* --- merged from: Catalog_test14.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

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
	TestID->"Catalog_20251223-91RLYU@@Tests/Core/Catalog.wlt:325,1-340,2"
]

(* --- merged from: Catalog_test15.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

VerificationTest[
	Apply[And, {SubsetQ[Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo]}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20251223-O3EOWM@@Tests/Core/Catalog.wlt:345,1-353,2"
]

(* --- merged from: Catalog_test16.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

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
	TestID->"Catalog_20251223-IJ59KY@@Tests/Core/Catalog.wlt:358,1-389,2"
]

End[]
EndTestSection[]
