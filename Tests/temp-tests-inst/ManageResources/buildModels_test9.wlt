BeginTestSection["buildModels"]

(* Setup: Load ManageResources package *)
If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed,
  BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[];
];
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
On[General::shdw];

(* Extract private symbols for testing *)
$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"];
$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"];
$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"];
$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"];
$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels;

$timeLimit = 5;

(* ============================================================ *)
(* Options Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{catalog1, catalog2, model, hash1, hash2},
    catalog1 = <|"name" -> "Test1", "shortname" -> "T1"|>;
    catalog2 = <|"name" -> "Test2", "shortname" -> "T2"|>;
    model = <|"exogenousEq" -> {x -> y}, "endogenousEq" -> {a -> b}|>;
    hash1 = $getMomentsHash[catalog1, model];
    hash2 = $getMomentsHash[catalog2, model];
    hash1 =!= hash2
  ],
  True,
  TestID -> "getMomentsHash-differs-for-different-catalog@@Tests/ManageResources/buildModels.wlt:91,1-102,2"
]

EndTestSection[]
