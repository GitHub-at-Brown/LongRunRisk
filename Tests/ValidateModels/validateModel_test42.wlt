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
  (* Test theta = 0 - violates theta < 0 || theta > 0 *)
  Module[{model, result, byParams, modifiedParams},
    byParams = $realModels["BY"]["parameters"];
    modifiedParams = byParams /. (Rule[s_Symbol, _] /; SymbolName[s] === "theta" :> (s -> 0));
    model = <|
      "name" -> "Bad Theta",
      "shortname" -> "BT",
      "bibRef" -> "Test2025",
      "desc" -> "Model with theta = 0",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> modifiedParams
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "BadAssumption"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "assumption-theta-zero-fails@@Tests/ValidateModels/validateModel.wlt:660,1-679,2"
]

EndTestSection[]
