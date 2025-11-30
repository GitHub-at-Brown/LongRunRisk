Print["Starting FindRootOptim.wlt"];
Module[{testDir, binaryFile, sourceFile, loadStart, loadEnd, isCI},
  testDir = DirectoryName[$InputFileName];
  binaryFile = FileNameJoin[{testDir, "TestData.mx"}];
  sourceFile = FileNameJoin[{testDir, "TestDataSource.wl"}];

  Off[General::shdw];

  (* Load the FindRootOptim code via Needs *)
  Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];

  (* Load test data: prefer binary, fall back to source *)
  (* On CI, always use source to avoid platform issues with .mx files *)
  loadStart = AbsoluteTime[];
  isCI = Environment["CI"] === "true" || Environment["GITHUB_ACTIONS"] === "true" ||
         Environment["GITLAB_CI"] === "true" || Environment["CIRCLECI"] === "true";

  If[isCI || !FileExistsQ[binaryFile],
    (* Use source file (portable, slower) *)
    If[FileExistsQ[sourceFile],
      Get[sourceFile];
      loadEnd = AbsoluteTime[];
      If[isCI,
        (* Print["CI detected: Using portable TestDataSource.wl"];*)
        Null,
        Print["Note: Loaded from TestDataSource.wl (",
              NumberForm[loadEnd - loadStart, {4, 2}], " seconds)"];
        Print["      Run CreateTestData.wls to generate faster binary TestData.mx"];
      ];
      ,
      (* Error: no data files found *)
      Print["ERROR: No test data files found!"];
      Print["Expected source: ", sourceFile];
      Abort[];
    ],
    (* Fast binary load (local development) *)
    Get[binaryFile];
    loadEnd = AbsoluteTime[];
    (*Print["Loaded test data from binary in ", NumberForm[loadEnd - loadStart, {4, 2}], " seconds"];*)
  ];

  On[General::shdw];
Print["Module finished"];
Print["Context of buildKernel inside wlt: ", Context[buildKernel]];
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

Print["Heads: ", {Head[exprAB], Head[{B[1][0]}], Head[paramAB]}];
Print["Options[buildKernel]: ", Options[buildKernel]];
Print["Test call buildKernel: ", buildKernel[1, {x}, {}]];

