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
  $getHash[<|"b" -> 1, "a" -> 2|>] === $getHash[<|"a" -> 2, "b" -> 1|>],
  True,
  TestID -> "hash-key-order-invariant@@Tests/ManageResources/updateModelManifest.wlt:23,1-27,2"
]

VerificationTest[
  $getHash[<|"x" -> <|"b" -> 1, "a" -> 2|>|>] === $getHash[<|"x" -> <|"a" -> 2, "b" -> 1|>|>],
  True,
  TestID -> "hash-nested-key-order-invariant@@Tests/ManageResources/updateModelManifest.wlt:29,1-33,2"
]

VerificationTest[
  $getHash[<|"z" -> {<|"b" -> 1|>, <|"a" -> 2|>}|>] === $getHash[<|"z" -> {<|"b" -> 1|>, <|"a" -> 2|>}|>],
  True,
  TestID -> "hash-list-of-associations@@Tests/ManageResources/updateModelManifest.wlt:35,1-39,2"
]

VerificationTest[
  (* Different content should produce different hashes *)
  $getHash[<|"a" -> 1|>] =!= $getHash[<|"a" -> 2|>],
  True,
  TestID -> "hash-different-values-differ@@Tests/ManageResources/updateModelManifest.wlt:41,1-46,2"
]

VerificationTest[
  (* Canonicalize should sort keys recursively *)
  $canonicalize[<|"b" -> <|"d" -> 1, "c" -> 2|>, "a" -> 3|>],
  <|"a" -> 3, "b" -> <|"c" -> 2, "d" -> 1|>|>,
  TestID -> "canonicalize-sorts-nested-keys@@Tests/ManageResources/updateModelManifest.wlt:48,1-53,2"
]

(* ============================================================ *)
(* updateModelManifest Error Handling Tests *)
(* ============================================================ *)

VerificationTest[
  Block[
    {FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot},
    FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := $Failed;
    updateModelManifest[]
  ],
  $Failed,
  {updateModelManifest::noroot},
  TimeConstraint -> $timeLimit,
  TestID -> "fails-when-root-not-found@@Tests/ManageResources/updateModelManifest.wlt:59,1-69,2"
]

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
    {result, fileExists}
  ],
  {$Failed, False},
  {updateModelManifest::nocat},
  TimeConstraint -> $timeLimit,
  TestID -> "rejects-non-association-catalog@@Tests/ManageResources/updateModelManifest.wlt:71,1-92,2"
]

(* ============================================================ *)
(* updateModelManifest Success Path Test *)
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
  TestID -> "writes-manifest-with-expected-content@@Tests/ManageResources/updateModelManifest.wlt:98,1-132,2"
]

(* ============================================================ *)
(* Hash Consistency with Key Permutation Test *)
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
  TestID -> "hash-complex-permutation-invariant@@Tests/ManageResources/updateModelManifest.wlt:138,1-153,2"
]

EndTestSection[]
