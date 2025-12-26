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
  (* Test non-positive index *)
  Module[{model, result, byParams, nonPositiveIndexParams},
    byParams = $realModels["BY"]["parameters"];
    (* mud[0] has non-positive index *)
    nonPositiveIndexParams = {mud[0] -> 0.001};
    model = <|
      "name" -> "Non-Positive Index",
      "shortname" -> "NPI",
      "bibRef" -> "Test2025",
      "desc" -> "Model with non-positive index",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> Join[byParams, nonPositiveIndexParams]
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "IndexNotPositive"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "non-positive-index-fails@@Tests/ValidateModels/validateModel.wlt:515,1-535,2"
]

EndTestSection[]
