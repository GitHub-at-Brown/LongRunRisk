BeginTestSection["pipelineIntegration"]

(* Setup: Load required packages *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"];
Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
On[General::shdw];

(* Load catalog *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];

$timeLimit = 10;

(* ============================================================ *)
(* Package Loading Tests *)
(* ============================================================ *)

VerificationTest[
  AllTrue[Values[FernandoDuarte`LongRunRisk`Model`Catalog`models], AssociationQ],
  True,
  TestID -> "catalog-values-are-associations@@Tests/ProcessModels/pipelineIntegration_test11.wlt:18,1-22,2"
]

EndTestSection[]
