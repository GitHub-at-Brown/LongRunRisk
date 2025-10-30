BeginTestSection["CreateEulerEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`"]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251030-0I3LYC@@Tests/CreateEulerEq.wlt:3,1-12,2"
]
VerificationTest[
	Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp = FernandoDuarte`LongRunRisk`Models;
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp @ "BY";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modNRC = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp @ "NRC";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modDES = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp @ "DES";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods = {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modNRC, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modDES};
	True
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251030-6CJGJT@@Tests/CreateEulerEq.wlt:13,1-27,2"
]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eulereq = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`eulereq;
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nomeulereq = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`nomeulereq;
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`findEulerEqConstants = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants;
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ee[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model_] := {
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eulereq[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model],
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eulereq[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`j], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model],
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eulereq[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model],
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nomeulereq[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model]
	};
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eeAll = Map[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ee, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffWc[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]}];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffPd[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]}];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffBond[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]}];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffNomBond[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]}];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffWcAll = Map[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffWc, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffPdAll = Map[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffPd, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffBondAll = Map[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffBond, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffNomBondAll = Map[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffNomBond, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods];
	True
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251030-FVIYM6@@Tests/CreateEulerEq.wlt:28,1-55,2"
]
VerificationTest[
	!SameQ[Names @ "*eulereq", {}]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251030-UFGA4H@@Tests/CreateEulerEq.wlt:56,1-64,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Map[
					Function[
						Equal[
							Max[
								Keys[
									CoefficientRules[
										#,
										DeleteDuplicates[
											Cases[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t], Blank[Symbol][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t] ^ Optional[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`p_], Infinity]
										]
									]
								]
							],
							1
						]
					],
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ee @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY
				],
				Map[
					Function[
						Equal[
							Max[
								Keys[
									CoefficientRules[
										#,
										DeleteDuplicates[
											Cases[
												FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modNRC["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t],
												Blank[Symbol][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t] ^ Optional[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`p_],
												Infinity
											]
										]
									]
								]
							],
							1
						]
					],
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ee @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modNRC
				],
				Map[
					Function[
						Equal[
							Max[
								Keys[
									CoefficientRules[
										#,
										DeleteDuplicates[
											Cases[
												FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modDES["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t],
												Blank[Symbol][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t] ^ Optional[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`p_],
												Infinity
											]
										]
									]
								]
							],
							1
						]
					],
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ee @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modDES
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251030-KMPVDC@@Tests/CreateEulerEq.wlt:65,1-140,2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eeAll[[1;;, 1]], n], #]
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffWcAll[[n]]
					],
					{n, 1, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods}
				],
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eeAll[[1;;, 2]], n], #]
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffPdAll[[n]]
					],
					{n, 1, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods}
				],
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eeAll[[1;;, 3]], n], #]
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffBondAll[[n]]
					],
					{n, 1, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods}
				],
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eeAll[[1;;, 4]], n], #]
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffNomBondAll[[n]]
					],
					{n, 1, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251030-HGY90H@@Tests/CreateEulerEq.wlt:141,1-198,2"
]
VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest,
		Apply[And,
			Flatten[
				{
					Map[
						Function[
							SameQ[
								Count[
									Cases[
										First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, #],
										Equal[0, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`x__] :> True
									],
									True
								],
								Length[#["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]] + 1
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
					],
					Map[
						Function[
							SameQ[
								Count[
									Cases[
										First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`j], #],
										Equal[0, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`x__] :> True
									],
									True
								],
								Length[#["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]] + 1
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
					],
					Map[
						Function[
							SameQ[
								Count[
									Cases[
										First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #],
										Equal[0, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`x__] :> True
									],
									True
								],
								Length[#["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]] + 1
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
					],
					Map[
						Function[
							SameQ[
								Count[
									Cases[
										First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #, True],
										Equal[0, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`x__] :> True
									],
									True
								],
								Length[#["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]] + 1
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
					]
				}
			]
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251030-W1QB1P@@Tests/CreateEulerEq.wlt:199,1-275,2"
]
VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest,
		Apply[And,
			Flatten[
				{
					Map[Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, #], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods],
					Map[
						Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`j], #], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
					],
					Map[
						Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
					],
					Map[
						Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #, True], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
					]
				}
			]
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251030-AT08IC@@Tests/CreateEulerEq.wlt:276,1-305,2"
]
VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest,
		Apply[And,
			Flatten[
				{
					SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t], #]&, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods],
						Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1], #]], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods]
					],
					SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`j], #]&, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods],
						Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`j], #]], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods]
					],
					SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #]&, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods],
						Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #]], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods]
					],
					SameQ[
						Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #, True]&, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods],
						Map[
							Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #, True]],
							FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
						]
					]
				}
			]
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251030-2FEVSW@@Tests/CreateEulerEq.wlt:306,1-338,2"
]
VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest,
		SameQ[{"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"},
			DeleteDuplicates[
				Flatten[
					{
						Map[Function @ Context @ Evaluate @ #,
							Flatten[
								Map[
									Function[
										Part[Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, #], 1;;, 0]
									],
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
								]
							]
						],
						Map[Function @ Context @ Evaluate @ #,
							Flatten[
								Map[
									Function[
										Part[Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`j], #], 1;;, 0, 0]
									],
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
								]
							]
						],
						Map[Function @ Context @ Evaluate @ #,
							Flatten[
								Map[
									Function[
										Part[
											Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #],
											1;;, 0, 0
										]
									],
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
								]
							]
						],
						Map[Function @ Context @ Evaluate @ #,
							Flatten[
								Map[
									Function[
										Part[
											Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #, True],
											1;;, 0, 0
										]
									],
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
								]
							]
						]
					}
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
	TestID->"CreateEulerEq_20251030-8U8CPW@@Tests/CreateEulerEq.wlt:339,1-403,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`checkBoolean[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model_] := Module[
		{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e3, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0p, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e1p, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e2p, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e3p},
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e1 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, 1], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e2 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e3 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model, True];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0p = Flatten[
			{
				Normal @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model @ "parameters",
				Thread[Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0, 2] -> 4],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc -> 4
			}
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e1p = Flatten[{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0p, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[_] -> 4, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[_] -> 4}];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e2p = Flatten[{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0p, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m_] -> 4}];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e3p = Flatten[{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0p, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m_] -> 4}];
		{
			Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0, 1] /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0p,
			Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e1, 1] /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e1p,
			Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e2, 1] /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e2p,
			Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e3, 1] /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e3p
		}
	];
	Apply[And, Map[BooleanQ, Flatten @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`checkBoolean @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY]]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251030-IVIDC8@@Tests/CreateEulerEq.wlt:404,1-435,2"
] 
VerificationTest[
  $ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ]; True,
  True,
  TestID -> "Untitled-8@@Tests/CreateEulerEq.wlt:436,1-444,8"
]
End[]
EndTestSection[]
