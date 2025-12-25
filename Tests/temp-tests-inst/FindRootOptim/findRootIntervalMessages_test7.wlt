BeginTestSection["findRootIntervalMessages"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval;

VerificationTest[
    Block[{B},
      fri[B[1][0] > 1 && B[1][0] < 5, <||>, {}, "CoeffName" -> "A"]
    ] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff},
    TimeConstraint -> timeLimit,
    TestID -> "nocoeff-message-wrong-coefficient-name-indexed@@Tests/FindRootOptim/findRootIntervalMessages.wlt:69,3-77,4"
  ]

EndTestSection[]
