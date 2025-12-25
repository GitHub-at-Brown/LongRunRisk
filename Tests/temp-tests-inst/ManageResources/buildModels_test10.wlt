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
  Module[{catalog, model1, model2, hash1, hash2},
    catalog = <|"name" -> "Test", "shortname" -> "T"|>;
    model1 = <|"exogenousEq" -> {x -> y}, "endogenousEq" -> {a -> b}|>;
    model2 = <|"exogenousEq" -> {x -> z}, "endogenousEq" -> {a -> b}|>;
    hash1 = $getMomentsHash[catalog, model1];
    hash2 = $getMomentsHash[catalog, model2];
    hash1 =!= hash2
  ],
  True,
  TestID -> "getMomentsHash-differs-for-different-exogenousEq@@Tests/ManageResources/buildModels.wlt:104,1-115,2"
]

EndTestSection[]
