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
    Module[{keysToKeep, raw, formatted, toCatalogFn, formatModelsFn, realModels},
      toCatalogFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog;
      formatModelsFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`formatModels;
      realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;
      keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
      raw = toCatalogFn[realModels, keysToKeep];
      formatted = formatModelsFn[raw];
      Head[formatted] === BoxData
    ],
    General::shdw
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "reformatCatalog-formatModels-produces-BoxData@@Tests/ManageResources/reformatCatalog_test4.wlt:18,1-34,2"
]

EndTestSection[]
