BeginTestSection["addCoeffsSolutionN"]

(* Setup: Load SolveEulerEq package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs::usage],
  True,
  TestID -> "updateCoeffs-has-usage@@Tests/SolveEulerEq/addCoeffsSolutionN_test4.wlt:14,1-18,2"
]

EndTestSection[]
