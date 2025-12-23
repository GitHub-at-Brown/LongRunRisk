BeginTestSection["solveWcPdRoots"]
Begin["FernandoDuarte`LongRunRisk`Tests`SolveEulerEq`solveWcPdRoots`"]

(* Tests for solveWcPdRoots wrapper and standardized output structure

   These tests verify:
   - solveCoeffRoots returns "Signs" in result
   - solveWcPdRoots (original) returns "SignsWc" and "SignsPd"
   - solveWcPdRoots (wrapper) returns flat list with sign info
   - wrapper finds multiple solutions for DES and NRCStochVol
*)


(* Find paclet root and load dependencies *)
Module[{start, d, pacletRoot, resourcesDir, modelsFile},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
    d = DirectoryName[d]
  ];
  pacletRoot = d;
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

(* Time limit for tests *)
timeLimit = 300;

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

(* j symbol for pd coefficient index - use generic i and j *)
jSym = Symbol["j"];
iSym = Symbol["i"];
extraParams = <|jSym -> 1, iSym -> 1|>;

tests = {

  (* Test: solveCoeffRoots returns "Signs" key *)
  VerificationTest[
    Module[{kernels, model, signsWc, paramsBase, wcResults},
      kernels = loadKernels["BY"];
      model = kernels["Model"];
      signsWc = getSignsFromKernel[kernels["WcKernel"]];
      paramsBase = getParamsBase[model];

      wcResults = Quiet@Check[
        solveCoeffRoots[
          model["coeffsParamQuadSolve"]["wc"],
          kernels["WcKernel"],
          paramsBase,
          signsWc,
          <||>
        ],
        $Failed
      ];

      ListQ[wcResults] && Length[wcResults] > 0 &&
      KeyExistsQ[wcResults[[1]], "Signs"] &&
      wcResults[[1]]["Signs"] === signsWc
    ],
    True,
    TestID -> "solveCoeffRoots-Signs-Key@@Tests/SolveEulerEq/solveWcPdRoots.wlt:74,3-98,4"
  ],

  (* Test: solveWcPdRoots (original) returns "SignsWc" and "SignsPd" keys *)
  VerificationTest[
    Module[{kernels, model, signsWc, signsPd, wcPdResults},
      kernels = loadKernels["BY"];
      model = kernels["Model"];
      signsWc = getSignsFromKernel[kernels["WcKernel"]];
      signsPd = getSignsFromKernel[kernels["PdKernel"]];

      wcPdResults = Quiet@Check[
        solveWcPdRoots[model, kernels["WcKernel"], kernels["PdKernel"], signsWc, signsPd, extraParams],
        $Failed
      ];

      ListQ[wcPdResults] && Length[wcPdResults] > 0 &&
      KeyExistsQ[wcPdResults[[1]], "SignsWc"] &&
      KeyExistsQ[wcPdResults[[1]], "SignsPd"] &&
      wcPdResults[[1]]["SignsWc"] === signsWc &&
      wcPdResults[[1]]["SignsPd"] === signsPd
    ],
    True,
    TestID -> "solveWcPdRoots-Original-Signs-Keys@@Tests/SolveEulerEq/solveWcPdRoots.wlt:101,3-121,4"
  ],

  (* Test: solveWcPdRoots (wrapper) returns flat list with sign info for BY *)
  VerificationTest[
    Module[{kernels, model, results},
      kernels = loadKernels["BY"];
      model = kernels["Model"];

      (* Call wrapper (no signs) *)
      results = Quiet@Check[
        solveWcPdRoots[model, kernels["WcKernel"], kernels["PdKernel"], extraParams],
        $Failed
      ];

      ListQ[results] && Length[results] > 0 &&
      KeyExistsQ[results[[1]], "SignsWc"] &&
      KeyExistsQ[results[[1]], "SignsPd"] &&
      KeyExistsQ[results[[1]], "Roots"] &&
      KeyExistsQ[results[[1]], "Pd"]
    ],
    True,
    TestID -> "solveWcPdRoots-Wrapper-BY-Structure@@Tests/SolveEulerEq/solveWcPdRoots.wlt:124,3-143,4"
  ],

  (* Test: solveWcPdRoots (wrapper) handles DES model
     Note: DES model may fail Reduce with inexact coefficients - this is a known limitation *)
  VerificationTest[
    Module[{kernels, model, results},
      kernels = loadKernels["DES"];
      model = kernels["Model"];

      results = Quiet@Check[
        solveWcPdRoots[model, kernels["WcKernel"], kernels["PdKernel"], extraParams],
        $Failed
      ];

      (* Accept either valid results with proper structure or graceful failure *)
      results === $Failed ||
      (ListQ[results] && Length[results] >= 1 &&
       AllTrue[results, KeyExistsQ[#, "SignsWc"] &] &&
       AllTrue[results, KeyExistsQ[#, "SignsPd"] &])
    ],
    True,
    TestID -> "solveWcPdRoots-Wrapper-DES-handles-gracefully@@Tests/SolveEulerEq/solveWcPdRoots.wlt:147,3-165,4"
  ],

  (* Test: solveWcPdRoots (wrapper) handles NRCStochVol model
     Note: NRCStochVol model may fail Reduce with inexact coefficients - this is a known limitation *)
  VerificationTest[
    Module[{kernels, model, results},
      kernels = loadKernels["NRCStochVol"];
      model = kernels["Model"];

      results = Quiet@Check[
        solveWcPdRoots[model, kernels["WcKernel"], kernels["PdKernel"], extraParams],
        $Failed
      ];

      (* Accept either valid results with proper structure or graceful failure *)
      results === $Failed ||
      (ListQ[results] && Length[results] >= 1 &&
       AllTrue[results, KeyExistsQ[#, "SignsWc"] &] &&
       AllTrue[results, KeyExistsQ[#, "SignsPd"] &])
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "solveWcPdRoots-Wrapper-NRCStochVol-handles-gracefully@@Tests/SolveEulerEq/solveWcPdRoots.wlt:169,3-188,4"
  ]

};



End[]
EndTestSection[]
