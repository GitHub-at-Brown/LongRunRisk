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
  TestID -> "checkCatalogChanges-assoc-input-returns-structure@@Tests/ManageResources/checkCatalogChanges.wlt:24,1-73,2"
]

VerificationTest[
  Module[{tmpRoot, manifestFile, modelsAssoc, currentHashes, savedManifest, checkCatalogChangesFn, result},
    tmpRoot = CreateDirectory[];
    CreateDirectory[FileNameJoin[{tmpRoot, "Resources"}]];
    manifestFile = FileNameJoin[{tmpRoot, "Resources", "ModelManifest.wl"}];

    modelsAssoc = <|
      "A" -> <|"x" -> 1|>,
      "B" -> <|"y" -> 2|>
    |>;

    currentHashes = Map[
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash,
      modelsAssoc
    ];

    (* Saved manifest differs: A changed, B is new, Old was removed *)
    savedManifest = <|
      "PacletVersion" -> "Development",
      "CatalogHash" -> "not-the-real-hash",
      "Models" -> <|
        "A" -> "different-hash",
        "Old" -> "old-hash"
      |>,
      "Date" -> "2025-01-01T00:00:00"
    |>;

    Put[savedManifest, manifestFile];

    checkCatalogChangesFn = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges;

    Block[
      {
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot,
        Needs,
        FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmpRoot;
      Needs[_] := Null;
      (* Stub validation to keep test lightweight and deterministic *)
      FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog[_] :=
        <|"Valid" -> True, "Results" -> <||>, "InvalidModels" -> {}, "TotalErrors" -> 0|>;
      result = Quiet[checkCatalogChangesFn[modelsAssoc]];
    ];

    DeleteDirectory[tmpRoot, DeleteContents -> True];

    AssociationQ[result] &&
      Sort[result["Changed"]] === {"A"} &&
      Sort[result["New"]] === {"B"} &&
      Sort[result["Removed"]] === {"Old"} &&
      TrueQ[result["Validation"]["Valid"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogChanges-detects-changed-new-removed@@Tests/ManageResources/checkCatalogChanges.wlt:75,1-131,2"
]

EndTestSection[]
