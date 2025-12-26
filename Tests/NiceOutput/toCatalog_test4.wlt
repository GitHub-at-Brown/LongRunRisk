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
  Module[{result},
    result = $toCatalog[$realModels, {"name"}];
    Keys[result] === Keys[$realModels]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-preserves-model-keys@@Tests/NiceOutput/toCatalog.wlt:48,1-56,2"
]

EndTestSection[]
