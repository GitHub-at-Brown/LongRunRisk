BeginTestSection["ProcessModels"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`"]

Needs @ "FernandoDuarte`LongRunRisk`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest = False;

(* === Shared State Setup === *)
FernandoDuarte`LongRunRisk`Models = Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest = If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Model`Catalog`models, KeyTake[FernandoDuarte`LongRunRisk`Model`Catalog`models, {"BY", "BKY", "NRC"}]];
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP = If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC"}]];

VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC = FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP @ "NRC";
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[myContext`t] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["exogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[myContext`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
						(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][myContext`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][myContext`t]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] /. FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["exogenousEq"], FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]],
			SameQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["exogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mud @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i,
					Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup) * FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i],
						(FernandoDuarte`LongRunRisk`Model`Parameters`phidc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]) + FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 2] * FernandoDuarte`LongRunRisk`Model`Parameters`xid[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0,
					Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[1] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
						Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[4] * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg),
							Plus[
								Times[
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 5,
									Subtract[
										(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) - (FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) / (1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2),
										FernandoDuarte`LongRunRisk`Model`Parameters`Esg ^ 2
									]
								],
								(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]) + FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[2] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
							]
						]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`pd[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]],
				Plus[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i][0],
					Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`mup) * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i][1],
						Plus[(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] - FernandoDuarte`LongRunRisk`Model`Parameters`Esg) * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i][4],
							Plus[
								Times[
									Subtract[
										(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ^ 2) - (FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) / (1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2),
										FernandoDuarte`LongRunRisk`Model`Parameters`Esg ^ 2
									],
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i][5]
								],
								Plus[
									FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1] * FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i][2] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t],
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i][3] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]
								]
							]
						]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondexcret[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondret[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i, 1] - FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, 1]
			],
			SameQ[
				(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondexcret[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i] /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]]) /. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC["endogenousEq"]],
				(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, 1] + FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i - 1]) - FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t - 1, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`i]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-RHISME@@Tests/ProcessModels.wlt:814,1-887,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
