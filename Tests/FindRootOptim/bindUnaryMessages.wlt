(* Load MUnit for message testing *)
Needs["MUnit`"];

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

tests = {
  (* Test: bindUnary returns $Failed and emits toofewsigns message (1 sign, needs 2) *)
  (* Note: Uses Quiet + Check to verify message without triggering VerificationTest MessagesFailure *)
  VerificationTest[
    Module[{result, messageEmitted = False},
      result = Quiet[
        Check[
          bindUnary[kernel, <|gamma -> 1.0, delta -> 2.0|>, "Signs" -> {1}],
          messageEmitted = True; $Failed,
          FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary::toofewsigns
        ]
      ];
      result === $Failed && messageEmitted
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "toofewsigns-returns-failed-one-sign@@Tests/FindRootOptim/bindUnaryMessages.wlt:30,3-44,4"
  ],

  (* Test: bindUnary returns $Failed and emits toofewsigns message (0 signs, needs 2) *)
  (* Note: Uses Quiet + Check to verify message without triggering VerificationTest MessagesFailure *)
  VerificationTest[
    Module[{result, messageEmitted = False},
      result = Quiet[
        Check[
          bindUnary[kernel, <|gamma -> 1.0, delta -> 2.0|>, "Signs" -> {}],
          messageEmitted = True; $Failed,
          FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary::toofewsigns
        ]
      ];
      result === $Failed && messageEmitted
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "toofewsigns-returns-failed-empty-signs@@Tests/FindRootOptim/bindUnaryMessages.wlt:48,3-62,4"
  ],

  (* Test: bindUnary works correctly with valid signs (no error, returns list of functions) *)
  VerificationTest[
    Module[{result},
      result = bindUnary[kernel, <|gamma -> 1.0, delta -> 2.0|>, "Signs" -> {1, -1}];
      MatchQ[result, {_Function, _Function}]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "valid-signs-succeeds@@Tests/FindRootOptim/bindUnaryMessages.wlt:65,3-73,4"
  ]
};

tests
