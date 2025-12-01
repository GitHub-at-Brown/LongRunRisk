(* Setup: Load required packages *)
Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName], Directory[]];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
    d = DirectoryName[d]];
  pacletRoot = d;
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "Model", "ProcessModels.wl"}]];
  Get[FileNameJoin[{pacletRoot, "Kernel", "Tools", "ManageResources.wl"}]];
  On[General::shdw];
];

(* Load catalog *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];

$timeLimit = 10;

(* ============================================================ *)
(* Package Loading Tests *)
(* ============================================================ *)

VerificationTest[
  MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Model`Catalog`"],
  True,
  TestID -> "catalog-package-loaded"
]

VerificationTest[
  MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"],
  True,
  TestID -> "processModels-package-loaded"
]

VerificationTest[
  MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Tools`ManageResources`"],
  True,
  TestID -> "manageResources-package-loaded"
]

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels],
  Symbol,
  TestID -> "processModels-symbol-exists"
]

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels],
  Symbol,
  TestID -> "buildModels-symbol-exists"
]

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels::usage],
  True,
  TestID -> "processModels-has-usage"
]

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels::usage],
  True,
  TestID -> "buildModels-has-usage"
]

(* ============================================================ *)
(* Catalog Tests *)
(* ============================================================ *)

VerificationTest[
  AssociationQ[FernandoDuarte`LongRunRisk`Model`Catalog`models],
  True,
  TestID -> "catalog-is-association"
]

VerificationTest[
  Length[FernandoDuarte`LongRunRisk`Model`Catalog`models] > 0,
  True,
  TestID -> "catalog-has-models"
]

VerificationTest[
  AllTrue[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], StringQ],
  True,
  TestID -> "catalog-keys-are-strings"
]

VerificationTest[
  AllTrue[Values[FernandoDuarte`LongRunRisk`Model`Catalog`models], AssociationQ],
  True,
  TestID -> "catalog-values-are-associations"
]

(* ============================================================ *)
(* Model Structure Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{model},
    model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BKY"];
    KeyExistsQ[model, "name"] && KeyExistsQ[model, "shortname"] &&
    KeyExistsQ[model, "parameters"] && KeyExistsQ[model, "stateVars"]
  ],
  True,
  TestID -> "BKY-model-has-required-keys"
]

VerificationTest[
  Module[{model},
    model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"];
    KeyExistsQ[model, "enabled"] && BooleanQ[model["enabled"]]
  ],
  True,
  TestID -> "BY-model-has-enabled-boolean"
]

VerificationTest[
  Module[{model},
    model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BKY"];
    KeyExistsQ[model, "enabled"] && BooleanQ[model["enabled"]]
  ],
  True,
  TestID -> "BKY-model-has-enabled-boolean"
]
