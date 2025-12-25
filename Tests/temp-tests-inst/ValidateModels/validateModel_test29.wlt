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
      "name" -> 42,  (* Wrong type *)
      "shortname" -> "TM",
      (* Missing bibRef, desc *)
      "stateVars" -> {x},  (* Missing [t] *)
      "parameters" -> {delta -> "bad", delta -> 0.99}  (* Non-numeric + duplicate *)
    |>;
    result = Quiet[$validateModel[model]];
    (* Should accumulate multiple errors - at least WrongType, MissingKey x2, BadStateVar, BadParam, DuplicateParam *)
    result["ErrorCount"] >= 4
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "accumulates-multiple-errors@@Tests/ValidateModels/validateModel.wlt:390,1-406,2"
]

EndTestSection[]
