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

EndTestSection[]
