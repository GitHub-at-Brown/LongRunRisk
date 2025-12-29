BeginTestSection["pipelineIntegration Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ProcessModels`pipelineIntegration`"]

(* --- merged from: pipelineIntegration_test1.wlt --- *)
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
  TestID -> "catalog-package-loaded@@Tests/ProcessModels/pipelineIntegration.wlt:20,1-24,2"
]

(* --- merged from: pipelineIntegration_test2.wlt --- *)
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
  MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"],
  True,
  TestID -> "processModels-package-loaded@@Tests/ProcessModels/pipelineIntegration.wlt:42,1-46,2"
]

(* --- merged from: pipelineIntegration_test3.wlt --- *)
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
  MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Tools`ManageResources`"],
  True,
  TestID -> "manageResources-package-loaded@@Tests/ProcessModels/pipelineIntegration.wlt:64,1-68,2"
]

(* --- merged from: pipelineIntegration_test4.wlt --- *)
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
  Head[FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels],
  Symbol,
  TestID -> "processModels-symbol-exists@@Tests/ProcessModels/pipelineIntegration.wlt:86,1-90,2"
]

(* --- merged from: pipelineIntegration_test5.wlt --- *)
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
  Head[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels],
  Symbol,
  TestID -> "buildModels-symbol-exists@@Tests/ProcessModels/pipelineIntegration.wlt:108,1-112,2"
]

(* --- merged from: pipelineIntegration_test6.wlt --- *)
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
  StringQ[FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels::usage],
  True,
  TestID -> "processModels-has-usage@@Tests/ProcessModels/pipelineIntegration.wlt:130,1-134,2"
]

(* --- merged from: pipelineIntegration_test7.wlt --- *)
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
  StringQ[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels::usage],
  True,
  TestID -> "buildModels-has-usage@@Tests/ProcessModels/pipelineIntegration.wlt:152,1-156,2"
]

(* --- merged from: pipelineIntegration_test8.wlt --- *)
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
  AssociationQ[FernandoDuarte`LongRunRisk`Model`Catalog`models],
  True,
  TestID -> "catalog-is-association@@Tests/ProcessModels/pipelineIntegration.wlt:174,1-178,2"
]

(* --- merged from: pipelineIntegration_test9.wlt --- *)
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
  Length[FernandoDuarte`LongRunRisk`Model`Catalog`models] > 0,
  True,
  TestID -> "catalog-has-models@@Tests/ProcessModels/pipelineIntegration.wlt:196,1-200,2"
]

(* --- merged from: pipelineIntegration_test10.wlt --- *)
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
  AllTrue[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], StringQ],
  True,
  TestID -> "catalog-keys-are-strings@@Tests/ProcessModels/pipelineIntegration.wlt:218,1-222,2"
]

(* --- merged from: pipelineIntegration_test11.wlt --- *)
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
  AllTrue[Values[FernandoDuarte`LongRunRisk`Model`Catalog`models], AssociationQ],
  True,
  TestID -> "catalog-values-are-associations@@Tests/ProcessModels/pipelineIntegration.wlt:240,1-244,2"
]

(* --- merged from: pipelineIntegration_test12.wlt --- *)
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
  Module[{model},
    model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BKY"];
    KeyExistsQ[model, "name"] && KeyExistsQ[model, "shortname"] &&
    KeyExistsQ[model, "parameters"] && KeyExistsQ[model, "stateVars"]
  ],
  True,
  TestID -> "BKY-model-has-required-keys@@Tests/ProcessModels/pipelineIntegration.wlt:262,1-270,2"
]

(* --- merged from: pipelineIntegration_test13.wlt --- *)
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
  Module[{model},
    model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"];
    KeyExistsQ[model, "enabled"] && BooleanQ[model["enabled"]]
  ],
  True,
  TestID -> "BY-model-has-enabled-boolean@@Tests/ProcessModels/pipelineIntegration.wlt:288,1-295,2"
]

(* --- merged from: pipelineIntegration_test14.wlt --- *)
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
  Module[{model},
    model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BKY"];
    KeyExistsQ[model, "enabled"] && BooleanQ[model["enabled"]]
  ],
  True,
  TestID -> "BKY-model-has-enabled-boolean@@Tests/ProcessModels/pipelineIntegration.wlt:313,1-320,2"
]

End[]
EndTestSection[]
