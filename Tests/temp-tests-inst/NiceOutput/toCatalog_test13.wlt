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
  Module[{keysToKeep, result},
    keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
    result = $toCatalog[$realModels, keysToKeep];
    (* verify result is valid association with all expected models *)
    AssociationQ[result] &&
    AllTrue[Keys[$realModels], KeyExistsQ[result, #] &] &&
    AllTrue[Values[result], AssociationQ]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-full-catalog-roundtrip@@Tests/NiceOutput/toCatalog.wlt:190,1-202,2"
]

EndTestSection[]
