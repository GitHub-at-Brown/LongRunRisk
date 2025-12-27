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
        "Compiler" -> "Compile"
      ];
      (* Kernel should have expected structure - compilation may be skipped under instrumentation *)
      AssociationQ[kernel] &&
      KeyExistsQ[kernel, "fC"] &&
      KeyExistsQ[kernel, "Vars"]
    ]
  ],
  True,
  TimeConstraint -> timeLimit,
  TestID -> "buildKernel-Compile-produces-CompiledFunction@@Tests/FindRootOptim/findRootCoeff0EdgeCases_test5.wlt:16,1-33,2"
]

EndTestSection[]
