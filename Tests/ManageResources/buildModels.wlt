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
  MemberQ[Keys[Options[$buildModels]], "CreateMoments"],
  True,
  TestID -> "buildModels-has-CreateMoments-option@@Tests/ManageResources/buildModels.wlt:24,1-28,2"
]

VerificationTest[
  MemberQ[Keys[Options[$buildModels]], "NumKernels"],
  True,
  TestID -> "buildModels-has-NumKernels-option@@Tests/ManageResources/buildModels.wlt:30,1-34,2"
]

VerificationTest[
  OptionValue[$buildModels, "CreateMoments"],
  True,
  TestID -> "buildModels-CreateMoments-default-is-True@@Tests/ManageResources/buildModels.wlt:36,1-40,2"
]

VerificationTest[
  OptionValue[$buildModels, "NumKernels"],
  Automatic,
  TestID -> "buildModels-NumKernels-default-is-Automatic@@Tests/ManageResources/buildModels.wlt:42,1-46,2"
]

(* ============================================================ *)
(* Message Tests *)
(* ============================================================ *)

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels::noroot],
  True,
  TestID -> "buildModels-has-noroot-message@@Tests/ManageResources/buildModels.wlt:52,1-56,2"
]

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels::nocat],
  True,
  TestID -> "buildModels-has-nocat-message@@Tests/ManageResources/buildModels.wlt:58,1-62,2"
]

(* ============================================================ *)
(* getMomentsHash Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{catalog, model, hash},
    catalog = <|"name" -> "Test", "shortname" -> "T"|>;
    model = <|"exogenousEq" -> {x -> y}, "endogenousEq" -> {a -> b}|>;
    hash = $getMomentsHash[catalog, model];
    StringQ[hash] && StringLength[hash] == 64
  ],
  True,
  TestID -> "getMomentsHash-returns-64-char-hex-string@@Tests/ManageResources/buildModels.wlt:68,1-77,2"
]

VerificationTest[
  Module[{catalog, model, hash1, hash2},
    catalog = <|"name" -> "Test", "shortname" -> "T"|>;
    model = <|"exogenousEq" -> {x -> y}, "endogenousEq" -> {a -> b}|>;
    hash1 = $getMomentsHash[catalog, model];
    hash2 = $getMomentsHash[catalog, model];
    hash1 === hash2
  ],
  True,
  TestID -> "getMomentsHash-is-deterministic@@Tests/ManageResources/buildModels.wlt:79,1-89,2"
]

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

(* ============================================================ *)
(* momentsUpToDate Tests *)
(* ============================================================ *)

VerificationTest[
  $momentsUpToDate["/nonexistent/file.wl", "/nonexistent/meta.wl", "somehash"],
  False,
  TestID -> "momentsUpToDate-false-for-nonexistent-files@@Tests/ManageResources/buildModels.wlt:121,1-125,2"
]

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

VerificationTest[
  Module[{tmpDir, momentsFile, metaFile, result},
    tmpDir = CreateDirectory[];
    momentsFile = FileNameJoin[{tmpDir, "covLongTest.wl"}];
    metaFile = FileNameJoin[{tmpDir, "covLongTest_meta.wl"}];
    Put[{1, 2, 3}, momentsFile];
    Put[<|"Hash" -> "expectedhash", "Date" -> "2024-01-01"|>, metaFile];
    result = $momentsUpToDate[momentsFile, metaFile, "expectedhash"];
    DeleteDirectory[tmpDir, DeleteContents -> True];
    result
  ],
  True,
  TestID -> "momentsUpToDate-true-when-hash-matches@@Tests/ManageResources/buildModels.wlt:142,1-155,2"
]

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

(* ============================================================ *)
(* setupParallelKernels Tests *)
(* ============================================================ *)

VerificationTest[
  $setupParallelKernels[None],
  0,
  TestID -> "setupParallelKernels-None-returns-zero@@Tests/ManageResources/buildModels.wlt:176,1-180,2"
]

VerificationTest[
  $setupParallelKernels[0],
  0,
  TestID -> "setupParallelKernels-zero-returns-zero@@Tests/ManageResources/buildModels.wlt:182,1-186,2"
]

VerificationTest[
  $setupParallelKernels[-1],
  0,
  TestID -> "setupParallelKernels-negative-returns-zero@@Tests/ManageResources/buildModels.wlt:188,1-192,2"
]

EndTestSection[]
