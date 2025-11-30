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
    TestID -> "extractIntervalsFromReduce-true-scalar"
  ],

  (* False yields empty even for nD *)
  VerificationTest[
    eir[False, {A[0], B[1][0]}],
    {},
    {extractIntervalsFromReduce::nointervals},
    TimeConstraint -> timeLimit,
    TestID -> "extractIntervalsFromReduce-false-nd"
  ],

  (* nD padding keeps first-dim bounds and pads others with +/- UnboundedPad *)
  VerificationTest[
    eir[ Inequality[1, LessEqual, A[0], LessEqual, 5], {A[0], B[1][0]}],
    {{
      {1.001, -1.*^5},
      {4.999,  1.*^5}
    }},
    TimeConstraint -> timeLimit,
    TestID -> "extractIntervalsFromReduce-nd-padding"
  ]
}
