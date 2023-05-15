BeginTestSection["SolveEulerEq"] 
Begin["ComputationalEngine`EulerEq`"]
VerificationTest[
	Get @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
	,
	Null
	,
	{}
	,
	TestID->"SolveEulerEq_20230515-RVUGGB"
]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`";
	,
	Null
	,
	{}
	,
	TestID->"SolveEulerEq_20230515-LXQHXM"
]
VerificationTest[
	!SameQ[Names @ "*eulereq", {}]
	,
	True
	,
	{}
	,
	TestID->"SolveEulerEq_20230515-QAZ0U1"
]
VerificationTest[
	ComputationalEngine`EulerEq`mm = FernandoDuarte`LongRunRisk`Model`Catalog`models;
	ComputationalEngine`EulerEq`ms = KeySelect[
		ComputationalEngine`EulerEq`mm,
		MatchQ[#, Alternatives["BKY", "NRC", "BS", "DES", "WCratio"]]&
	];
	ComputationalEngine`EulerEq`msp = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ ComputationalEngine`EulerEq`ms;
	ComputationalEngine`EulerEq`modBKY = ComputationalEngine`EulerEq`msp @ "BKY";
	ComputationalEngine`EulerEq`modNRC = ComputationalEngine`EulerEq`msp @ "NRC";
	ComputationalEngine`EulerEq`modBS = ComputationalEngine`EulerEq`msp @ "BS";
	ComputationalEngine`EulerEq`modDES = ComputationalEngine`EulerEq`msp @ "DES";
	ComputationalEngine`EulerEq`modWCratio = ComputationalEngine`EulerEq`msp @ "WCratio";
	ComputationalEngine`EulerEq`modBKYa = Map[Activate, ComputationalEngine`EulerEq`modBKY];
	ComputationalEngine`EulerEq`modNRCa = Map[Activate, ComputationalEngine`EulerEq`modNRC];
	ComputationalEngine`EulerEq`modBSa = Map[Activate, ComputationalEngine`EulerEq`modBS];
	ComputationalEngine`EulerEq`modDESa = Map[Activate, ComputationalEngine`EulerEq`modDES];
	ComputationalEngine`EulerEq`modWCratioa = Map[Activate, ComputationalEngine`EulerEq`modWCratio];
	,
	Null
	,
	{}
	,
	TestID->"SolveEulerEq_20230515-8XKPPV"
]
VerificationTest[
	ComputationalEngine`EulerEq`model = ComputationalEngine`EulerEq`modBSa;
	ComputationalEngine`EulerEq`modelAssumptions = ComputationalEngine`EulerEq`model @ "modelAssumptions";
	ComputationalEngine`EulerEq`parameters = ComputationalEngine`EulerEq`model @ "parameters";
	ComputationalEngine`EulerEq`numStocks = ComputationalEngine`EulerEq`model @ "numStocks";
	ComputationalEngine`EulerEq`ratiosUncondERule = {
		FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc -> Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`EulerEq`wc[ComputationalEngine`EulerEq`t], ComputationalEngine`EulerEq`model]],
		FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[ComputationalEngine`EulerEq`j_] -> Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`EulerEq`pd[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`j], ComputationalEngine`EulerEq`model]]
	}
	,
	{
		FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc -> (FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[0] - FernandoDuarte`LongRunRisk`Model`Parameters`mupbar * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[2]),
		FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[ComputationalEngine`EulerEq`j_] -> (FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[ComputationalEngine`EulerEq`j][0] - FernandoDuarte`LongRunRisk`Model`Parameters`mupbar * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[ComputationalEngine`EulerEq`j][2])
	}
	,
	{}
	,
	TestID->"SolveEulerEq_20230515-ZX437P"
]
VerificationTest[
	{ComputationalEngine`EulerEq`systemWc, ComputationalEngine`EulerEq`unknownsWc} = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`retc[ComputationalEngine`EulerEq`t + 1], ComputationalEngine`EulerEq`model] /. ComputationalEngine`EulerEq`ratiosUncondERule;
	{ComputationalEngine`EulerEq`systemPd, ComputationalEngine`EulerEq`unknownsPd} = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`ret[ComputationalEngine`EulerEq`t + 1, ComputationalEngine`EulerEq`j], ComputationalEngine`EulerEq`model] /. ComputationalEngine`EulerEq`ratiosUncondERule;
	ComputationalEngine`EulerEq`unknownsWcGuess = Prepend[Table[0, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 8];
	ComputationalEngine`EulerEq`solWc = FindRoot[
		ComputationalEngine`EulerEq`systemWc //. ComputationalEngine`EulerEq`parameters,
		Thread @ {ComputationalEngine`EulerEq`unknownsWc, ComputationalEngine`EulerEq`unknownsWcGuess},
		MaxIterations -> 3500
	];
	ComputationalEngine`EulerEq`unknownsPdGuess = Prepend[Table[0, Length[ComputationalEngine`EulerEq`unknownsPd] - 1], 7];
	ComputationalEngine`EulerEq`solOnePd[ComputationalEngine`EulerEq`stockNumber_] := FindRoot[
		((ComputationalEngine`EulerEq`systemPd /. ComputationalEngine`EulerEq`j -> ComputationalEngine`EulerEq`stockNumber) //. ComputationalEngine`EulerEq`solWc) //. ComputationalEngine`EulerEq`parameters,
		Thread[{ComputationalEngine`EulerEq`unknownsPd, ComputationalEngine`EulerEq`unknownsPdGuess}] /. ComputationalEngine`EulerEq`j -> ComputationalEngine`EulerEq`stockNumber,
		MaxIterations -> 3500
	];
	ComputationalEngine`EulerEq`solPd = Map[ComputationalEngine`EulerEq`solOnePd[#]&, Range @ ComputationalEngine`EulerEq`numStocks];
	ComputationalEngine`EulerEq`bondRecursion = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`findBondRecursion[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`n + 1, ComputationalEngine`EulerEq`model] /. ComputationalEngine`EulerEq`ratiosUncondERule;
	ComputationalEngine`EulerEq`maxMaturity = 6;
	ComputationalEngine`EulerEq`bondCoefficientRules = ReplaceAll[
		Join[ComputationalEngine`EulerEq`bondRecursion[[1, 4]], ComputationalEngine`EulerEq`bondRecursion[[2, 4]]],
		ComputationalEngine`EulerEq`x_[ComputationalEngine`EulerEq`n][ComputationalEngine`EulerEq`j_Integer] :> (ComputationalEngine`EulerEq`x[ComputationalEngine`EulerEq`n_][ComputationalEngine`EulerEq`j] -> Symbol[StringJoin[SymbolName[ComputationalEngine`EulerEq`x], IntegerString @ ComputationalEngine`EulerEq`j]][ComputationalEngine`EulerEq`n])
	];
	ComputationalEngine`EulerEq`posConstantCoeff = Position[
		ComputationalEngine`EulerEq`bondRecursion[[1, 2]],
		PatternTest[_, FreeQ[#, ComputationalEngine`EulerEq`n - 1]&],
		1, Heads -> False
	];
	ComputationalEngine`EulerEq`perturbationNom = If[
		SameQ[ComputationalEngine`EulerEq`posConstantCoeff, {}],
		0,
		ReplaceAll[
			Times[10 ^ -18,
				First[Extract[ComputationalEngine`EulerEq`bondRecursion[[2, 4]], ComputationalEngine`EulerEq`posConstantCoeffNom]]
			],
			ComputationalEngine`EulerEq`n -> (ComputationalEngine`EulerEq`n - 1)
		]
	];
	ComputationalEngine`EulerEq`bondRecursionPerturbation = MapAt[
		Function[
			ReplaceAll[#, Equal[ComputationalEngine`EulerEq`a_, ComputationalEngine`EulerEq`b_] :> Equal[ComputationalEngine`EulerEq`a, ComputationalEngine`EulerEq`b + ComputationalEngine`EulerEq`perturbation]]
		],
		ComputationalEngine`EulerEq`bondRecursion[[1, 2]],
		ComputationalEngine`EulerEq`posConstantCoeff
	];
	ComputationalEngine`EulerEq`solBondNum = Chop[
		Column[
			RecurrenceTable[
				Simplify[
					ReplaceAll[
						ReplaceAll[
							ReplaceRepeated[
								Flatten[{ComputationalEngine`EulerEq`bondRecursionPerturbation, ComputationalEngine`EulerEq`bondRecursion[[1, 3]]}],
								ComputationalEngine`EulerEq`parameters
							],
							ComputationalEngine`EulerEq`solWc
						],
						ComputationalEngine`EulerEq`bondCoefficientRules
					]
				],
				Part[ComputationalEngine`EulerEq`bondRecursion, 1, 4] /. ComputationalEngine`EulerEq`bondCoefficientRules,
				{ComputationalEngine`EulerEq`n, 1, ComputationalEngine`EulerEq`maxMaturity},
				DependentVariables -> Automatic
			]
		]
	];
	ComputationalEngine`EulerEq`solBond = Flatten[
		{
			Part[ComputationalEngine`EulerEq`bondRecursion, 1, 3] /. Equal -> Rule,
			Table[Thread[Part[ComputationalEngine`EulerEq`bondRecursion, 1, 4] -> Part[ComputationalEngine`EulerEq`solBondNum, 1, ComputationalEngine`EulerEq`n]],
				{ComputationalEngine`EulerEq`n, 1, ComputationalEngine`EulerEq`maxMaturity}
			]
		}
	];
	ComputationalEngine`EulerEq`posConstantCoeffNom = Position[
		ComputationalEngine`EulerEq`bondRecursion[[2, 2]],
		PatternTest[_, FreeQ[#, ComputationalEngine`EulerEq`n - 1]&],
		1, Heads -> False
	];
	ComputationalEngine`EulerEq`perturbationNom = If[
		SameQ[ComputationalEngine`EulerEq`posConstantCoeffNom, {}],
		0,
		ReplaceAll[
			Times[10 ^ -18,
				First[Extract[ComputationalEngine`EulerEq`bondRecursion[[2, 4]], ComputationalEngine`EulerEq`posConstantCoeffNom]]
			],
			ComputationalEngine`EulerEq`n -> (ComputationalEngine`EulerEq`n - 1)
		]
	];
	ComputationalEngine`EulerEq`bondRecursionPerturbationNom = MapAt[
		Function[
			ReplaceAll[#, Equal[ComputationalEngine`EulerEq`a_, ComputationalEngine`EulerEq`b_] :> Equal[ComputationalEngine`EulerEq`a, ComputationalEngine`EulerEq`b + ComputationalEngine`EulerEq`perturbationNom]]
		],
		ComputationalEngine`EulerEq`bondRecursion[[2, 2]],
		ComputationalEngine`EulerEq`posConstantCoeffNom
	];
	ComputationalEngine`EulerEq`solNomBondNum = Chop[
		Column[
			RecurrenceTable[
				ReplaceAll[
					ReplaceAll[
						ReplaceRepeated[
							Flatten[{ComputationalEngine`EulerEq`bondRecursionPerturbationNom, ComputationalEngine`EulerEq`bondRecursion[[2, 3]]}],
							ComputationalEngine`EulerEq`parameters
						],
						ComputationalEngine`EulerEq`solWc
					],
					ComputationalEngine`EulerEq`bondCoefficientRules
				],
				Part[ComputationalEngine`EulerEq`bondRecursion, 2, 4] /. ComputationalEngine`EulerEq`bondCoefficientRules,
				{ComputationalEngine`EulerEq`n, 1, ComputationalEngine`EulerEq`maxMaturity},
				DependentVariables -> Automatic
			]
		]
	];
	ComputationalEngine`EulerEq`solNomBond = Flatten[
		{
			Part[ComputationalEngine`EulerEq`bondRecursion, 2, 3] /. Equal -> Rule,
			Table[
				Thread[Part[ComputationalEngine`EulerEq`bondRecursion, 2, 4] -> Part[ComputationalEngine`EulerEq`solNomBondNum, 1, ComputationalEngine`EulerEq`n]],
				{ComputationalEngine`EulerEq`n, 1, ComputationalEngine`EulerEq`maxMaturity}
			]
		}
	];
	,
	Null
	,
	{}
	,
	TestID->"SolveEulerEq_20230515-WP4WSJ"
]
VerificationTest[
	Apply[And,
		Map[NumberQ,
			Values @ Flatten @ {ComputationalEngine`EulerEq`solWc, ComputationalEngine`EulerEq`solPd, ComputationalEngine`EulerEq`solBond, ComputationalEngine`EulerEq`solNomBond}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"SolveEulerEq_20230515-IF6EJS"
]
VerificationTest[
	Apply[And,
		{
			FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`retc[ComputationalEngine`EulerEq`t + 1], ComputationalEngine`EulerEq`model], ComputationalEngine`EulerEq`t],
			FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`retc @ ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`model], ComputationalEngine`EulerEq`t]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"SolveEulerEq_20230515-F3GWQU"
]
VerificationTest[
	Apply[And,
		{
			SameQ[Simplify[Expand[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`retc[ComputationalEngine`EulerEq`t + 1], ComputationalEngine`EulerEq`model]]],
				Simplify @ Expand @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`retc @ ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`model]
			],
			SameQ[Simplify[Expand[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`ret[ComputationalEngine`EulerEq`t + 1, ComputationalEngine`EulerEq`j], ComputationalEngine`EulerEq`model]]],
				Simplify @ Expand @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`ret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`j], ComputationalEngine`EulerEq`model]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"SolveEulerEq_20230515-H5KJ4T"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				{
					Apply[And,
						Map[MatchQ["FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`", #]&, Map[Context, Map[Head, ComputationalEngine`EulerEq`unknownsWc]]]
					],
					Apply[And,
						Map[MatchQ["FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`", #]&,
							Map[Context, Map[Head, Map[Head, ComputationalEngine`EulerEq`unknownsPd]]]
						]
					]
				}
			],
			Apply[And,
				{
					Apply[And,
						Map[BooleanQ,
							ReplaceAll[
								ComputationalEngine`EulerEq`systemWc //. ComputationalEngine`EulerEq`parameters,
								Thread[
									ComputationalEngine`EulerEq`unknownsWc -> Prepend[Table[0, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
								]
							]
						]
					],
					Apply[And,
						Map[BooleanQ,
							ReplaceAll[
								ReplaceRepeated[
									ReplaceAll[
										ReplaceAll[
											ComputationalEngine`EulerEq`systemPd,
											Thread[
												ComputationalEngine`EulerEq`unknownsPd -> Prepend[Table[0, Length[ComputationalEngine`EulerEq`unknownsPd] - 1], 6]
											]
										],
										ComputationalEngine`EulerEq`j -> 1
									],
									ComputationalEngine`EulerEq`parameters
								],
								Thread[
									ComputationalEngine`EulerEq`unknownsWc -> Prepend[Table[0, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
								]
							]
						]
					],
					Apply[And,
						Map[NumberQ,
							ReplaceAll[
								Part[ComputationalEngine`EulerEq`systemWc, 1;;, 2] //. ComputationalEngine`EulerEq`parameters,
								Thread[
									ComputationalEngine`EulerEq`unknownsWc -> Prepend[Table[0, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
								]
							]
						]
					],
					Apply[And,
						Map[NumberQ,
							ReplaceAll[
								ReplaceRepeated[
									ReplaceAll[
										ReplaceAll[
											ComputationalEngine`EulerEq`systemPd[[1;;, 2]],
											Thread[
												ComputationalEngine`EulerEq`unknownsPd -> Prepend[Table[0, Length[ComputationalEngine`EulerEq`unknownsPd] - 1], 6]
											]
										],
										ComputationalEngine`EulerEq`j -> 1
									],
									ComputationalEngine`EulerEq`parameters
								],
								Thread[
									ComputationalEngine`EulerEq`unknownsWc -> Prepend[Table[0, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
								]
							]
						]
					],
					Apply[And,
						Map[BooleanQ,
							ReplaceAll[
								ComputationalEngine`EulerEq`systemWc //. ComputationalEngine`EulerEq`parameters,
								Thread[
									ComputationalEngine`EulerEq`unknownsWc -> Prepend[RandomReal[{-10, 10}, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
								]
							]
						]
					],
					Apply[And,
						Map[BooleanQ,
							ReplaceAll[
								ReplaceRepeated[
									ReplaceAll[
										ReplaceAll[
											ComputationalEngine`EulerEq`systemPd,
											Thread[
												ComputationalEngine`EulerEq`unknownsPd -> Prepend[RandomReal[{-10, 10}, Length[ComputationalEngine`EulerEq`unknownsPd] - 1], 6]
											]
										],
										ComputationalEngine`EulerEq`j -> 1
									],
									ComputationalEngine`EulerEq`parameters
								],
								Thread[
									ComputationalEngine`EulerEq`unknownsWc -> Prepend[RandomReal[{-10, 10}, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
								]
							]
						]
					],
					Apply[And,
						Map[NumberQ,
							ReplaceAll[
								Part[ComputationalEngine`EulerEq`systemWc, 1;;, 2] //. ComputationalEngine`EulerEq`parameters,
								Thread[
									ComputationalEngine`EulerEq`unknownsWc -> Prepend[RandomReal[{-10, 10}, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
								]
							]
						]
					],
					Apply[And,
						Map[NumberQ,
							ReplaceAll[
								ReplaceRepeated[
									ReplaceAll[
										ReplaceAll[
											ComputationalEngine`EulerEq`systemPd[[1;;, 2]],
											Thread[
												ComputationalEngine`EulerEq`unknownsPd -> Prepend[RandomReal[{-10, 10}, Length[ComputationalEngine`EulerEq`unknownsPd] - 1], 6]
											]
										],
										ComputationalEngine`EulerEq`j -> 1
									],
									ComputationalEngine`EulerEq`parameters
								],
								Thread[
									ComputationalEngine`EulerEq`unknownsWc -> Prepend[RandomReal[{-10, 10}, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
								]
							]
						]
					]
				}
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"SolveEulerEq_20230515-4IM8J1"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				{
					Apply[And,
						Map[MatchQ["FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`", #]&,
							Map[
								Context,
								Map[Head, Map[Head, ComputationalEngine`EulerEq`bondRecursion[[1, 4]]]]
							]
						]
					],
					Apply[And,
						Map[MatchQ["FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`", #]&,
							Map[
								Context,
								Map[Head, Map[Head, ComputationalEngine`EulerEq`bondRecursion[[2, 4]]]]
							]
						]
					]
				}
			],
			Apply[And,
				{
					Apply[And,
						Map[BooleanQ,
							ReplaceAll[
								ReplaceAll[
									ReplaceRepeated[
										Flatten[{ComputationalEngine`EulerEq`bondRecursion[[1, 2]], ComputationalEngine`EulerEq`bondRecursion[[1, 3]]}],
										ComputationalEngine`EulerEq`parameters
									],
									Thread[
										ComputationalEngine`EulerEq`unknownsWc -> Prepend[Table[0, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
									]
								],
								Thread[Part[ComputationalEngine`EulerEq`bondRecursion, 1, 4] -> 0] /. ComputationalEngine`EulerEq`n -> __
							]
						]
					],
					Apply[And,
						Map[BooleanQ,
							ReplaceAll[
								ReplaceAll[
									ReplaceRepeated[
										Flatten[{ComputationalEngine`EulerEq`bondRecursion[[2, 2]], ComputationalEngine`EulerEq`bondRecursion[[2, 3]]}],
										ComputationalEngine`EulerEq`parameters
									],
									Thread[
										ComputationalEngine`EulerEq`unknownsWc -> Prepend[Table[0, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
									]
								],
								Thread[Part[ComputationalEngine`EulerEq`bondRecursion, 2, 4] -> 0] /. ComputationalEngine`EulerEq`n -> __
							]
						]
					],
					Apply[And,
						Map[NumberQ,
							ReplaceAll[
								ReplaceAll[
									ReplaceRepeated[
										Flatten[
											{
												Part[ComputationalEngine`EulerEq`bondRecursion[[1, 2]], 1;;, 2],
												Part[ComputationalEngine`EulerEq`bondRecursion[[1, 3]], 1;;, 2]
											}
										],
										ComputationalEngine`EulerEq`parameters
									],
									Thread[
										ComputationalEngine`EulerEq`unknownsWc -> Prepend[Table[0, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
									]
								],
								Thread[Part[ComputationalEngine`EulerEq`bondRecursion, 1, 4] -> 0] /. ComputationalEngine`EulerEq`n -> __
							]
						]
					],
					Apply[And,
						Map[NumberQ,
							ReplaceAll[
								ReplaceAll[
									ReplaceRepeated[
										Flatten[
											{
												Part[ComputationalEngine`EulerEq`bondRecursion[[2, 2]], 1;;, 2],
												Part[ComputationalEngine`EulerEq`bondRecursion[[2, 3]], 1;;, 2]
											}
										],
										ComputationalEngine`EulerEq`parameters
									],
									Thread[
										ComputationalEngine`EulerEq`unknownsWc -> Prepend[Table[0, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
									]
								],
								Thread[Part[ComputationalEngine`EulerEq`bondRecursion, 2, 4] -> 0] /. ComputationalEngine`EulerEq`n -> __
							]
						]
					],
					Apply[And,
						Map[BooleanQ,
							ReplaceAll[
								ReplaceAll[
									ReplaceRepeated[
										Flatten[{ComputationalEngine`EulerEq`bondRecursion[[1, 2]], ComputationalEngine`EulerEq`bondRecursion[[1, 3]]}],
										ComputationalEngine`EulerEq`parameters
									],
									Thread[
										ComputationalEngine`EulerEq`unknownsWc -> Prepend[RandomReal[{-10, 10}, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
									]
								],
								Thread[Part[ComputationalEngine`EulerEq`bondRecursion, 1, 4] -> 0] /. ComputationalEngine`EulerEq`n -> __
							]
						]
					],
					Apply[And,
						Map[BooleanQ,
							ReplaceAll[
								ReplaceAll[
									ReplaceRepeated[
										Flatten[{ComputationalEngine`EulerEq`bondRecursion[[2, 2]], ComputationalEngine`EulerEq`bondRecursion[[2, 3]]}],
										ComputationalEngine`EulerEq`parameters
									],
									Thread[
										ComputationalEngine`EulerEq`unknownsWc -> Prepend[RandomReal[{-10, 10}, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
									]
								],
								Thread[Part[ComputationalEngine`EulerEq`bondRecursion, 2, 4] -> 0] /. ComputationalEngine`EulerEq`n -> __
							]
						]
					],
					Apply[And,
						Map[NumberQ,
							ReplaceAll[
								ReplaceAll[
									ReplaceRepeated[
										Flatten[
											{
												Part[ComputationalEngine`EulerEq`bondRecursion[[1, 2]], 1;;, 2],
												Part[ComputationalEngine`EulerEq`bondRecursion[[1, 3]], 1;;, 2]
											}
										],
										ComputationalEngine`EulerEq`parameters
									],
									Thread[
										ComputationalEngine`EulerEq`unknownsWc -> Prepend[RandomReal[{-10, 10}, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
									]
								],
								Thread[Part[ComputationalEngine`EulerEq`bondRecursion, 1, 4] -> 0] /. ComputationalEngine`EulerEq`n -> __
							]
						]
					],
					Apply[And,
						Map[NumberQ,
							ReplaceAll[
								ReplaceAll[
									ReplaceRepeated[
										Flatten[
											{
												Part[ComputationalEngine`EulerEq`bondRecursion[[2, 2]], 1;;, 2],
												Part[ComputationalEngine`EulerEq`bondRecursion[[2, 3]], 1;;, 2]
											}
										],
										ComputationalEngine`EulerEq`parameters
									],
									Thread[
										ComputationalEngine`EulerEq`unknownsWc -> Prepend[RandomReal[{-10, 10}, Length[ComputationalEngine`EulerEq`unknownsWc] - 1], 6]
									]
								],
								Thread[Part[ComputationalEngine`EulerEq`bondRecursion, 2, 4] -> 0] /. ComputationalEngine`EulerEq`n -> __
							]
						]
					]
				}
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"SolveEulerEq_20230515-HTL1PZ"
] 
End[]
EndTestSection[]
