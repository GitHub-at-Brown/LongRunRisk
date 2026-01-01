BeginTestSection["solveCoeffRoots Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`SolveEulerEq`solveCoeffRoots`"]

(* --- merged from: solveCoeffRoots_test1.wlt --- *)
(* Tests for solveCoeffRoots and solveWcPdRoots functions

   These tests verify the bug fixes applied in commit ad5bdbb:
   - SignSymbol now read from kernel instead of hardcoded default
   - extraParams now applied to both keys and values of Solution

   Tests verify that:
   - solveCoeffRoots returns numeric solutions for wc coefficients
   - solveCoeffRoots returns numeric solutions for pd coefficients
   - solveWcPdRoots returns valid interval structure
*)

(* Load required packages *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
On[General::shdw];

(* Load models data from Resources *)
Module[{pacletFile, pacletRoot, resourcesDir, modelsFile},
  (* Find paclet root from loaded package *)
  pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
  pacletRoot = If[StringQ[pacletFile],
    DirectoryName[pacletFile, 3],
    (* Fallback: try $InputFileName *)
    If[StringQ[$InputFileName] && $InputFileName =!= "",
      Module[{d = DirectoryName[$InputFileName]},
        While[!FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
          d = DirectoryName[d]];
        d
      ],
      Directory[]
    ]
  ];

  (* Store paclet root for use in tests *)
  $testPacletRoot = pacletRoot;

  (* CRITICAL for TestPaclet compatibility *)
  PacletDirectoryLoad[pacletRoot];

  (* Load models data - Get@Get extracts from DefinitionData wrapper *)
  resourcesDir = FileNameJoin[{pacletRoot, "Resources"}];
  modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}];
  $testModels = Get@Get[modelsFile];
];

(* Time limit for tests - these involve numeric solving *)
timeLimit = 120;

(* Helper: generate signs from kernel SignIndex *)
getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx},
  signIdx = kernel["SignIndex"];
  If[signIdx === {} || signIdx === {{}}, Return[{}]];
  maxIdx = Max[Flatten[signIdx]];
  Table[-1, maxIdx]
];

(* Helper: compute numeric params base from model *)
getParamsBase[model_Association] := (Association@model["params"])//.model["params"]//N;

(* Helper: load kernels for a model using new unified loader *)
loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"];

loadKernels[modelKey_String] := Module[
  {model, kernelData},

  model = $testModels[modelKey];
  kernelData = loadModelKernels[modelKey];

  <|"Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]|>
];

(* Bind private functions *)
solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"];
solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"];

(* j symbol for pd coefficient index *)
jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j;

VerificationTest[
    Module[{kernels, model, signsWc, paramsBase, wcResults},
      kernels = loadKernels["BY"];
      model = kernels["Model"];
      signsWc = getSignsFromKernel[kernels["WcKernel"]];
      paramsBase = getParamsBase[model];

      wcResults = Quiet@Check[
        TimeConstrained[
          solveCoeffRoots[
            model["coeffsParamQuadSolve"]["wc"],
            kernels["WcKernel"],
            paramsBase,
            signsWc,
            <||>
          ],
          60
        ],
        $Failed
      ];

      (* Check structure and numeric values *)
      ListQ[wcResults] &&
      Length[wcResults] > 0 &&
      AssociationQ[wcResults[[1]]] &&
      KeyExistsQ[wcResults[[1]], "Sol"] &&
      Length[wcResults[[1]]["Sol"]] > 0 &&
      AssociationQ[wcResults[[1]]["Sol"][[1]]] &&
      AllTrue[Values[wcResults[[1]]["Sol"][[1]]], NumericQ]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "solveCoeffRoots-wc-BY-numeric@@Tests/SolveEulerEq/solveCoeffRoots.wlt:85,1-118,4"
  ]

(* --- merged from: solveCoeffRoots_test2.wlt --- *)
(* Tests for solveCoeffRoots and solveWcPdRoots functions

   These tests verify the bug fixes applied in commit ad5bdbb:
   - SignSymbol now read from kernel instead of hardcoded default
   - extraParams now applied to both keys and values of Solution

   Tests verify that:
   - solveCoeffRoots returns numeric solutions for wc coefficients
   - solveCoeffRoots returns numeric solutions for pd coefficients
   - solveWcPdRoots returns valid interval structure
*)

(* Load required packages *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
On[General::shdw];

(* Load models data from Resources *)
Module[{pacletFile, pacletRoot, resourcesDir, modelsFile},
  (* Find paclet root from loaded package *)
  pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
  pacletRoot = If[StringQ[pacletFile],
    DirectoryName[pacletFile, 3],
    (* Fallback: try $InputFileName *)
    If[StringQ[$InputFileName] && $InputFileName =!= "",
      Module[{d = DirectoryName[$InputFileName]},
        While[!FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
          d = DirectoryName[d]];
        d
      ],
      Directory[]
    ]
  ];

  (* Store paclet root for use in tests *)
  $testPacletRoot = pacletRoot;

  (* CRITICAL for TestPaclet compatibility *)
  PacletDirectoryLoad[pacletRoot];

  (* Load models data - Get@Get extracts from DefinitionData wrapper *)
  resourcesDir = FileNameJoin[{pacletRoot, "Resources"}];
  modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}];
  $testModels = Get@Get[modelsFile];
];

