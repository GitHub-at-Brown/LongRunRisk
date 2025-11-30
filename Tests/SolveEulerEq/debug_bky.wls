#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Debug script for solveCoeffRoots failures with BKY model *)

Module[{start, d, pacletRoot, resourcesDir, modelsFile, modelsData},
  start = DirectoryName[$InputFileName];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
    d = DirectoryName[d]
  ];
  pacletRoot = d;

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

  (* Run the failing case: BKY model wc *)
  Print["\n--- Debugging BKY Model WC ---"];
  kernels = loadKernels["BKY"];
  signsWc = getSignsFromKernel[kernels["WcKernel"]];
  
  Print["SignsWc: ", signsWc];
  Print["Vars: ", kernels["WcKernel"]["Vars"]];

  wcResults = Check[
    solveCoeffRoots[kernels["Model"], kernels["WcKernel"], signsWc, "wc", <||>],
    $Failed
  ];

  Print["\nResult:"];
  Print[wcResults];

  If[ListQ[wcResults] && Length[wcResults] > 0,
      Print["\nFirst Result Keys: ", Keys[wcResults[[1]]]];
      If[KeyExistsQ[wcResults[[1]], "Sol"],
          Print["\nSol: ", wcResults[[1]]["Sol"]];
      ];
  ];
];
