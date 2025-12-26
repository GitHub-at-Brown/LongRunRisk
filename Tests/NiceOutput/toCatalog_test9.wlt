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
  Module[{result},
    result = $toCatalog[$realModels, {"parameters"}];
    (* parameters should be List of Rules *)
    AllTrue[Values[result], ListQ[#["parameters"]] &]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "toCatalog-preserves-parameters-list@@Tests/NiceOutput/toCatalog.wlt:126,1-135,2"
]

EndTestSection[]
