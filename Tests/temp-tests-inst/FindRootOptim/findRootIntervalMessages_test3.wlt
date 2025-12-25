BeginTestSection["findRootIntervalMessages"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval;

VerificationTest[
    Block[{A},
      fri[A[0] > 0 && A[0] > 0 && A[0] < -1, <||>, {}, "CoeffName" -> "A"]
    ] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval},
    TimeConstraint -> timeLimit,
    TestID -> "emptyinterval-message-on-param-contradiction@@Tests/FindRootOptim/findRootIntervalMessages.wlt:31,3-39,4"
  ]

EndTestSection[]
