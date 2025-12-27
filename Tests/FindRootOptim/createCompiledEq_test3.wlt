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
  StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq::usage],
  True,
  TestID -> "createCompiledEq-has-usage@@Tests/FindRootOptim/createCompiledEq_test3.wlt:14,1-18,2"
]

EndTestSection[]
