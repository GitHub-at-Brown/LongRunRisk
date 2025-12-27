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
  (* Test invalid indexed parameter name (not in dividend growth params) *)
  Module[{model, result, byParams, badIndexedParams},
    byParams = $realModels["BY"]["parameters"];
    (* notADividendParam is not in paramList["Real dividend growth"] *)
    badIndexedParams = {notADividendParam[1] -> 0.5};
    model = <|
      "name" -> "Bad Indexed",
      "shortname" -> "BI",
      "bibRef" -> "Test2025",
      "desc" -> "Model with invalid indexed param",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> Join[byParams, badIndexedParams]
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "BadIndexedParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "bad-indexed-param-name-fails@@Tests/ValidateModels/validateModel_test35.wlt:26,1-46,2"
]

EndTestSection[]
