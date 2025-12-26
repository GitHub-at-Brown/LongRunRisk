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

EndTestSection[]
