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
  (* Test valid state variables with exo vars, params, shocks pass *)
  Module[{model, result},
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      (* Valid: x is exo var, mup is param, t is time *)
      "stateVars" -> {x[t], -mup + pi[t]},
      "parameters" -> $realModels["BY"]["parameters"]
    |>;
    result = Quiet[$validateModel[model]];
    !MemberQ[result["Errors"][[All, "Type"]], "BadStateVarSymbol"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "stateVars-valid-symbols-pass@@Tests/ValidateModels/validateModel.wlt:282,1-300,2"
]

EndTestSection[]
