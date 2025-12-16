BeginTestSection["ComputeConditionalExpectations"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`";
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20251215-HX7GF3@@Tests/ComputeConditionalExpectations.wlt:4,1-13,2"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`"];
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20251215-0GI93B@@Tests/ComputeConditionalExpectations.wlt:16,1-26,2"
]


VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"]}]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20251215-L3XV08@@Tests/ComputeConditionalExpectations.wlt:29,1-37,2"
]


VerificationTest[
	Apply[And,
		{
			!SameQ[Names @ "*ev", {}],
			!SameQ[Names @ "lagStateVarst", {}]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20251215-P9MRG6@@Tests/ComputeConditionalExpectations.wlt:40,1-53,2"
]


VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`msp = FernandoDuarte`LongRunRisk`Models;
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modBY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`msp @ "BY";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`msp @ "NRC";
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20251215-K1QUWI@@Tests/ComputeConditionalExpectations.wlt:56,1-67,2"
]


VerificationTest[
	SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
		FernandoDuarte`LongRunRisk`Model`Parameters`phip
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20251215-SMFST1@@Tests/ComputeConditionalExpectations.wlt:70,1-80,2"
]


VerificationTest[
	Apply[And,
		{
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
							],
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mud @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xid[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							Times[
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`mud @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xid[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
								],
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`muc,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
								]
							],
							FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Parameters`phidc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 3] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1],
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
						],
						Times[FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								Times[
									Plus[
										FernandoDuarte`LongRunRisk`Model`Parameters`mup,
										(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
									],
									Plus[
										FernandoDuarte`LongRunRisk`Model`Parameters`muc,
										(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
									]
								],
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`phip ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							Times[
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`mup,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
								],
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`mup,
									((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
								]
							],
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`phip ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Parameters`phip
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							Times[
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`mup,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
								],
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`muc,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
								]
							],
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`phip ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
							],
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`muc,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t,
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`muc,
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
									(FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1],
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`muc,
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
									(FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]) + FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2],
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`muc,
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 3] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
									(FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 4] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 3]) + FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[(1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog) * FernandoDuarte`LongRunRisk`Model`Parameters`Esg * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
							FernandoDuarte`LongRunRisk`Model`Parameters`rhog * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 3, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							Times[
								1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog,
								Times[
									FernandoDuarte`LongRunRisk`Model`Parameters`Esg,
									((FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
								]
							],
							Times[
								FernandoDuarte`LongRunRisk`Model`Parameters`rhog,
								Plus[
									(FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) ^ 3,
									Times[
										3,
										(FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) * (FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg))
									]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 3] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							(1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * FernandoDuarte`LongRunRisk`Model`Parameters`Esg * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 3, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 3] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							Times[
								1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2,
								Times[
									FernandoDuarte`LongRunRisk`Model`Parameters`Esg,
									((FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
								]
							],
							Times[
								FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2,
								Plus[
									(FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) ^ 3,
									Times[
										3,
										(FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) * (FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg))
									]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							(FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) * (FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)),
							FernandoDuarte`LongRunRisk`Model`Parameters`rhog * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 3] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							(FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) * (FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)),
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							Times[
								FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
								FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)
							],
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 3) * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 3] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							Times[
								FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 4) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
								FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)
							],
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 4) * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + (FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						((FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
					]
				]
			],
			SameQ[0,
				Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] ^ 2
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] ^ 2
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						((FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							Power[
								FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
								2
							],
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) + 1) * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							Power[
								FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
								2
							],
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 4) + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) + 1) * FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - (FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg))
				]
			],
			SameQ[0, Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]]],
			SameQ[0,
				Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]]
			],
			SameQ[0,
				Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1]
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - (FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg))
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`Model`Parameters`Esg + (FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
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
	TestID->"ComputeConditionalExpectations_20251215-3GAOJZ@@Tests/ComputeConditionalExpectations.wlt:83,1-549,2"
]


VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`dc1 = FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] /. Normal[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC["exogenousEq"]];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`dc2 = FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] /. Normal[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC["exogenousEq"]];
	Apply[And,
		{
			Simplify[
				SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`dc1,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
							(FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]) + FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
								(FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]) + FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
							]
						]
					]
				]
			],
			Simplify[
				SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`dc2,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 3] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
							(FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 4] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 3]) + FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 3] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
								(FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 4] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 3]) + FernandoDuarte`LongRunRisk`Model`Parameters`phic * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
								FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`Model`Parameters`phip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`phip) + FernandoDuarte`LongRunRisk`Model`Parameters`xip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`Model`Parameters`phip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`Model`Parameters`rhop * ((FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`phip) + FernandoDuarte`LongRunRisk`Model`Parameters`xip)
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`phip) + FernandoDuarte`LongRunRisk`Model`Parameters`xip
					]
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`Parameters`phip
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`Model`Parameters`rhop * ((FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`phip) + FernandoDuarte`LongRunRisk`Model`Parameters`xip)
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`phip) + FernandoDuarte`LongRunRisk`Model`Parameters`xip
					]
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`Parameters`phip
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Times[
							Plus[
								FernandoDuarte`LongRunRisk`Model`Parameters`mup,
								(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1]
							],
							FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]
					]
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + (FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 4) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + (FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 3) * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`rhop * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							((FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 3) * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + (FernandoDuarte`LongRunRisk`Model`Parameters`rhop ^ 2) * FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`muc,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - (FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg))
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mud @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i,
							(FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xid[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							Power[
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`mup,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
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
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							Power[
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`muc,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhocp * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xic * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
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
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						((FernandoDuarte`LongRunRisk`Model`Parameters`Esg + FernandoDuarte`LongRunRisk`Model`Parameters`rhog * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg)) ^ 2) + FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						Plus[
							Power[
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`mud @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i,
									(FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup)) + FernandoDuarte`LongRunRisk`Model`Parameters`xid[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
								],
								2
							],
							FernandoDuarte`LongRunRisk`Model`Parameters`phidc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] ^ 2
						]
					]
				]
			],
			SameQ[0, Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`Parameters`phip ^ 2]],
			SameQ[0, Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`Parameters`phic ^ 2]],
			SameQ[0, Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2]],
			SameQ[0,
				Simplify[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] - FernandoDuarte`LongRunRisk`Model`Parameters`phidc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] ^ 2
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20251215-WUJQT5@@Tests/ComputeConditionalExpectations.wlt:552,1-1081,2"
]


EndTestSection[]