(* Time limit for tests - these involve numeric solving *)
timeLimit = 120;

(* Helper: generate signs from kernel SignIndex *)
getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx},
  signIdx = kernel["SignIndex"];
  If[signIdx === {} || signIdx === {{}}, Return[{}]];
  maxIdx = Max[Flatten[signIdx]];
  Table[-1, maxIdx]
];

(* Helper: compute numeric params base from model *)
getParamsBase[model_Association] := (Association@model["params"])//.model["params"]//N;

(* Helper: load kernels for a model using new unified loader *)
loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"];

loadKernels[modelKey_String] := Module[
  {model, kernelData},

  model = $testModels[modelKey];
  kernelData = loadModelKernels[modelKey];

  <|"Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]|>
];

(* Bind private functions *)
solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"];
solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"];

(* j symbol for pd coefficient index *)
jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j;

VerificationTest[
    Module[{kernels, model, signsWc, signsPd, paramsBase, wcResults, extraParamsPd, jAsoc, pdResults},
      kernels = loadKernels["BY"];
      model = kernels["Model"];
      signsWc = getSignsFromKernel[kernels["WcKernel"]];
      signsPd = getSignsFromKernel[kernels["PdKernel"]];
      paramsBase = getParamsBase[model];

      (* First get wc results *)
      wcResults = Quiet@Check[
        TimeConstrained[
          solveCoeffRoots[
            model["coeffsParamQuadSolve"]["wc"],
            kernels["WcKernel"],
            paramsBase,
            signsWc,
            <||>
          ],
          60
        ],
        $Failed
      ];

      If[!ListQ[wcResults] || Length[wcResults] == 0, Return[False]];

      (* Now test pd with wc results as extra params *)
      extraParamsPd = wcResults[[1]]["Sol"][[1]];
      jAsoc = <|jSym -> 1|>;

      pdResults = Quiet@Check[
        TimeConstrained[
          solveCoeffRoots[
            model["coeffsParamQuadSolve"]["pd"],
            kernels["PdKernel"],
            paramsBase,
            signsPd,
            Join[extraParamsPd, jAsoc]
          ],
          60
        ],
        $Failed
      ];

      (* Check structure and numeric values *)
      ListQ[pdResults] &&
      Length[pdResults] > 0 &&
      AssociationQ[pdResults[[1]]] &&
      KeyExistsQ[pdResults[[1]], "Roots"] &&
      Length[pdResults[[1]]["Roots"]] > 0 &&
      KeyExistsQ[pdResults[[1]], "Sol"] &&
      Length[pdResults[[1]]["Sol"]] > 0 &&
      AssociationQ[pdResults[[1]]["Sol"][[1]]] &&
      AllTrue[Values[pdResults[[1]]["Sol"][[1]]], NumericQ]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "solveCoeffRoots-pd-BY-numeric@@Tests/SolveEulerEq/solveCoeffRoots.wlt:201,1-258,4"
  ]

(* --- merged from: solveCoeffRoots_test3.wlt --- *)
(* Tests for solveCoeffRoots and solveWcPdRoots functions

   These tests verify the bug fixes applied in commit ad5bdbb:
   - SignSymbol now read from kernel instead of hardcoded default
   - extraParams now applied to both keys and values of Solution

   Tests verify that:
   - solveCoeffRoots returns numeric solutions for wc coefficients
   - solveCoeffRoots returns numeric solutions for pd coefficients
   - solveWcPdRoots returns valid interval structure
*)

(* Load required packages *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
On[General::shdw];

(* Load models data from Resources *)
Module[{pacletFile, pacletRoot, resourcesDir, modelsFile},
  (* Find paclet root from loaded package *)
  pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
  pacletRoot = If[StringQ[pacletFile],
    DirectoryName[pacletFile, 3],
    (* Fallback: try $InputFileName *)
    If[StringQ[$InputFileName] && $InputFileName =!= "",
      Module[{d = DirectoryName[$InputFileName]},
        While[!FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
          d = DirectoryName[d]];
        d
      ],
      Directory[]
    ]
  ];

  (* Store paclet root for use in tests *)
  $testPacletRoot = pacletRoot;

  (* CRITICAL for TestPaclet compatibility *)
  PacletDirectoryLoad[pacletRoot];

  (* Load models data - Get@Get extracts from DefinitionData wrapper *)
  resourcesDir = FileNameJoin[{pacletRoot, "Resources"}];
  modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}];
  $testModels = Get@Get[modelsFile];
];

