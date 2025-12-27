BeginTestSection["ComputeUnconditionalExpectations"] 
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`"]

FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`longTest = False;
Needs @ "PacletizedResourceFunctions`";
Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`"];
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`"];

(* === Shared State Setup === *)
Needs @ "FernandoDuarte`LongRunRisk`";
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`msp = FernandoDuarte`LongRunRisk`Models;
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modBY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`msp @ "BY";
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`msp @ "NRC";

FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`stateVarsNoEps = {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sg, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi};
FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`model = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC;

VerificationTest[
	Apply[And,
		{
			SameQ[
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`evNoEpsStateVarsProduct[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`foo[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`model, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`stateVarsNoEps],
				FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`foo[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1]
			],
			SameQ[
				ExpandAll[
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`evNoEpsStateVarsProduct[
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`model, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`stateVarsNoEps
					]
				],
				ExpandAll[
					Times[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`evNoEpsStateVarsProduct[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t] * FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`model, FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`stateVarsNoEps]
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
	TestID->"ComputeUnconditionalExpectations_20251223-9I48T0@@Tests/ComputeUnconditionalExpectations.wlt:453,1-481,2"
]

$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`" | "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`"];

End[]
EndTestSection[]