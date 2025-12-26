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
  Head[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq],
  Symbol,
  TestID -> "createCompiledEq-symbol-exists@@Tests/FindRootOptim/createCompiledEq.wlt:14,1-18,2"
]

EndTestSection[]
