BeginTestSection["extractIntervalsFromReduce_nd"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];

timeLimit = 5;

(* Scalar root with Reduce==True stays 1D *)
VerificationTest[
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce[True, A[0]],
  {{0.002, 14.998}},
  TimeConstraint -> timeLimit,
  TestID -> "extractIntervalsFromReduce-true-scalar@@Tests/FindRootOptim/extractIntervalsFromReduce_nd.wlt:8,1-13,2"
]

(* False yields empty even for nD *)
VerificationTest[
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce[False, {A[0], B[1][0]}],
  {},
  {extractIntervalsFromReduce::nointervals},
  TimeConstraint -> timeLimit,
  TestID -> "extractIntervalsFromReduce-false-nd@@Tests/FindRootOptim/extractIntervalsFromReduce_nd.wlt:16,1-22,2"
]


(* nD padding keeps first-dim bounds and pads others with +/- UnboundedPad *)
VerificationTest[
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce[ Inequality[1, LessEqual, A[0], LessEqual, 5], {A[0], B[1][0]}],
  {{
    {1.001, -1.*^5},
    {4.999,  1.*^5}
  }},
  TimeConstraint -> timeLimit,
  TestID -> "extractIntervalsFromReduce-nd-padding@@Tests/FindRootOptim/extractIntervalsFromReduce_nd.wlt:26,1-34,2"
]

EndTestSection[]
