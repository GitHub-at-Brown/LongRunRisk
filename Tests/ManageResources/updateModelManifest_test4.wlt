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
  (* Different content should produce different hashes *)
  $getHash[<|"a" -> 1|>] =!= $getHash[<|"a" -> 2|>],
  True,
  TestID -> "hash-different-values-differ@@Tests/ManageResources/updateModelManifest_test4.wlt:23,1-28,2"
]

EndTestSection[]
