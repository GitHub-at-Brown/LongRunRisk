BeginTestSection["solveCoeffRoots"]

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
      signSymbol = kernels["WcKernel"]["SignSymbol"];

      (* SignSymbol should be "signA" for wc kernel *)
      StringQ[signSymbol] && signSymbol === "signA"
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "kernel-SignSymbol-wc@@Tests/SolveEulerEq/solveCoeffRoots.wlt:278,3-289,4"
  ]

EndTestSection[]
