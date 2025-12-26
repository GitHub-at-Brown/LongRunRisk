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
        x^2 - A[0],
        {A[0]},
        {x},
        "CoeffName" -> "A",
        "SignSymbol" -> "signA",
        "CompileMode" -> "Both",
        "Compiler" -> "FunctionCompile"  (* Required for CompiledCodeFunction *)
      ];
      (* Kernel should have FunctionCompile-produced compiled functions *)
      Head[kernel["fC"]] === CompiledCodeFunction &&
      Head[kernel["dfC"]] === CompiledCodeFunction
    ]
  ],
  True,
  TimeConstraint -> timeLimit,
  TestID -> "buildKernel-produces-CompiledCodeFunction@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:71,1-91,2"
]

EndTestSection[]
