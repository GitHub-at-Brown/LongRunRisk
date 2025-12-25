BeginTestSection["ComputeUnconditionalExpectations"] 
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`"]

FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`longTest = False;
Needs @ "PacletizedResourceFunctions`";
Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`"];
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`"];

(* === Shared State Setup === *)
FernandoDuarte`LongRunRisk`Models = Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`msp = FernandoDuarte`LongRunRisk`Models;
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modBY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`msp @ "BY";
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`msp @ "NRC";

FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`stateVarsNoEps = {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sg, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi};
FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`model = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC;

VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`longTest,
		Apply[And,
			{
				SameQ[Simplify @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`wc @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0],
				SameQ[Simplify @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`wc @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modBY], FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0],
				SameQ[0,
					Simplify[
						Subtract[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 3, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC],
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[(FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 3) * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC]
						]
					]
				],
				SameQ[0,
					Simplify[
						Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[(FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 3) * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC],
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
				SameQ[Simplify @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dc @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`muc],
				SameQ[FullSimplify[Expand[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] ^ 2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC]]],
					FullSimplify[
						Expand[
							Plus[
								FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`muc ^ 2,
								Plus[
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phic ^ 2,
									Plus[
										2 * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`Esg * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhocp * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xic,
										Plus[
											Times[
												FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xic ^ 2,
												(FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`Esg ^ 2) + (FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phig ^ 2) / (1 - FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhog ^ 2)
											],
											Divide[
												Times[
													FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhocp ^ 2,
													(FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip ^ 2) + (2 * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhop * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xip) + FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xip ^ 2
												],
												1 - FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhop ^ 2
											]
										]
									]
								]
							]
						]
					]
				],
				SameQ[FullSimplify[Expand[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC]]],
					FullSimplify[
						Expand[
							Plus[
								FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`muc * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`mup,
								Plus[
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhocp * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xip * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip,
									Plus[
										FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xic * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhop * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`Esg,
										Plus[
											FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xic * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xip * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`Esg,
											Divide[
												Times[
													FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhocp * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhop,
													(FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xip ^ 2) + (2 * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhop * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xip * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip) + FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip ^ 2
												],
												1 - FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhop ^ 2
											]
										]
									]
								]
							]
						]
					]
				],
				SameQ[FullSimplify[Expand[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC]]],
					FullSimplify[Expand[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`muc * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`Esg]]
				],
				SameQ[FullSimplify[Expand[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC]]],
					FullSimplify[
						Expand[
							(FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`Esg ^ 2) + (FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhog / (1 - FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhog ^ 2)) * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phig ^ 2
						]
					]
				],
				SameQ[FullSimplify[Expand[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC]]],
					FullSimplify[
						Expand[
							(FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`Esg ^ 2) + (FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhog / (1 - FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhog ^ 2)) * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phig ^ 2
						]
					]
				],
				SameQ[FullSimplify[Expand[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC]]],
					FullSimplify[
						Expand[
							Plus[
								FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`mup ^ 2,
								Plus[
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xip,
									Divide[
										Times[
											FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhop,
											(FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip ^ 2) + (2 * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhop * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xip * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip) + FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xip ^ 2
										],
										1 - FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhop ^ 2
									]
								]
							]
						]
					]
				],
				SameQ[FullSimplify[Expand[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC]]],
					FullSimplify[
						Expand[
							Plus[
								FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`mup ^ 2,
								Plus[
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xip,
									Divide[
										Times[
											FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhop,
											(FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip ^ 2) + (2 * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhop * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xip * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip) + FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xip ^ 2
										],
										1 - FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhop ^ 2
									]
								]
							]
						]
					]
				],
				SameQ[FullSimplify[Expand[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC]]],
					FullSimplify[Expand[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`Esg * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`mup]]
				],
				SameQ[FullSimplify[Expand[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC]]],
					FullSimplify[
						Expand[
							Plus[
								FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`muc * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`mup,
								Plus[
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`Esg * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xic,
									Divide[
										Times[
											FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhocp,
											(FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip ^ 2) + (2 * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`phip * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhop * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xip) + FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`xip ^ 2
										],
										1 - FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`rhop ^ 2
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
				SameQ[Simplify @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`wc @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC], FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0],
				SameQ[Simplify @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`wc @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modBY], FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20251223-PBSGRC@@Tests/ComputeUnconditionalExpectations.wlt:742,1-924,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
