BeginTestSection["findRootCoeff0EdgeCases"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

(* Access functions for testing *)
tests = With[{
  fri = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval"],
  bk = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"],
  bu = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"]
},
  {
    (* Test that findRootInterval with contradiction returns $Failed quickly *)
    (* Use A[0] contradiction to get emptyinterval message *)
    VerificationTest[
      Block[{A},
        fri[
          A[0] < 0 && A[0] > 0,  (* Contradiction containing coefficient *)
          <|x -> 2|>,
          {},
          "CoeffName" -> "A", "SignSymbol" -> "signA"
        ] === $Failed
      ],
      True,
      {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval},
      TimeConstraint -> timeLimit,
      TestID -> "findRootInterval-contradiction-returns-failed@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:17,5-30,6"
    ],

    (* Test buildKernel with "CoeffName" and "SignSymbol" options *)
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
      TestID -> "buildKernel-coeffname-signsymbol-options@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:33,5-47,6"
    ],

    (* Test bindUnary with insufficient signs returns $Failed with message *)
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
      TestID -> "bindUnary-insufficient-signs-returns-failed@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:50,5-66,6"
    ],

    (* Test buildKernel produces CompiledCodeFunction via FunctionCompile *)
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
      TestID -> "buildKernel-produces-CompiledCodeFunction@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:69,5-87,6"
    ],

    (* Test buildKernel with "Compiler" -> "Compile" produces CompiledFunction *)
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
          Head[kernel["fC"]] === CompiledFunction
        ]
      ],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "buildKernel-Compile-produces-CompiledFunction@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:90,5-105,6"
    ],

    (* Test both compilers produce equivalent numerical results *)
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
      TestID -> "buildKernel-both-compilers-equivalent-results@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:108,5-120,6"
    ],

    (* Test isCompiledCode detects both function types *)
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
      TestID -> "isCompiledCode-detects-both-types@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:123,5-133,6"
    ]
  }
];


EndTestSection[]
