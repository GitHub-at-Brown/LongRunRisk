BeginTestSection["findRootCoeff0EdgeCases"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 15;

(* Access functions for testing *)
fri = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval"];
bk = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"];
bu = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"];

(* Test that findRootInterval with contradiction returns $Failed quickly *)
(* Use A[0] contradiction to get emptyinterval message *)

VerificationTest[
  Block[{A},
    fri[
      A[0] < 0 && A[0] > 0,  (* Contradiction containing coefficient *)
      <|x -> 2|>,
      {},
      "CoeffName" -> "A", "SignSymbol" -> "signA"
    ] === $Failed
  ],
  True,
  {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval},
  TimeConstraint -> timeLimit,
  TestID -> "findRootInterval-contradiction-returns-failed@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:15,1-28,2"
]

EndTestSection[]
