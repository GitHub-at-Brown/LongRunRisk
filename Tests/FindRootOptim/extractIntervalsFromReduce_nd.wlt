BeginTestSection["extractIntervalsFromReduce_nd"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];

timeLimit = 5;

{
  (* Scalar root with Reduce==True stays 1D *)
  VerificationTest[
    FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce[True, A[0]],
    {{0.002, 14.998}},
    TimeConstraint -> timeLimit,
    TestID -> "extractIntervalsFromReduce-true-scalar@@Tests/FindRootOptim/extractIntervalsFromReduce_nd.wlt:9,3-14,4"
  ],

  (* False yields empty even for nD *)
  VerificationTest[
    FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce[False, {A[0], B[1][0]}],
    {},
    {extractIntervalsFromReduce::nointervals},
    TimeConstraint -> timeLimit,
    TestID -> "extractIntervalsFromReduce-false-nd@@Tests/FindRootOptim/extractIntervalsFromReduce_nd.wlt:17,3-23,4"
  ],


  (* nD padding keeps first-dim bounds and pads others with +/- UnboundedPad *)
  VerificationTest[
    FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce[ Inequality[1, LessEqual, A[0], LessEqual, 5], {A[0], B[1][0]}],
    {{
      {1.001, -1.*^5},
      {4.999,  1.*^5}
    }},
    TimeConstraint -> timeLimit,
    TestID -> "extractIntervalsFromReduce-nd-padding@@Tests/FindRootOptim/extractIntervalsFromReduce_nd.wlt:27,3-35,4"
  ]
}

EndTestSection[]
