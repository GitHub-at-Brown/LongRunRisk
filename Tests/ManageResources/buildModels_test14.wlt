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
    Put[{1, 2, 3}, momentsFile];
    Put[<|"Hash" -> "oldhash", "Date" -> "2024-01-01"|>, metaFile];
    result = $momentsUpToDate[momentsFile, metaFile, "newhash"];
    DeleteDirectory[tmpDir, DeleteContents -> True];
    result
  ],
  False,
  TestID -> "momentsUpToDate-false-when-hash-differs@@Tests/ManageResources/buildModels.wlt:157,1-170,2"
]

EndTestSection[]