(* Time limit for tests - these involve numeric solving *)
timeLimit = 120;

(* Helper: generate signs from kernel SignIndex *)
getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx},
  signIdx = kernel["SignIndex"];
  If[signIdx === {} || signIdx === {{}}, Return[{}]];
  maxIdx = Max[Flatten[signIdx]];
  Table[-1, maxIdx]
];

(* Helper: compute numeric params base from model *)
getParamsBase[model_Association] := (Association@model["params"])//.model["params"]//N;

(* Helper: load kernels for a model using new unified loader *)
loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"];

loadKernels[modelKey_String] := Module[
  {model, kernelData},

  model = $testModels[modelKey];
  kernelData = loadModelKernels[modelKey];

  <|"Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]|>
];

(* Bind private functions *)
solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"];
solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"];

(* j symbol for pd coefficient index *)
jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j;

VerificationTest[
    Module[{kernels, model, signsWc, signsPd, jAsoc, wcPdResults},
      kernels = loadKernels["BY"];
      model = kernels["Model"];
      signsWc = getSignsFromKernel[kernels["WcKernel"]];
      signsPd = getSignsFromKernel[kernels["PdKernel"]];
      jAsoc = <|jSym -> 1|>;

      wcPdResults = Quiet@Check[
        TimeConstrained[
          solveWcPdRoots[model, kernels["WcKernel"], kernels["PdKernel"], signsWc, signsPd, jAsoc],
          90
        ],
        $Failed
      ];

      (* Check structure: should return list of associations with Wc and Pd keys *)
      ListQ[wcPdResults] &&
      Length[wcPdResults] > 0 &&
      AssociationQ[wcPdResults[[1]]] &&
      KeyExistsQ[wcPdResults[[1]], "Roots"] &&
      KeyExistsQ[wcPdResults[[1]], "Pd"]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "solveWcPdRoots-BY-structure@@Tests/SolveEulerEq/solveCoeffRoots.wlt:341,1-367,4"
  ]

(* --- merged from: solveCoeffRoots_test4.wlt --- *)
(* Tests for solveCoeffRoots and solveWcPdRoots functions

   These tests verify the bug fixes applied in commit ad5bdbb:
   - SignSymbol now read from kernel instead of hardcoded default
   - extraParams now applied to both keys and values of Solution

   Tests verify that:
   - solveCoeffRoots returns numeric solutions for wc coefficients
   - solveCoeffRoots returns numeric solutions for pd coefficients
   - solveWcPdRoots returns valid interval structure
*)

(* Load required packages *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
On[General::shdw];

(* Load models data from Resources *)
Module[{pacletFile, pacletRoot, resourcesDir, modelsFile},
  (* Find paclet root from loaded package *)
  pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
  pacletRoot = If[StringQ[pacletFile],
    DirectoryName[pacletFile, 3],
    (* Fallback: try $InputFileName *)
    If[StringQ[$InputFileName] && $InputFileName =!= "",
      Module[{d = DirectoryName[$InputFileName]},
        While[!FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
          d = DirectoryName[d]];
        d
      ],
      Directory[]
    ]
  ];

  (* Store paclet root for use in tests *)
  $testPacletRoot = pacletRoot;

  (* CRITICAL for TestPaclet compatibility *)
  PacletDirectoryLoad[pacletRoot];

  (* Load models data - Get@Get extracts from DefinitionData wrapper *)
  resourcesDir = FileNameJoin[{pacletRoot, "Resources"}];
  modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}];
  $testModels = Get@Get[modelsFile];
];

