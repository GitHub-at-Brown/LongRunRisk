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
  TestID -> "catalog-has-models@@Tests/ProcessModels/pipelineIntegration_test9.wlt:18,1-22,2"
]

EndTestSection[]
