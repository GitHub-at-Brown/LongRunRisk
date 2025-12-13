(* Setup: Load ManageResources.wl and NiceOutput.wl *)
Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName], Directory[]];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
    d = DirectoryName[d]];
  pacletRoot = d;
  SetDirectory[pacletRoot];
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "Tools", "ManageResources.wl"}]];
  Get[FileNameJoin[{pacletRoot, "Kernel", "Tools", "NiceOutput.wl"}]];
  On[General::shdw];
];

(* Load catalog for testing *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];

$timeLimit = 30;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`Tools`ManageResources`reformatCatalog],
  Symbol,
  TestID -> "reformatCatalog-symbol-exists"
]

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`ManageResources`reformatCatalog::usage],
  True,
  TestID -> "reformatCatalog-has-usage"
]

(* ============================================================ *)
(* Underlying Formatting Pipeline Tests *)
(* These test the functions that reformatCatalog uses internally *)
(* ============================================================ *)

VerificationTest[
  Module[{keysToKeep, raw, toCatalogFn, realModels},
    toCatalogFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog;
    realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;
    keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
    raw = toCatalogFn[realModels, keysToKeep];
    AssociationQ[raw] && Length[raw] === Length[realModels]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "reformatCatalog-toCatalog-works-on-full-catalog"
]

VerificationTest[
  Module[{keysToKeep, raw, formatted, toCatalogFn, formatModelsFn, realModels},
    toCatalogFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog;
    formatModelsFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`formatModels;
    realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;
    keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
    raw = toCatalogFn[realModels, keysToKeep];
    formatted = formatModelsFn[raw];
    Head[formatted] === BoxData
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "reformatCatalog-formatModels-produces-BoxData"
]

VerificationTest[
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
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "reformatCatalog-all-models-in-formatted-output"
]

VerificationTest[
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
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "reformatCatalog-enabled-field-in-output"
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
  TestID -> "reformatCatalog-string-formatting-idempotent"
]
