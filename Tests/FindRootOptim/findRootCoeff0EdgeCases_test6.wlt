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
  Module[{kernelFC, kernelC, fFC, fC, dfFC, dfC},
    Block[{$ContextPath = Prepend[$ContextPath, "CCompilerDriver`"]},
      kernelFC = bk[x^2 - A[0], {A[0]}, {x}, "Compiler" -> "FunctionCompile"];
      kernelC = bk[x^2 - A[0], {A[0]}, {x}, "Compiler" -> "Compile"];
      {fFC, dfFC} = bu[kernelFC, <|x -> 2|>, {}];
      {fC, dfC} = bu[kernelC, <|x -> 2|>, {}];
      (* Both should evaluate to the same result at A[0] = 1: 2^2 - 1 = 3 *)
      Abs[fFC[1] - fC[1]] < 10^-10
    ]
  ],
  True,
  TimeConstraint -> timeLimit,
  TestID -> "buildKernel-both-compilers-equivalent-results@@Tests/FindRootOptim/findRootCoeff0EdgeCases_test6.wlt:16,1-30,2"
]

EndTestSection[]
