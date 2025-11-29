Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

(* Access private functions for testing *)
tests = With[{
  frc0 = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootCoeff0"],
  frcs0 = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootsCoeff0"],
  fri = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval"],
  bk = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"],
  bu = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"]
},
  {
    (* Test invalid parameters return $Failed with badparams message for findRootCoeff0 *)
    VerificationTest[
      frc0[
        x^2 - A[0],
        {x},
        x > 0 && A[0] > 0,
        A[0] > 0,
        <|x -> -1|>,  (* Invalid: violates x > 0 assumption *)
        {},
        "CoeffName" -> "A", "SignSymbol" -> "signA"
      ],
      $Failed,
      {findRootCoeff0::badparams},
      TimeConstraint -> timeLimit,
      TestID -> "badparams-returns-failed@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:16,5-30,6"
    ],

    (* Test invalid parameters return empty list with badparams message for findRootsCoeff0 *)
    VerificationTest[
      frcs0[
        x^2 - A[0],
        {x},
        x > 0 && A[0] > 0,
        A[0] > 0,
        <|x -> -1|>,  (* Invalid: violates x > 0 assumption *)
        {},
        "CoeffName" -> "A", "SignSymbol" -> "signA"
      ],
      {},
      {findRootsCoeff0::badparams},
      TimeConstraint -> timeLimit,
      TestID -> "badparams-returns-empty-list@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:33,5-47,6"
    ],

    (* Test that invalid parameters fail quickly without compilation *)
    VerificationTest[
      Module[{startTime, result, elapsed},
        startTime = AbsoluteTime[];
        result = frc0[
          x^2 - A[0],
          {x},
          x > 0 && A[0] > 0,
          A[0] > 0,
          <|x -> -1|>,
          {},
          "CoeffName" -> "A", "SignSymbol" -> "signA"
        ];
        elapsed = AbsoluteTime[] - startTime;
        (* Should fail in under 0.5 seconds (no compilation) *)
        result === $Failed && elapsed < 0.5
      ],
      True,
      {findRootCoeff0::badparams},
      TimeConstraint -> timeLimit,
      TestID -> "badparams-returns-failed-quickly@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:50,5-70,6"
    ],

    (* Test CompilationTarget -> "WVM" option propagation for findRootCoeff0 *)
    VerificationTest[
      Module[{result},
        result = frc0[
          x^2 - A[0],
          {x},
          x > 0 && A[0] > 0,
          A[0] > 0 && A[0] < 10,
          <|x -> 2|>,
          {},
          CompilationTarget -> "WVM",
          "CoeffName" -> "A", "SignSymbol" -> "signA"
        ];
        (* Should return a rule with numeric value *)
        MatchQ[result, A[0] -> _?NumericQ]
      ],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "compilationtarget-wvm-option@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:73,5-91,6"
    ],

    (* Test "CoeffName" -> "B" option override for findRootCoeff0 *)
    VerificationTest[
      Module[{result},
        result = frc0[
          x^2 - B[0],
          {x},
          x > 0 && B[0] > 0,
          B[0] > 0 && B[0] < 10,
          <|x -> 2|>,
          {},
          "CoeffName" -> "B", "SignSymbol" -> "signB"
        ];
        (* Should return B[0] -> value, not A[0] *)
        MatchQ[result, B[0] -> _?NumericQ]
      ],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "coeffname-override-B@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:94,5-111,6"
    ],


    (* Test "SignSymbol" -> "signB" option override *)
    VerificationTest[
      Module[{result},
        result = frc0[
          x^2 - A[0] + signB[1],
          {x},
          x > 0 && A[0] > 0,
          A[0] > 0 && A[0] < 10,
          <|x -> 2|>,
          {1},  (* signB[1] = 1 *)
          "CoeffName" -> "A", "SignSymbol" -> "signB"
        ];
        (* Should successfully handle signB[1] *)
        MatchQ[result, A[0] -> _?NumericQ]
      ],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "signsymbol-override-signB@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:115,5-132,6"
    ],

    (* Test empty interval from findRootInterval returns $Failed for findRootCoeff0 *)
    VerificationTest[
      Module[{result},
        result = frc0[
          x^2 - A[0],
          {x},
          x > 0 && A[0] > 0,
          A[0] > 100 && A[0] < 0,  (* Contradictory: no solutions *)
          <|x -> 2|>,
          {},
          "CoeffName" -> "A", "SignSymbol" -> "signA"
        ];
        result
      ],
      $Failed,
      {findRootInterval::emptyinterval},
      TimeConstraint -> timeLimit,
      TestID -> "empty-interval-returns-failed@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:135,5-152,6"
    ],

    (* Test empty interval from findRootInterval returns empty list for findRootsCoeff0 *)
    VerificationTest[
      Module[{result},
        result = frcs0[
          x^2 - A[0],
          {x},
          x > 0 && A[0] > 0,
          A[0] > 100 && A[0] < 0,  (* Contradictory: no solutions *)
          <|x -> 2|>,
          {},
          "CoeffName" -> "A", "SignSymbol" -> "signA"
        ];
        result
      ],
      {},
      {findRootInterval::emptyinterval},
      TimeConstraint -> timeLimit,
      TestID -> "empty-interval-returns-empty-list@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:155,5-172,6"
    ],

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
      TestID -> "findRootInterval-false-returns-failed@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:175,5-189,6"
    ],

    (* Test buildKernel with "CoeffName" and "SignSymbol" options *)
    VerificationTest[
      Module[{kernel},
        kernel = bk[
          x^2 - B[0] + signB[1],
          {x},
          "CoeffName" -> "B",
          "SignSymbol" -> "signB"
        ];
        kernel["CoeffName"] === "B" && kernel["SignSymbol"] === "signB"
      ],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "buildKernel-coeffname-signsymbol-options@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:192,5-205,6"
    ],

    (* Test bindUnary with insufficient signs returns $Failed with message *)
    VerificationTest[
      Module[{kernel, result},
        kernel = bk[
          x^2 - A[0] + signA[1] + signA[2],
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
      TestID -> "bindUnary-insufficient-signs-returns-failed@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:208,5-223,6"
    ],

    (* Test that findRootCoeff0 with contradictory root clauses fails quickly *)
    VerificationTest[
      Module[{result},
        result = frc0[
          x^2 - A[0],
          {x},
          A[0] > 10 && A[0] < 1,  (* Contradictory root clauses *)
          A[0] > 0,
          <|x -> 2|>,
          {},
          "CoeffName" -> "A", "SignSymbol" -> "signA"
        ];
        result
      ],
      $Failed,
      {findRootCoeff0::badparams},
      TimeConstraint -> timeLimit,
      TestID -> "contradictory-root-clauses-fails@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:226,5-243,6"
    ],

    (* Test CompilationTarget propagates to buildKernel *)
    VerificationTest[
      Module[{kernel},
        kernel = bk[
          x^2 - A[0],
          {x},
          CompilationTarget -> "WVM",
          "CoeffName" -> "A",
          "SignSymbol" -> "signA"
        ];
        (* Kernel should have compiled functions *)
        Head[kernel["fC"]] === CompiledFunction &&
        Head[kernel["dfC"]] === CompiledFunction
      ],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "buildKernel-compilationtarget-wvm@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:246,5-262,6"
    ],

    (* Test findRootsCoeff0 with CompilationTarget -> "WVM" *)
    VerificationTest[
      Module[{result},
        result = frcs0[
          x^2 - A[0],
          {x},
          x > 0 && A[0] > 0,
          A[0] > 0 && A[0] < 10,
          <|x -> 2|>,
          {},
          CompilationTarget -> "WVM",
          "CoeffName" -> "A", "SignSymbol" -> "signA"
        ];
        (* Should return list of rules *)
        MatchQ[result, {(A[0] -> _?NumericQ) ..}]
      ],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "findRootsCoeff0-compilationtarget-wvm@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:265,5-283,6"
    ]
  }
];

tests
