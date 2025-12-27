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
      "stateVars" -> "not a list",  (* Should be List *)
      "parameters" -> {delta -> 0.998}
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "WrongType"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "wrong-type-stateVars-string@@Tests/ValidateModels/validateModel_test19.wlt:26,1-42,2"
]

EndTestSection[]
