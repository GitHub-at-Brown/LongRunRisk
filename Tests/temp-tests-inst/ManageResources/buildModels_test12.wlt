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
  Module[{tmpDir, momentsFile, metaFile, result},
    tmpDir = CreateDirectory[];
    momentsFile = FileNameJoin[{tmpDir, "covLongTest.wl"}];
    metaFile = FileNameJoin[{tmpDir, "covLongTest_meta.wl"}];
    (* Only create moments file, not meta file *)
    Put[{1, 2, 3}, momentsFile];
    result = $momentsUpToDate[momentsFile, metaFile, "somehash"];
    DeleteDirectory[tmpDir, DeleteContents -> True];
    result
  ],
  False,
  TestID -> "momentsUpToDate-false-when-meta-missing@@Tests/ManageResources/buildModels.wlt:127,1-140,2"
]

EndTestSection[]
