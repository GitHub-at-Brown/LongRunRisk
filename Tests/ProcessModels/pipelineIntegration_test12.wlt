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
  Module[{model},
    model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BKY"];
    KeyExistsQ[model, "name"] && KeyExistsQ[model, "shortname"] &&
    KeyExistsQ[model, "parameters"] && KeyExistsQ[model, "stateVars"]
  ],
  True,
  TestID -> "BKY-model-has-required-keys@@Tests/ProcessModels/pipelineIntegration_test12.wlt:18,1-26,2"
]

EndTestSection[]
