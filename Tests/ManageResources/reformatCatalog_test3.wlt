BeginTestSection["reformatCatalog"]

(* Setup: Load required packages *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];
On[General::shdw];

(* Load catalog for testing *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];

$timeLimit = 30;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Quiet[
    Module[{keysToKeep, raw, toCatalogFn, realModels},
      toCatalogFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog;
      realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;
      keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
      raw = toCatalogFn[realModels, keysToKeep];
      AssociationQ[raw] && Length[raw] === Length[realModels]
    ],
    General::shdw
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "reformatCatalog-toCatalog-works-on-full-catalog@@Tests/ManageResources/reformatCatalog_test3.wlt:18,1-32,2"
]

EndTestSection[]
