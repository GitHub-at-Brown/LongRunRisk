BeginTestSection["CreateEulerEq"] 
Begin["ComputationalEngine`CreateEulerEq`"]
VerificationTest[
	Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
	ComputationalEngine`CreateEulerEq`msp = FernandoDuarte`LongRunRisk`Models;
	ComputationalEngine`CreateEulerEq`modBY = ComputationalEngine`CreateEulerEq`msp @ "BY";
	ComputationalEngine`CreateEulerEq`modNRC = ComputationalEngine`CreateEulerEq`msp @ "NRC";
	ComputationalEngine`CreateEulerEq`modDES = ComputationalEngine`CreateEulerEq`msp @ "DES";
	ComputationalEngine`CreateEulerEq`mods = {ComputationalEngine`CreateEulerEq`modBY, ComputationalEngine`CreateEulerEq`modNRC, ComputationalEngine`CreateEulerEq`modDES};
	True
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20231008-QYNXGM"
]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`";
	ComputationalEngine`CreateEulerEq`eulereq = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`eulereq;
	ComputationalEngine`CreateEulerEq`nomeulereq = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`nomeulereq;
	ComputationalEngine`CreateEulerEq`findEulerEqConstants = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants;
	ComputationalEngine`CreateEulerEq`ee[ComputationalEngine`CreateEulerEq`model_] := {
		ComputationalEngine`CreateEulerEq`eulereq[ComputationalEngine`CreateEulerEq`retc[ComputationalEngine`CreateEulerEq`t + 1], ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`model],
		ComputationalEngine`CreateEulerEq`eulereq[ComputationalEngine`CreateEulerEq`ret[ComputationalEngine`CreateEulerEq`t + 1, ComputationalEngine`CreateEulerEq`j], ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`model],
		ComputationalEngine`CreateEulerEq`eulereq[ComputationalEngine`CreateEulerEq`bondret[ComputationalEngine`CreateEulerEq`t + 1, ComputationalEngine`CreateEulerEq`m], ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`model],
		ComputationalEngine`CreateEulerEq`nomeulereq[ComputationalEngine`CreateEulerEq`nombondret[ComputationalEngine`CreateEulerEq`t + 1, ComputationalEngine`CreateEulerEq`m], ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`model]
	};
	ComputationalEngine`CreateEulerEq`eeAll = Map[ComputationalEngine`CreateEulerEq`ee, ComputationalEngine`CreateEulerEq`mods];
	ComputationalEngine`CreateEulerEq`coeffWc[ComputationalEngine`CreateEulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc @ ComputationalEngine`CreateEulerEq`i, {ComputationalEngine`CreateEulerEq`i, Length @ ComputationalEngine`CreateEulerEq`model["stateVars"][ComputationalEngine`CreateEulerEq`t]}];
	ComputationalEngine`CreateEulerEq`coeffPd[ComputationalEngine`CreateEulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd @ ComputationalEngine`CreateEulerEq`i, {ComputationalEngine`CreateEulerEq`i, Length @ ComputationalEngine`CreateEulerEq`model["stateVars"][ComputationalEngine`CreateEulerEq`t]}];
	ComputationalEngine`CreateEulerEq`coeffBond[ComputationalEngine`CreateEulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb @ ComputationalEngine`CreateEulerEq`i, {ComputationalEngine`CreateEulerEq`i, Length @ ComputationalEngine`CreateEulerEq`model["stateVars"][ComputationalEngine`CreateEulerEq`t]}];
	ComputationalEngine`CreateEulerEq`coeffNomBond[ComputationalEngine`CreateEulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb @ ComputationalEngine`CreateEulerEq`i, {ComputationalEngine`CreateEulerEq`i, Length @ ComputationalEngine`CreateEulerEq`model["stateVars"][ComputationalEngine`CreateEulerEq`t]}];
	ComputationalEngine`CreateEulerEq`coeffWcAll = Map[ComputationalEngine`CreateEulerEq`coeffWc, ComputationalEngine`CreateEulerEq`mods];
	ComputationalEngine`CreateEulerEq`coeffPdAll = Map[ComputationalEngine`CreateEulerEq`coeffPd, ComputationalEngine`CreateEulerEq`mods];
	ComputationalEngine`CreateEulerEq`coeffBondAll = Map[ComputationalEngine`CreateEulerEq`coeffBond, ComputationalEngine`CreateEulerEq`mods];
	ComputationalEngine`CreateEulerEq`coeffNomBondAll = Map[ComputationalEngine`CreateEulerEq`coeffNomBond, ComputationalEngine`CreateEulerEq`mods];
	True
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20231008-MRNHKS"
]
VerificationTest[
	!SameQ[Names @ "*eulereq", {}]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20231008-4LOX3D"
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
											Cases[ComputationalEngine`CreateEulerEq`modBY["stateVars"][ComputationalEngine`CreateEulerEq`t], Blank[Symbol][ComputationalEngine`CreateEulerEq`t] ^ Optional[ComputationalEngine`CreateEulerEq`p_], Infinity]
										]
									]
								]
							],
							1
						]
					],
					ComputationalEngine`CreateEulerEq`ee @ ComputationalEngine`CreateEulerEq`modBY
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
												ComputationalEngine`CreateEulerEq`modNRC["stateVars"][ComputationalEngine`CreateEulerEq`t],
												Blank[Symbol][ComputationalEngine`CreateEulerEq`t] ^ Optional[ComputationalEngine`CreateEulerEq`p_],
												Infinity
											]
										]
									]
								]
							],
							1
						]
					],
					ComputationalEngine`CreateEulerEq`ee @ ComputationalEngine`CreateEulerEq`modNRC
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
												ComputationalEngine`CreateEulerEq`modDES["stateVars"][ComputationalEngine`CreateEulerEq`t],
												Blank[Symbol][ComputationalEngine`CreateEulerEq`t] ^ Optional[ComputationalEngine`CreateEulerEq`p_],
												Infinity
											]
										]
									]
								]
							],
							1
						]
					],
					ComputationalEngine`CreateEulerEq`ee @ ComputationalEngine`CreateEulerEq`modDES
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20231008-D6WOT2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[ComputationalEngine`CreateEulerEq`eeAll[[1;;, 1]], ComputationalEngine`CreateEulerEq`n], #]
							]
						],
						ComputationalEngine`CreateEulerEq`coeffWcAll[[ComputationalEngine`CreateEulerEq`n]]
					],
					{ComputationalEngine`CreateEulerEq`n, 1, Length @ ComputationalEngine`CreateEulerEq`mods}
				],
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[ComputationalEngine`CreateEulerEq`eeAll[[1;;, 2]], ComputationalEngine`CreateEulerEq`n], #]
							]
						],
						ComputationalEngine`CreateEulerEq`coeffPdAll[[ComputationalEngine`CreateEulerEq`n]]
					],
					{ComputationalEngine`CreateEulerEq`n, 1, Length @ ComputationalEngine`CreateEulerEq`mods}
				],
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[ComputationalEngine`CreateEulerEq`eeAll[[1;;, 3]], ComputationalEngine`CreateEulerEq`n], #]
							]
						],
						ComputationalEngine`CreateEulerEq`coeffBondAll[[ComputationalEngine`CreateEulerEq`n]]
					],
					{ComputationalEngine`CreateEulerEq`n, 1, Length @ ComputationalEngine`CreateEulerEq`mods}
				],
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[ComputationalEngine`CreateEulerEq`eeAll[[1;;, 4]], ComputationalEngine`CreateEulerEq`n], #]
							]
						],
						ComputationalEngine`CreateEulerEq`coeffNomBondAll[[ComputationalEngine`CreateEulerEq`n]]
					],
					{ComputationalEngine`CreateEulerEq`n, 1, Length @ ComputationalEngine`CreateEulerEq`mods}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20231008-89IR3Z"
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
									First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`retc @ ComputationalEngine`CreateEulerEq`t, #],
									Equal[0, ComputationalEngine`CreateEulerEq`x__] :> True
								],
								True
							],
							Length[#["stateVars"][ComputationalEngine`CreateEulerEq`t]] + 1
						]
					],
					ComputationalEngine`CreateEulerEq`mods
				],
				Map[
					Function[
						SameQ[
							Count[
								Cases[
									First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`ret[ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`j], #],
									Equal[0, ComputationalEngine`CreateEulerEq`x__] :> True
								],
								True
							],
							Length[#["stateVars"][ComputationalEngine`CreateEulerEq`t]] + 1
						]
					],
					ComputationalEngine`CreateEulerEq`mods
				],
				Map[
					Function[
						SameQ[
							Count[
								Cases[
									First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`bondret[ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`m], #],
									Equal[0, ComputationalEngine`CreateEulerEq`x__] :> True
								],
								True
							],
							Length[#["stateVars"][ComputationalEngine`CreateEulerEq`t]] + 1
						]
					],
					ComputationalEngine`CreateEulerEq`mods
				],
				Map[
					Function[
						SameQ[
							Count[
								Cases[
									First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`nombondret[ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`m], #, True],
									Equal[0, ComputationalEngine`CreateEulerEq`x__] :> True
								],
								True
							],
							Length[#["stateVars"][ComputationalEngine`CreateEulerEq`t]] + 1
						]
					],
					ComputationalEngine`CreateEulerEq`mods
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20231008-VLE90A"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				Map[Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`retc @ ComputationalEngine`CreateEulerEq`t, #], ComputationalEngine`CreateEulerEq`t], ComputationalEngine`CreateEulerEq`mods],
				Map[Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`ret[ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`j], #], ComputationalEngine`CreateEulerEq`t],
					ComputationalEngine`CreateEulerEq`mods
				],
				Map[
					Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`bondret[ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`m], #], ComputationalEngine`CreateEulerEq`t],
					ComputationalEngine`CreateEulerEq`mods
				],
				Map[
					Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`nombondret[ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`m], #, True], ComputationalEngine`CreateEulerEq`t],
					ComputationalEngine`CreateEulerEq`mods
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20231008-DDMBT2"
]
VerificationTest[
	Apply[And,
		Flatten[
			{
				SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`retc[ComputationalEngine`CreateEulerEq`t], #]&, ComputationalEngine`CreateEulerEq`mods],
					Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`retc[ComputationalEngine`CreateEulerEq`t + 1], #]], ComputationalEngine`CreateEulerEq`mods]
				],
				SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`ret[ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`j], #]&, ComputationalEngine`CreateEulerEq`mods],
					Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`ret[ComputationalEngine`CreateEulerEq`t + 1, ComputationalEngine`CreateEulerEq`j], #]], ComputationalEngine`CreateEulerEq`mods]
				],
				SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`bondret[ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`m], #]&, ComputationalEngine`CreateEulerEq`mods],
					Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`bondret[ComputationalEngine`CreateEulerEq`t + 1, ComputationalEngine`CreateEulerEq`m], #]], ComputationalEngine`CreateEulerEq`mods]
				],
				SameQ[
					Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`nombondret[ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`m], #, True]&, ComputationalEngine`CreateEulerEq`mods],
					Map[
						Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`nombondret[ComputationalEngine`CreateEulerEq`t + 1, ComputationalEngine`CreateEulerEq`m], #, True]],
						ComputationalEngine`CreateEulerEq`mods
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
	TestID->"CreateEulerEq_20231008-20RNSI"
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
									Part[Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`retc @ ComputationalEngine`CreateEulerEq`t, #], 1;;, 0]
								],
								ComputationalEngine`CreateEulerEq`mods
							]
						]
					],
					Map[Function @ Context @ Evaluate @ #,
						Flatten[
							Map[
								Function[
									Part[Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`ret[ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`j], #], 1;;, 0, 0]
								],
								ComputationalEngine`CreateEulerEq`mods
							]
						]
					],
					Map[Function @ Context @ Evaluate @ #,
						Flatten[
							Map[
								Function[
									Part[
										Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`bondret[ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`m], #],
										1;;, 0, 0
									]
								],
								ComputationalEngine`CreateEulerEq`mods
							]
						]
					],
					Map[Function @ Context @ Evaluate @ #,
						Flatten[
							Map[
								Function[
									Part[
										Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`nombondret[ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`m], #, True],
										1;;, 0, 0
									]
								],
								ComputationalEngine`CreateEulerEq`mods
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
	TestID->"CreateEulerEq_20231008-RYRH7S"
]
VerificationTest[
	ComputationalEngine`CreateEulerEq`checkBoolean[ComputationalEngine`CreateEulerEq`model_] := Module[
		{ComputationalEngine`CreateEulerEq`e0, ComputationalEngine`CreateEulerEq`e1, ComputationalEngine`CreateEulerEq`e2, ComputationalEngine`CreateEulerEq`e3, ComputationalEngine`CreateEulerEq`e0p, ComputationalEngine`CreateEulerEq`e1p, ComputationalEngine`CreateEulerEq`e2p, ComputationalEngine`CreateEulerEq`e3p},
		ComputationalEngine`CreateEulerEq`e0 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`retc @ ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`model];
		ComputationalEngine`CreateEulerEq`e1 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`ret[ComputationalEngine`CreateEulerEq`t, 1], ComputationalEngine`CreateEulerEq`model];
		ComputationalEngine`CreateEulerEq`e2 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`bondret[ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`m], ComputationalEngine`CreateEulerEq`model];
		ComputationalEngine`CreateEulerEq`e3 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[ComputationalEngine`CreateEulerEq`nombondret[ComputationalEngine`CreateEulerEq`t, ComputationalEngine`CreateEulerEq`m], ComputationalEngine`CreateEulerEq`model, True];
		ComputationalEngine`CreateEulerEq`e0p = Flatten[
			{
				Normal @ ComputationalEngine`CreateEulerEq`model @ "parameters",
				Thread[Part[ComputationalEngine`CreateEulerEq`e0, 2] -> 4],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc -> 4
			}
		];
		ComputationalEngine`CreateEulerEq`e1p = Flatten[{ComputationalEngine`CreateEulerEq`e0p, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[_] -> 4, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[_] -> 4}];
		ComputationalEngine`CreateEulerEq`e2p = Flatten[{ComputationalEngine`CreateEulerEq`e0p, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[ComputationalEngine`CreateEulerEq`m_] -> 4}];
		ComputationalEngine`CreateEulerEq`e3p = Flatten[{ComputationalEngine`CreateEulerEq`e0p, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[ComputationalEngine`CreateEulerEq`m_] -> 4}];
		{
			Part[ComputationalEngine`CreateEulerEq`e0, 1] /. ComputationalEngine`CreateEulerEq`e0p,
			Part[ComputationalEngine`CreateEulerEq`e1, 1] /. ComputationalEngine`CreateEulerEq`e1p,
			Part[ComputationalEngine`CreateEulerEq`e2, 1] /. ComputationalEngine`CreateEulerEq`e2p,
			Part[ComputationalEngine`CreateEulerEq`e3, 1] /. ComputationalEngine`CreateEulerEq`e3p
		}
	];
	Apply[And, Map[BooleanQ, Flatten @ ComputationalEngine`CreateEulerEq`checkBoolean @ ComputationalEngine`CreateEulerEq`modBY]]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20231008-6D1Q66"
] 
End[]
EndTestSection[]
