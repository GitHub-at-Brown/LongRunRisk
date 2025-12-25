BeginTestSection["validateModel"]

(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Simple test model has missing params *)
  Module[{model, result},
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> {x[t]},
      "parameters" -> {delta -> 0.998, gamma -> 10}
    |>;
    result = Quiet[$validateModel[model]];
    (* Should detect missing params since only 2 of 73 are present *)
    MemberQ[result["Errors"][[All, "Type"]], "MissingParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "simple-model-missing-params@@Tests/ValidateModels/validateModel.wlt:469,1-487,2"
]

EndTestSection[]
