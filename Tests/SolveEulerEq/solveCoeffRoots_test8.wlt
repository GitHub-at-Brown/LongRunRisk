BeginTestSection["solveCoeffRoots"]

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
    TestID -> "solveCoeffRoots-pd-no-cfne-messages@@Tests/SolveEulerEq/solveCoeffRoots_test8.wlt:80,1-112,4"
  ]

EndTestSection[]
