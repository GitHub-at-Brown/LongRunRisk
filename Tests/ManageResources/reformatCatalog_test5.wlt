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
    Module[{keysToKeep, raw, formatted, strings, modelNames, toCatalogFn, formatModelsFn, realModels},
      toCatalogFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog;
      formatModelsFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`formatModels;
      realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;
      keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
      raw = toCatalogFn[realModels, keysToKeep];
      formatted = formatModelsFn[raw];
      strings = Cases[formatted, _String, Infinity];
      modelNames = Values[#["shortname"]& /@ raw];
      AllTrue[modelNames, MemberQ[strings, s_String /; StringContainsQ[s, #]]&]
    ],
    General::shdw
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "reformatCatalog-all-models-in-formatted-output@@Tests/ManageResources/reformatCatalog.wlt:69,1-87,2"
]

EndTestSection[]
