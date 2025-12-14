(* Setup: Load PipelineMonitor.wl *)
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
  Get[FileNameJoin[{pacletRoot, "Kernel", "Tools", "PipelineMonitor.wl"}]];
  On[General::shdw];
];

$CheckModels = FernandoDuarte`LongRunRisk`Tools`PipelineMonitor`CheckModels;
$loadConfig = ToExpression["FernandoDuarte`LongRunRisk`Tools`PipelineMonitor`Private`loadConfig"];
$statusIcon = ToExpression["FernandoDuarte`LongRunRisk`Tools`PipelineMonitor`Private`statusIcon"];

$timeLimit = 15;

VerificationTest[
  Module[{tmpHome, result},
    tmpHome = CreateDirectory[];
    result = Block[{$HomeDirectory = tmpHome}, Quiet[$loadConfig[]]];
    DeleteDirectory[tmpHome, DeleteContents -> True];
    result
  ],
  <||>,
  TimeConstraint -> $timeLimit,
  TestID -> "loadConfig-missing-file-returns-empty@@Tests/PipelineMonitor/CheckModels.wlt:24,1-34,2"
]

VerificationTest[
  Module[{tmpHome, cfgDir, cfgFile, result},
    tmpHome = CreateDirectory[];
    cfgDir = FileNameJoin[{tmpHome, ".longrunrisk"}];
    CreateDirectory[cfgDir];
    cfgFile = FileNameJoin[{cfgDir, "config.wl"}];
    Put[42, cfgFile];
    result = Block[{$HomeDirectory = tmpHome}, Quiet[$loadConfig[]]];
    DeleteDirectory[tmpHome, DeleteContents -> True];
    result
  ],
  <||>,
  TimeConstraint -> $timeLimit,
  TestID -> "loadConfig-malformed-file-returns-empty@@Tests/PipelineMonitor/CheckModels.wlt:36,1-50,2"
]

