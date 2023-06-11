BeginTestSection["CreateEulerEq"] 
Begin["ComputationalEngine`EulerEq`"]
VerificationTest[
	Get @ Get @ FileNameJoin @ {pacletDir, "Resources", "Models.wl"};
	ComputationalEngine`EulerEq`msp = FernandoDuarte`LongRunRisk`Models;
	ComputationalEngine`EulerEq`modBY = ComputationalEngine`EulerEq`msp @ "BY";
	ComputationalEngine`EulerEq`modNRC = ComputationalEngine`EulerEq`msp @ "NRC";
	ComputationalEngine`EulerEq`modDES = ComputationalEngine`EulerEq`msp @ "DES";
	ComputationalEngine`EulerEq`mods = {ComputationalEngine`EulerEq`modBY, ComputationalEngine`EulerEq`modNRC, ComputationalEngine`EulerEq`modDES};
	,
	Null
	,
	{}
	,
	TestID->"CreateEulerEq_20230610-BUDHZN"
]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`";
	,
	Null
	,
	{}
	,
	TestID->"CreateEulerEq_20230610-L0UJJK"
]
VerificationTest[
	!SameQ[Names @ "*eulereq", {}]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20230610-4GCM3T"
]
VerificationTest[
	ComputationalEngine`EulerEq`ee[ComputationalEngine`EulerEq`model_] := {
		FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`eulereq[ComputationalEngine`EulerEq`retc[ComputationalEngine`EulerEq`t + 1], ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`model],
		FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`eulereq[ComputationalEngine`EulerEq`ret[ComputationalEngine`EulerEq`t + 1, ComputationalEngine`EulerEq`j], ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`model],
		FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`eulereq[ComputationalEngine`EulerEq`bondret[ComputationalEngine`EulerEq`t + 1, ComputationalEngine`EulerEq`m], ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`model],
		FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`nomeulereq[ComputationalEngine`EulerEq`nombondret[ComputationalEngine`EulerEq`t + 1, ComputationalEngine`EulerEq`m], ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`model]
	};
	ComputationalEngine`EulerEq`eeAll = Map[ComputationalEngine`EulerEq`ee, ComputationalEngine`EulerEq`mods];
	ComputationalEngine`EulerEq`coeffWc[ComputationalEngine`EulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc @ ComputationalEngine`EulerEq`i, {ComputationalEngine`EulerEq`i, Length @ ComputationalEngine`EulerEq`model["stateVars"][ComputationalEngine`EulerEq`t]}];
	ComputationalEngine`EulerEq`coeffPd[ComputationalEngine`EulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd @ ComputationalEngine`EulerEq`i, {ComputationalEngine`EulerEq`i, Length @ ComputationalEngine`EulerEq`model["stateVars"][ComputationalEngine`EulerEq`t]}];
	ComputationalEngine`EulerEq`coeffBond[ComputationalEngine`EulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb @ ComputationalEngine`EulerEq`i, {ComputationalEngine`EulerEq`i, Length @ ComputationalEngine`EulerEq`model["stateVars"][ComputationalEngine`EulerEq`t]}];
	ComputationalEngine`EulerEq`coeffNomBond[ComputationalEngine`EulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb @ ComputationalEngine`EulerEq`i, {ComputationalEngine`EulerEq`i, Length @ ComputationalEngine`EulerEq`model["stateVars"][ComputationalEngine`EulerEq`t]}];
	ComputationalEngine`EulerEq`coeffWcAll = Map[ComputationalEngine`EulerEq`coeffWc, ComputationalEngine`EulerEq`mods];
	ComputationalEngine`EulerEq`coeffPdAll = Map[ComputationalEngine`EulerEq`coeffPd, ComputationalEngine`EulerEq`mods];
	ComputationalEngine`EulerEq`coeffBondAll = Map[ComputationalEngine`EulerEq`coeffBond, ComputationalEngine`EulerEq`mods];
	ComputationalEngine`EulerEq`coeffNomBondAll = Map[ComputationalEngine`EulerEq`coeffNomBond, ComputationalEngine`EulerEq`mods];
	,
	Null
	,
	{}
	,
	TestID->"CreateEulerEq_20230610-B7PS9K"
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
											Cases[ComputationalEngine`EulerEq`modBY["stateVars"][ComputationalEngine`EulerEq`t], Blank[Symbol][ComputationalEngine`EulerEq`t] ^ Optional[ComputationalEngine`EulerEq`p_], Infinity]
										]
									]
								]
							],
							1
						]
					],
					ComputationalEngine`EulerEq`ee @ ComputationalEngine`EulerEq`modBY
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
												ComputationalEngine`EulerEq`modNRC["stateVars"][ComputationalEngine`EulerEq`t],
												Blank[Symbol][ComputationalEngine`EulerEq`t] ^ Optional[ComputationalEngine`EulerEq`p_],
												Infinity
											]
										]
									]
								]
							],
							1
						]
					],
					ComputationalEngine`EulerEq`ee @ ComputationalEngine`EulerEq`modNRC
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
												ComputationalEngine`EulerEq`modDES["stateVars"][ComputationalEngine`EulerEq`t],
												Blank[Symbol][ComputationalEngine`EulerEq`t] ^ Optional[ComputationalEngine`EulerEq`p_],
												Infinity
											]
										]
									]
								]
							],
							1
						]
					],
					ComputationalEngine`EulerEq`ee @ ComputationalEngine`EulerEq`modDES
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20230610-5LL9SA"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[ComputationalEngine`EulerEq`eeAll[[1;;, 1]], ComputationalEngine`EulerEq`n], #]
							]
						],
						ComputationalEngine`EulerEq`coeffWcAll[[ComputationalEngine`EulerEq`n]]
					],
					{ComputationalEngine`EulerEq`n, 1, Length @ ComputationalEngine`EulerEq`mods}
				],
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[ComputationalEngine`EulerEq`eeAll[[1;;, 2]], ComputationalEngine`EulerEq`n], #]
							]
						],
						ComputationalEngine`EulerEq`coeffPdAll[[ComputationalEngine`EulerEq`n]]
					],
					{ComputationalEngine`EulerEq`n, 1, Length @ ComputationalEngine`EulerEq`mods}
				],
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[ComputationalEngine`EulerEq`eeAll[[1;;, 3]], ComputationalEngine`EulerEq`n], #]
							]
						],
						ComputationalEngine`EulerEq`coeffBondAll[[ComputationalEngine`EulerEq`n]]
					],
					{ComputationalEngine`EulerEq`n, 1, Length @ ComputationalEngine`EulerEq`mods}
				],
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[ComputationalEngine`EulerEq`eeAll[[1;;, 4]], ComputationalEngine`EulerEq`n], #]
							]
						],
						ComputationalEngine`EulerEq`coeffNomBondAll[[ComputationalEngine`EulerEq`n]]
					],
					{ComputationalEngine`EulerEq`n, 1, Length @ ComputationalEngine`EulerEq`mods}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20230610-94P7EM"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Map[
					Function[
						SameQ[
							Count[
								Cases[
									First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`retc @ ComputationalEngine`EulerEq`t, #],
									Equal[0, ComputationalEngine`EulerEq`x__] :> True
								],
								True
							],
							Length[#["stateVars"][ComputationalEngine`EulerEq`t]] + 1
						]
					],
					ComputationalEngine`EulerEq`mods
				],
				Map[
					Function[
						SameQ[
							Count[
								Cases[
									First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`ret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`j], #],
									Equal[0, ComputationalEngine`EulerEq`x__] :> True
								],
								True
							],
							Length[#["stateVars"][ComputationalEngine`EulerEq`t]] + 1
						]
					],
					ComputationalEngine`EulerEq`mods
				],
				Map[
					Function[
						SameQ[
							Count[
								Cases[
									First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`bondret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`m], #],
									Equal[0, ComputationalEngine`EulerEq`x__] :> True
								],
								True
							],
							Length[#["stateVars"][ComputationalEngine`EulerEq`t]] + 1
						]
					],
					ComputationalEngine`EulerEq`mods
				],
				Map[
					Function[
						SameQ[
							Count[
								Cases[
									First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`nombondret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`m], #, True],
									Equal[0, ComputationalEngine`EulerEq`x__] :> True
								],
								True
							],
							Length[#["stateVars"][ComputationalEngine`EulerEq`t]] + 1
						]
					],
					ComputationalEngine`EulerEq`mods
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20230610-71O1R2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Map[Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`retc @ ComputationalEngine`EulerEq`t, #], ComputationalEngine`EulerEq`t], ComputationalEngine`EulerEq`mods],
				Map[Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`ret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`j], #], ComputationalEngine`EulerEq`t],
					ComputationalEngine`EulerEq`mods
				],
				Map[
					Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`bondret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`m], #], ComputationalEngine`EulerEq`t],
					ComputationalEngine`EulerEq`mods
				],
				Map[
					Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`nombondret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`m], #, True], ComputationalEngine`EulerEq`t],
					ComputationalEngine`EulerEq`mods
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20230610-OCPA9P"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`retc[ComputationalEngine`EulerEq`t], #]&, ComputationalEngine`EulerEq`mods],
					Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`retc[ComputationalEngine`EulerEq`t + 1], #]], ComputationalEngine`EulerEq`mods]
				],
				SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`ret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`j], #]&, ComputationalEngine`EulerEq`mods],
					Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`ret[ComputationalEngine`EulerEq`t + 1, ComputationalEngine`EulerEq`j], #]], ComputationalEngine`EulerEq`mods]
				],
				SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`bondret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`m], #]&, ComputationalEngine`EulerEq`mods],
					Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`bondret[ComputationalEngine`EulerEq`t + 1, ComputationalEngine`EulerEq`m], #]], ComputationalEngine`EulerEq`mods]
				],
				SameQ[
					Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`nombondret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`m], #, True]&, ComputationalEngine`EulerEq`mods],
					Map[
						Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`nombondret[ComputationalEngine`EulerEq`t + 1, ComputationalEngine`EulerEq`m], #, True]],
						ComputationalEngine`EulerEq`mods
					]
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20230610-VHP4X3"
]
VerificationTest[
	SameQ[{"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"},
		DeleteDuplicates[
			Flatten[
				{
					Map[Function @ Context @ Evaluate @ #,
						Flatten[
							Map[
								Function[
									Part[Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`retc @ ComputationalEngine`EulerEq`t, #], 1;;, 0]
								],
								ComputationalEngine`EulerEq`mods
							]
						]
					],
					Map[Function @ Context @ Evaluate @ #,
						Flatten[
							Map[
								Function[
									Part[Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`ret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`j], #], 1;;, 0, 0]
								],
								ComputationalEngine`EulerEq`mods
							]
						]
					],
					Map[Function @ Context @ Evaluate @ #,
						Flatten[
							Map[
								Function[
									Part[
										Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`bondret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`m], #],
										1;;, 0, 0
									]
								],
								ComputationalEngine`EulerEq`mods
							]
						]
					],
					Map[Function @ Context @ Evaluate @ #,
						Flatten[
							Map[
								Function[
									Part[
										Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`nombondret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`m], #, True],
										1;;, 0, 0
									]
								],
								ComputationalEngine`EulerEq`mods
							]
						]
					]
				}
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20230610-CH72PP"
]
VerificationTest[
	ComputationalEngine`EulerEq`checkBoolean[ComputationalEngine`EulerEq`model_] := Module[
		{ComputationalEngine`EulerEq`e0, ComputationalEngine`EulerEq`e1, ComputationalEngine`EulerEq`e2, ComputationalEngine`EulerEq`e3, ComputationalEngine`EulerEq`e0p, ComputationalEngine`EulerEq`e1p, ComputationalEngine`EulerEq`e2p, ComputationalEngine`EulerEq`e3p},
		ComputationalEngine`EulerEq`e0 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`retc @ ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`model];
		ComputationalEngine`EulerEq`e1 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`ret[ComputationalEngine`EulerEq`t, 1], ComputationalEngine`EulerEq`model];
		ComputationalEngine`EulerEq`e2 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`bondret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`m], ComputationalEngine`EulerEq`model];
		ComputationalEngine`EulerEq`e3 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`EulerEq`nombondret[ComputationalEngine`EulerEq`t, ComputationalEngine`EulerEq`m], ComputationalEngine`EulerEq`model, True];
		ComputationalEngine`EulerEq`e0p = Flatten[
			{
				Normal @ ComputationalEngine`EulerEq`model @ "parameters",
				Thread[Part[ComputationalEngine`EulerEq`e0, 2] -> 4],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc -> 4
			}
		];
		ComputationalEngine`EulerEq`e1p = Flatten[{ComputationalEngine`EulerEq`e0p, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[_] -> 4, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[_] -> 4}];
		ComputationalEngine`EulerEq`e2p = Flatten[{ComputationalEngine`EulerEq`e0p, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[ComputationalEngine`EulerEq`m_] -> 4}];
		ComputationalEngine`EulerEq`e3p = Flatten[{ComputationalEngine`EulerEq`e0p, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[ComputationalEngine`EulerEq`m_] -> 4}];
		{
			Part[ComputationalEngine`EulerEq`e0, 1] /. ComputationalEngine`EulerEq`e0p,
			Part[ComputationalEngine`EulerEq`e1, 1] /. ComputationalEngine`EulerEq`e1p,
			Part[ComputationalEngine`EulerEq`e2, 1] /. ComputationalEngine`EulerEq`e2p,
			Part[ComputationalEngine`EulerEq`e3, 1] /. ComputationalEngine`EulerEq`e3p
		}
	];
	Apply[And, Map[BooleanQ, Flatten @ ComputationalEngine`EulerEq`checkBoolean @ ComputationalEngine`EulerEq`modBY]]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20230610-OSUVZY"
] 
End[]
EndTestSection[]
