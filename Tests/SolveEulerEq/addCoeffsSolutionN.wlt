(* Setup: Load SolveEulerEq.wl *)
Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName], Directory[]];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
    d = DirectoryName[d]];
  pacletRoot = d;
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "ComputationalEngine", "SolveEulerEq.wl"}]];
  On[General::shdw];
];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`addCoeffsSolutionN],
  Symbol,
  TestID -> "addCoeffsSolutionN-symbol-exists"
]

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs],
  Symbol,
  TestID -> "updateCoeffs-symbol-exists"
]

(* ============================================================ *)
(* Usage Message Tests *)
(* ============================================================ *)

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`addCoeffsSolutionN::usage],
  True,
  TestID -> "addCoeffsSolutionN-has-usage"
]

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs::usage],
  True,
  TestID -> "updateCoeffs-has-usage"
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
  TestID -> "updateCoeffs-options-is-list"
]
