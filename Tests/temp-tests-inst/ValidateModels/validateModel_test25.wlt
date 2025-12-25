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
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> {x[t]},
      "parameters" -> {delta -> 0.998, delta -> 0.99}  (* Duplicate *)
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "DuplicateParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "duplicate-parameter-fails@@Tests/ValidateModels/validateModel.wlt:306,1-322,2"
]

EndTestSection[]
