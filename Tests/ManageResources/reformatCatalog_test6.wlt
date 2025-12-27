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
    Module[{keysToKeep, raw, formatted, strings, toCatalogFn, formatModelsFn, realModels},
      toCatalogFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog;
      formatModelsFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`formatModels;
      realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;
      keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
      raw = toCatalogFn[realModels, keysToKeep];
      formatted = formatModelsFn[raw];
      strings = Cases[formatted, _String, Infinity];
      MemberQ[strings, s_String /; StringContainsQ[s, "enabled"]]
    ],
    General::shdw
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "reformatCatalog-enabled-field-in-output@@Tests/ManageResources/reformatCatalog_test6.wlt:18,1-35,2"
]

EndTestSection[]
