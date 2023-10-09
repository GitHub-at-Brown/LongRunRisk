BeginTestSection["ComputeUnconditionalExpectations"] 
Begin["ComputationalEngine`Uncond`"]
VerificationTest[
	ComputationalEngine`Uncond`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20231009-DGPUWV"
]
VerificationTest[
	Needs @ "PacletizedResourceFunctions`";
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20231009-IPY7CS"
]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`";
	$ContextAliases["ce`"] = "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`";
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20231009-NKUGMU"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"]
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20231009-QDSLFW"
]
VerificationTest[
	!SameQ[Names @ "*uncondE", {}]
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20231009-0QCCUR"
]
VerificationTest[
	Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
	ComputationalEngine`Uncond`msp = FernandoDuarte`LongRunRisk`Models;
	ComputationalEngine`Uncond`modBY = ComputationalEngine`Uncond`msp @ "BY";
	ComputationalEngine`Uncond`modNRC = ComputationalEngine`Uncond`msp @ "NRC";
	ComputationalEngine`Uncond`createSystem = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`createSystem;
	ComputationalEngine`Uncond`evNoEpsStateVarsProduct = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`evNoEpsStateVarsProduct;
	ComputationalEngine`Uncond`uncondEStep = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`uncondEStep;
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20231009-7P4OS1"
]
VerificationTest[
	If[ComputationalEngine`Uncond`longTest,
		{ComputationalEngine`Uncond`nameRules1, ComputationalEngine`Uncond`system1, ComputationalEngine`Uncond`unknowns1} = ComputationalEngine`Uncond`createSystem[1, ComputationalEngine`Uncond`modNRC];
		{ComputationalEngine`Uncond`nameRules2, ComputationalEngine`Uncond`system2, ComputationalEngine`Uncond`unknowns2} = ComputationalEngine`Uncond`createSystem[2, ComputationalEngine`Uncond`modNRC];
		{ComputationalEngine`Uncond`nameRules3, ComputationalEngine`Uncond`system3, ComputationalEngine`Uncond`unknowns3} = ComputationalEngine`Uncond`createSystem[3, ComputationalEngine`Uncond`modNRC];
		{ComputationalEngine`Uncond`nameRules4, ComputationalEngine`Uncond`system4, ComputationalEngine`Uncond`unknowns4} = ComputationalEngine`Uncond`createSystem[4, ComputationalEngine`Uncond`modNRC];
		ComputationalEngine`Uncond`sol1 = Flatten @ Solve[ComputationalEngine`Uncond`system1, ComputationalEngine`Uncond`unknowns1];
		ComputationalEngine`Uncond`sol2 = Flatten @ Solve[ComputationalEngine`Uncond`system2, ComputationalEngine`Uncond`unknowns2];
		ComputationalEngine`Uncond`sol3 = Flatten @ Solve[ComputationalEngine`Uncond`system3, ComputationalEngine`Uncond`unknowns3];
		ComputationalEngine`Uncond`sol4 = Flatten @ Solve[ComputationalEngine`Uncond`system4, ComputationalEngine`Uncond`unknowns4];
		Apply[And,
			{
				Apply[And,
					{
						!SameQ[ComputationalEngine`Uncond`nameRules1, $Failed],
						!SameQ[ComputationalEngine`Uncond`system1, $Failed],
						!SameQ[ComputationalEngine`Uncond`unknowns1, $Failed]
					}
				],
				Apply[And,
					{
						!SameQ[ComputationalEngine`Uncond`nameRules2, $Failed],
						!SameQ[ComputationalEngine`Uncond`system2, $Failed],
						!SameQ[ComputationalEngine`Uncond`unknowns2, $Failed]
					}
				],
				Apply[And,
					{
						!SameQ[ComputationalEngine`Uncond`nameRules3, $Failed],
						!SameQ[ComputationalEngine`Uncond`system3, $Failed],
						!SameQ[ComputationalEngine`Uncond`unknowns3, $Failed]
					}
				],
				Apply[And,
					{
						!SameQ[ComputationalEngine`Uncond`nameRules4, $Failed],
						!SameQ[ComputationalEngine`Uncond`system4, $Failed],
						!SameQ[ComputationalEngine`Uncond`unknowns4, $Failed]
					}
				],
				Apply[And,
					{
						!SameQ[ComputationalEngine`Uncond`sol1, {}],
						!SameQ[ComputationalEngine`Uncond`sol2, {}],
						!SameQ[ComputationalEngine`Uncond`sol3, {}],
						!SameQ[ComputationalEngine`Uncond`sol4, {}]
					}
				],
				Apply[And,
					{
						Apply[MatchQ, Intersection[ComputationalEngine`Uncond`unknowns1, ComputationalEngine`Uncond`unknowns3] /. {ComputationalEngine`Uncond`sol1, ComputationalEngine`Uncond`sol3}],
						Apply[MatchQ, Intersection[ComputationalEngine`Uncond`unknowns2, ComputationalEngine`Uncond`unknowns3] /. {ComputationalEngine`Uncond`sol2, ComputationalEngine`Uncond`sol3}],
						Apply[MatchQ, Intersection[ComputationalEngine`Uncond`unknowns1, ComputationalEngine`Uncond`unknowns4] /. {ComputationalEngine`Uncond`sol1, ComputationalEngine`Uncond`sol4}],
						Apply[MatchQ, Intersection[ComputationalEngine`Uncond`unknowns2, ComputationalEngine`Uncond`unknowns4] /. {ComputationalEngine`Uncond`sol2, ComputationalEngine`Uncond`sol4}],
						Apply[MatchQ, Intersection[ComputationalEngine`Uncond`unknowns3, ComputationalEngine`Uncond`unknowns4] /. {ComputationalEngine`Uncond`sol3, ComputationalEngine`Uncond`sol4}]
					}
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
	TestID->"ComputeUnconditionalExpectations_20231009-G2EFO6"
]
VerificationTest[
	If[ComputationalEngine`Uncond`longTest,
		Apply[And,
			{
				SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`pi1 /. ComputationalEngine`Uncond`sol1, FernandoDuarte`LongRunRisk`Model`Parameters`mup],
				SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`sg1 /. ComputationalEngine`Uncond`sol1, FernandoDuarte`LongRunRisk`Model`Parameters`Esg],
				SameQ[FullSimplify[ExpandAll[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`pi2 /. ComputationalEngine`Uncond`sol2]],
					FullSimplify[
						ExpandAll[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup ^ 2,
								Divide[
									(FernandoDuarte`LongRunRisk`Model`Parameters`xip ^ 2) + (2 * FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Parameters`phip) + FernandoDuarte`LongRunRisk`Model`Parameters`phip ^ 2,
									1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2
								]
							]
						]
					]
				],
				SameQ[Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`sg2 /. ComputationalEngine`Uncond`sol2],
					Simplify[
						(FernandoDuarte`LongRunRisk`Model`Parameters`Esg ^ 2) + (FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) / (1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2)
					]
				],
				SameQ[Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`pi1sg1 /. ComputationalEngine`Uncond`sol2], Simplify[FernandoDuarte`LongRunRisk`Model`Parameters`Esg * FernandoDuarte`LongRunRisk`Model`Parameters`mup]]
			}
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20231009-KSU86I"
]
VerificationTest[
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`pi @ ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`modNRC], FernandoDuarte`LongRunRisk`Model`Parameters`mup],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`sg @ ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`modNRC], FernandoDuarte`LongRunRisk`Model`Parameters`Esg],
			SameQ[FullSimplify[ExpandAll[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] ^ 2, ComputationalEngine`Uncond`modNRC]]],
				FullSimplify[
					ExpandAll[
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup ^ 2,
							Divide[
								(FernandoDuarte`LongRunRisk`Model`Parameters`xip ^ 2) + (2 * FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Parameters`phip) + FernandoDuarte`LongRunRisk`Model`Parameters`phip ^ 2,
								1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2
							]
						]
					]
				]
			],
			SameQ[Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t] ^ 2, ComputationalEngine`Uncond`modNRC]],
				Simplify[
					(FernandoDuarte`LongRunRisk`Model`Parameters`Esg ^ 2) + (FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) / (1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2)
				]
			],
			SameQ[Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`modNRC]], Simplify[FernandoDuarte`LongRunRisk`Model`Parameters`Esg * FernandoDuarte`LongRunRisk`Model`Parameters`mup]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20231009-DNRBU1"
]
VerificationTest[
	If[ComputationalEngine`Uncond`longTest,
		Apply[And,
			{
				Apply[And, Map[NumberQ, Values[ComputationalEngine`Uncond`sol1] //. ComputationalEngine`Uncond`modNRC["parameters"]]],
				Apply[And, Map[NumberQ, Values[ComputationalEngine`Uncond`sol2] //. ComputationalEngine`Uncond`modNRC["parameters"]]],
				Apply[And, Map[NumberQ, Values[ComputationalEngine`Uncond`sol3] //. ComputationalEngine`Uncond`modNRC["parameters"]]],
				Apply[And, Map[NumberQ, Values[ComputationalEngine`Uncond`sol4] //. ComputationalEngine`Uncond`modNRC["parameters"]]]
			}
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20231009-IK5FRD"
]
VerificationTest[
	ComputationalEngine`Uncond`stateVarsNoEps = {ComputationalEngine`Uncond`sg, ComputationalEngine`Uncond`pi};
	ComputationalEngine`Uncond`model = ComputationalEngine`Uncond`modNRC;
	Apply[And,
		{
			SameQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps],
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps]
			],
			SameQ[ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi @ ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps],
				FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ ComputationalEngine`Uncond`t
			],
			SameQ[ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps],
				FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Uncond`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[ComputationalEngine`Uncond`t]
			],
			SameQ[
				ExpandAll[
					ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps]
				],
				ExpandAll[
					Subtract[
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`Esg * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Uncond`t - 1],
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhog * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Uncond`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[ComputationalEngine`Uncond`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phig * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Uncond`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][ComputationalEngine`Uncond`t]
						],
						FernandoDuarte`LongRunRisk`Model`Parameters`Esg * FernandoDuarte`LongRunRisk`Model`Parameters`rhog * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Uncond`t - 1]
					]
				]
			],
			SameQ[
				ExpandAll[
					ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps]
				],
				ExpandAll[
					Subtract[
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t],
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Uncond`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t],
								(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t] ^ 2
							]
						],
						FernandoDuarte`LongRunRisk`Model`Parameters`mup * FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t]
					]
				]
			],
			SameQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t + 1], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps],
				FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Uncond`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][1 + ComputationalEngine`Uncond`t]
			],
			SameQ[
				ExpandAll[
					ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`dd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps]
				],
				ExpandAll[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t]]
			],
			SameQ[
				ExpandAll[
					ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`dd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i], ComputationalEngine`Uncond`model, Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`dd]]
				],
				ExpandAll[
					Subtract[
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mud[ComputationalEngine`Uncond`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t],
							Plus[
								FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Uncond`t - 1] * FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[ComputationalEngine`Uncond`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t],
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`phidc[ComputationalEngine`Uncond`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][ComputationalEngine`Uncond`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t],
									FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[ComputationalEngine`Uncond`t - 2] * FernandoDuarte`LongRunRisk`Model`Parameters`xid[ComputationalEngine`Uncond`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t]
								]
							]
						],
						FernandoDuarte`LongRunRisk`Model`Parameters`mup * FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[ComputationalEngine`Uncond`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t]
					]
				]
			],
			SameQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps],
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps]
			],
			SameQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t - 1], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps],
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20231009-V71CVX"
]
VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
					DeleteDuplicates[
						Cases[
							ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
								ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`dd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1],
								ComputationalEngine`Uncond`model,
								Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`dd]
							],
							RuleDelayed[
								PatternTest[ComputationalEngine`Uncond`x_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__, ___],
								Context @ ComputationalEngine`Uncond`x
							],
							Infinity
						]
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
					DeleteDuplicates[
						Cases[
							ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
								Times[
									ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1],
									ComputationalEngine`Uncond`dd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1]
								],
								ComputationalEngine`Uncond`model,
								Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`dd]
							],
							RuleDelayed[
								PatternTest[ComputationalEngine`Uncond`x_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__, ___],
								Context @ ComputationalEngine`Uncond`x
							],
							Infinity
						]
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
					DeleteDuplicates[
						Cases[
							ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
								ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`dd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1],
								ComputationalEngine`Uncond`model,
								Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`dd]
							],
							RuleDelayed[
								PatternTest[ComputationalEngine`Uncond`x_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__, ___],
								Context @ ComputationalEngine`Uncond`x
							],
							Infinity
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
	TestID->"ComputeUnconditionalExpectations_20231009-H6QK1J"
]
VerificationTest[
	Apply[And,
		{
			SameQ[{},
				Cases[
					ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t - 1], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps],
					PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "pi"]][ComputationalEngine`Uncond`t],
					Infinity
				]
			],
			Not[
				SameQ[{},
					Cases[
						ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t - 1], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps],
						PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "sg"]][ComputationalEngine`Uncond`t - 1],
						Infinity
					]
				]
			],
			SameQ[{},
				Cases[
					ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
						(ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t - 1]) + ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t],
						ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps
					],
					PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "pi"]][ComputationalEngine`Uncond`t],
					Infinity
				]
			],
			SameQ[{},
				Cases[
					ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
						(ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t - 1]) + ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t],
						ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps
					],
					PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "sg"]][ComputationalEngine`Uncond`t],
					Infinity
				]
			],
			Not[
				SameQ[{},
					Cases[
						ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
							(ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t - 1]) + ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t],
							ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps
						],
						PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "pi"]][ComputationalEngine`Uncond`t - 1],
						Infinity
					]
				]
			],
			Not[
				SameQ[{},
					Cases[
						ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
							(ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t - 1]) + ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t],
							ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps
						],
						PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "sg"]][ComputationalEngine`Uncond`t - 1],
						Infinity
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
	TestID->"ComputeUnconditionalExpectations_20231009-WS3A6I"
]
VerificationTest[
	Apply[And,
		{
			SameQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`foo[ComputationalEngine`Uncond`t - 1], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps],
				FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`foo[ComputationalEngine`Uncond`t - 1]
			],
			SameQ[
				ExpandAll[
					ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
						ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t + 1] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t],
						ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps
					]
				],
				ExpandAll[
					Times[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t + 1],
						ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps]
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
	TestID->"ComputeUnconditionalExpectations_20231009-MQBJ7D"
]
VerificationTest[
	Apply[And,
		{
			SameQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1],
					ComputationalEngine`Uncond`model,
					Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`myVariable]
				],
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`model, Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`dd]]
			],
			SameQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi @ ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`model, Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`irrelevantVar]],
				FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ ComputationalEngine`Uncond`t
			],
			SameQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`anotherIrrelevantVar * ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t],
					ComputationalEngine`Uncond`model,
					Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`anotherIrrelevantVar]
				],
				ComputationalEngine`Uncond`anotherIrrelevantVar * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Uncond`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[ComputationalEngine`Uncond`t]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20231009-P14MXG"
]
VerificationTest[
	Apply[And,
		{
			FreeQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`dd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i], ComputationalEngine`Uncond`model, Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`dd]],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "dd"]][ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i]
			],
			FreeQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`dd[ComputationalEngine`Uncond`t - 1, ComputationalEngine`Uncond`i], ComputationalEngine`Uncond`model, Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`dd]],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "pi"]][ComputationalEngine`Uncond`t]
			],
			FreeQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`dd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1],
					ComputationalEngine`Uncond`model,
					Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`dd]
				],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "dd"]][ComputationalEngine`Uncond`t - 1, ComputationalEngine`Uncond`i]
			],
			Not[
				FreeQ[
					ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
						ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`dd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1],
						ComputationalEngine`Uncond`model,
						Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`dd]
					],
					PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "eps"]]["pi"][ComputationalEngine`Uncond`t - 1]
				]
			],
			FreeQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`dd[ComputationalEngine`Uncond`t - 1, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1],
					ComputationalEngine`Uncond`model,
					Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`dd]
				],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "pi"]][ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i]
			],
			FreeQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
					ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`dd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["dd"][ComputationalEngine`Uncond`t - 1, ComputationalEngine`Uncond`i],
					ComputationalEngine`Uncond`model,
					Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`dd]
				],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "dd"]][ComputationalEngine`Uncond`t - 1, ComputationalEngine`Uncond`i]
			],
			Not[
				FreeQ[
					ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
						ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`dd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["dd"][ComputationalEngine`Uncond`t - 1, ComputationalEngine`Uncond`i],
						ComputationalEngine`Uncond`model,
						Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`dd]
					],
					PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "eps"]]["dd"][ComputationalEngine`Uncond`t - 1, ComputationalEngine`Uncond`i]
				]
			],
			FreeQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
					Times[ComputationalEngine`Uncond`pi @ ComputationalEngine`Uncond`t,
						ComputationalEngine`Uncond`dd[ComputationalEngine`Uncond`t - 1, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["dd"][ComputationalEngine`Uncond`t - 1, ComputationalEngine`Uncond`i]
					],
					ComputationalEngine`Uncond`model,
					Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`dd]
				],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "pi"]][ComputationalEngine`Uncond`t]
			],
			Not[
				FreeQ[
					ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
						Times[ComputationalEngine`Uncond`pi @ ComputationalEngine`Uncond`t,
							ComputationalEngine`Uncond`dd[ComputationalEngine`Uncond`t - 1, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["dd"][ComputationalEngine`Uncond`t - 1, ComputationalEngine`Uncond`i]
						],
						ComputationalEngine`Uncond`model,
						Append[ComputationalEngine`Uncond`stateVarsNoEps, ComputationalEngine`Uncond`dd]
					],
					PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "pi"]][_]
				]
			],
			FreeQ[ComputationalEngine`Uncond`uncondEStep[ComputationalEngine`Uncond`dc[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`modNRC],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "dc"]],
				Infinity
			],
			FreeQ[ComputationalEngine`Uncond`uncondEStep[ComputationalEngine`Uncond`dc[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`modNRC],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "pi"]][ComputationalEngine`Uncond`t],
				Infinity
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20231009-734G39"
]
VerificationTest[
	Apply[And,
		{
			SameQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`wc[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc[ComputationalEngine`Uncond`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t - 1]
			],
			SameQ[
				Coefficient[
					ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`wc[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`model, {ComputationalEngine`Uncond`wc}],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Uncond`t - 1]
				],
				FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t]
			],
			SameQ[
				DeleteDuplicates[
					Cases[
						ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`A[0] * ComputationalEngine`Uncond`wc[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps],
						RuleDelayed[
							PatternTest[ComputationalEngine`Uncond`x_Symbol, Function[MatchQ[SymbolName[#], "A"]]][_],
							Context @ ComputationalEngine`Uncond`x
						],
						Infinity
					]
				],
				{"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"}
			],
			SameQ[
				DeleteDuplicates[
					Cases[
						ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`A[0] * ComputationalEngine`Uncond`wc[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1],
							ComputationalEngine`Uncond`model, {ComputationalEngine`Uncond`wc}
						],
						RuleDelayed[
							PatternTest[ComputationalEngine`Uncond`x_Symbol, Function[MatchQ[SymbolName[#], "A"]]][_],
							Context @ ComputationalEngine`Uncond`x
						],
						Infinity
					]
				],
				{"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"}
			],
			SameQ[
				ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1], ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`pd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t - 1]
			],
			SameQ[
				Coefficient[
					ComputationalEngine`Uncond`evNoEpsStateVarsProduct[ComputationalEngine`Uncond`pd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`model, {ComputationalEngine`Uncond`pd}],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Uncond`t - 1]
				],
				FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[ComputationalEngine`Uncond`i][1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Uncond`t]
			],
			SameQ[
				DeleteDuplicates[
					Cases[
						ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
							Times[
								ComputationalEngine`Uncond`A @ 0,
								ComputationalEngine`Uncond`B[ComputationalEngine`Uncond`i][1] * ComputationalEngine`Uncond`pd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1]
							],
							ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps
						],
						RuleDelayed[
							PatternTest[ComputationalEngine`Uncond`x_Symbol, Function[MatchQ[SymbolName[#], "A"]]][_],
							Context @ ComputationalEngine`Uncond`x
						],
						Infinity
					]
				],
				{"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"}
			],
			SameQ[
				DeleteDuplicates[
					Cases[
						ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
							Times[
								ComputationalEngine`Uncond`A @ 0,
								ComputationalEngine`Uncond`B[ComputationalEngine`Uncond`i][1] * ComputationalEngine`Uncond`pd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1]
							],
							ComputationalEngine`Uncond`model, ComputationalEngine`Uncond`stateVarsNoEps
						],
						RuleDelayed[
							PatternTest[ComputationalEngine`Uncond`x_Symbol, Function[MatchQ[SymbolName[#], "B"]]][_][_],
							Context @ ComputationalEngine`Uncond`x
						],
						Infinity
					]
				],
				{"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"}
			],
			SameQ[
				DeleteDuplicates[
					Cases[
						ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
							Times[
								ComputationalEngine`Uncond`A @ 0,
								ComputationalEngine`Uncond`B[ComputationalEngine`Uncond`i][1] * ComputationalEngine`Uncond`pd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1]
							],
							ComputationalEngine`Uncond`model, {ComputationalEngine`Uncond`pd}
						],
						RuleDelayed[
							PatternTest[ComputationalEngine`Uncond`x_Symbol, Function[MatchQ[SymbolName[#], "A"]]][_],
							Context @ ComputationalEngine`Uncond`x
						],
						Infinity
					]
				],
				{"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"}
			],
			SameQ[
				DeleteDuplicates[
					Cases[
						ComputationalEngine`Uncond`evNoEpsStateVarsProduct[
							Times[
								ComputationalEngine`Uncond`A @ 0,
								ComputationalEngine`Uncond`B[ComputationalEngine`Uncond`i][1] * ComputationalEngine`Uncond`pd[ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`i] * ComputationalEngine`Uncond`eps["pi"][ComputationalEngine`Uncond`t - 1]
							],
							ComputationalEngine`Uncond`model, {ComputationalEngine`Uncond`pd}
						],
						RuleDelayed[
							PatternTest[ComputationalEngine`Uncond`x_Symbol, Function[MatchQ[SymbolName[#], "B"]]][_][_],
							Context @ ComputationalEngine`Uncond`x
						],
						Infinity
					]
				],
				{"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"}
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20231009-TY51RS"
]
VerificationTest[
	If[ComputationalEngine`Uncond`longTest,
		Apply[And,
			{
				SameQ[Simplify @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`wc @ ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`modNRC], FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0],
				SameQ[Simplify @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`wc @ ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`modBY], FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0],
				SameQ[0,
					Simplify[
						Subtract[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] ^ 3, ComputationalEngine`Uncond`modNRC] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`modNRC],
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[(ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] ^ 3) * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`modNRC]
						]
					]
				],
				SameQ[0,
					Simplify[
						Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[(ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] ^ 3) * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`modNRC],
							Times[
								FernandoDuarte`LongRunRisk`Model`Parameters`Esg,
								Times[
									FernandoDuarte`LongRunRisk`Model`Parameters`mup,
									Subtract[
										FernandoDuarte`LongRunRisk`Model`Parameters`mup ^ 2,
										Divide[
											Times[
												3,
												(FernandoDuarte`LongRunRisk`Model`Parameters`phip ^ 2) + (2 * FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip) + FernandoDuarte`LongRunRisk`Model`Parameters`xip ^ 2
											],
											(FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) - 1
										]
									]
								]
							]
						]
					]
				],
				SameQ[Simplify @ PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`dc @ ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`modNRC], ComputationalEngine`Uncond`muc],
				SameQ[
					FullSimplify[Expand[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`dc[ComputationalEngine`Uncond`t] ^ 2, ComputationalEngine`Uncond`modNRC]]]],
					FullSimplify[
						Expand[
							Plus[
								ComputationalEngine`Uncond`muc ^ 2,
								Plus[
									ComputationalEngine`Uncond`phic ^ 2,
									Plus[
										2 * ComputationalEngine`Uncond`Esg * ComputationalEngine`Uncond`phip * ComputationalEngine`Uncond`rhocp * ComputationalEngine`Uncond`xic,
										Plus[
											Times[
												ComputationalEngine`Uncond`xic ^ 2,
												(ComputationalEngine`Uncond`Esg ^ 2) + (ComputationalEngine`Uncond`phig ^ 2) / (1 - ComputationalEngine`Uncond`rhog ^ 2)
											],
											Divide[
												Times[
													ComputationalEngine`Uncond`rhocp ^ 2,
													(ComputationalEngine`Uncond`phip ^ 2) + (2 * ComputationalEngine`Uncond`phip * ComputationalEngine`Uncond`rhop * ComputationalEngine`Uncond`xip) + ComputationalEngine`Uncond`xip ^ 2
												],
												1 - ComputationalEngine`Uncond`rhop ^ 2
											]
										]
									]
								]
							]
						]
					]
				],
				SameQ[
					FullSimplify[Expand[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`dc[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`modNRC]]]],
					FullSimplify[
						Expand[
							Plus[
								ComputationalEngine`Uncond`muc * ComputationalEngine`Uncond`mup,
								Plus[
									ComputationalEngine`Uncond`rhocp * ComputationalEngine`Uncond`xip * ComputationalEngine`Uncond`phip,
									Plus[
										ComputationalEngine`Uncond`xic * ComputationalEngine`Uncond`rhop * ComputationalEngine`Uncond`phip * ComputationalEngine`Uncond`Esg,
										Plus[
											ComputationalEngine`Uncond`xic * ComputationalEngine`Uncond`xip * ComputationalEngine`Uncond`Esg,
											Divide[
												Times[
													ComputationalEngine`Uncond`rhocp * ComputationalEngine`Uncond`rhop,
													(ComputationalEngine`Uncond`xip ^ 2) + (2 * ComputationalEngine`Uncond`rhop * ComputationalEngine`Uncond`xip * ComputationalEngine`Uncond`phip) + ComputationalEngine`Uncond`phip ^ 2
												],
												1 - ComputationalEngine`Uncond`rhop ^ 2
											]
										]
									]
								]
							]
						]
					]
				],
				SameQ[
					FullSimplify[Expand[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`dc[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`modNRC]]]],
					FullSimplify[Expand[ComputationalEngine`Uncond`muc * ComputationalEngine`Uncond`Esg]]
				],
				SameQ[
					FullSimplify[
						Expand[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t + 1], ComputationalEngine`Uncond`modNRC]]]
					],
					FullSimplify[
						Expand[
							(ComputationalEngine`Uncond`Esg ^ 2) + (ComputationalEngine`Uncond`rhog / (1 - ComputationalEngine`Uncond`rhog ^ 2)) * ComputationalEngine`Uncond`phig ^ 2
						]
					]
				],
				SameQ[
					FullSimplify[
						Expand[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t - 1], ComputationalEngine`Uncond`modNRC]]]
					],
					FullSimplify[
						Expand[
							(ComputationalEngine`Uncond`Esg ^ 2) + (ComputationalEngine`Uncond`rhog / (1 - ComputationalEngine`Uncond`rhog ^ 2)) * ComputationalEngine`Uncond`phig ^ 2
						]
					]
				],
				SameQ[
					FullSimplify[
						Expand[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t + 1], ComputationalEngine`Uncond`modNRC]]]
					],
					FullSimplify[
						Expand[
							Plus[
								ComputationalEngine`Uncond`mup ^ 2,
								Plus[
									ComputationalEngine`Uncond`phip * ComputationalEngine`Uncond`xip,
									Divide[
										Times[
											ComputationalEngine`Uncond`rhop,
											(ComputationalEngine`Uncond`phip ^ 2) + (2 * ComputationalEngine`Uncond`rhop * ComputationalEngine`Uncond`xip * ComputationalEngine`Uncond`phip) + ComputationalEngine`Uncond`xip ^ 2
										],
										1 - ComputationalEngine`Uncond`rhop ^ 2
									]
								]
							]
						]
					]
				],
				SameQ[
					FullSimplify[
						Expand[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1], ComputationalEngine`Uncond`modNRC]]]
					],
					FullSimplify[
						Expand[
							Plus[
								ComputationalEngine`Uncond`mup ^ 2,
								Plus[
									ComputationalEngine`Uncond`phip * ComputationalEngine`Uncond`xip,
									Divide[
										Times[
											ComputationalEngine`Uncond`rhop,
											(ComputationalEngine`Uncond`phip ^ 2) + (2 * ComputationalEngine`Uncond`rhop * ComputationalEngine`Uncond`xip * ComputationalEngine`Uncond`phip) + ComputationalEngine`Uncond`xip ^ 2
										],
										1 - ComputationalEngine`Uncond`rhop ^ 2
									]
								]
							]
						]
					]
				],
				SameQ[
					FullSimplify[
						Expand[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t] * ComputationalEngine`Uncond`sg[ComputationalEngine`Uncond`t + 1], ComputationalEngine`Uncond`modNRC]]]
					],
					FullSimplify[Expand[ComputationalEngine`Uncond`Esg * ComputationalEngine`Uncond`mup]]
				],
				SameQ[
					FullSimplify[
						Expand[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`pi[ComputationalEngine`Uncond`t - 1] * ComputationalEngine`Uncond`dc[ComputationalEngine`Uncond`t], ComputationalEngine`Uncond`modNRC]]]
					],
					FullSimplify[
						Expand[
							Plus[
								ComputationalEngine`Uncond`muc * ComputationalEngine`Uncond`mup,
								Plus[
									ComputationalEngine`Uncond`Esg * ComputationalEngine`Uncond`phip * ComputationalEngine`Uncond`xic,
									Divide[
										Times[
											ComputationalEngine`Uncond`rhocp,
											(ComputationalEngine`Uncond`phip ^ 2) + (2 * ComputationalEngine`Uncond`phip * ComputationalEngine`Uncond`rhop * ComputationalEngine`Uncond`xip) + ComputationalEngine`Uncond`xip ^ 2
										],
										1 - ComputationalEngine`Uncond`rhop ^ 2
									]
								]
							]
						]
					]
				]
			}
		],
		Apply[And,
			{
				SameQ[Simplify @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`wc @ ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`modNRC], FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0],
				SameQ[Simplify @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[ComputationalEngine`Uncond`wc @ ComputationalEngine`Uncond`t, ComputationalEngine`Uncond`modBY], FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20231009-5WBQ1Q"
] 
End[]
EndTestSection[]
