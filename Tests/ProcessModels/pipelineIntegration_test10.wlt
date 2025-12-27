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
  AllTrue[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], StringQ],
  True,
  TestID -> "catalog-keys-are-strings@@Tests/ProcessModels/pipelineIntegration_test10.wlt:18,1-22,2"
]

EndTestSection[]
