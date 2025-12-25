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
	True
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20251223-BSKL53@@Tests/ComputeConditionalExpectations.wlt:1444,1-1452,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
