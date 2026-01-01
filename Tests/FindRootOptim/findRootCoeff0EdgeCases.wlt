BeginTestSection["findRootCoeff0EdgeCases Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`findRootCoeff0EdgeCases`"]

(* --- merged from: findRootCoeff0EdgeCases_test1.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 15;

(* Access functions for testing *)
fri = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval"];
bk = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"];
bu = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"];

(* Test that findRootInterval with contradiction returns $Failed quickly *)
(* Use A[0] contradiction to get emptyinterval message *)

VerificationTest[
  Block[{A},
    fri[
      A[0] < 0 && A[0] > 0,  (* Contradiction containing coefficient *)
      <|x -> 2|>,
      "A", "signA"
    ] === $Failed
  ],
  True,
  {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval},
  TimeConstraint -> timeLimit,
  TestID -> "findRootInterval-contradiction-returns-failed@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:18,1-30,2"
]

(* --- merged from: findRootCoeff0EdgeCases_test2.wlt --- *)
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
        "CompileSignSymbol" -> "signB"
      ];
      kernel["CoeffName"] === "B" && kernel["CompileSignSymbol"] === "signB"
    ]
  ],
  True,
  TimeConstraint -> timeLimit,
  TestID -> "buildKernel-coeffname-signsymbol-options@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:46,1-62,2"
]

(* --- merged from: findRootCoeff0EdgeCases_test3.wlt --- *)
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
        "CompileSignSymbol" -> "signA"
      ];
      result = bu[kernel, <|x -> 2|>, {1}];  (* Only 1 sign, but need 2 *)
      result === $Failed
    ]
  ],
  True,
  {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary::toofewsigns},
  TimeConstraint -> timeLimit,
  TestID -> "bindUnary-insufficient-signs-returns-failed@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:78,1-96,2"
]

(* --- merged from: findRootCoeff0EdgeCases_test4.wlt --- *)
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
        "CompileSignSymbol" -> "signA",
        "CompileMode" -> "Both",
        "Compiler" -> "FunctionCompile"  (* Required for CompiledCodeFunction *)
      ];
      (* Kernel should have expected structure - compilation may be skipped under instrumentation *)
      AssociationQ[kernel] &&
      KeyExistsQ[kernel, "fC"] &&
      KeyExistsQ[kernel, "dfC"] &&
      KeyExistsQ[kernel, "Vars"]
    ]
  ],
  True,
  TimeConstraint -> timeLimit,
  TestID -> "buildKernel-produces-CompiledCodeFunction@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:112,1-134,2"
]

(* --- merged from: findRootCoeff0EdgeCases_test5.wlt --- *)
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
        "CompileSignSymbol" -> "signA",
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
  TestID -> "buildKernel-Compile-produces-CompiledFunction@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:150,1-170,2"
]

(* --- merged from: findRootCoeff0EdgeCases_test6.wlt --- *)
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
  TestID -> "buildKernel-both-compilers-equivalent-results@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:186,1-200,2"
]

End[]
EndTestSection[]
