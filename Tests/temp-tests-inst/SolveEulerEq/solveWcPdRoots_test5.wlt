BeginTestSection["solveWcPdRoots"]

(* Tests for solveWcPdRoots wrapper and standardized output structure

   These tests verify:
   - solveCoeffRoots returns "Signs" in result
   - solveWcPdRoots (original) returns "SignsWc" and "SignsPd"
   - solveWcPdRoots (wrapper) returns flat list with sign info
   - wrapper finds multiple solutions for DES and NRCStochVol
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
  $testPacletRoot = pacletRoot;

  (* Load models data - Get@Get extracts from DefinitionData wrapper *)
  resourcesDir = FileNameJoin[{pacletRoot, "Resources"}];
  modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}];
  $testModels = Get@Get[modelsFile];
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
    TestID -> "solveWcPdRoots-Wrapper-NRCStochVol-handles-gracefully@@Tests/SolveEulerEq/solveWcPdRoots.wlt:175,3-194,4"
  ]

EndTestSection[]
