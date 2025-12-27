BeginTestSection["extractIntervalsFromReduce_nd"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];

timeLimit = 5;

(* Scalar root with Reduce==True stays 1D *)

VerificationTest[
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce[False, {A[0], B[1][0]}],
  {},
  {extractIntervalsFromReduce::nointervals},
  TimeConstraint -> timeLimit,
  TestID -> "extractIntervalsFromReduce-false-nd@@Tests/FindRootOptim/extractIntervalsFromReduce_nd_test2.wlt:9,1-15,2"
]

EndTestSection[]
