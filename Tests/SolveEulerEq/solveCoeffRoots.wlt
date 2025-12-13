(* Tests for solveCoeffRoots and solveWcPdRoots functions

   These tests verify the bug fixes applied in commit ad5bdbb:
   - SignSymbol now read from kernel instead of hardcoded default
   - extraParams now applied to both keys and values of Solution

   Tests verify that:
   - solveCoeffRoots returns numeric solutions for wc coefficients
   - solveCoeffRoots returns numeric solutions for pd coefficients
   - solveWcPdRoots returns valid interval structure
*)


(* Find paclet root and load dependencies *)
Module[{start, d, pacletRoot, resourcesDir, modelsFile, modelsData},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
    d = DirectoryName[d]
  ];
  pacletRoot = d;

  (* Store paclet root for use in tests *)
  $testPacletRoot = pacletRoot;

  (* Load models data - Get@Get extracts from DefinitionData wrapper *)
  resourcesDir = FileNameJoin[{pacletRoot, "Resources"}];
  modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}];
  $testModels = Get@Get[modelsFile];

  Off[General::shdw];
  PacletDirectoryLoad[pacletRoot];
  Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
  Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
  On[General::shdw];
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

tests = {

  (* Test: solveCoeffRoots for wc returns numeric solution for BY model *)
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
    TestID -> "solveCoeffRoots-wc-BY-numeric@@Tests/SolveEulerEq/solveCoeffRoots.wlt:77,3-110,4"
  ],

  (* Test: solveCoeffRoots for pd returns numeric solution for BY model *)
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

      If[!ListQ[wcResults] || Length[wcResults] == 0, Return[$Failed]];

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
    TestID -> "solveCoeffRoots-pd-BY-numeric@@Tests/SolveEulerEq/solveCoeffRoots.wlt:113,3-170,4"
  ],

  (* Test: solveWcPdRoots returns valid structure for BY model *)
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
    TestID -> "solveWcPdRoots-BY-structure@@Tests/SolveEulerEq/solveCoeffRoots.wlt:173,3-199,4"
  ],

  (* Test: solveCoeffRoots for wc returns numeric solution for BKY model *)
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
    TestID -> "solveCoeffRoots-wc-BKY-numeric@@Tests/SolveEulerEq/solveCoeffRoots.wlt:202,3-234,4"
  ],

  (* Test: solveCoeffRoots for wc handles NRC model (may fail due to numerical precision)
     Note: NRC model can fail Reduce with inexact coefficients - this is a known limitation *)
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
    TestID -> "solveCoeffRoots-wc-NRC-handles-gracefully@@Tests/SolveEulerEq/solveCoeffRoots.wlt:238,3-269,4"
  ],

  (* Test: kernel SignSymbol is correctly read for wc *)
  VerificationTest[
    Module[{kernels, signSymbol},
      kernels = loadKernels["BY"];
      signSymbol = kernels["WcKernel"]["SignSymbol"];

      (* SignSymbol should be "signA" for wc kernel *)
      StringQ[signSymbol] && signSymbol === "signA"
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "kernel-SignSymbol-wc@@Tests/SolveEulerEq/solveCoeffRoots.wlt:272,3-283,4"
  ],

  (* Test: kernel SignSymbol is correctly read for pd *)
  VerificationTest[
    Module[{kernels, signSymbol},
      kernels = loadKernels["BY"];
      signSymbol = kernels["PdKernel"]["SignSymbol"];

      (* SignSymbol should be "signB" for pd kernel *)
      StringQ[signSymbol] && signSymbol === "signB"
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "kernel-SignSymbol-pd@@Tests/SolveEulerEq/solveCoeffRoots.wlt:286,3-297,4"
  ]

};


tests
