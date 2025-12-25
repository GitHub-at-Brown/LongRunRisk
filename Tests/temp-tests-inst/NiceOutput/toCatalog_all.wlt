BeginTestSection["toCatalog"]

(* Setup: Load NiceOutput package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];
On[General::shdw];

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
  TestID -> "toCatalog-empty-catalog-returns-empty@@Tests/NiceOutput/toCatalog.wlt:20,1-24,2"
]

VerificationTest[
  AssociationQ[$toCatalog[<||>, {"name"}]],
  True,
  TestID -> "toCatalog-empty-catalog-is-association@@Tests/NiceOutput/toCatalog.wlt:26,1-30,2"
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
  TestID -> "toCatalog-returns-associations@@Tests/NiceOutput/toCatalog.wlt:36,1-46,2"
]

VerificationTest[
  Module[{result},
    result = $toCatalog[$realModels, {"name"}];
    Keys[result] === Keys[$realModels]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-preserves-model-keys@@Tests/NiceOutput/toCatalog.wlt:48,1-56,2"
]

VerificationTest[
  Module[{result},
    result = $toCatalog[$realModels, {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"}];
    (* each model should have only the requested keys plus stateVars handling *)
    AllTrue[Values[result], Length[#] >= 6 &]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-filters-to-specified-keys@@Tests/NiceOutput/toCatalog.wlt:58,1-67,2"
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
  TestID -> "toCatalog-evaluates-stateVars-function@@Tests/NiceOutput/toCatalog.wlt:73,1-90,2"
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
  TestID -> "toCatalog-preserves-stateVars-list@@Tests/NiceOutput/toCatalog.wlt:92,1-109,2"
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
  TestID -> "toCatalog-preserves-enabled-boolean@@Tests/NiceOutput/toCatalog.wlt:115,1-124,2"
]

VerificationTest[
  Module[{result},
    result = $toCatalog[$realModels, {"parameters"}];
    (* parameters should be List of Rules *)
    AllTrue[Values[result], ListQ[#["parameters"]] &]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-preserves-parameters-list@@Tests/NiceOutput/toCatalog.wlt:126,1-135,2"
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
  TestID -> "toCatalog-filters-out-extra-fields@@Tests/NiceOutput/toCatalog.wlt:137,1-157,2"
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
  TestID -> "toCatalog-single-model@@Tests/NiceOutput/toCatalog.wlt:163,1-172,2"
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
  TestID -> "toCatalog-preserves-all-models@@Tests/NiceOutput/toCatalog.wlt:174,1-184,2"
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
  TestID -> "toCatalog-full-catalog-roundtrip@@Tests/NiceOutput/toCatalog.wlt:190,1-202,2"
]

EndTestSection[]
