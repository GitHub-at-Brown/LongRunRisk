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
  Module[{catalog, result},
    catalog = <|
      "ModelA" -> $realModels["BY"],
      "ModelB" -> <|
        "name" -> 42,  (* Invalid *)
        "shortname" -> "B",
        "bibRef" -> "B2025",
        "desc" -> "Second model",
        "stateVars" -> {y[t]},
        "parameters" -> {gamma -> 10}
      |>
    |>;
    result = Quiet[$validateCatalog[catalog]];
    MemberQ[result["InvalidModels"], "ModelB"] && result["TotalErrors"] >= 1
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "catalog-identifies-invalid-models@@Tests/ValidateModels/validateModel.wlt:719,1-738,2"
]

EndTestSection[]
