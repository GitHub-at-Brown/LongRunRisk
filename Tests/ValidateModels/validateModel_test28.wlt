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
  Module[{model, result, byParams, incompleteStock2Params},
    (* Start with valid BY params (which has complete stock 1), then add incomplete stock 2 params *)
    byParams = $realModels["BY"]["parameters"];
    (* Add only some of the 16 stock params for stock 2 - incomplete *)
    incompleteStock2Params = {mud[2] -> 0.002, rhodx[2] -> 2.5};
    model = <|
      "name" -> "Multi Stock",
      "shortname" -> "MS",
      "bibRef" -> "Test2025",
      "desc" -> "Multi stock model",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> Join[byParams, incompleteStock2Params]
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "MissingStockParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "incomplete-stock-params-fails@@Tests/ValidateModels/validateModel.wlt:364,1-384,2"
]

EndTestSection[]
