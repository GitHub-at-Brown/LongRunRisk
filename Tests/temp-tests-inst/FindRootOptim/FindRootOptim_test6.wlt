BeginTestSection["FindRootOptim"]

(* Load the FindRootOptim package first *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Load test data - must run AFTER package is loaded with Needs *)
Module[{testDir, sourceFile, pacletFile, pacletRoot, candidateDirs},
  (* Try multiple methods to find test directory, validate each *)
  candidateDirs = {};

  (* Method 1: Use $InputFileName if available (works with wolframscript -file) *)
  If[StringQ[$InputFileName] && $InputFileName =!= "",
    AppendTo[candidateDirs, DirectoryName[$InputFileName]]
  ];

  (* Method 2: Use Directory[] + expected test path (works with TestReport) *)
  AppendTo[candidateDirs, FileNameJoin[{Directory[], "Tests", "FindRootOptim"}]];

  (* Method 3: Use FindFile on loaded package (works when paclet installed) *)
  pacletFile = FindFile["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
  If[StringQ[pacletFile],
    pacletRoot = DirectoryName[pacletFile, 3];
    AppendTo[candidateDirs, FileNameJoin[{pacletRoot, "Tests", "FindRootOptim"}]]
  ];

  (* Method 4: Current directory as last resort *)
  AppendTo[candidateDirs, Directory[]];

  (* Find first candidate where TestDataSource.wl exists *)
  testDir = SelectFirst[
    candidateDirs,
    FileExistsQ[FileNameJoin[{#, "TestDataSource.wl"}]] &,
    First[candidateDirs] (* fallback to first candidate if none work *)
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
  eir[B[1][0] > 0, B[1][0]],
  {{0.001, 14.999}},
  SameTest -> tolSameTest,
  TimeConstraint -> timeLimit,
  TestID -> "extractIntervalsFromReduce-simple-inequality@@Tests/FindRootOptim/FindRootOptim.wlt:99,1-105,2"
]

(* buildKernel, bindUnary, findRootInterval, and fastRoot are tested in findRootCoeff0EdgeCases.wlt *)
(* with simpler expressions that don't timeout during FunctionCompile *)

EndTestSection[]