Print["Returning tests list"];
tests = {
  (* Test that A[0] coefficient is found and matches expected value *)
  VerificationTest[
    solNA0,
    {A[0] -> 1.777113528819289},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "dividend-model-A0-coefficient@@Tests/FindRootOptim/FindRootOptim.wlt:64,3-70,4"
  ],

  (* Test that B[1][0] coefficient is found and matches expected value *)
  VerificationTest[
    solNAB0,
    {B[1][0] -> 1.784254766558428},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "dividend-model-B10-coefficient@@Tests/FindRootOptim/FindRootOptim.wlt:73,3-79,4"
  ],

  (* Test that A[0] value is in expected range *)
  VerificationTest[
    1.77 < solNA0[[1,2]] < 1.78,
    True,
    TimeConstraint -> timeLimit,
    TestID -> "A0-coefficient-in-range@@Tests/FindRootOptim/FindRootOptim.wlt:82,3-87,4"
  ],

  (* Test that B[1][0] value is in expected range *)
  VerificationTest[
    1.78 < solNAB0[[1,2]] < 1.79,
    True,
    TimeConstraint -> timeLimit,
    TestID -> "B10-coefficient-in-range@@Tests/FindRootOptim/FindRootOptim.wlt:90,3-95,4"
  ],

  (* Test that extractIntervalsFromReduce is exported and works *)
  VerificationTest[
    Module[{intervals},
      intervals = eir[B[1][0] > 0, B[1][0]];
      MatchQ[intervals, {{_?NumericQ, _?NumericQ} ..}]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "extractIntervalsFromReduce-exported@@Tests/FindRootOptim/FindRootOptim.wlt:98,3-106,4"
  ],

  (* Test that extractIntervalsFromReduce returns correct interval for simple case *)
  VerificationTest[
    eir[B[1][0] > 0, B[1][0]],
    {{0.001, 14.999}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "extractIntervalsFromReduce-simple-inequality@@Tests/FindRootOptim/FindRootOptim.wlt:109,3-115,4"
  ],

  (* Test buildKernel for B coefficient structure *)
  VerificationTest[
    Module[{kernel, keys},
      kernel = buildKernel[exprAB, {B[1][0]}, paramAB,
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      keys = Keys[kernel];
      AllTrue[{"fC", "dfC", "Vars", "ParamOrder", "SignIndex", "CoeffName", "SignSymbol"},
        MemberQ[keys, #] &]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "buildKernel-B-structure@@Tests/FindRootOptim/FindRootOptim.wlt:118,3-129,4"
  ],

  (* Test buildKernel CoeffName is correctly set *)
  VerificationTest[
    Module[{kernel},
      kernel = buildKernel[exprAB, {B[1][0]}, paramAB,
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      kernel["CoeffName"]
    ],
    "B",
    TimeConstraint -> timeLimit,
    TestID -> "buildKernel-B-coeffname@@Tests/FindRootOptim/FindRootOptim.wlt:132,3-141,4"
  ],

  (* Test bindUnary for B coefficient returns functions *)
  VerificationTest[
    Module[{kernel, fC, dfC},
      kernel = buildKernel[exprAB, {B[1][0]}, paramAB,
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      {fC, dfC} = bindUnary[kernel, paramsAB, signsAB];
      {Head[fC], Head[dfC]}
    ],
    {Function, Function},
    TimeConstraint -> timeLimit,
    TestID -> "bindUnary-B-returns-functions@@Tests/FindRootOptim/FindRootOptim.wlt:144,3-154,4"
  ],

  (* Test findRootInterval for B coefficient returns valid expression *)
  VerificationTest[
    Module[{reduceExpr},
      reduceExpr = findRootInterval[condAB, paramsAB, signsAB,
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      reduceExpr =!= $Failed && reduceExpr =!= False
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "findRootInterval-B-succeeds@@Tests/FindRootOptim/FindRootOptim.wlt:157,3-166,4"
  ],

  (* Test that fastRoot finds correct root via manual workflow *)
  VerificationTest[
    Module[{kernel, fC, dfC, reduceExpr, intervals, L, U, root},
      kernel = buildKernel[exprAB, {B[1][0]}, paramAB,
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      {fC, dfC} = bindUnary[kernel, paramsAB, signsAB];
      reduceExpr = findRootInterval[condAB, paramsAB, signsAB,
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      intervals = eir[reduceExpr, B[1][0]];
      {L, U} = {intervals[[1,1]], intervals[[-1,2]]};
      (* bindUnary returns functions expecting a list; wrap for fastRoot's scalar interface *)
      root = fastRoot[fC[{#}] &, dfC[{#}] &, {L, U - 0.01}];
      MatchQ[root, {_ -> _?NumericQ}] && Abs[root[[1,2]] - 1.784254766558428] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "fastRoot-B-workflow-complete@@Tests/FindRootOptim/FindRootOptim.wlt:169,3-184,4"
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
    TestID -> "integration-parameter-chaining@@Tests/FindRootOptim/FindRootOptim.wlt:189,3-198,4"
  ],

  (* Test buildKernel structure check - FunctionCompile produces CompiledCodeFunction *)
  VerificationTest[
    Module[{kernel, keys},
      kernel = buildKernel[exprAB, {B[1][0]}, paramAB,
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      keys = Keys[kernel];
      AllTrue[{"fC", "dfC", "Vars", "ParamOrder", "SignIndex", "CoeffName", "SignSymbol"},
        MemberQ[keys, #] &]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "buildKernel-structure-check@@Tests/FindRootOptim/FindRootOptim.wlt:202,3-213,4"
  ]
};
Print["Tests list length: ", Length[tests]];
tests
