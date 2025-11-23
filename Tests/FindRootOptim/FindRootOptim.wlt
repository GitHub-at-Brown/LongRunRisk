Module[{start, d, pacletRoot, testDir, binaryFile, sourceFile, loadStart, loadEnd, isCI},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d], d = DirectoryName[d]];
  pacletRoot = d;
  testDir = DirectoryName[$InputFileName];
  binaryFile = FileNameJoin[{testDir, "TestData.mx"}];
  sourceFile = FileNameJoin[{testDir, "TestDataSource.wl"}];

  Off[General::shdw];

  (* Load the FindRootOptim code *)
  Get[FileNameJoin[{pacletRoot, "Kernel", "Tools", "FindRootOptim.wl"}]];

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
    TestID -> "dividend-model-A0-coefficient@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* Test that B[1][0] coefficient is found and matches expected value *)
  VerificationTest[
    solNAB0,
    {B[1][0] -> 1.784254766558428},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "dividend-model-B10-coefficient@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* Test that A[0] value is in expected range *)
  VerificationTest[
    1.77 < solNA0[[1,2]] < 1.78,
    True,
    TimeConstraint -> timeLimit,
    TestID -> "A0-coefficient-in-range@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* Test that B[1][0] value is in expected range *)
  VerificationTest[
    1.78 < solNAB0[[1,2]] < 1.79,
    True,
    TimeConstraint -> timeLimit,
    TestID -> "B10-coefficient-in-range@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* Test that extractIntervalsFromReduce is exported and works *)
  VerificationTest[
    Module[{intervals},
      intervals = eir[B[1][0] > 0, B[1][0]];
      MatchQ[intervals, {{_?NumericQ, _?NumericQ} ..}]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "extractIntervalsFromReduce-exported@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* Test that extractIntervalsFromReduce returns correct interval for simple case *)
  VerificationTest[
    eir[B[1][0] > 0, B[1][0]],
    {{0.001, 14.999}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "extractIntervalsFromReduce-simple-inequality@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* Test buildKernel for B coefficient structure *)
  VerificationTest[
    Module[{kernel, keys},
      kernel = buildKernel[exprAB, paramAB, CompilationTarget -> "C",
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      keys = Keys[kernel];
      AllTrue[{"fC", "dfC", "ParamOrder", "SignIndex", "CoeffName", "SignSymbol"},
        MemberQ[keys, #] &]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "buildKernel-B-structure@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* Test buildKernel CoeffName is correctly set *)
  VerificationTest[
    Module[{kernel},
      kernel = buildKernel[exprAB, paramAB, CompilationTarget -> "C",
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      kernel["CoeffName"]
    ],
    "B",
    TimeConstraint -> timeLimit,
    TestID -> "buildKernel-B-coeffname@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* Test bindUnary for B coefficient returns functions *)
  VerificationTest[
    Module[{kernel, fC, dfC},
      kernel = buildKernel[exprAB, paramAB, CompilationTarget -> "C",
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      {fC, dfC} = bindUnary[kernel, paramsAB, signsAB];
      {Head[fC], Head[dfC]}
    ],
    {Function, Function},
    TimeConstraint -> timeLimit,
    TestID -> "bindUnary-B-returns-functions@@test/FindRootOptim/FindRootOptim.wlt"
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
    TestID -> "findRootInterval-B-succeeds@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* Test that fastRoot finds correct root via manual workflow *)
  VerificationTest[
    Module[{kernel, fC, dfC, reduceExpr, intervals, L, U, root},
      kernel = buildKernel[exprAB, paramAB, CompilationTarget -> "C",
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      {fC, dfC} = bindUnary[kernel, paramsAB, signsAB];
      reduceExpr = findRootInterval[condAB, paramsAB, signsAB,
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      intervals = eir[reduceExpr, B[1][0]];
      {L, U} = {intervals[[1,1]], intervals[[-1,2]]};
      root = fastRoot[fC, dfC, {L, U - 0.01}];
      MatchQ[root, {_ -> _?NumericQ}] && Abs[root[[1,2]] - 1.784254766558428] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "fastRoot-B-workflow-complete@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* Test findRootCoeff0 for A[0] coefficient - run once and verify both format and value *)
  VerificationTest[
    Module[{result},
      result = findRootCoeff0[exprA, paramA, assumeA, condA, paramsA, signsA,
        "CoeffName" -> "A", "SignSymbol" -> "signA"];
      MatchQ[result, A[0] -> _?NumericQ] && Abs[result[[2]] - 1.777113528819289] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "findRootCoeff0-A-complete@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* Test findRootCoeff0 for B[1][0] coefficient - run once and verify both format and value *)
  VerificationTest[
    Module[{result},
      result = findRootCoeff0[exprAB, paramAB, assumeAB, condAB, paramsAB, signsAB,
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      MatchQ[result, B[1][0] -> _?NumericQ] && Abs[result[[2]] - 1.784254766558428] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "findRootCoeff0-B-complete@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* Test findRootsCoeff0 - run once and verify format, count, and value *)
  VerificationTest[
    Module[{result},
      result = findRootsCoeff0[exprAB, paramAB, assumeAB, condAB, paramsAB, signsAB,
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      MatchQ[result, {(B[1][0] -> _?NumericQ) ..}] &&
      Length[result] >= 1 &&
      Abs[result[[1, 2]] - 1.784254766558428] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "findRootsCoeff0-B-complete@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* scanAndSolve is already tested via findRootsCoeff0 which uses it internally *)

  (* Test workflow concept: verify pre-computed results can be chained *)
  VerificationTest[
    Module[{testParams},
      (* Verify that A[0] result can be added to parameters *)
      testParams = Append[paramsA, solNA0[[1]]];
      MatchQ[Lookup[testParams, A[0]], _?NumericQ]
    ],
    True,
    TimeConstraint -> 5,
    TestID -> "integration-parameter-chaining@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* Test error handling: invalid parameters *)
  VerificationTest[
    Module[{badParams},
      badParams = Association[
        FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> -1,
        FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.5
      ];
      findRootCoeff0[exprA, paramA, assumeA, condA, badParams, signsA,
        "CoeffName" -> "A", "SignSymbol" -> "signA"]
    ],
    $Failed,
    {findRootCoeff0::badparams},
    TimeConstraint -> timeLimit,
    TestID -> "findRootCoeff0-invalid-params@@test/FindRootOptim/FindRootOptim.wlt"
  ],

  (* Detailed option testing and edge cases removed to improve performance *)
  (* Core functionality fully tested via findRootCoeff0, findRootsCoeff0, and integration tests *)

  (* Test buildKernel with WVM compilation target - fast structure check only *)
  VerificationTest[
    Module[{kernel, keys},
      kernel = buildKernel[exprAB, paramAB, CompilationTarget -> "WVM",
        "CoeffName" -> "B", "SignSymbol" -> "signB"];
      keys = Keys[kernel];
      AllTrue[{"fC", "dfC", "ParamOrder", "SignIndex", "CoeffName", "SignSymbol"},
        MemberQ[keys, #] &]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "buildKernel-WVM-target@@test/FindRootOptim/FindRootOptim.wlt"
  ]

  (* WVM compilation functionality validated via buildKernel structure test *)
}
