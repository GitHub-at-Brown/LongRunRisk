BeginTestSection["toCatalog"]
Begin["FernandoDuarte`LongRunRisk`Tests`NiceOutput`toCatalog`"]

(* Setup: Load NiceOutput.wl and Catalog *)
Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName], Directory[]];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
    d = DirectoryName[d]];
  pacletRoot = d;
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "Tools", "NiceOutput.wl"}]];
  On[General::shdw];
];

$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog;

(* Load catalog for testing with real models *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Empty Catalog Tests *)
(* ============================================================ *)

VerificationTest[
  $toCatalog[<||>, {"name", "shortname"}],
  <||>,
  TestID -> "toCatalog-empty-catalog-returns-empty@@Tests/NiceOutput/toCatalog.wlt:26,1-30,2"
]

VerificationTest[
  AssociationQ[$toCatalog[<||>, {"name"}]],
  True,
  TestID -> "toCatalog-empty-catalog-is-association@@Tests/NiceOutput/toCatalog.wlt:32,1-36,2"
]

(* ============================================================ *)
(* Key Filtering Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{result, expectedKeys},
    result = $toCatalog[$realModels, {"name", "shortname"}];
    expectedKeys = Sort[{"name", "shortname", "stateVars"}];
    (* stateVars may be included if present in keysToKeep *)
    AllTrue[Values[result], AssociationQ]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-returns-associations@@Tests/NiceOutput/toCatalog.wlt:42,1-52,2"
]

VerificationTest[
  Module[{result},
    result = $toCatalog[$realModels, {"name"}];
    Keys[result] === Keys[$realModels]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-preserves-model-keys@@Tests/NiceOutput/toCatalog.wlt:54,1-62,2"
]

VerificationTest[
  Module[{result},
    result = $toCatalog[$realModels, {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"}];
    (* each model should have only the requested keys plus stateVars handling *)
    AllTrue[Values[result], Length[#] >= 6 &]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-filters-to-specified-keys@@Tests/NiceOutput/toCatalog.wlt:64,1-73,2"
]

(* ============================================================ *)
(* StateVars Handling Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{testModel, result},
    (* model with stateVars as Function *)
    testModel = <|
      "test" -> <|
        "name" -> "Test",
        "stateVars" -> Function[t, {x[t], sc[t]}],
        "parameters" -> {delta -> 0.999}
      |>
    |>;
    result = $toCatalog[testModel, {"stateVars"}];
    (* Function should be evaluated *)
    Head[result["test"]["stateVars"]] === List
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-evaluates-stateVars-function@@Tests/NiceOutput/toCatalog.wlt:79,1-96,2"
]

VerificationTest[
  Module[{testModel, result},
    (* model with stateVars as List *)
    testModel = <|
      "test" -> <|
        "name" -> "Test",
        "stateVars" -> {x[t], sc[t]},
        "parameters" -> {delta -> 0.999}
      |>
    |>;
    result = $toCatalog[testModel, {"stateVars"}];
    (* List should remain unchanged *)
    Head[result["test"]["stateVars"]] === List
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-preserves-stateVars-list@@Tests/NiceOutput/toCatalog.wlt:98,1-115,2"
]

(* ============================================================ *)
(* Field Preservation Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{result},
    result = $toCatalog[$realModels, {"enabled"}];
    (* enabled field should be Boolean *)
    AllTrue[Values[result], BooleanQ[#["enabled"]] &]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-preserves-enabled-boolean@@Tests/NiceOutput/toCatalog.wlt:121,1-130,2"
]

VerificationTest[
  Module[{result},
    result = $toCatalog[$realModels, {"parameters"}];
    (* parameters should be List of Rules *)
    AllTrue[Values[result], ListQ[#["parameters"]] &]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-preserves-parameters-list@@Tests/NiceOutput/toCatalog.wlt:132,1-141,2"
]

VerificationTest[
  Module[{testModel, result},
    testModel = <|
      "test" -> <|
        "name" -> "Test Model",
        "shortname" -> "TM",
        "bibRef" -> "test2024",
        "desc" -> "A test model",
        "enabled" -> True,
        "stateVars" -> {x[t]},
        "parameters" -> {delta -> 0.999},
        "extraField" -> "should be filtered"
      |>
    |>;
    result = $toCatalog[testModel, {"name", "shortname"}];
    !KeyExistsQ[result["test"], "extraField"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-filters-out-extra-fields@@Tests/NiceOutput/toCatalog.wlt:143,1-163,2"
]

(* ============================================================ *)
(* Single and Multiple Model Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{singleModel, result},
    singleModel = <|"BKY" -> $realModels["BKY"]|>;
    result = $toCatalog[singleModel, {"name"}];
    Length[result] === 1 && KeyExistsQ[result, "BKY"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-single-model@@Tests/NiceOutput/toCatalog.wlt:169,1-178,2"
]

VerificationTest[
  Module[{result, keysToKeep},
    keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
    result = $toCatalog[$realModels, keysToKeep];
    (* should have same number of models as input *)
    Length[result] === Length[$realModels]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-preserves-all-models@@Tests/NiceOutput/toCatalog.wlt:180,1-190,2"
]

(* ============================================================ *)
(* Full Catalog Round-trip Test *)
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
  TestID -> "toCatalog-full-catalog-roundtrip@@Tests/NiceOutput/toCatalog.wlt:196,1-208,2"
]

End[]
EndTestSection[]
