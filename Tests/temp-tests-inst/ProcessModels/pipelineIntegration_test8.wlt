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
  AssociationQ[FernandoDuarte`LongRunRisk`Model`Catalog`models],
  True,
  TestID -> "catalog-is-association@@Tests/ProcessModels/pipelineIntegration.wlt:68,1-72,2"
]

EndTestSection[]
