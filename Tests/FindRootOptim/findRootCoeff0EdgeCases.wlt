Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

(* Access functions for testing *)
tests = With[{
  fri = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval"],
  bk = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"],
  bu = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"]
},
  {
    (* Test that findRootInterval with False returns $Failed quickly *)
    VerificationTest[
      Module[{result},
        result = fri[
          False,  (* Always false condition *)
          <|x -> 2|>,
          {},
          "CoeffName" -> "A", "SignSymbol" -> "signA"
        ];
        result
      ],
      $Failed,
      {findRootInterval::nocoeff},
      TimeConstraint -> timeLimit,
      TestID -> "findRootInterval-false-returns-failed"
    ],

    (* Test buildKernel with "CoeffName" and "SignSymbol" options *)
    VerificationTest[
      Module[{kernel},
        kernel = bk[
          x^2 - B[0] + signB[1],
          {B[0]},
          {x},
          "CoeffName" -> "B",
          "SignSymbol" -> "signB"
        ];
        kernel["CoeffName"] === "B" && kernel["SignSymbol"] === "signB"
      ],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "buildKernel-coeffname-signsymbol-options"
    ],

    (* Test bindUnary with insufficient signs returns $Failed with message *)
    VerificationTest[
      Module[{kernel, result},
        kernel = bk[
          x^2 - A[0] + signA[1] + signA[2],
          {A[0]},
          {x},
          "CoeffName" -> "A",
          "SignSymbol" -> "signA"
        ];
        result = bu[kernel, <|x -> 2|>, {1}];  (* Only 1 sign, but need 2 *)
        result
      ],
      $Failed,
      {bindUnary::insufficientsigns},
      TimeConstraint -> timeLimit,
      TestID -> "bindUnary-insufficient-signs-returns-failed"
    ],

    (* Test buildKernel produces CompiledCodeFunction via FunctionCompile *)
    VerificationTest[
      Module[{kernel},
        kernel = bk[
          x^2 - A[0],
          {A[0]},
          {x},
          "CoeffName" -> "A",
          "SignSymbol" -> "signA"
        ];
        (* Kernel should have FunctionCompile-produced compiled functions *)
        Head[kernel["fC"]] === CompiledCodeFunction &&
        Head[kernel["dfC"]] === CompiledCodeFunction
      ],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "buildKernel-produces-CompiledCodeFunction"
    ]
  }
];

tests
