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
  Module[{kernelFC, kernelC, isCompiled},
    Block[{$ContextPath = Prepend[$ContextPath, "CCompilerDriver`"]},
      isCompiled = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`isCompiledCode"];
      kernelFC = bk[x^2 - A[0], {A[0]}, {x}, "Compiler" -> "FunctionCompile"];
      kernelC = bk[x^2 - A[0], {A[0]}, {x}, "Compiler" -> "Compile"];
      isCompiled[kernelFC["fC"]] && isCompiled[kernelC["fC"]]
    ]
  ],
  True,
  TimeConstraint -> timeLimit,
  TestID -> "isCompiledCode-detects-both-types@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:131,1-143,2"
]

EndTestSection[]
