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
  StringQ[FernandoDuarte`LongRunRisk`Tools`ManageResources`reformatCatalog::usage],
  True,
  TestID -> "reformatCatalog-has-usage@@Tests/ManageResources/reformatCatalog_test2.wlt:18,1-22,2"
]

EndTestSection[]
