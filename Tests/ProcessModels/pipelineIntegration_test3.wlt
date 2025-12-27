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
  MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Tools`ManageResources`"],
  True,
  TestID -> "manageResources-package-loaded@@Tests/ProcessModels/pipelineIntegration_test3.wlt:18,1-22,2"
]

EndTestSection[]
