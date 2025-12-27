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
  Block[
    {FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot},
    FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := $Failed;
    updateModelManifest[]
  ] === $Failed,
  True,
  {FernandoDuarte`LongRunRisk`Tools`ManageResources`updateModelManifest::noroot},
  TimeConstraint -> $timeLimit,
  TestID -> "fails-when-root-not-found@@Tests/ManageResources/updateModelManifest_test6.wlt:23,1-33,2"
]

EndTestSection[]
