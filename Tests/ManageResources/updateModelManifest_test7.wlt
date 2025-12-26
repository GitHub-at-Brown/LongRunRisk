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
  Module[{tmp, manifestFile, result, fileExists},
    tmp = CreateDirectory[FileNameJoin[{$TemporaryDirectory, "tmp-" <> CreateUUID[]}]];
    manifestFile = FileNameJoin[{tmp, "Resources", "ModelManifest.wl"}];
    Block[
      {
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmp;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := 42;  (* Not an association *)
      result = updateModelManifest[];
      fileExists = FileExistsQ[manifestFile];
    ];
    If[DirectoryQ[tmp], DeleteDirectory[tmp, DeleteContents -> True]];
    result === $Failed && fileExists === False
  ],
  True,
  {FernandoDuarte`LongRunRisk`Tools`ManageResources`updateModelManifest::nocat},
  TimeConstraint -> $timeLimit,
  TestID -> "rejects-non-association-catalog@@Tests/ManageResources/updateModelManifest.wlt:71,1-92,2"
]

EndTestSection[]
