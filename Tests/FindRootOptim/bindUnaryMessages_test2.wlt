BeginTestSection["bindUnaryMessages"]

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
  kernel = buildKernel[expr, vars, params, "SignSymbol" -> "signA"];
];

gamma = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`gamma"];
delta = ToExpression["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`delta"];

VerificationTest[
    bindUnary[kernel, <|gamma -> 1.0, delta -> 2.0|>, "Signs" -> {}] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary::toofewsigns},
    TimeConstraint -> timeLimit,
    TestID -> "toofewsigns-returns-failed-empty-signs@@Tests/FindRootOptim/bindUnaryMessages_test2.wlt:28,1-34,4"
  ]

EndTestSection[]
