BeginTestSection["findRootIntervalMessages"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval;

VerificationTest[
    Block[{A},
      fri[A[0] > 1 && A[0] < 5, <||>, {}, "CoeffName" -> "A"]
    ],
    _,
    {},
    SameTest -> MatchQ,
    TimeConstraint -> timeLimit,
    TestID -> "no-messages-on-valid-input@@Tests/FindRootOptim/findRootIntervalMessages.wlt:80,3-89,4"
  ]

EndTestSection[]