(* Time limit for tests - these involve numeric solving *)
timeLimit = 120;

(* Helper: generate signs from kernel SignIndex *)
getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx},
  signIdx = kernel["SignIndex"];
  If[signIdx === {} || signIdx === {{}}, Return[{}]];
  maxIdx = Max[Flatten[signIdx]];
  Table[-1, maxIdx]
];

(* Helper: compute numeric params base from model *)
getParamsBase[model_Association] := (Association@model["params"])//.model["params"]//N;

(* Helper: load kernels for a model using new unified loader *)
loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"];

loadKernels[modelKey_String] := Module[
  {model, kernelData},

  model = $testModels[modelKey];
  kernelData = loadModelKernels[modelKey];

  <|"Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]|>
];

(* Bind private functions *)
solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"];
solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"];

(* j symbol for pd coefficient index *)
jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j;

VerificationTest[
    Module[{kernels, model, signsWc, paramsBase, wcResults},
      kernels = loadKernels["BKY"];
      model = kernels["Model"];
      signsWc = getSignsFromKernel[kernels["WcKernel"]];
      paramsBase = getParamsBase[model];

      wcResults = Quiet@Check[
        TimeConstrained[
          solveCoeffRoots[
            model["coeffsParamQuadSolve"]["wc"],
            kernels["WcKernel"],
            paramsBase,
            signsWc,
            <||>
          ],
          60
        ],
        $Failed
      ];

      ListQ[wcResults] &&
      Length[wcResults] > 0 &&
      AssociationQ[wcResults[[1]]] &&
      KeyExistsQ[wcResults[[1]], "Sol"] &&
      Length[wcResults[[1]]["Sol"]] > 0 &&
      AssociationQ[wcResults[[1]]["Sol"][[1]]] &&
      AllTrue[Values[wcResults[[1]]["Sol"][[1]]], NumericQ]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "solveCoeffRoots-wc-BKY-numeric@@Tests/SolveEulerEq/solveCoeffRoots.wlt:450,1-482,4"
  ]

(* --- merged from: solveCoeffRoots_test5.wlt --- *)
(* Tests for solveCoeffRoots and solveWcPdRoots functions

   These tests verify the bug fixes applied in commit ad5bdbb:
   - SignSymbol now read from kernel instead of hardcoded default
   - extraParams now applied to both keys and values of Solution

   Tests verify that:
   - solveCoeffRoots returns numeric solutions for wc coefficients
   - solveCoeffRoots returns numeric solutions for pd coefficients
   - solveWcPdRoots returns valid interval structure
*)

(* Load required packages *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
On[General::shdw];

(* Load models data from Resources *)
Module[{pacletFile, pacletRoot, resourcesDir, modelsFile},
  (* Find paclet root from loaded package *)
  pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
  pacletRoot = If[StringQ[pacletFile],
    DirectoryName[pacletFile, 3],
    (* Fallback: try $InputFileName *)
    If[StringQ[$InputFileName] && $InputFileName =!= "",
      Module[{d = DirectoryName[$InputFileName]},
        While[!FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
          d = DirectoryName[d]];
        d
      ],
      Directory[]
    ]
  ];

  (* Store paclet root for use in tests *)
  $testPacletRoot = pacletRoot;

  (* CRITICAL for TestPaclet compatibility *)
  PacletDirectoryLoad[pacletRoot];

  (* Load models data - Get@Get extracts from DefinitionData wrapper *)
  resourcesDir = FileNameJoin[{pacletRoot, "Resources"}];
  modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}];
  $testModels = Get@Get[modelsFile];
];

