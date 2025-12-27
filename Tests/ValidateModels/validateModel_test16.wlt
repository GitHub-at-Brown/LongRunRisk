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
  Module[{model, result},
    model = <|
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Missing name",
      "stateVars" -> {x[t]},
      "parameters" -> {delta -> 0.998}
    |>;
    result = Quiet[$validateModel[model]];
    (* Check that MissingKey error is present *)
    MemberQ[result["Errors"][[All, "Type"]], "MissingKey"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "missing-name-key-fails@@Tests/ValidateModels/validateModel_test16.wlt:26,1-42,2"
]

EndTestSection[]
