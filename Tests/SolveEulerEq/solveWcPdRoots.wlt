(* Tests for solveWcPdRoots wrapper and standardized output structure
   
   These tests verify:
   - solveCoeffRoots returns "Signs" in result
   - solveWcPdRoots (original) returns "SignsWc" and "SignsPd"
   - solveWcPdRoots (wrapper) returns flat list with sign info
   - wrapper finds multiple solutions for DES and NRCStochVol
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

(* Time limit for tests *)
timeLimit = 300;

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
jSym = Symbol["j"]; 
iSym = Symbol["i"];
extraParams = <|jSym -> 1, iSym -> 1|>;

tests = {

  (* Test 1: solveCoeffRoots returns "Signs" key *)
  VerificationTest[
    Module[{kernels, signsWc, wcResults},
      kernels = loadKernels["BY"];
      signsWc = getSignsFromKernel[kernels["WcKernel"]];

      wcResults = Quiet@Check[
        solveCoeffRoots[kernels["Model"], kernels["WcKernel"], signsWc, "wc", <||>],
        $Failed
      ];

      ListQ[wcResults] && Length[wcResults] > 0 &&
      KeyExistsQ[wcResults[[1]], "Signs"] &&
      wcResults[[1]]["Signs"] === signsWc
    ],
    True,
    TestID -> "solveCoeffRoots-Signs-Key"
  ],

  (* Test 2: solveWcPdRoots (original) returns "SignsWc" and "SignsPd" keys *)
  VerificationTest[
    Module[{kernels, signsWc, signsPd, wcPdResults},
      kernels = loadKernels["BY"];
      signsWc = getSignsFromKernel[kernels["WcKernel"]];
      signsPd = getSignsFromKernel[kernels["PdKernel"]];

      wcPdResults = Quiet@Check[
        solveWcPdRoots[kernels["Model"], kernels["WcKernel"], kernels["PdKernel"], signsWc, signsPd, extraParams],
        $Failed
      ];

      ListQ[wcPdResults] && Length[wcPdResults] > 0 &&
      KeyExistsQ[wcPdResults[[1]], "SignsWc"] &&
      KeyExistsQ[wcPdResults[[1]], "SignsPd"] &&
      wcPdResults[[1]]["SignsWc"] === signsWc &&
      wcPdResults[[1]]["SignsPd"] === signsPd
    ],
    True,
    TestID -> "solveWcPdRoots-Original-Signs-Keys"
  ],

  (* Test 3: solveWcPdRoots (wrapper) returns flat list with sign info for BY *)
  VerificationTest[
    Module[{kernels, results},
      kernels = loadKernels["BY"];
      
      (* Call wrapper (no signs) *)
      results = Quiet@Check[
        solveWcPdRoots[kernels["Model"], kernels["WcKernel"], kernels["PdKernel"], extraParams],
        $Failed
      ];

      ListQ[results] && Length[results] > 0 &&
      KeyExistsQ[results[[1]], "SignsWc"] &&
      KeyExistsQ[results[[1]], "SignsPd"] &&
      KeyExistsQ[results[[1]], "Roots"] &&
      KeyExistsQ[results[[1]], "Pd"]
    ],
    True,
    TestID -> "solveWcPdRoots-Wrapper-BY-Structure"
  ],

  (* Test 4: solveWcPdRoots (wrapper) finds multiple solutions for DES *)
  VerificationTest[
    Module[{kernels, results},
      kernels = loadKernels["DES"];
      
      results = Quiet@Check[
        solveWcPdRoots[kernels["Model"], kernels["WcKernel"], kernels["PdKernel"], extraParams],
        $Failed
      ];

      ListQ[results] && Length[results] >= 2 && (* Expecting at least 2 solutions *)
      AllTrue[results, KeyExistsQ[#, "SignsWc"] &] &&
      AllTrue[results, KeyExistsQ[#, "SignsPd"] &]
    ],
    True,
    TestID -> "solveWcPdRoots-Wrapper-DES-MultipleSolutions"
  ],

  (* Test 5: solveWcPdRoots (wrapper) finds multiple solutions for NRCStochVol *)
  VerificationTest[
    Module[{kernels, results},
      kernels = loadKernels["NRCStochVol"];
      
      results = Quiet@Check[
        solveWcPdRoots[kernels["Model"], kernels["WcKernel"], kernels["PdKernel"], extraParams],
        $Failed
      ];

      ListQ[results] && Length[results] >= 2 && (* Expecting at least 2 solutions *)
      AllTrue[results, KeyExistsQ[#, "SignsWc"] &] &&
      AllTrue[results, KeyExistsQ[#, "SignsPd"] &]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "solveWcPdRoots-Wrapper-NRCStochVol-MultipleSolutions"
  ]

};


tests
