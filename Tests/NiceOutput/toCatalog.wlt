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
  TestID -> "toCatalog-empty-catalog-returns-empty"
]

VerificationTest[
  AssociationQ[$toCatalog[<||>, {"name"}]],
  True,
  TestID -> "toCatalog-empty-catalog-is-association"
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
  TestID -> "toCatalog-returns-associations"
]

VerificationTest[
  Module[{result},
    result = $toCatalog[$realModels, {"name"}];
    Keys[result] === Keys[$realModels]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-preserves-model-keys"
]

VerificationTest[
  Module[{result},
    result = $toCatalog[$realModels, {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"}];
    (* each model should have only the requested keys plus stateVars handling *)
    AllTrue[Values[result], Length[#] >= 6 &]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-filters-to-specified-keys"
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
  TestID -> "toCatalog-evaluates-stateVars-function"
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
  TestID -> "toCatalog-preserves-stateVars-list"
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
  TestID -> "toCatalog-preserves-enabled-boolean"
]

VerificationTest[
  Module[{result},
    result = $toCatalog[$realModels, {"parameters"}];
    (* parameters should be List of Rules *)
    AllTrue[Values[result], ListQ[#["parameters"]] &]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-preserves-parameters-list"
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
  TestID -> "toCatalog-filters-out-extra-fields"
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
  TestID -> "toCatalog-single-model"
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
  TestID -> "toCatalog-preserves-all-models"
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
  TestID -> "toCatalog-full-catalog-roundtrip"
]
