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
  Module[{catalog1, catalog2},
    (* Same content, different key order at multiple levels *)
    catalog1 = <|
      "ModelB" -> <|"params" -> <|"gamma" -> 2, "beta" -> 1|>, "name" -> "B"|>,
      "ModelA" -> <|"name" -> "A", "params" -> <|"alpha" -> 0|>|>
    |>;
    catalog2 = <|
      "ModelA" -> <|"params" -> <|"alpha" -> 0|>, "name" -> "A"|>,
      "ModelB" -> <|"name" -> "B", "params" -> <|"beta" -> 1, "gamma" -> 2|>|>
    |>;
    $getHash[catalog1] === $getHash[catalog2]
  ],
  True,
  TestID -> "hash-complex-permutation-invariant@@Tests/ManageResources/updateModelManifest_test9.wlt:23,1-38,2"
]

EndTestSection[]
