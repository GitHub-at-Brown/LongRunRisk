BeginTestSection["extractIntervalsFromReduce_nd Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`extractIntervalsFromReduceNd`"]

(* --- merged from: extractIntervalsFromReduce_nd_test1.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];

timeLimit = 5;

(* Scalar root with Reduce==True stays 1D *)

VerificationTest[
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce[True, A[0]],
  {{0.002, 14.998}},
  TimeConstraint -> timeLimit,
  TestID -> "extractIntervalsFromReduce-true-scalar@@Tests/FindRootOptim/extractIntervalsFromReduce_nd.wlt:11,1-16,2"
]

(* --- merged from: extractIntervalsFromReduce_nd_test2.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];

timeLimit = 5;

(* Scalar root with Reduce==True stays 1D *)

VerificationTest[
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce[False, {A[0], B[1][0]}],
  {},
  {extractIntervalsFromReduce::nointervals},
  TimeConstraint -> timeLimit,
  TestID -> "extractIntervalsFromReduce-false-nd@@Tests/FindRootOptim/extractIntervalsFromReduce_nd.wlt:25,1-31,2"
]

(* --- merged from: extractIntervalsFromReduce_nd_test3.wlt --- *)
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
  TestID -> "extractIntervalsFromReduce-nd-padding@@Tests/FindRootOptim/extractIntervalsFromReduce_nd.wlt:40,1-48,2"
]

End[]
EndTestSection[]
