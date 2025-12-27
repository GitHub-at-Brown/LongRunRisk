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
  Module[
    {tmp, manifestFile, catalogOverride, result, fileData, dropDate, dateOK, versionOK, hashesOK},
    tmp = CreateDirectory[FileNameJoin[{$TemporaryDirectory, "tmp-" <> CreateUUID[]}]];
    manifestFile = FileNameJoin[{tmp, "Resources", "ModelManifest.wl"}];
    catalogOverride = <|"ModelA" -> <|"a" -> 1|>, "ModelB" -> <|"b" -> {1, 2}|>|>;
    dropDate = KeyDrop[#, {"Date"}] &;
    Block[
      {
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmp;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := catalogOverride;
      result = updateModelManifest[];
      fileData = Get[manifestFile];
    ];
    If[DirectoryQ[tmp], DeleteDirectory[tmp, DeleteContents -> True]];
    dateOK = StringQ[result["Date"]];
    With[
      {
        baseResult = dropDate[result],
        baseFile = dropDate[fileData],
        expectedCatalogHash = $getHash[catalogOverride],
        expectedModelHashes = Map[$getHash, catalogOverride]
      },
      versionOK = StringQ[baseResult["PacletVersion"]];
      hashesOK = baseResult["CatalogHash"] === expectedCatalogHash && baseResult["Models"] === expectedModelHashes;
      baseResult === baseFile && versionOK && hashesOK && dateOK
    ]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "writes-manifest-with-expected-content@@Tests/ManageResources/updateModelManifest_test8.wlt:23,1-57,2"
]

EndTestSection[]
