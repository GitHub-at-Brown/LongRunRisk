BeginTestSection["bindUnaryMessages Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`bindUnaryMessages`"]

(* --- merged from: bindUnaryMessages_test1.wlt --- *)
(* Load MUnit for message testing *)

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


bindUnary = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"];
buildKernel = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"];
timeLimit = 5;

(* Create a test kernel with sign dependencies *)
(* Need to create symbols in the correct context *)
ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`signA"];
Module[{expr, vars, params, signA},
  signA = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`signA"];
  gamma = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`gamma"];
  delta = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`delta"];
  expr = signA[1] * gamma + signA[2] * delta - A[0];
  vars = {A[0]};
  params = {gamma, delta};
  kernel = buildKernel[expr, vars, params, "CompileSignSymbol" -> "signA"];
];

gamma = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`gamma"];
delta = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`delta"];

VerificationTest[
    bindUnary[kernel, <|gamma -> 1.0, delta -> 2.0|>, {1}] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary::toofewsigns},
    TimeConstraint -> timeLimit,
    TestID -> "toofewsigns-returns-failed-one-sign@@Tests/FindRootOptim/bindUnaryMessages.wlt:30,1-36,4"
  ]

(* --- merged from: bindUnaryMessages_test2.wlt --- *)
(* Load MUnit for message testing *)

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


bindUnary = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"];
buildKernel = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"];
timeLimit = 5;

(* Create a test kernel with sign dependencies *)
(* Need to create symbols in the correct context *)
ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`signA"];
Module[{expr, vars, params, signA},
  signA = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`signA"];
  gamma = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`gamma"];
  delta = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`delta"];
  expr = signA[1] * gamma + signA[2] * delta - A[0];
  vars = {A[0]};
  params = {gamma, delta};
  kernel = buildKernel[expr, vars, params, "CompileSignSymbol" -> "signA"];
];

gamma = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`gamma"];
delta = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`delta"];

VerificationTest[
    bindUnary[kernel, <|gamma -> 1.0, delta -> 2.0|>, {}] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary::toofewsigns},
    TimeConstraint -> timeLimit,
    TestID -> "toofewsigns-returns-failed-empty-signs@@Tests/FindRootOptim/bindUnaryMessages.wlt:64,1-70,4"
  ]

(* --- merged from: bindUnaryMessages_test3.wlt --- *)
(* Load MUnit for message testing *)

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


bindUnary = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"];
buildKernel = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"];
timeLimit = 5;

(* Create a test kernel with sign dependencies *)
(* Need to create symbols in the correct context *)
ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`signA"];
Module[{expr, vars, params, signA},
  signA = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`signA"];
  gamma = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`gamma"];
  delta = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`delta"];
  expr = signA[1] * gamma + signA[2] * delta - A[0];
  vars = {A[0]};
  params = {gamma, delta};
  kernel = buildKernel[expr, vars, params, "CompileSignSymbol" -> "signA"];
];

gamma = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`gamma"];
delta = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`delta"];

VerificationTest[
    Module[{result},
      result = bindUnary[kernel, <|gamma -> 1.0, delta -> 2.0|>, {1, -1}];
      MatchQ[result, {_Function, _Function}]
    ],
    True,
    {},
    TimeConstraint -> timeLimit,
    TestID -> "valid-signs-succeeds@@Tests/FindRootOptim/bindUnaryMessages.wlt:98,1-107,4"
  ]

End[]
EndTestSection[]
