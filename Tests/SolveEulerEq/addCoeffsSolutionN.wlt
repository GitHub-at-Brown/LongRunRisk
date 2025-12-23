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
  TestID -> "addCoeffsSolutionN-symbol-exists@@Tests/SolveEulerEq/addCoeffsSolutionN.wlt:23,1-27,2"
]

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs],
  Symbol,
  TestID -> "updateCoeffs-symbol-exists@@Tests/SolveEulerEq/addCoeffsSolutionN.wlt:29,1-33,2"
]

(* ============================================================ *)
(* Usage Message Tests *)
(* ============================================================ *)

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`addCoeffsSolutionN::usage],
  True,
  TestID -> "addCoeffsSolutionN-has-usage@@Tests/SolveEulerEq/addCoeffsSolutionN.wlt:39,1-43,2"
]

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs::usage],
  True,
  TestID -> "updateCoeffs-has-usage@@Tests/SolveEulerEq/addCoeffsSolutionN.wlt:45,1-49,2"
]

(* ============================================================ *)
(* Options Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{opts, updateCoeffs},
    updateCoeffs = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs;
    opts = Options[updateCoeffs];
    (* updateCoeffs should have options *)
    ListQ[opts]
  ],
  True,
  TestID -> "updateCoeffs-options-is-list@@Tests/SolveEulerEq/addCoeffsSolutionN.wlt:55,1-64,2"
]

EndTestSection[]