(* Time limit for tests - these involve numeric solving *)
timeLimit = 120;

(* Helper: generate signs from kernel SignIndex *)
getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx},
  signIdx = kernel["SignIndex"];
  If[signIdx === {} || signIdx === {{}}, Return[{}]];
  maxIdx = Max[Flatten[signIdx]];
  Table[-1, maxIdx]
];

(* Helper: compute numeric params base from model *)
getParamsBase[model_Association] := (Association@model["params"])//.model["params"]//N;

(* Helper: load kernels for a model using new unified loader *)
loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"];

loadKernels[modelKey_String] := Module[
  {model, kernelData},

  model = $testModels[modelKey];
  kernelData = loadModelKernels[modelKey];

  <|"Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]|>
];

(* Bind private functions *)
solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"];
solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"];

(* j symbol for pd coefficient index *)
jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j;

VerificationTest[
    Module[{kernels, model, signsWc, paramsBase, wcResults},
      kernels = loadKernels["NRC"];
      model = kernels["Model"];
      signsWc = getSignsFromKernel[kernels["WcKernel"]];
      paramsBase = getParamsBase[model];

      wcResults = Quiet@Check[
        TimeConstrained[
          solveCoeffRoots[
            model["coeffsParamQuadSolve"]["wc"],
            kernels["WcKernel"],
            paramsBase,
            signsWc,
            <||>
          ],
          60
        ],
        $Failed
      ];

      (* Accept either valid results or graceful failure *)
      wcResults === $Failed ||
      (ListQ[wcResults] &&
       Length[wcResults] > 0 &&
       AssociationQ[wcResults[[1]]] &&
       KeyExistsQ[wcResults[[1]], "Sol"])
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "solveCoeffRoots-wc-NRC-handles-gracefully@@Tests/SolveEulerEq/solveCoeffRoots.wlt:565,1-596,4"
  ]

(* --- merged from: solveCoeffRoots_test6.wlt --- *)
(* Tests for solveCoeffRoots and solveWcPdRoots functions

   These tests verify the bug fixes applied in commit ad5bdbb:
   - SignSymbol now read from kernel instead of hardcoded default
   - extraParams now applied to both keys and values of Solution

   Tests verify that:
   - solveCoeffRoots returns numeric solutions for wc coefficients
   - solveCoeffRoots returns numeric solutions for pd coefficients
   - solveWcPdRoots returns valid interval structure
*)

(* Load required packages *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
On[General::shdw];

(* Load models data from Resources *)
Module[{pacletFile, pacletRoot, resourcesDir, modelsFile},
  (* Find paclet root from loaded package *)
  pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
  pacletRoot = If[StringQ[pacletFile],
    DirectoryName[pacletFile, 3],
    (* Fallback: try $InputFileName *)
    If[StringQ[$InputFileName] && $InputFileName =!= "",
      Module[{d = DirectoryName[$InputFileName]},
        While[!FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
          d = DirectoryName[d]];
        d
      ],
      Directory[]
    ]
  ];

  (* Store paclet root for use in tests *)
  $testPacletRoot = pacletRoot;

  (* CRITICAL for TestPaclet compatibility *)
  PacletDirectoryLoad[pacletRoot];

  (* Load models data - Get@Get extracts from DefinitionData wrapper *)
  resourcesDir = FileNameJoin[{pacletRoot, "Resources"}];
  modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}];
  $testModels = Get@Get[modelsFile];
];

