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
  Head[FernandoDuarte`LongRunRisk`Tools`ManageResources`reformatCatalog],
  Symbol,
  TestID -> "reformatCatalog-symbol-exists@@Tests/ManageResources/reformatCatalog.wlt:18,1-22,2"
]

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`ManageResources`reformatCatalog::usage],
  True,
  TestID -> "reformatCatalog-has-usage@@Tests/ManageResources/reformatCatalog.wlt:24,1-28,2"
]

(* ============================================================ *)
(* Underlying Formatting Pipeline Tests *)
(* These test the functions that reformatCatalog uses internally *)
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
  TestID -> "reformatCatalog-toCatalog-works-on-full-catalog@@Tests/ManageResources/reformatCatalog.wlt:35,1-49,2"
]

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
  TestID -> "reformatCatalog-formatModels-produces-BoxData@@Tests/ManageResources/reformatCatalog.wlt:51,1-67,2"
]

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
  TestID -> "reformatCatalog-enabled-field-in-output@@Tests/ManageResources/reformatCatalog.wlt:89,1-106,2"
]

(* ============================================================ *)
(* Idempotency Tests for Formatting Pipeline *)
(* ============================================================ *)

VerificationTest[
  Module[{normalizeWS, stringFmt, desc, r1, r2, r3},
    normalizeWS = ToExpression["FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`normalizeWhitespace"];
    stringFmt = ToExpression["FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stringFormattingTemplate"];
    desc = "Bansal and Yaron (2004) long-run risk model with stochastic volatility of consumption growth.";
    r1 = stringFmt[desc];
    r2 = stringFmt[r1];
    r3 = stringFmt[r2];
    r1 === r2 && r2 === r3
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "reformatCatalog-string-formatting-idempotent@@Tests/ManageResources/reformatCatalog.wlt:112,1-125,2"
]

EndTestSection[]
