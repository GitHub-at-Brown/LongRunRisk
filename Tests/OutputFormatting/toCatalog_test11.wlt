BeginTestSection["toCatalog"]

(* Setup: Load NiceOutput package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];
On[General::shdw];

$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog;

(* Load catalog for testing with real models *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Empty Catalog Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{singleModel, result},
    singleModel = <|"BKY" -> $realModels["BKY"]|>;
    result = $toCatalog[singleModel, {"name"}];
    Length[result] === 1 && KeyExistsQ[result, "BKY"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-single-model@@Tests/NiceOutput/toCatalog_test11.wlt:20,1-29,2"
]

EndTestSection[]
