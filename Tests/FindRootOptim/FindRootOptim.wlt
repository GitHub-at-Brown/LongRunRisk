BeginTestSection["FindRootOptim Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`FindRootOptim`"]

(* --- merged from: FindRootOptim_test1.wlt --- *)
(* Load the FindRootOptim package first *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Load test data - must run AFTER package is loaded with Needs *)
Module[{pacletObj, sourceFile},
  pacletObj = First@PacletFind["FernandoDuarte/LongRunRisk"];
  sourceFile = FileNameJoin[{pacletObj[[1]]["Location"], "Resources", "TestFiles", "TestDataSource.wl"}];
  Get@sourceFile
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
  solNA0,
  {A[0] -> 1.777113528819289},
  SameTest -> tolSameTest,
  TimeConstraint -> timeLimit,
  TestID -> "dividend-model-A0-coefficient@@Tests/FindRootOptim/FindRootOptim.wlt:37,1-43,2"
]

(* buildKernel, bindUnary, findRootInterval, and fastRoot are tested in findRootCoeff0EdgeCases.wlt *)
(* with simpler expressions that don't timeout during FunctionCompile *)

(* --- merged from: FindRootOptim_test2.wlt --- *)
(* Load the FindRootOptim package first *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Load test data - must run AFTER package is loaded with Needs *)
Module[{pacletObj, sourceFile},
  pacletObj = First@PacletFind["FernandoDuarte/LongRunRisk"];
  sourceFile = FileNameJoin[{pacletObj[[1]]["Location"], "Resources", "TestFiles", "TestDataSource.wl"}];
  Get@sourceFile
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
  solNAB0,
  {B[1][0] -> 1.784254766558428},
  SameTest -> tolSameTest,
  TimeConstraint -> timeLimit,
  TestID -> "dividend-model-B10-coefficient@@Tests/FindRootOptim/FindRootOptim.wlt:81,1-87,2"
]

(* buildKernel, bindUnary, findRootInterval, and fastRoot are tested in findRootCoeff0EdgeCases.wlt *)
(* with simpler expressions that don't timeout during FunctionCompile *)

(* --- merged from: FindRootOptim_test3.wlt --- *)
(* Load the FindRootOptim package first *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Load test data - must run AFTER package is loaded with Needs *)
Module[{pacletObj, sourceFile},
  pacletObj = First@PacletFind["FernandoDuarte/LongRunRisk"];
  sourceFile = FileNameJoin[{pacletObj[[1]]["Location"], "Resources", "TestFiles", "TestDataSource.wl"}];
  Get@sourceFile
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
  TestID -> "A0-coefficient-in-range@@Tests/FindRootOptim/FindRootOptim.wlt:125,1-130,2"
]

(* buildKernel, bindUnary, findRootInterval, and fastRoot are tested in findRootCoeff0EdgeCases.wlt *)
(* with simpler expressions that don't timeout during FunctionCompile *)

(* --- merged from: FindRootOptim_test4.wlt --- *)
(* Load the FindRootOptim package first *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Load test data - must run AFTER package is loaded with Needs *)
Module[{pacletObj, sourceFile},
  pacletObj = First@PacletFind["FernandoDuarte/LongRunRisk"];
  sourceFile = FileNameJoin[{pacletObj[[1]]["Location"], "Resources", "TestFiles", "TestDataSource.wl"}];
  Get@sourceFile
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
  1.78 < solNAB0[[1,2]] < 1.79,
  True,
  TimeConstraint -> timeLimit,
  TestID -> "B10-coefficient-in-range@@Tests/FindRootOptim/FindRootOptim.wlt:168,1-173,2"
]

(* buildKernel, bindUnary, findRootInterval, and fastRoot are tested in findRootCoeff0EdgeCases.wlt *)
(* with simpler expressions that don't timeout during FunctionCompile *)

(* --- merged from: FindRootOptim_test5.wlt --- *)
(* Load the FindRootOptim package first *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Load test data - must run AFTER package is loaded with Needs *)
Module[{pacletObj, sourceFile},
  pacletObj = First@PacletFind["FernandoDuarte/LongRunRisk"];
  sourceFile = FileNameJoin[{pacletObj[[1]]["Location"], "Resources", "TestFiles", "TestDataSource.wl"}];
  Get@sourceFile
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
  Module[{intervals},
    intervals = eir[B[1][0] > 0, B[1][0]];
    MatchQ[intervals, {{_?NumericQ, _?NumericQ} ..}]
  ],
  True,
  TimeConstraint -> timeLimit,
  TestID -> "extractIntervalsFromReduce-exported@@Tests/FindRootOptim/FindRootOptim.wlt:211,1-219,2"
]

(* buildKernel, bindUnary, findRootInterval, and fastRoot are tested in findRootCoeff0EdgeCases.wlt *)
(* with simpler expressions that don't timeout during FunctionCompile *)

(* --- merged from: FindRootOptim_test6.wlt --- *)
(* Load the FindRootOptim package first *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Load test data - must run AFTER package is loaded with Needs *)
Module[{pacletObj, sourceFile},
  pacletObj = First@PacletFind["FernandoDuarte/LongRunRisk"];
  sourceFile = FileNameJoin[{pacletObj[[1]]["Location"], "Resources", "TestFiles", "TestDataSource.wl"}];
  Get@sourceFile
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
  TestID -> "extractIntervalsFromReduce-simple-inequality@@Tests/FindRootOptim/FindRootOptim.wlt:257,1-263,2"
]

(* buildKernel, bindUnary, findRootInterval, and fastRoot are tested in findRootCoeff0EdgeCases.wlt *)
(* with simpler expressions that don't timeout during FunctionCompile *)

(* --- merged from: FindRootOptim_test7.wlt --- *)
(* Load the FindRootOptim package first *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Load test data - must run AFTER package is loaded with Needs *)
Module[{pacletObj, sourceFile},
  pacletObj = First@PacletFind["FernandoDuarte/LongRunRisk"];
  sourceFile = FileNameJoin[{pacletObj[[1]]["Location"], "Resources", "TestFiles", "TestDataSource.wl"}];
  Get@sourceFile
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
  Module[{testParams},
    (* Verify that A[0] result can be added to parameters *)
    testParams = Append[paramsA, solNA0[[1]]];
    MatchQ[Lookup[testParams, A[0]], _?NumericQ]
  ],
  True,
  TimeConstraint -> 5,
  TestID -> "integration-parameter-chaining@@Tests/FindRootOptim/FindRootOptim.wlt:301,1-310,2"
]

(* buildKernel, bindUnary, findRootInterval, and fastRoot are tested in findRootCoeff0EdgeCases.wlt *)
(* with simpler expressions that don't timeout during FunctionCompile *)

End[]
EndTestSection[]
