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
  (* Model missing a parameter from $parameters *)
  Module[{model, result, byParams},
    (* Remove delta param by matching symbol name (context-independent) *)
    byParams = DeleteCases[$realModels["BY"]["parameters"],
      Rule[s_Symbol, _] /; SymbolName[s] === "delta"];
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> byParams
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "MissingParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "missing-param-detected@@Tests/ValidateModels/validateModel.wlt:447,1-467,2"
]

EndTestSection[]
