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

VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`longTest,
		Apply[And,
			{
				SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`pi1 /. FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`sol1, FernandoDuarte`LongRunRisk`Model`Parameters`mup],
				SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`sg1 /. FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`sol1, FernandoDuarte`LongRunRisk`Model`Parameters`Esg],
				SameQ[FullSimplify[ExpandAll[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`pi2 /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol2]],
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
				SameQ[Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`sg2 /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol2],
					Simplify[
						(FernandoDuarte`LongRunRisk`Model`Parameters`Esg ^ 2) + (FernandoDuarte`LongRunRisk`Model`Parameters`phig ^ 2) / (1 - FernandoDuarte`LongRunRisk`Model`Parameters`rhog ^ 2)
					]
				],
				SameQ[Simplify[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`pi1sg1 /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol2], Simplify[FernandoDuarte`LongRunRisk`Model`Parameters`Esg * FernandoDuarte`LongRunRisk`Model`Parameters`mup]]
			}
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20251223-3UOJXH@@Tests/ComputeUnconditionalExpectations.wlt:135,1-170,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
