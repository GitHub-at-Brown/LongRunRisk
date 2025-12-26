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
  TestID -> "createCompiledEq-has-usage@@Tests/FindRootOptim/createCompiledEq.wlt:30,1-34,2"
]

EndTestSection[]
