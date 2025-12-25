BeginTestSection["ComputeConditionalExpectations"] 
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`"]

Needs @ "FernandoDuarte`LongRunRisk`";
Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`"];

(* === Shared State Setup === *)
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`msp = FernandoDuarte`LongRunRisk`Models;
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modBY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`msp @ "BY";
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`msp @ "NRC";

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
	TestID->"ComputeConditionalExpectations_20251223-JD5FNV@@Tests/ComputeConditionalExpectations.wlt:70,1-536,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
