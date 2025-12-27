BeginTestSection["createCompiledEq"]

(* Setup: Load FindRootOptim package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "PerformanceGoal"]
  ],
  True,
  TestID -> "buildKernel-has-PerformanceGoal-option@@Tests/FindRootOptim/createCompiledEq_test8.wlt:14,1-22,2"
]

EndTestSection[]
