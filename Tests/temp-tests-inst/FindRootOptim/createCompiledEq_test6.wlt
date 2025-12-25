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
    MemberQ[Keys[opts], "CoeffName"]
  ],
  True,
  TestID -> "buildKernel-has-CoeffName-option@@Tests/FindRootOptim/createCompiledEq.wlt:56,1-64,2"
]

EndTestSection[]
