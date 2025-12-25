BeginTestSection["checkCatalogChanges"]

(* Setup: Load ManageResources package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
On[General::shdw];

$timeLimit = 30;

(* ============================================================ *)
(* Controlled Behavior Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{tmpRoot, manifestFile, modelsAssoc, modelHashes, savedManifest, checkCatalogChangesFn, result},
    tmpRoot = CreateDirectory[];
    CreateDirectory[FileNameJoin[{tmpRoot, "Resources"}]];
    manifestFile = FileNameJoin[{tmpRoot, "Resources", "ModelManifest.wl"}];

    modelsAssoc = <|
      "ModelA" -> <|"a" -> 1|>,
      "ModelB" -> <|"b" -> {1, 2}|>
    |>;

    modelHashes = Map[
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash,
      modelsAssoc
    ];

    (* Force hash mismatch but keep per-model hashes identical so validation is skipped *)
    savedManifest = <|
      "PacletVersion" -> "Development",
      "CatalogHash" -> "not-the-real-hash",
      "Models" -> modelHashes,
      "Date" -> "2025-01-01T00:00:00"
    |>;

    Put[savedManifest, manifestFile];

    checkCatalogChangesFn = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges;

    Block[{FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot},
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmpRoot;
      result = Quiet[checkCatalogChangesFn[modelsAssoc]];
    ];

    DeleteDirectory[tmpRoot, DeleteContents -> True];

    AssociationQ[result] &&
      KeyExistsQ[result, "Changed"] &&
      KeyExistsQ[result, "New"] &&
      KeyExistsQ[result, "Removed"] &&
      KeyExistsQ[result, "Validation"] &&
      result["Changed"] === {} &&
      result["New"] === {} &&
      result["Removed"] === {} &&
      AssociationQ[result["Validation"]] &&
      TrueQ[result["Validation"]["Valid"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogChanges-assoc-input-returns-structure@@Tests/ManageResources/checkCatalogChanges.wlt:14,1-63,2"
]

EndTestSection[]
