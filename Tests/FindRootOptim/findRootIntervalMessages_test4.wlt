BeginTestSection["findRootIntervalMessages"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval;

VerificationTest[
    Block[{x},
      fri[x > 0 && x < 10, <||>, {}, "CoeffName" -> "A"]
    ] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff},
    TimeConstraint -> timeLimit,
    TestID -> "nocoeff-message-no-coefficient@@Tests/FindRootOptim/findRootIntervalMessages.wlt:42,3-50,4"
  ]

EndTestSection[]
