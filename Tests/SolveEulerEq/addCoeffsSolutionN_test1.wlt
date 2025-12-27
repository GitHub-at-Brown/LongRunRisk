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
  Head[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`addCoeffsSolutionN],
  Symbol,
  TestID -> "addCoeffsSolutionN-symbol-exists@@Tests/SolveEulerEq/addCoeffsSolutionN_test1.wlt:14,1-18,2"
]

EndTestSection[]
