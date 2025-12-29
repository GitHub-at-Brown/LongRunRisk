BeginTestSection["updateModelManifest Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ManageResources`updateModelManifest`"]

(* --- merged from: updateModelManifest_test1.wlt --- *)
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
  TestID -> "hash-key-order-invariant@@Tests/ManageResources/updateModelManifest.wlt:25,1-29,2"
]

(* --- merged from: updateModelManifest_test2.wlt --- *)
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
  $getHash[<|"x" -> <|"b" -> 1, "a" -> 2|>|>] === $getHash[<|"x" -> <|"a" -> 2, "b" -> 1|>|>],
  True,
  TestID -> "hash-nested-key-order-invariant@@Tests/ManageResources/updateModelManifest.wlt:52,1-56,2"
]

(* --- merged from: updateModelManifest_test3.wlt --- *)
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
  $getHash[<|"z" -> {<|"b" -> 1|>, <|"a" -> 2|>}|>] === $getHash[<|"z" -> {<|"b" -> 1|>, <|"a" -> 2|>}|>],
  True,
  TestID -> "hash-list-of-associations@@Tests/ManageResources/updateModelManifest.wlt:79,1-83,2"
]

(* --- merged from: updateModelManifest_test4.wlt --- *)
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
  TestID -> "hash-different-values-differ@@Tests/ManageResources/updateModelManifest.wlt:106,1-111,2"
]

(* --- merged from: updateModelManifest_test5.wlt --- *)
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
  (* Canonicalize should sort keys recursively *)
  $canonicalize[<|"b" -> <|"d" -> 1, "c" -> 2|>, "a" -> 3|>],
  <|"a" -> 3, "b" -> <|"c" -> 2, "d" -> 1|>|>,
  TestID -> "canonicalize-sorts-nested-keys@@Tests/ManageResources/updateModelManifest.wlt:134,1-139,2"
]

(* --- merged from: updateModelManifest_test6.wlt --- *)
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
  TestID -> "fails-when-root-not-found@@Tests/ManageResources/updateModelManifest.wlt:162,1-172,2"
]

(* --- merged from: updateModelManifest_test7.wlt --- *)
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
  TestID -> "rejects-non-association-catalog@@Tests/ManageResources/updateModelManifest.wlt:195,1-216,2"
]

(* --- merged from: updateModelManifest_test8.wlt --- *)
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
  TestID -> "writes-manifest-with-expected-content@@Tests/ManageResources/updateModelManifest.wlt:239,1-273,2"
]

(* --- merged from: updateModelManifest_test9.wlt --- *)
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
  TestID -> "hash-complex-permutation-invariant@@Tests/ManageResources/updateModelManifest.wlt:296,1-311,2"
]

End[]
EndTestSection[]
