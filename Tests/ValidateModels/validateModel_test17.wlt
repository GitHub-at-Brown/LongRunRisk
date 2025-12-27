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
  Module[{model, result, missingKeyCount},
    model = <|
      "name" -> "Test",
      (* Missing shortname, bibRef, desc *)
      "stateVars" -> {x[t]},
      "parameters" -> {delta -> 0.998}
    |>;
    result = Quiet[$validateModel[model]];
    missingKeyCount = Count[result["Errors"][[All, "Type"]], "MissingKey"];
    missingKeyCount >= 3
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "multiple-missing-keys-accumulated@@Tests/ValidateModels/validateModel_test17.wlt:26,1-41,2"
]

EndTestSection[]
