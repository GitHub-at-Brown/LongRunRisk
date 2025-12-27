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
  Module[{kernel},
    Block[{$ContextPath = Prepend[$ContextPath, "CCompilerDriver`"]},
      kernel = bk[
        x^2 - B[0] + signB[1],
        {B[0]},
        {x},
        "CoeffName" -> "B",
        "SignSymbol" -> "signB"
      ];
      kernel["CoeffName"] === "B" && kernel["SignSymbol"] === "signB"
    ]
  ],
  True,
  TimeConstraint -> timeLimit,
  TestID -> "buildKernel-coeffname-signsymbol-options@@Tests/FindRootOptim/findRootCoeff0EdgeCases_test2.wlt:16,1-32,2"
]

EndTestSection[]
