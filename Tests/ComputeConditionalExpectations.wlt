BeginTestSection["ComputeConditionalExpectations"] 
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`";
	Needs @ "PacletizedResourceFunctions`";
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231113-O8SSHH@@Tests/ComputeConditionalExpectations.wlt:3,1-13,2"
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
	TestID->"ComputeConditionalExpectations_20231113-5AZKMP@@Tests/ComputeConditionalExpectations.wlt:14,1-24,2"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"]}]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231113-KRCWBK@@Tests/ComputeConditionalExpectations.wlt:25,1-33,2"
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
	TestID->"ComputeConditionalExpectations_20231113-TP50XY@@Tests/ComputeConditionalExpectations.wlt:34,1-47,2"
]
VerificationTest[
	Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`msp = FernandoDuarte`LongRunRisk`Models;
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modBY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`msp @ "BY";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`msp @ "NRC";
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231113-RH6MFA@@Tests/ComputeConditionalExpectations.wlt:48,1-60,2"
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
	TestID->"ComputeConditionalExpectations_20231113-HQY17T@@Tests/ComputeConditionalExpectations.wlt:61,1-71,2"
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
	TestID->"ComputeConditionalExpectations_20231113-A9L5ZQ@@Tests/ComputeConditionalExpectations.wlt:72,1-538,2"
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
	TestID->"ComputeConditionalExpectations_20231113-1X8BUI@@Tests/ComputeConditionalExpectations.wlt:539,1-1068,2"
]
VerificationTest[
	Apply[And,
		{
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]
					]
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2) * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2,
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2,
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2,
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231113-9QHJUK@@Tests/ComputeConditionalExpectations.wlt:1069,1-1338,2"
]
VerificationTest[
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[foo`t + 1], foo`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] /. foo`t -> FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[foo`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + foo`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], foo`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[foo`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + foo`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], foo`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[bar`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + bar`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], bar`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[bar`t + 1], goo`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + bar`t]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231113-FKOI0I@@Tests/ComputeConditionalExpectations.wlt:1339,1-1361,2"
]
VerificationTest[
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
						(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] /. FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t -> (FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1)
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t],
						Plus[
							Times[
								FernandoDuarte`LongRunRisk`Model`Parameters`rhop,
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
									(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
								]
							],
							FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][1 + FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
						]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 2], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][2 + FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				Times[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t],
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
							(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
						]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`Parameters`delta, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Model`Parameters`delta],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`R[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`m - 1][0], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`R[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`m - 1][0]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`pieq[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`m], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`pieq[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`m]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`EndogenousEq`wceq @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Model`EndogenousEq`wceq @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[{FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t}, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				{
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]
				}
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[foo`pi @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[foo`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[foo`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[foo`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * bar`delta, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * foo`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Model`Parameters`delta, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ foo`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ foo`t],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[foo`t], foo`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC] /. foo`t -> FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t
			],
			SameQ[ExpandAll[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[foo`t] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], foo`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]],
				ExpandAll[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[foo`t], foo`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC]]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[foo`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], foo`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
				FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[foo`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231113-IZWF8D@@Tests/ComputeConditionalExpectations.wlt:1362,1-1445,2"
]
VerificationTest[
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20231113-6L2WTL@@Tests/ComputeConditionalExpectations.wlt:1446,1-1454,2"
] 
End[]
EndTestSection[]
