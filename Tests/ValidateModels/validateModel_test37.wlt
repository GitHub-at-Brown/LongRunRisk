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
  (* Test index gap - has index 3 without index 2 *)
  Module[{model, result, byParams, gapIndexParams, stock3Params},
    byParams = $realModels["BY"]["parameters"];
    (* Add complete params for stock 3 but skip stock 2 *)
    stock3Params = {
      mud[3] -> 0.001, rhodx[3] -> 2, rhodp[3] -> 0, phidc[3] -> 0,
      phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> 0, phids[3] -> 0,
      phidxc[3] -> 0, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0,
      phidxd[3] -> 4, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    };
    model = <|
      "name" -> "Index Gap",
      "shortname" -> "IG",
      "bibRef" -> "Test2025",
      "desc" -> "Model with index gap",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> Join[byParams, stock3Params]
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "IndexGap"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "index-gap-fails@@Tests/ValidateModels/validateModel_test37.wlt:26,1-51,2"
]

EndTestSection[]
