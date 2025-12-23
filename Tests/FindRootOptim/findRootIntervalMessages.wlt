BeginTestSection["findRootIntervalMessages"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`findRootIntervalMessages`"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval;

tests = {
  (* Test: emptyinterval message when Reduce yields False/no interval *)
  (* Note: A[0] < 0 is valid (infinitely many solutions), use A[0] < 0 && A[0] > 0 for contradiction *)
  VerificationTest[
    Block[{A},
      fri[A[0] < 0 && A[0] > 0, <||>, {}, "CoeffName" -> "A"]
    ],
    $Failed,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval},
    TimeConstraint -> timeLimit,
    TestID -> "emptyinterval-message-on-false@@Tests/FindRootOptim/findRootIntervalMessages.wlt:11,3-19,4"
  ],
  VerificationTest[
    Block[{A},
      fri[A[0] > 10 && A[0] < 5, <||>, {}, "CoeffName" -> "A"]
    ],
    $Failed,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval},
    TimeConstraint -> timeLimit,
    TestID -> "emptyinterval-message-on-contradiction@@Tests/FindRootOptim/findRootIntervalMessages.wlt:20,3-28,4"
  ],
  VerificationTest[
    Block[{A},
      fri[A[0] > 0 && A[0] > 0 && A[0] < -1, <||>, {}, "CoeffName" -> "A"]
    ],
    $Failed,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval},
    TimeConstraint -> timeLimit,
    TestID -> "emptyinterval-message-on-param-contradiction@@Tests/FindRootOptim/findRootIntervalMessages.wlt:29,3-37,4"
  ],

  (* Test: nocoeff message when no root variable matching "CoeffName" is present *)
  VerificationTest[
    Block[{x},
      fri[x > 0 && x < 10, <||>, {}, "CoeffName" -> "A"]
    ],
    $Failed,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff},
    TimeConstraint -> timeLimit,
    TestID -> "nocoeff-message-no-coefficient@@Tests/FindRootOptim/findRootIntervalMessages.wlt:40,3-48,4"
  ],
  VerificationTest[
    Block[{a},
      fri[a > 0, <|a -> 1|>, {}, "CoeffName" -> "A"]
    ],
    $Failed,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff},
    TimeConstraint -> timeLimit,
    TestID -> "nocoeff-message-only-parameters@@Tests/FindRootOptim/findRootIntervalMessages.wlt:49,3-57,4"
  ],
  VerificationTest[
    Block[{B},
      fri[B[0] > 1 && B[0] < 5, <||>, {}, "CoeffName" -> "A"]
    ],
    $Failed,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff},
    TimeConstraint -> timeLimit,
    TestID -> "nocoeff-message-wrong-coefficient-name@@Tests/FindRootOptim/findRootIntervalMessages.wlt:58,3-66,4"
  ],
  VerificationTest[
    Block[{B},
      fri[B[1][0] > 1 && B[1][0] < 5, <||>, {}, "CoeffName" -> "A"]
    ],
    $Failed,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff},
    TimeConstraint -> timeLimit,
    TestID -> "nocoeff-message-wrong-coefficient-name-indexed@@Tests/FindRootOptim/findRootIntervalMessages.wlt:67,3-75,4"
  ],

  (* Test: Valid case runs without messages *)
  VerificationTest[
    Block[{A},
      fri[A[0] > 1 && A[0] < 5, <||>, {}, "CoeffName" -> "A"]
    ],
    _,
    {},
    SameTest -> MatchQ,
    TimeConstraint -> timeLimit,
    TestID -> "no-messages-on-valid-input@@Tests/FindRootOptim/findRootIntervalMessages.wlt:78,3-87,4"
  ]
};


End[]
EndTestSection[]
