Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`"];

(* Load MUnit for message testing *)
Needs["MUnit`"];

Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d], d = DirectoryName[d]];
  pacletRoot = d;
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "Tools", "FindRootOptim.wl"}]];
  On[General::shdw];
];

bindUnary = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"];
buildKernel = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"];
timeLimit = 5;

(* Create a test kernel with sign dependencies *)
(* Need to create symbols in the correct context *)
ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`signA"];
Module[{expr, params, signA},
  signA = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`signA"];
  gamma = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`gamma"];
  delta = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`delta"];
  expr = signA[1] * gamma + signA[2] * delta;
  params = {gamma, delta};
  kernel = buildKernel[expr, params, CompilationTarget -> "WVM", "SignSymbol" -> "signA"];
];

gamma = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`gamma"];
delta = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`delta"];

tests = {
  (* Test: bindUnary returns $Failed and emits insufficientsigns message (1 sign, needs 2) *)
  VerificationTest[
    bindUnary[kernel, <|gamma -> 1.0, delta -> 2.0|>, {1}],
    $Failed,
    {bindUnary::insufficientsigns},
    TimeConstraint -> timeLimit,
    TestID -> "insufficientsigns-returns-failed-one-sign@@test/FindRootOptim/bindUnaryMessages.wlt"
  ],

  (* Test: bindUnary returns $Failed and emits insufficientsigns message (0 signs, needs 2) *)
  VerificationTest[
    bindUnary[kernel, <|gamma -> 1.0, delta -> 2.0|>, {}],
    $Failed,
    {bindUnary::insufficientsigns},
    TimeConstraint -> timeLimit,
    TestID -> "insufficientsigns-returns-failed-empty-signs@@test/FindRootOptim/bindUnaryMessages.wlt"
  ],

  (* Test: bindUnary works correctly with valid signs (no error, returns list of functions) *)
  VerificationTest[
    Module[{result},
      result = bindUnary[kernel, <|gamma -> 1.0, delta -> 2.0|>, {1, -1}];
      MatchQ[result, {_Function, _Function}]
    ],
    True,
    {},
    TimeConstraint -> timeLimit,
    TestID -> "valid-signs-succeeds@@test/FindRootOptim/bindUnaryMessages.wlt"
  ]
};

End[];
FernandoDuarte`LongRunRisk`Tests`FindRootOptim`tests
