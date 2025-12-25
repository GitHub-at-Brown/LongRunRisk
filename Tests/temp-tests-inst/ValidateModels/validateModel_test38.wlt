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
  (* Test valid multi-stock model passes *)
  Module[{model, result, byParams, stock2Params},
    byParams = $realModels["BY"]["parameters"];
    (* Add complete params for stock 2 - should pass *)
    stock2Params = {
      mud[2] -> 0.001, rhodx[2] -> 2, rhodp[2] -> 0, phidc[2] -> 0,
      phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0,
      phidxd[2] -> 4, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    };
    model = <|
      "name" -> "Multi Stock Valid",
      "shortname" -> "MSV",
      "bibRef" -> "Test2025",
      "desc" -> "Valid multi-stock model",
      "enabled" -> True,
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> Join[byParams, stock2Params]
    |>;
    result = Quiet[$validateModel[model]];
    result["Valid"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "valid-multi-stock-passes@@Tests/ValidateModels/validateModel.wlt:564,1-590,2"
]

EndTestSection[]
