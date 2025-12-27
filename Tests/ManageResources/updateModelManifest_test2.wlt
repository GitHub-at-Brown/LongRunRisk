BeginTestSection["updateModelManifest"]

(* Setup: Load ManageResources package *)
If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed,
  BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[];
];
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
On[General::shdw];

(* Extract private symbols for testing *)
$getHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash"];
$canonicalize = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`canonicalize"];
$findPacletRoot = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot"];
$getVersion = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getVersion"];

$timeLimit = 5;

(* ============================================================ *)
(* Hash Determinism Tests *)
(* ============================================================ *)

VerificationTest[
  $getHash[<|"x" -> <|"b" -> 1, "a" -> 2|>|>] === $getHash[<|"x" -> <|"a" -> 2, "b" -> 1|>|>],
  True,
  TestID -> "hash-nested-key-order-invariant@@Tests/ManageResources/updateModelManifest_test2.wlt:23,1-27,2"
]

EndTestSection[]
