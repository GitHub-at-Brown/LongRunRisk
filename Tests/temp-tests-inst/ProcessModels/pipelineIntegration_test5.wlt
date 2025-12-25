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
  Head[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels],
  Symbol,
  TestID -> "buildModels-symbol-exists@@Tests/ProcessModels/pipelineIntegration.wlt:46,1-50,2"
]

EndTestSection[]
