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
  MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"],
  True,
  TestID -> "processModels-package-loaded@@Tests/ProcessModels/pipelineIntegration.wlt:24,1-28,2"
]

EndTestSection[]
