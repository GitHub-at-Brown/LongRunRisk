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
  (* Test delta > 1 - violates delta < 1 *)
  Module[{model, result, byParams, modifiedParams},
    byParams = $realModels["BY"]["parameters"];
    modifiedParams = byParams /. (Rule[s_Symbol, _] /; SymbolName[s] === "delta" :> (s -> 1.5));
    model = <|
      "name" -> "Bad Delta High",
      "shortname" -> "BDH",
      "bibRef" -> "Test2025",
      "desc" -> "Model with delta too high",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> modifiedParams
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "BadAssumption"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "assumption-delta-too-high-fails@@Tests/ValidateModels/validateModel.wlt:618,1-637,2"
]

EndTestSection[]
