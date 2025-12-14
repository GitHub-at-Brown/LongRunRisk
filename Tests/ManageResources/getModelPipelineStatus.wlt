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

$getModelPipelineStatus = FernandoDuarte`LongRunRisk`Tools`ManageResources`getModelPipelineStatus;

$timeLimit = 10;

VerificationTest[
  Block[
    {FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot},
    FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := $Failed;
    $getModelPipelineStatus[]
  ],
  $Failed,
  TimeConstraint -> $timeLimit,
  TestID -> "getModelPipelineStatus-root-failure@@Tests/ManageResources/getModelPipelineStatus.wlt:22,1-31,2"
]

VerificationTest[
  Module[{catalogModels, result},
    catalogModels = <|
      "KeyA" -> <|"enabled" -> True, "shortname" -> "A"|>,
      "KeyB" -> <|"enabled" -> False, "shortname" -> "B"|>,
      "KeyC" -> <|"enabled" -> True, "shortname" -> "C"|>
    |>;

    Block[
      {
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`loadModels,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`loadManifestSafe,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`determineModelStatus
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := "/tmp";
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := catalogModels;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`loadModels[_] := <||>;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`loadManifestSafe[_] := <||>;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`determineModelStatus[key_, ___] := <|
        "MainStage" -> key,
        "Reason" -> "stub"
      |>;
      result = Quiet[$getModelPipelineStatus[]];
    ];

    AssociationQ[result] &&
      Sort[Keys[result]] === {"A", "C"} &&
      result["A"]["MainStage"] === "KeyA" &&
      result["C"]["MainStage"] === "KeyC"
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "getModelPipelineStatus-all-enabled-only-and-uses-model-keys@@Tests/ManageResources/getModelPipelineStatus.wlt:33,1-68,2"
]

VerificationTest[
  Module[{catalogModels, result},
    catalogModels = <|
      "KeyA" -> <|"enabled" -> True, "shortname" -> "A"|>,
      "KeyB" -> <|"enabled" -> False, "shortname" -> "B"|>,
      "KeyC" -> <|"enabled" -> True, "shortname" -> "C"|>
    |>;

    Block[
      {
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`loadModels,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`loadManifestSafe,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`determineModelStatus
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := "/tmp";
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := catalogModels;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`loadModels[_] := <||>;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`loadManifestSafe[_] := <||>;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`determineModelStatus[key_, ___] := <|
        "MainStage" -> key,
        "Reason" -> "stub"
      |>;
      result = Quiet[$getModelPipelineStatus[{"C", "B"}]];
    ];

    AssociationQ[result] &&
      Keys[result] === {"C"} &&
      result["C"]["MainStage"] === "KeyC"
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "getModelPipelineStatus-filters-by-shortnames-and-still-enabled-only@@Tests/ManageResources/getModelPipelineStatus.wlt:70,1-104,2"
]

VerificationTest[
  Block[
    {
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot,
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels
    },
    FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := "/tmp";
    FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := $Failed;
    Quiet[$getModelPipelineStatus[]]
  ],
  $Failed,
  TimeConstraint -> $timeLimit,
  TestID -> "getModelPipelineStatus-catalog-failure@@Tests/ManageResources/getModelPipelineStatus.wlt:106,1-119,2"
]

