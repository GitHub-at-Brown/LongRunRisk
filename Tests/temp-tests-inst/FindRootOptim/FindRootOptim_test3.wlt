BeginTestSection["FindRootOptim"]

(* Load the FindRootOptim package first *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Load test data - must run AFTER package is loaded with Needs *)
Module[{testDir, sourceFile, pacletFile, pacletRoot},
  (* Try to find test directory using FindFile on the loaded package *)
  pacletFile = FindFile["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];

  testDir = If[StringQ[pacletFile],
    (* Found package file - derive test directory from paclet root *)
    pacletRoot = DirectoryName[pacletFile, 3];
    FileNameJoin[{pacletRoot, "Tests", "FindRootOptim"}],
    (* Fallback: if FindFile fails, try using $InputFileName *)
    If[StringQ[$InputFileName] && StringLength[$InputFileName] > 0,
      DirectoryName[$InputFileName],
      (* Last resort: current directory (will likely fail) *)
      Directory[]
    ]
  ];

  sourceFile = FileNameJoin[{testDir, "TestDataSource.wl"}];

  (* Load test data from source file *)
  If[FileExistsQ[sourceFile],
    Get[sourceFile],
    (* File not found - set dummy variables so tests fail instead of error *)
    solNA0 = {}; solNAB0 = {}; paramsA = <||>;
  ];
];

(* Prefer exported extractIntervalsFromReduce; fall back to Private if needed *)
eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

(* Robust comparison that handles scalars, lists, and rules *)
tolSameTest = Function[{actual, expected},
  Module[{a, e},
    (* Extract numeric values from rules, lists of rules, or plain numbers *)
    a = actual /. {Rule[_, v_?NumericQ] :> v, {Rule[_, v_?NumericQ]} :> v};
    e = expected /. {Rule[_, v_?NumericQ] :> v, {Rule[_, v_?NumericQ]} :> v};
    (* Ensure we have lists for Flatten *)
    Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^-6
  ]
];
timeLimit = 60;

(* Test that A[0] coefficient is found and matches expected value *)

VerificationTest[
  1.77 < solNA0[[1,2]] < 1.78,
  True,
  TimeConstraint -> timeLimit,
  TestID -> "A0-coefficient-in-range@@Tests/FindRootOptim/FindRootOptim.wlt:72,1-77,2"
]

(* buildKernel, bindUnary, findRootInterval, and fastRoot are tested in findRootCoeff0EdgeCases.wlt *)
(* with simpler expressions that don't timeout during FunctionCompile *)

EndTestSection[]
