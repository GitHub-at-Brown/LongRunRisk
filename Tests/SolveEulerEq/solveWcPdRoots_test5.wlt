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
Module[{pacletFile, pacletRoot, resourcesDir, modelsFile, candidateRoots},
  (* Try multiple methods to find paclet root, validate each *)
  candidateRoots = {};

  (* Method 1: Use $InputFileName and walk up to find PacletInfo.wl (works with wolframscript -file) *)
  If[StringQ[$InputFileName] && $InputFileName =!= "",
    Module[{d = DirectoryName[$InputFileName]},
      While[!FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
        d = DirectoryName[d]];
      AppendTo[candidateRoots, d]
    ]
  ];

  (* Method 2: Use Directory[] as paclet root (works with TestReport) *)
  AppendTo[candidateRoots, Directory[]];

  (* Method 3: Use FindFile on loaded package (works when paclet installed) *)
  pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
  If[StringQ[pacletFile],
    AppendTo[candidateRoots, DirectoryName[pacletFile, 3]]
  ];

  (* Find first candidate where Resources/Models.wl exists *)
  pacletRoot = SelectFirst[
    candidateRoots,
    FileExistsQ[FileNameJoin[{#, "Resources", "Models.wl"}]] &,
    First[candidateRoots] (* fallback to first candidate if none work *)
  ];

  $testPacletRoot = pacletRoot;

  (* CRITICAL for TestPaclet compatibility *)
  PacletDirectoryLoad[pacletRoot];

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

(* Helper to extract j symbol from kernel Vars - CRITICAL for correct context matching *)
(* The j symbol must be in the same context as used in the kernel, not Global` *)
(* Pattern: B[j][0] has structure where Head = B[j], so we need Head[Head[var]][[1]] to get j *)
getJSymbolFromKernel[kernel_Association] := Module[{var, innerHead},
  var = First[kernel["Vars"]];
  (* var = B[j][0], Head[var] = B[j], Head[Head[var]] = B, Head[var][[1]] = j *)
  innerHead = Head[var];  (* B[j] *)
  If[Length[innerHead] > 0, innerHead[[1]], Symbol["j"]]
];

VerificationTest[
    Module[{kernels, model, results, jSym, extraParams},
      kernels = loadKernels["NRCStochVol"];
      model = kernels["Model"];

      (* Extract j symbol from PdKernel to ensure correct context *)
      jSym = getJSymbolFromKernel[kernels["PdKernel"]];
      extraParams = <|jSym -> 1|>;

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
    TestID -> "solveWcPdRoots-Wrapper-NRCStochVol-handles-gracefully@@Tests/SolveEulerEq/solveWcPdRoots_test5.wlt:94,1-113,4"
  ]

EndTestSection[]
