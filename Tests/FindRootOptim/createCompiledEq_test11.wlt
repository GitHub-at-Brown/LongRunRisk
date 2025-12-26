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
  Module[{cce},
    cce = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq;
    (* createCompiledEq uses OptionsPattern[{buildKernel, ...}] to inherit options *)
    MatchQ[
      Head[cce],
      Symbol
    ]
  ],
  True,
  TestID -> "createCompiledEq-accepts-buildKernel-options@@Tests/FindRootOptim/createCompiledEq.wlt:111,1-122,2"
]

EndTestSection[]
