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
	Apply[And,
		{
			FreeQ[
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`evNoEpsStateVarsProduct[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`model, Append[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`stateVarsNoEps, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd]],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "dd"]][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i]
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`evNoEpsStateVarsProduct[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`model, Append[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`stateVarsNoEps, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd]],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "pi"]][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`evNoEpsStateVarsProduct[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`model,
					Append[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`stateVarsNoEps, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd]
				],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "dd"]][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i]
			],
			Not[
				FreeQ[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`evNoEpsStateVarsProduct[
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`model,
						Append[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`stateVarsNoEps, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd]
					],
					PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "eps"]]["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
				]
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`evNoEpsStateVarsProduct[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`model,
					Append[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`stateVarsNoEps, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd]
				],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "pi"]][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i]
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`evNoEpsStateVarsProduct[
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`eps["dd"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`model,
					Append[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`stateVarsNoEps, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd]
				],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "dd"]][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i]
			],
			Not[
				FreeQ[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`evNoEpsStateVarsProduct[
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`eps["dd"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`model,
						Append[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`stateVarsNoEps, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd]
					],
					PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "eps"]]["dd"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i]
				]
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`evNoEpsStateVarsProduct[
					Times[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t,
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`eps["dd"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i]
					],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`model,
					Append[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`stateVarsNoEps, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd]
				],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "pi"]][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t]
			],
			Not[
				FreeQ[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`evNoEpsStateVarsProduct[
						Times[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi @ FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t,
							FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`eps["dd"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`i]
						],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`model,
						Append[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`stateVarsNoEps, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dd]
					],
					PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "pi"]][_]
				]
			],
			FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`uncondEStep[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "dc"]],
				Infinity
			],
			FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`uncondEStep[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`dc[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sg[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC],
				PatternTest[_Symbol, Function @ MatchQ[SymbolName @ #, "pi"]][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t],
				Infinity
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20251223-WCRWGJ@@Tests/ComputeUnconditionalExpectations.wlt:512,1-603,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
