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
	SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t + 1], FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`t - 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`modNRC],
		FernandoDuarte`LongRunRisk`Model`Parameters`phip
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20251223-P3GKZJ@@Tests/ComputeConditionalExpectations.wlt:59,1-69,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
