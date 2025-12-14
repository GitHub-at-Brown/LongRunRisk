(* Setup: Load ManageResources.wl *)
Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  d = start;
  While[!FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
    d = DirectoryName[d]
  ];
  pacletRoot = d;
  SetDirectory[pacletRoot];
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "Tools", "ManageResources.wl"}]];
  On[General::shdw];
];

$checkCatalogForUI = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI;
$getCanonicalHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash"];

$timeLimit = 10;

VerificationTest[
  Module[{tmpRoot, catalogModels, result},
    tmpRoot = CreateDirectory[];
    CreateDirectory[FileNameJoin[{tmpRoot, "Resources"}]];

    catalogModels = <|
      "A" -> <|"enabled" -> True, "shortname" -> "A"|>,
      "B" -> <|"enabled" -> False, "shortname" -> "B"|>,
      "C" -> <|"enabled" -> True, "shortname" -> "C"|>
    |>;

    Block[
      {
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmpRoot;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := catalogModels;
      result = Quiet[$checkCatalogForUI[]];
    ];

    DeleteDirectory[tmpRoot, DeleteContents -> True];

    AssociationQ[result] &&
      Sort[result["New"]] === {"A", "C"} &&
      result["Changed"] === {} &&
      result["Removed"] === {} &&
      TrueQ[result["FirstRun"]] &&
      TrueQ[result["Validation"]["Valid"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogForUI-first-run-all-enabled-are-new@@Tests/ManageResources/checkCatalogForUI.wlt:23,1-56,2"
]

VerificationTest[
  Block[
    {FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot},
    FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := $Failed;
    $checkCatalogForUI[]
  ],
  $Failed,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogForUI-root-failure@@Tests/ManageResources/checkCatalogForUI.wlt:58,1-67,2"
]

VerificationTest[
  Module[{tmpRoot, result},
    tmpRoot = CreateDirectory[];
    CreateDirectory[FileNameJoin[{tmpRoot, "Resources"}]];

    Block[
      {
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmpRoot;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := $Failed;
      result = Quiet[$checkCatalogForUI[]];
    ];

    DeleteDirectory[tmpRoot, DeleteContents -> True];
    result
  ],
  $Failed,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogForUI-catalog-load-failure@@Tests/ManageResources/checkCatalogForUI.wlt:69,1-90,2"
]

VerificationTest[
  Module[{tmpRoot, manifestFile, catalogModels, savedManifest, currentHash, result},
    tmpRoot = CreateDirectory[];
    CreateDirectory[FileNameJoin[{tmpRoot, "Resources"}]];
    manifestFile = FileNameJoin[{tmpRoot, "Resources", "ModelManifest.wl"}];
    Put[<||>, manifestFile];

    catalogModels = <|
      "A" -> <|"enabled" -> True, "shortname" -> "A"|>,
      "B" -> <|"enabled" -> True, "shortname" -> "B"|>
    |>;

    currentHash = $getCanonicalHash[catalogModels];
    savedManifest = <|"CatalogHash" -> currentHash, "Models" -> <||>|>;

    Block[
      {
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`loadManifestSafe
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmpRoot;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := catalogModels;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`loadManifestSafe[_] := savedManifest;
      result = Quiet[$checkCatalogForUI[]];
    ];

    DeleteDirectory[tmpRoot, DeleteContents -> True];

    AssociationQ[result] &&
      result["Changed"] === {} &&
      result["New"] === {} &&
      result["Removed"] === {} &&
      False === TrueQ[result["FirstRun"]] &&
      TrueQ[result["Validation"]["Valid"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogForUI-no-changes-returns-empty@@Tests/ManageResources/checkCatalogForUI.wlt:92,1-131,2"
]

VerificationTest[
  Module[
    {
      tmpRoot, manifestFile, catalogModels, savedManifest, validationArg, validationStub, result
    },
    tmpRoot = CreateDirectory[];
    CreateDirectory[FileNameJoin[{tmpRoot, "Resources"}]];
    manifestFile = FileNameJoin[{tmpRoot, "Resources", "ModelManifest.wl"}];
    Put[<||>, manifestFile];

    catalogModels = <|
      "A" -> <|"enabled" -> True, "shortname" -> "AA"|>,
      "B" -> <|"enabled" -> True, "shortname" -> "BB"|>
    |>;

    savedManifest = <|
      "CatalogHash" -> "not-the-real-hash",
      "Models" -> <|
        "A" -> "different-hash",
        "Old" -> "old-hash"
      |>
    |>;

    validationArg = None;
    validationStub = <|
      "Valid" -> True,
      "Results" -> <||>,
      "InvalidModels" -> {},
      "TotalErrors" -> 0
    |>;

    Block[
      {
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`loadManifestSafe,
        Needs,
        FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmpRoot;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := catalogModels;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`loadManifestSafe[_] := savedManifest;
      Needs[_] := Null;
      FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog[arg_] := (validationArg = arg; validationStub);
      result = Quiet[$checkCatalogForUI[]];
    ];

    DeleteDirectory[tmpRoot, DeleteContents -> True];

    AssociationQ[result] &&
      Sort[result["Changed"]] === {"A"} &&
      Sort[result["New"]] === {"B"} &&
      Sort[result["Removed"]] === {"Old"} &&
      validationArg =!= None &&
      Sort[Keys[validationArg]] === {"A", "B"} &&
      result["Validation"] === validationStub &&
      TrueQ[result["Validation"]["Valid"]] &&
      False === TrueQ[result["FirstRun"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogForUI-detects-changed-new-removed-and-validates@@Tests/ManageResources/checkCatalogForUI.wlt:133,1-195,2"
]

