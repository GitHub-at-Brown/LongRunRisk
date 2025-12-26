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
  Module[{bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    OptionValue[bk, "CompileMode"]
  ],
  "FunctionOnly",
  TestID -> "buildKernel-CompileMode-default-is-FunctionOnly@@Tests/FindRootOptim/createCompiledEq.wlt:96,1-103,2"
]

EndTestSection[]
