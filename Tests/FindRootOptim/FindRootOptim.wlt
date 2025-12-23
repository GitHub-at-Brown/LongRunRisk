BeginTestSection["FindRootOptim"]

(* Load the FindRootOptim package first *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Load test data from test directory *)
Module[{testDir, binaryFile, sourceFile, isCI, pacletFile, pacletRoot},
  (* Robust path detection: try $InputFileName first, then derive from paclet location *)
  testDir = If[StringQ[$InputFileName] && StringLength[$InputFileName] > 0,
    DirectoryName[$InputFileName],
    (* Fallback: find paclet root from loaded package and derive test directory *)
    pacletFile = FindFile["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
    If[StringQ[pacletFile],
      (* Go from Kernel/Tools/FindRootOptim.wl up to paclet root, then to Tests/FindRootOptim *)
      pacletRoot = DirectoryName[pacletFile, 3];
      FileNameJoin[{pacletRoot, "Tests", "FindRootOptim"}],
      (* Last resort: try current directory *)
      Directory[]
    ]
  ];
  binaryFile = FileNameJoin[{testDir, "TestData.mx"}];
  sourceFile = FileNameJoin[{testDir, "TestDataSource.wl"}];

  (* Load test data: prefer binary, fall back to source *)
  (* On CI, always use source to avoid platform issues with .mx files *)
  isCI = Environment["CI"] === "true" || Environment["GITHUB_ACTIONS"] === "true" ||
         Environment["GITLAB_CI"] === "true" || Environment["CIRCLECI"] === "true";

  If[isCI || !FileExistsQ[binaryFile],
    (* Use source file (portable, slower) *)
    If[FileExistsQ[sourceFile],
      Get[sourceFile],
      (* Error: no data files found *)
      Abort[]
    ],
    (* Fast binary load (local development) *)
    Get[binaryFile]
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

{
  (* Test that A[0] coefficient is found and matches expected value *)
  VerificationTest[
    solNA0,
    {A[0] -> 1.777113528819289},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "dividend-model-A0-coefficient@@Tests/FindRootOptim/FindRootOptim.wlt:74,3-80,4"
  ],

  (* Test that B[1][0] coefficient is found and matches expected value *)
  VerificationTest[
    solNAB0,
    {B[1][0] -> 1.784254766558428},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "dividend-model-B10-coefficient@@Tests/FindRootOptim/FindRootOptim.wlt:83,3-89,4"
  ],

  (* Test that A[0] value is in expected range *)
  VerificationTest[
    1.77 < solNA0[[1,2]] < 1.78,
    True,
    TimeConstraint -> timeLimit,
    TestID -> "A0-coefficient-in-range@@Tests/FindRootOptim/FindRootOptim.wlt:92,3-97,4"
  ],

  (* Test that B[1][0] value is in expected range *)
  VerificationTest[
    1.78 < solNAB0[[1,2]] < 1.79,
    True,
    TimeConstraint -> timeLimit,
    TestID -> "B10-coefficient-in-range@@Tests/FindRootOptim/FindRootOptim.wlt:100,3-105,4"
  ],

  (* Test that extractIntervalsFromReduce is exported and works *)
  VerificationTest[
    Module[{intervals},
      intervals = eir[B[1][0] > 0, B[1][0]];
      MatchQ[intervals, {{_?NumericQ, _?NumericQ} ..}]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "extractIntervalsFromReduce-exported@@Tests/FindRootOptim/FindRootOptim.wlt:108,3-116,4"
  ],

  (* Test that extractIntervalsFromReduce returns correct interval for simple case *)
  VerificationTest[
    eir[B[1][0] > 0, B[1][0]],
    {{0.001, 14.999}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "extractIntervalsFromReduce-simple-inequality@@Tests/FindRootOptim/FindRootOptim.wlt:119,3-125,4"
  ],

  (* Test workflow concept: verify pre-computed results can be chained *)
  VerificationTest[
    Module[{testParams},
      (* Verify that A[0] result can be added to parameters *)
      testParams = Append[paramsA, solNA0[[1]]];
      MatchQ[Lookup[testParams, A[0]], _?NumericQ]
    ],
    True,
    TimeConstraint -> 5,
    TestID -> "integration-parameter-chaining@@Tests/FindRootOptim/FindRootOptim.wlt:128,3-137,4"
  ]

  (* buildKernel, bindUnary, findRootInterval, and fastRoot are tested in findRootCoeff0EdgeCases.wlt *)
  (* with simpler expressions that don't timeout during FunctionCompile *)
}

EndTestSection[]