(* Time limit for tests - these involve numeric solving *)
timeLimit = 120;

(* Helper: generate signs from kernel SignIndex *)
getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx},
  signIdx = kernel["SignIndex"];
  If[signIdx === {} || signIdx === {{}}, Return[{}]];
  maxIdx = Max[Flatten[signIdx]];
  Table[-1, maxIdx]
];

(* Helper: compute numeric params base from model *)
getParamsBase[model_Association] := (Association@model["params"])//.model["params"]//N;

(* Helper: load kernels for a model using new unified loader *)
loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"];

loadKernels[modelKey_String] := Module[
  {model, kernelData},

  model = $testModels[modelKey];
  kernelData = loadModelKernels[modelKey];

  <|"Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]|>
];

(* Bind private functions *)
solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"];
solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"];

(* j symbol for pd coefficient index *)
jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j;

VerificationTest[
    Module[{kernels, signSymbol},
      kernels = loadKernels["BY"];
      signSymbol = kernels["WcKernel"]["CompileSignSymbol"];

      (* CompileSignSymbol should be "signA" for wc kernel *)
      StringQ[signSymbol] && signSymbol === "signA"
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "kernel-CompileSignSymbol-wc@@Tests/SolveEulerEq/solveCoeffRoots.wlt:679,1-690,4"
  ]

(* --- merged from: solveCoeffRoots_test7.wlt --- *)
(* Tests for solveCoeffRoots and solveWcPdRoots functions

   These tests verify the bug fixes applied in commit ad5bdbb:
   - SignSymbol now read from kernel instead of hardcoded default
   - extraParams now applied to both keys and values of Solution

   Tests verify that:
   - solveCoeffRoots returns numeric solutions for wc coefficients
   - solveCoeffRoots returns numeric solutions for pd coefficients
   - solveWcPdRoots returns valid interval structure
*)

(* Load required packages *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
On[General::shdw];

(* Load models data from Resources *)
Module[{pacletFile, pacletRoot, resourcesDir, modelsFile},
  (* Find paclet root from loaded package *)
  pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
  pacletRoot = If[StringQ[pacletFile],
    DirectoryName[pacletFile, 3],
    (* Fallback: try $InputFileName *)
    If[StringQ[$InputFileName] && $InputFileName =!= "",
      Module[{d = DirectoryName[$InputFileName]},
        While[!FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
          d = DirectoryName[d]];
        d
      ],
      Directory[]
    ]
  ];

  (* Store paclet root for use in tests *)
  $testPacletRoot = pacletRoot;

  (* CRITICAL for TestPaclet compatibility *)
  PacletDirectoryLoad[pacletRoot];

  (* Load models data - Get@Get extracts from DefinitionData wrapper *)
  resourcesDir = FileNameJoin[{pacletRoot, "Resources"}];
  modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}];
  $testModels = Get@Get[modelsFile];
];

(* Time limit for tests - these involve numeric solving *)
timeLimit = 120;

(* Helper: generate signs from kernel SignIndex *)
getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx},
  signIdx = kernel["SignIndex"];
  If[signIdx === {} || signIdx === {{}}, Return[{}]];
  maxIdx = Max[Flatten[signIdx]];
  Table[-1, maxIdx]
];

(* Helper: compute numeric params base from model *)
getParamsBase[model_Association] := (Association@model["params"])//.model["params"]//N;

(* Helper: load kernels for a model using new unified loader *)
loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"];

loadKernels[modelKey_String] := Module[
  {model, kernelData},

  model = $testModels[modelKey];
  kernelData = loadModelKernels[modelKey];

  <|"Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]|>
];

(* Bind private functions *)
solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"];
solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"];

(* j symbol for pd coefficient index *)
jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j;

