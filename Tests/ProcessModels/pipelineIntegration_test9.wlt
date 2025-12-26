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
  Length[FernandoDuarte`LongRunRisk`Model`Catalog`models] > 0,
  True,
  TestID -> "catalog-has-models@@Tests/ProcessModels/pipelineIntegration.wlt:74,1-78,2"
]

EndTestSection[]