VerificationTest[
  Module[{called, result},
    called = False;
    result = Block[
      {
        $KernelID = 1,
        $ParallelEvaluationEnvironment = False,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI[] := (called = True; $Failed);
      Quiet[$CheckModels[]]
    ];
    result === Null && called === False
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "CheckModels-guarded-in-subkernel@@Tests/PipelineMonitor/CheckModels.wlt:52,1-69,2"
]

VerificationTest[
  Module[{tmpHome, cfgDir, cfgFile, called, result},
    tmpHome = CreateDirectory[];
    cfgDir = FileNameJoin[{tmpHome, ".longrunrisk"}];
    CreateDirectory[cfgDir];
    cfgFile = FileNameJoin[{cfgDir, "config.wl"}];
    Put[<|"PipelineMonitorEnabled" -> False|>, cfgFile];

    called = False;
    result = Block[
      {
        $KernelID = 0,
        $ParallelEvaluationEnvironment = False,
        $HomeDirectory = tmpHome,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI[] := (called = True; $Failed);
      Quiet[$CheckModels[]]
    ];

    DeleteDirectory[tmpHome, DeleteContents -> True];
    result === Null && called === False
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "CheckModels-config-disabled-exits@@Tests/PipelineMonitor/CheckModels.wlt:71,1-97,2"
]

VerificationTest[
  Module[{prints, result},
    prints = {};
    result = Block[
      {
        $KernelID = 0,
        $ParallelEvaluationEnvironment = False,
        $HomeDirectory = CreateDirectory[],
        Print = (AppendTo[prints, StringRiffle[ToString /@ {##}, ""]]; Null) &,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI[] := <|
        "Changed" -> {},
        "New" -> {},
        "Removed" -> {},
        "Validation" -> <|"Valid" -> True|>,
        "FirstRun" -> False
      |>;
      Quiet[$CheckModels[]]
    ];

    result === Null && prints === {}
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "CheckModels-no-changes-silent@@Tests/PipelineMonitor/CheckModels.wlt:99,1-125,2"
]

VerificationTest[
  Module[{prints, result},
    prints = {};
    result = Block[
      {
        $KernelID = 0,
        $ParallelEvaluationEnvironment = False,
        $HomeDirectory = CreateDirectory[],
        Print = (AppendTo[prints, StringRiffle[ToString /@ {##}, ""]]; Null) &,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI[] := $Failed;
      Quiet[$CheckModels[]]
    ];

    result === $Failed &&
      AnyTrue[prints, StringContainsQ[#, "Could not check catalog"] &]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "CheckModels-checkCatalogForUI-failure@@Tests/PipelineMonitor/CheckModels.wlt:127,1-148,2"
]

VerificationTest[
  Module[{prints, result, changes, validation},
    prints = {};

    validation = <|
      "Valid" -> False,
      "Results" -> <|
        "A" -> <|
          "Valid" -> False,
          "Errors" -> {<|"Type" -> "MissingKey", "Message" -> "Required key stateVars missing"|>}
        |>
      |>
    |>;

    changes = <|
      "Changed" -> {"A"},
      "New" -> {},
      "Removed" -> {},
      "Validation" -> validation,
      "FirstRun" -> False
    |>;

    result = Block[
      {
        $KernelID = 0,
        $ParallelEvaluationEnvironment = False,
        $HomeDirectory = CreateDirectory[],
        Print = (AppendTo[prints, StringRiffle[ToString /@ {##}, ""]]; Null) &,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`getModelPipelineStatus
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI[] := changes;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := <|
        "A" -> <|"shortname" -> "AA"|>
      |>;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`getModelPipelineStatus[_] := <|
        "AA" -> <|"MainStage" -> "Symbolic", "Reason" -> "changed"|>
      |>;
      Quiet[$CheckModels[]]
    ];

    result === $Failed &&
      AnyTrue[prints, StringContainsQ[#, "VALIDATION ERRORS"] &] &&
      AnyTrue[prints, StringContainsQ[#, "MissingKey"] &]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "CheckModels-validation-errors-return-failed@@Tests/PipelineMonitor/CheckModels.wlt:150,1-199,2"
]

VerificationTest[
  Module[{prints, output, result, changes},
    prints = {};

    changes = <|
      "Changed" -> {"A"},
      "New" -> {"B"},
      "Removed" -> {},
      "Validation" -> <|"Valid" -> True|>,
      "FirstRun" -> False
    |>;

    result = Block[
      {
        $KernelID = 0,
        $ParallelEvaluationEnvironment = False,
        $HomeDirectory = CreateDirectory[],
        Print = (AppendTo[prints, StringRiffle[ToString /@ {##}, ""]]; Null) &,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`getModelPipelineStatus
      },
      FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI[] := changes;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := <|
        "A" -> <|"shortname" -> "AA"|>,
        "B" -> <|"shortname" -> "BB"|>
      |>;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`getModelPipelineStatus[_] := <|
        "AA" -> <|"MainStage" -> "Numerical", "Reason" -> "changed"|>,
        "BB" -> <|"MainStage" -> "Symbolic", "Reason" -> "new"|>
      |>;
      Quiet[$CheckModels[]]
    ];

    output = StringRiffle[prints, "\n"];
    result === Null &&
      StringContainsQ[output, "Catalog Changes Detected"] &&
      StringContainsQ[output, "Needs[\"FernandoDuarte`LongRunRisk`Tools`ManageResources`"] &&
      StringContainsQ[output, "FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels"] &&
      StringContainsQ[output, ToString[{"AA", "BB"}, InputForm]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "showTerminalReport-prints-fully-qualified-command@@Tests/PipelineMonitor/CheckModels.wlt:201,1-245,2"
]

VerificationTest[
  Block[{$Notebooks = False},
    $statusIcon["Compile", "Numerical"] === "[OK]" &&
      $statusIcon["Numerical", "Numerical"] === "[>>]" &&
      $statusIcon["Moments", "Numerical"] === "[ ]"
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "statusIcon-terminal-contract@@Tests/PipelineMonitor/CheckModels.wlt:247,1-256,2"
]

VerificationTest[
  Module[{buildCalled, buildArgs, result, changes},
    buildCalled = False;
    buildArgs = None;

    changes = <|
      "Changed" -> {"A"},
      "New" -> {},
      "Removed" -> {},
      "Validation" -> <|"Valid" -> True|>,
      "FirstRun" -> False
    |>;

    result = Block[
      {
        $KernelID = 0,
        $ParallelEvaluationEnvironment = False,
        $HomeDirectory = CreateDirectory[],
        $Notebooks = True,
        DialogInput,
        MessageDialog,
        PrintTemporary,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`getModelPipelineStatus,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels
      },
      DialogInput[_, ___] := "Cancel";
      MessageDialog[___] := Null;
      PrintTemporary[___] := Null;

      FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI[] := changes;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := <|
        "A" -> <|"shortname" -> "AA"|>
      |>;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`getModelPipelineStatus[_] := <|
        "AA" -> <|"MainStage" -> "Symbolic", "Reason" -> "changed"|>
      |>;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels[args___] := (buildCalled = True; buildArgs = {args}; "ok");

      Quiet[$CheckModels[]]
    ];

    result === Null && buildCalled === False && buildArgs === None
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "CheckModels-notebook-cancel-does-not-build@@Tests/PipelineMonitor/CheckModels.wlt:258,1-306,2"
]

VerificationTest[
  Module[{buildCalled, buildArgs, dialogs, result, changes},
    buildCalled = False;
    buildArgs = None;
    dialogs = {};

    changes = <|
      "Changed" -> {"A"},
      "New" -> {},
      "Removed" -> {},
      "Validation" -> <|"Valid" -> True|>,
      "FirstRun" -> False
    |>;

    result = Block[
      {
        $KernelID = 0,
        $ParallelEvaluationEnvironment = False,
        $HomeDirectory = CreateDirectory[],
        $Notebooks = True,
        DialogInput,
        MessageDialog,
        PrintTemporary,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`getModelPipelineStatus,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels
      },
      DialogInput[_, ___] := "Build";
      MessageDialog[msg_, ___] := (AppendTo[dialogs, msg]; Null);
      PrintTemporary[___] := Null;

      FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI[] := changes;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := <|
        "A" -> <|"shortname" -> "AA"|>
      |>;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`getModelPipelineStatus[_] := <|
        "AA" -> <|"MainStage" -> "Symbolic", "Reason" -> "changed"|>
      |>;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels[args___] := (buildCalled = True; buildArgs = {args}; "OK");

      Quiet[$CheckModels[]]
    ];

    result === "OK" &&
      buildCalled === True &&
      buildArgs === {"Models" -> {"AA"}} &&
      AnyTrue[dialogs, StringContainsQ[#, "Build completed successfully"] &]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "CheckModels-notebook-build-success@@Tests/PipelineMonitor/CheckModels.wlt:308,1-360,2"
]

VerificationTest[
  Module[{dialogs, result, changes},
    dialogs = {};

    changes = <|
      "Changed" -> {"A"},
      "New" -> {},
      "Removed" -> {},
      "Validation" -> <|"Valid" -> True|>,
      "FirstRun" -> False
    |>;

    result = Block[
      {
        $KernelID = 0,
        $ParallelEvaluationEnvironment = False,
        $HomeDirectory = CreateDirectory[],
        $Notebooks = True,
        DialogInput,
        MessageDialog,
        PrintTemporary,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`getModelPipelineStatus,
        FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels
      },
      DialogInput[_, ___] := "Build";
      MessageDialog[msg_, ___] := (AppendTo[dialogs, msg]; Null);
      PrintTemporary[___] := Null;

      FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI[] := changes;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := <|
        "A" -> <|"shortname" -> "AA"|>
      |>;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`getModelPipelineStatus[_] := <|
        "AA" -> <|"MainStage" -> "Symbolic", "Reason" -> "changed"|>
      |>;
      FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels[___] := $Failed;

      Quiet[$CheckModels[]]
    ];

    result === $Failed &&
      AnyTrue[dialogs, StringContainsQ[#, "Build failed"] &]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "CheckModels-notebook-build-failure@@Tests/PipelineMonitor/CheckModels.wlt:362,1-410,2"
]
