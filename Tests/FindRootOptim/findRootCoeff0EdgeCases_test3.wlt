BeginTestSection["findRootCoeff0EdgeCases"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 15;

(* Access functions for testing *)
fri = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval"];
bk = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"];
bu = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"];

(* Test that findRootInterval with contradiction returns $Failed quickly *)
(* Use A[0] contradiction to get emptyinterval message *)

VerificationTest[
  Module[{kernel, result},
    Block[{$ContextPath = Prepend[$ContextPath, "CCompilerDriver`"]},
      kernel = bk[
        x^2 - A[0] + signA[1] + signA[2],
        {A[0]},
        {x},
        "CoeffName" -> "A",
        "SignSymbol" -> "signA"
      ];
      result = bu[kernel, <|x -> 2|>, "Signs" -> {1}];  (* Only 1 sign, but need 2 *)
      result === $Failed
    ]
  ],
  True,
  {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary::toofewsigns},
  TimeConstraint -> timeLimit,
  TestID -> "bindUnary-insufficient-signs-returns-failed@@Tests/FindRootOptim/findRootCoeff0EdgeCases_test3.wlt:16,1-34,2"
]

EndTestSection[]
