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
  StringQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`addCoeffsSolutionN::usage],
  True,
  TestID -> "addCoeffsSolutionN-has-usage@@Tests/SolveEulerEq/addCoeffsSolutionN.wlt:30,1-34,2"
]

EndTestSection[]
