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
  StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel::usage],
  True,
  TestID -> "buildKernel-has-usage@@Tests/FindRootOptim/createCompiledEq.wlt:36,1-40,2"
]

EndTestSection[]
