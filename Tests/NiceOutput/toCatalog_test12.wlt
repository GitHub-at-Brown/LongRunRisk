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
  Module[{result, keysToKeep},
    keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
    result = $toCatalog[$realModels, keysToKeep];
    (* should have same number of models as input *)
    Length[result] === Length[$realModels]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-preserves-all-models@@Tests/NiceOutput/toCatalog_test12.wlt:20,1-30,2"
]

EndTestSection[]
