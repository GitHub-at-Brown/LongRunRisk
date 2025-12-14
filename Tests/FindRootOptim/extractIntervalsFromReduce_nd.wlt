Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];

timeLimit = 5;

(* local handles *)
eir = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"];

{
  (* Scalar root with Reduce==True stays 1D *)
  VerificationTest[
    eir[True, A[0]],
    {{0.002, 14.998}},
    TimeConstraint -> timeLimit,
    TestID -> "extractIntervalsFromReduce-true-scalar@@Tests/FindRootOptim/extractIntervalsFromReduce_nd.wlt:10,3-15,4"
  ],

  (* False yields empty even for nD *)
  (* Note: Uses Quiet + Check to verify message without triggering VerificationTest MessagesFailure *)
  VerificationTest[
    Module[{result, messageEmitted = False},
      result = Quiet[
        Check[
          eir[False, {A[0], B[1][0]}],
          messageEmitted = True; {},
          FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce::nointervals
        ]
      ];
      result === {} && messageEmitted
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "extractIntervalsFromReduce-false-nd@@Tests/FindRootOptim/extractIntervalsFromReduce_nd.wlt:19,3-33,4"
  ],

  (* nD padding keeps first-dim bounds and pads others with +/- UnboundedPad *)
  VerificationTest[
    eir[ Inequality[1, LessEqual, A[0], LessEqual, 5], {A[0], B[1][0]}],
    {{
      {1.001, -1.*^5},
      {4.999,  1.*^5}
    }},
    TimeConstraint -> timeLimit,
    TestID -> "extractIntervalsFromReduce-nd-padding@@Tests/FindRootOptim/extractIntervalsFromReduce_nd.wlt:36,3-44,4"
  ]
}
