(* Tests for solveCoeffRoots and solveWcPdRoots functions

   These tests verify the bug fixes applied in commit ad5bdbb:
   - SignSymbol now read from kernel instead of hardcoded default
   - extraParams now applied to both keys and values of Solution

   Tests verify that:
   - solveCoeffRoots returns numeric solutions for wc coefficients
   - solveCoeffRoots returns numeric solutions for pd coefficients
   - solveWcPdRoots returns valid interval structure
*)

Begin["FernandoDuarte`LongRunRisk`Tests`SolveEulerEq`"];

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

  (* Load models data *)
  resourcesDir = FileNameJoin[{pacletRoot, "Resources"}];
  modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}];
  modelsData = Get[modelsFile];
  Get[modelsData];

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

(* Helper: load kernels for a model using new unified loader *)
loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"];

loadKernels[modelKey_String] := Module[
  {model, kernelData},

  model = FernandoDuarte`LongRunRisk`Models[modelKey];
  kernelData = loadModelKernels[model];

  <|"Model" -> model, "WcKernel" -> kernelData["wc"], "PdKernel" -> kernelData["pd"]|>
];

(* Bind private functions *)
solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"];
solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"];

(* j symbol for pd coefficient index *)
jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j;

tests = {

  (* Test: solveCoeffRoots for wc returns numeric solution for BY model *)
  VerificationTest[
    Module[{kernels, signsWc, wcResults, sol},
      kernels = loadKernels["BY"];
      signsWc = getSignsFromKernel[kernels["WcKernel"]];

      wcResults = Quiet@Check[
        TimeConstrained[
          solveCoeffRoots[kernels["Model"], kernels["WcKernel"], signsWc, "wc", <||>],
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
    TestID -> "solveCoeffRoots-wc-BY-numeric@@Tests/SolveEulerEq/solveCoeffRoots.wlt:83,3-108,4"
  ],

  (* Test: solveCoeffRoots for pd returns numeric solution for BY model *)
  VerificationTest[
    Module[{kernels, signsWc, signsPd, wcResults, extraParamsPd, jAsoc, pdResults, sol},
      kernels = loadKernels["BY"];
      signsWc = getSignsFromKernel[kernels["WcKernel"]];
      signsPd = getSignsFromKernel[kernels["PdKernel"]];

      (* First get wc results *)
      wcResults = Quiet@Check[
        TimeConstrained[
          solveCoeffRoots[kernels["Model"], kernels["WcKernel"], signsWc, "wc", <||>],
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
          solveCoeffRoots[kernels["Model"], kernels["PdKernel"], signsPd, "pd", Join[extraParamsPd, jAsoc]],
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
    TestID -> "solveCoeffRoots-pd-BY-numeric@@Tests/SolveEulerEq/solveCoeffRoots.wlt:111,3-154,4"
  ],

  (* Test: solveWcPdRoots returns valid structure for BY model *)
  VerificationTest[
    Module[{kernels, signsWc, signsPd, jAsoc, wcPdResults},
      kernels = loadKernels["BY"];
      signsWc = getSignsFromKernel[kernels["WcKernel"]];
      signsPd = getSignsFromKernel[kernels["PdKernel"]];
      jAsoc = <|jSym -> 1|>;

      wcPdResults = Quiet@Check[
        TimeConstrained[
          solveWcPdRoots[kernels["Model"], kernels["WcKernel"], kernels["PdKernel"], signsWc, signsPd, jAsoc],
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
    TestID -> "solveWcPdRoots-BY-structure@@Tests/SolveEulerEq/solveCoeffRoots.wlt:157,3-182,4"
  ],

  (* Test: solveCoeffRoots for wc returns numeric solution for BKY model *)
  VerificationTest[
    Module[{kernels, signsWc, wcResults},
      kernels = loadKernels["BKY"];
      signsWc = getSignsFromKernel[kernels["WcKernel"]];

      wcResults = Quiet@Check[
        TimeConstrained[
          solveCoeffRoots[kernels["Model"], kernels["WcKernel"], signsWc, "wc", <||>],
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
    TestID -> "solveCoeffRoots-wc-BKY-numeric@@Tests/SolveEulerEq/solveCoeffRoots.wlt:185,3-209,4"
  ],

  (* Test: solveCoeffRoots for wc returns numeric solution for NRC model *)
  VerificationTest[
    Module[{kernels, signsWc, wcResults},
      kernels = loadKernels["NRC"];
      signsWc = getSignsFromKernel[kernels["WcKernel"]];

      wcResults = Quiet@Check[
        TimeConstrained[
          solveCoeffRoots[kernels["Model"], kernels["WcKernel"], signsWc, "wc", <||>],
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
    TestID -> "solveCoeffRoots-wc-NRC-numeric@@Tests/SolveEulerEq/solveCoeffRoots.wlt:212,3-236,4"
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
    TestID -> "kernel-SignSymbol-wc@@Tests/SolveEulerEq/solveCoeffRoots.wlt:239,3-250,4"
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
    TestID -> "kernel-SignSymbol-pd@@Tests/SolveEulerEq/solveCoeffRoots.wlt:253,3-264,4"
  ]

};

End[];

tests
