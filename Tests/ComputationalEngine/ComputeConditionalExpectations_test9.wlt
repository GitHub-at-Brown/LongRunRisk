BeginTestSection["ComputeConditionalExpectations"] 
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`"]

Needs @ "FernandoDuarte`LongRunRisk`";
Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`"];

(* === Shared State Setup === *)
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`msp = FernandoDuarte`LongRunRisk`Models;
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modBY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`msp @ "BY";
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`msp @ "NRC";

FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`dc1 = FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] /. Normal[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC["exogenousEq"]];
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`dc2 = FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 2] /. Normal[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC["exogenousEq"]];

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
	TestID->"ComputeConditionalExpectations_20251223-RC6VXJ@@Tests/ComputeConditionalExpectations.wlt:1360,1-1443,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
