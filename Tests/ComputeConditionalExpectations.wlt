BeginTestSection["ComputeConditionalExpectations"] 
Begin["ComputationalEngine`Cond`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`";
	Needs @ "PacletizedResourceFunctions`";
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231009-D0TBST"
]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`";
	$ContextAliases["ce`"] = "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`";
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231009-JWMJDA"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"]}]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231009-80KMEI"
]
VerificationTest[
	Apply[And,
		{
			!SameQ[Names @ "*ev", {}],
			!SameQ[Names @ "ce`lagStateVarst", {}]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231009-1QW6RG"
]
VerificationTest[
	Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
	ComputationalEngine`Cond`msp = FernandoDuarte`LongRunRisk`Models;
	ComputationalEngine`Cond`modBY = ComputationalEngine`Cond`msp @ "BY";
	ComputationalEngine`Cond`modNRC = ComputationalEngine`Cond`msp @ "NRC";
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231009-2MME05"
]
VerificationTest[
	SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
		FernandoDuarte`LongRunRisk`Model`Parameters`phip
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231009-WLC7ZF"
]
VerificationTest[
	Apply[And,
		{
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]
						],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
							],
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mud @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xid[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]
						],
						Plus[
							Times[
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`mud @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xid[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
								],
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`muc,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
								]
							],
							FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Parameters`phidc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[
								FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 3] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1],
								FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC
							]
						],
						Times[FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								Times[
									Plus[
										FernandoDuarte`LongRunRisk`Model`Parameters`mup,
										(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
									],
									Plus[
										FernandoDuarte`LongRunRisk`Model`Parameters`muc,
										(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
									]
								],
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`phip ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Plus[
							Times[
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`mup,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
								],
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`mup,
									((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
								]
							],
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`phip ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Parameters`phip
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]
						],
						FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Plus[
							Times[
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`mup,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
								],
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`muc,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
								]
							],
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`phip ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
							],
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`muc,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Times[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t,
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`muc,
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
									(FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Times[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1],
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`muc,
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
									(FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]) + FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Times[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2],
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`muc,
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 3] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
									(FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 4] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 3]) + FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]
						],
						Plus[
							(1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog) * FernandoDuarte`LongRunRisk`Model`Parameters`Esg * PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
							FernandoDuarte`LongRunRisk`Model`Parameters`rhog * PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 3, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]
						],
						Plus[
							Times[
								1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog,
								Times[
									FernandoDuarte`LongRunRisk`Model`Parameters`Esg,
									((FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
								]
							],
							Times[
								FernandoDuarte`LongRunRisk`Model`Parameters`rhog,
								Plus[
									(FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) ^ 3,
									Times[
										3,
										(FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) * (FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg))
									]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 3] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]
						],
						Plus[
							(1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * FernandoDuarte`LongRunRisk`Model`Parameters`Esg * PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 3, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 3] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]
						],
						Plus[
							Times[
								1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2,
								Times[
									FernandoDuarte`LongRunRisk`Model`Parameters`Esg,
									((FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
								]
							],
							Times[
								FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2,
								Plus[
									(FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) ^ 3,
									Times[
										3,
										(FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) * (FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg))
									]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Plus[
							(FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) * (FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)),
							FernandoDuarte`LongRunRisk`Model`Parameters`rhog * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 3] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Plus[
							(FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) * (FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)),
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
						],
						Plus[
							Times[
								FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
								FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)
							],
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 3) * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 3] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
						],
						Plus[
							Times[
								FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 4) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
								FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)
							],
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 4) * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Times[FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]
						],
						FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Times[FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
						],
						Times[FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2, ComputationalEngine`Cond`modNRC]
						],
						Times[FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + (FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						((FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
					]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] ^ 2
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] ^ 2
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						((FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[
							Power[
								FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
								2
							],
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) + 1) * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2, ComputationalEngine`Cond`modNRC]],
						Plus[
							Power[
								FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
								2
							],
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 4) + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) + 1) * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - (FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg))
				]
			],
			SameQ[0, Simplify[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]]],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - (FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg))
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]],
						FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
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
	TestID->"ComputeConditionalExpectations_20231009-9YTG4G"
]
VerificationTest[
	ComputationalEngine`Cond`dc1 = PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] /. Normal[ComputationalEngine`Cond`modNRC["exogenousEq"]]];
	ComputationalEngine`Cond`dc2 = PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] /. Normal[ComputationalEngine`Cond`modNRC["exogenousEq"]]];
	Apply[And,
		{
			Simplify[
				SameQ[ComputationalEngine`Cond`dc1,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
							(FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]) + FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
								(FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]) + FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
							]
						]
					]
				]
			],
			Simplify[
				SameQ[ComputationalEngine`Cond`dc2,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 3] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
							(FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 4] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 3]) + FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 3] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
								(FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 4] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 3]) + FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
								FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
						],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
						],
						FernandoDuarte`LongRunRisk`Model`Parameters`phip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
						],
						(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`phip) + FernandoDuarte`LongRunRisk`Model`Parameters`xip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
						],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
						],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]
						],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]
						],
						FernandoDuarte`LongRunRisk`Model`Parameters`phip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]
						],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]
						],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]
						],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]
						],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]
						],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]
						],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]
						],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2, ComputationalEngine`Cond`modNRC]
						],
						FernandoDuarte`LongRunRisk`Model`Parameters`rhop * ((FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`phip) + FernandoDuarte`LongRunRisk`Model`Parameters`xip)
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2, ComputationalEngine`Cond`modNRC]
						],
						(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`phip) + FernandoDuarte`LongRunRisk`Model`Parameters`xip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2, ComputationalEngine`Cond`modNRC]],
						FernandoDuarte`LongRunRisk`Model`Parameters`phip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2, ComputationalEngine`Cond`modNRC]
						],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2, ComputationalEngine`Cond`modNRC]
						],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
						],
						FernandoDuarte`LongRunRisk`Model`Parameters`rhop * ((FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`phip) + FernandoDuarte`LongRunRisk`Model`Parameters`xip)
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
						],
						(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`phip) + FernandoDuarte`LongRunRisk`Model`Parameters`xip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]],
						FernandoDuarte`LongRunRisk`Model`Parameters`phip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
						],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
						],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]
						],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]
						],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]
						],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]
						],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]
					]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + (FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 4) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + (FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 3) * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + (FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - (FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg))
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mud @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xid[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Plus[
							Power[
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`mup,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
								],
								2
							],
							FernandoDuarte`LongRunRisk`Model`Parameters`phip ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Plus[
							Power[
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`muc,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
								],
								2
							],
							FernandoDuarte`LongRunRisk`Model`Parameters`phic ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						((FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]],
						Plus[
							Power[
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`mud @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xid[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
								],
								2
							],
							FernandoDuarte`LongRunRisk`Model`Parameters`phidc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`Parameters`phip ^ 2]
			],
			SameQ[0,
				Simplify[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`Parameters`phic ^ 2]
			],
			SameQ[0,
				Simplify[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]] - FernandoDuarte`LongRunRisk`Model`Parameters`phidc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] ^ 2
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231009-K1TX8C"
]
VerificationTest[
	Apply[And,
		{
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
							FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
							FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
					]
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2,
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2,
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2,
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231009-YSFBG5"
]
VerificationTest[
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[foo`t + 1], foo`t, ComputationalEngine`Cond`modNRC] /. foo`t -> FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[foo`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + foo`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], foo`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[foo`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + foo`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], foo`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[bar`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + bar`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], bar`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[bar`t + 1], goo`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + bar`t]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231009-PO8NUC"
]
VerificationTest[
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
						(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC] /. FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t -> (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1)
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t],
						Plus[
							Times[
								FernandoDuarte`LongRunRisk`Model`Parameters`rhop,
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
									(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
								]
							],
							FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][1 + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
						]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 2], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][2 + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				Times[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t],
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
							(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
						]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`Parameters`delta, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`Parameters`delta],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`R[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`m - 1][0], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`R[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`m - 1][0]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`pieq[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`m], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`pieq[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`m]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`EndogenousEq`wceq @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t + 1, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`EndogenousEq`wceq @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[{FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t}, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				{
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, ComputationalEngine`Cond`modNRC]
				}
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[foo`pi @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[foo`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[foo`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[foo`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * bar`delta, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * foo`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`Model`Parameters`delta, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ foo`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ foo`t],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[foo`t], foo`t - 1, ComputationalEngine`Cond`modNRC] /. foo`t -> FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t
			],
			SameQ[ExpandAll[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[foo`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t], foo`t - 1, ComputationalEngine`Cond`modNRC]],
				ExpandAll[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[foo`t], foo`t - 1, ComputationalEngine`Cond`modNRC]]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[foo`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t], foo`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[foo`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231009-BJF97S"
]
VerificationTest[
	Unset @ $ContextAliases @ "ce`";
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231009-PLM37U"
] 
End[]
EndTestSection[]
