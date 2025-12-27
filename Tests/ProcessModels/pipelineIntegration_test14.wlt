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
    KeyExistsQ[model, "enabled"] && BooleanQ[model["enabled"]]
  ],
  True,
  TestID -> "BKY-model-has-enabled-boolean@@Tests/ProcessModels/pipelineIntegration_test14.wlt:18,1-25,2"
]

EndTestSection[]
