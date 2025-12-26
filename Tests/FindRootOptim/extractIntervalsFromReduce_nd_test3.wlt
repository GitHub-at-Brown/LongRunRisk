BeginTestSection["extractIntervalsFromReduce_nd"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];

timeLimit = 5;

(* Scalar root with Reduce==True stays 1D *)

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
