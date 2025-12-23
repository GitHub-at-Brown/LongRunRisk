BeginTestSection["pipelineIntegration"]

(* Setup: Load required packages *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"];
Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
On[General::shdw];

(* Load catalog *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];

$timeLimit = 10;

(* ============================================================ *)
(* Package Loading Tests *)
(* ============================================================ *)

VerificationTest[
  MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Model`Catalog`"],
  True,
  TestID -> "catalog-package-loaded@@Tests/ProcessModels/pipelineIntegration.wlt:18,1-22,2"
]

VerificationTest[
  MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"],
  True,
  TestID -> "processModels-package-loaded@@Tests/ProcessModels/pipelineIntegration.wlt:24,1-28,2"
]

VerificationTest[
  MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Tools`ManageResources`"],
  True,
  TestID -> "manageResources-package-loaded@@Tests/ProcessModels/pipelineIntegration.wlt:30,1-34,2"
]

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels],
  Symbol,
  TestID -> "processModels-symbol-exists@@Tests/ProcessModels/pipelineIntegration.wlt:40,1-44,2"
]

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels],
  Symbol,
  TestID -> "buildModels-symbol-exists@@Tests/ProcessModels/pipelineIntegration.wlt:46,1-50,2"
]

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels::usage],
  True,
  TestID -> "processModels-has-usage@@Tests/ProcessModels/pipelineIntegration.wlt:52,1-56,2"
]

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels::usage],
  True,
  TestID -> "buildModels-has-usage@@Tests/ProcessModels/pipelineIntegration.wlt:58,1-62,2"
]

(* ============================================================ *)
(* Catalog Tests *)
(* ============================================================ *)

VerificationTest[
  AssociationQ[FernandoDuarte`LongRunRisk`Model`Catalog`models],
  True,
  TestID -> "catalog-is-association@@Tests/ProcessModels/pipelineIntegration.wlt:68,1-72,2"
]

VerificationTest[
  Length[FernandoDuarte`LongRunRisk`Model`Catalog`models] > 0,
  True,
  TestID -> "catalog-has-models@@Tests/ProcessModels/pipelineIntegration.wlt:74,1-78,2"
]

VerificationTest[
  AllTrue[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], StringQ],
  True,
  TestID -> "catalog-keys-are-strings@@Tests/ProcessModels/pipelineIntegration.wlt:80,1-84,2"
]

VerificationTest[
  AllTrue[Values[FernandoDuarte`LongRunRisk`Model`Catalog`models], AssociationQ],
  True,
  TestID -> "catalog-values-are-associations@@Tests/ProcessModels/pipelineIntegration.wlt:86,1-90,2"
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
  TestID -> "BKY-model-has-required-keys@@Tests/ProcessModels/pipelineIntegration.wlt:96,1-104,2"
]

VerificationTest[
  Module[{model},
    model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"];
    KeyExistsQ[model, "enabled"] && BooleanQ[model["enabled"]]
  ],
  True,
  TestID -> "BY-model-has-enabled-boolean@@Tests/ProcessModels/pipelineIntegration.wlt:106,1-113,2"
]

VerificationTest[
  Module[{model},
    model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BKY"];
    KeyExistsQ[model, "enabled"] && BooleanQ[model["enabled"]]
  ],
  True,
  TestID -> "BKY-model-has-enabled-boolean@@Tests/ProcessModels/pipelineIntegration.wlt:115,1-122,2"
]

EndTestSection[]