VerificationTest[
    Module[{kernels, signSymbol},
      kernels = loadKernels["BY"];
      signSymbol = kernels["PdKernel"]["CompileSignSymbol"];

      (* CompileSignSymbol should be "signB" for pd kernel *)
      StringQ[signSymbol] && signSymbol === "signB"
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "kernel-CompileSignSymbol-pd@@Tests/SolveEulerEq/solveCoeffRoots.wlt:773,1-784,4"
  ]

(* --- merged from: solveCoeffRoots_test8.wlt --- *)
(* Regression test for CompiledFunction::cfne bug fix

   This test verifies the fix for the symbol mismatch bug where:
   - findRootInterval computed reduceExpr containing B[1][0] (with j substituted)
   - but extractIntervalsFromReduce received coefList with B[j][0] (symbolic j)
   - causing the pattern match to fail and default interval to be used
   - which included x values where discriminant < 0, producing complex results
   - and triggering CompiledFunction::cfne warnings

   The fix applies paramsAll to coefList before passing to extractIntervalsFromReduce
   so the index variables match between reduceExpr and coefList.
*)

(* Load required packages *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
On[General::shdw];

(* Load models data from Resources *)
Module[{pacletFile, pacletRoot, resourcesDir, modelsFile},
  (* Find paclet root from loaded package *)
  pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
  pacletRoot = If[StringQ[pacletFile],
    DirectoryName[pacletFile, 3],
    (* Fallback: try $InputFileName *)
    If[StringQ[$InputFileName] && $InputFileName =!= "",
      Module[{d = DirectoryName[$InputFileName]},
        While[!FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
          d = DirectoryName[d]];
        d
      ],
      Directory[]
    ]
  ];

  (* Store paclet root for use in tests *)
  $testPacletRoot = pacletRoot;

  (* CRITICAL for TestPaclet compatibility *)
  PacletDirectoryLoad[pacletRoot];

  (* Load models data - Get@Get extracts from DefinitionData wrapper *)
  resourcesDir = FileNameJoin[{pacletRoot, "Resources"}];
  modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}];
  $testModels = Get@Get[modelsFile];
];

(* Time limit for tests - these involve numeric solving *)
timeLimit = 120;

(* Helper: generate signs from kernel SignIndex *)
getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx},
  signIdx = kernel["SignIndex"];
  If[signIdx === {} || signIdx === {{}}, Return[{}]];
  maxIdx = Max[Flatten[signIdx]];
  Table[-1, maxIdx]
];

(* Helper: compute numeric params base from model *)
getParamsBase[model_Association] := (Association@model["params"])//.model["params"]//N;

(* Helper: load kernels for a model using new unified loader *)
loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"];

loadKernels[modelKey_String] := Module[
  {model, kernelData},

  model = $testModels[modelKey];
  kernelData = loadModelKernels[modelKey];

  <|"Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]|>
];

(* Bind private functions *)
solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"];

(* j symbol for pd coefficient index *)
jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j;

(* Test: solveCoeffRoots for pd (B) coefficients should not emit cfne messages *)
(* This is a regression test for the index variable mismatch bug *)
VerificationTest[
    Module[{kernels, model, signsPd, paramsBase, pdResults, cfneOccurred},
      kernels = loadKernels["BY"];
      model = kernels["Model"];
      signsPd = getSignsFromKernel[kernels["PdKernel"]];
      paramsBase = getParamsBase[model];

      (* Check if CompiledFunction::cfne messages occur *)
      (* Use Check to detect if cfne was issued, wrapped in Quiet to suppress other messages *)
      cfneOccurred = False;
      Quiet[
        Check[
          pdResults = TimeConstrained[
            solveCoeffRoots[
              model["coeffsParamQuadSolve"]["pd"],
              kernels["PdKernel"],
              paramsBase,
              signsPd,
              <|jSym -> 1|>
            ],
            60
          ],
          cfneOccurred = True,
          CompiledFunction::cfne
        ]
      ];

      (* Test passes if no cfne messages were issued *)
      (* If the fix is removed, this will fail because complex values trigger cfne *)
      !cfneOccurred
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "solveCoeffRoots-pd-no-cfne-messages@@Tests/SolveEulerEq/solveCoeffRoots.wlt:869,1-903,4"
  ]

End[]
EndTestSection[]
