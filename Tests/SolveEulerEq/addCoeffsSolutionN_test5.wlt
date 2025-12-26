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
  Module[{opts, updateCoeffs},
    updateCoeffs = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs;
    opts = Options[updateCoeffs];
    (* updateCoeffs should have options *)
    ListQ[opts]
  ],
  True,
  TestID -> "updateCoeffs-options-is-list@@Tests/SolveEulerEq/addCoeffsSolutionN.wlt:46,1-55,2"
]

EndTestSection[]
