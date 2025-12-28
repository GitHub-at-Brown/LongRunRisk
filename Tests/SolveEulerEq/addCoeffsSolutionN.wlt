BeginTestSection["addCoeffsSolutionN Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`SolveEulerEq`addCoeffsSolutionN`"]

(* --- merged from: addCoeffsSolutionN_test1.wlt --- *)
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
  TestID -> "addCoeffsSolutionN-symbol-exists@@Tests/SolveEulerEq/addCoeffsSolutionN.wlt:16,1-20,2"
]

(* --- merged from: addCoeffsSolutionN_test2.wlt --- *)
(* Setup: Load SolveEulerEq package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs],
  Symbol,
  TestID -> "updateCoeffs-symbol-exists@@Tests/SolveEulerEq/addCoeffsSolutionN.wlt:34,1-38,2"
]

(* --- merged from: addCoeffsSolutionN_test3.wlt --- *)
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
  TestID -> "addCoeffsSolutionN-has-usage@@Tests/SolveEulerEq/addCoeffsSolutionN.wlt:52,1-56,2"
]

(* --- merged from: addCoeffsSolutionN_test4.wlt --- *)
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
  TestID -> "updateCoeffs-has-usage@@Tests/SolveEulerEq/addCoeffsSolutionN.wlt:70,1-74,2"
]

(* --- merged from: addCoeffsSolutionN_test5.wlt --- *)
(* Setup: Load SolveEulerEq package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{opts, updateCoeffs},
    updateCoeffs = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs;
    opts = Options[updateCoeffs];
    (* updateCoeffs should have options *)
    ListQ[opts]
  ],
  True,
  TestID -> "updateCoeffs-options-is-list@@Tests/SolveEulerEq/addCoeffsSolutionN.wlt:88,1-97,2"
]

End[]
EndTestSection[]
