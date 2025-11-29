Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`"];

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

tests = With[{fri = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval"]},
  {
    (* Test: emptyinterval message when Reduce yields False/no interval *)
    VerificationTest[
      Block[{A},
        fri[A[0] < 0, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::emptyinterval},
      TimeConstraint -> timeLimit,
      TestID -> "emptyinterval-message-on-false@@Tests/FindRootOptim/findRootIntervalMessages.wlt:11,5-19,6"
    ],
    VerificationTest[
      Block[{A},
        fri[A[0] > 10 && A[0] < 5, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::emptyinterval},
      TimeConstraint -> timeLimit,
      TestID -> "emptyinterval-message-on-contradiction@@Tests/FindRootOptim/findRootIntervalMessages.wlt:20,5-28,6"
    ],
    VerificationTest[
      Block[{A},
        fri[A[0] > 0 && A[0] > 0 && A[0] < -1, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::emptyinterval},
      TimeConstraint -> timeLimit,
      TestID -> "emptyinterval-message-on-param-contradiction@@Tests/FindRootOptim/findRootIntervalMessages.wlt:29,5-37,6"
    ],

    (* Test: nocoeff message when no root variable matching "CoeffName" is present *)
    VerificationTest[
      Block[{x},
        fri[x > 0 && x < 10, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::nocoeff},
      TimeConstraint -> timeLimit,
      TestID -> "nocoeff-message-no-coefficient@@Tests/FindRootOptim/findRootIntervalMessages.wlt:40,5-48,6"
    ],
    VerificationTest[
      Block[{a},
        fri[a > 0, <|a -> 1|>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::nocoeff},
      TimeConstraint -> timeLimit,
      TestID -> "nocoeff-message-only-parameters@@Tests/FindRootOptim/findRootIntervalMessages.wlt:49,5-57,6"
    ],
    VerificationTest[
      Block[{B},
        fri[B[0] > 1 && B[0] < 5, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::nocoeff},
      TimeConstraint -> timeLimit,
      TestID -> "nocoeff-message-wrong-coefficient-name@@Tests/FindRootOptim/findRootIntervalMessages.wlt:58,5-66,6"
    ],
    VerificationTest[
      Block[{B},
        fri[B[1][0] > 1 && B[1][0] < 5, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::nocoeff},
      TimeConstraint -> timeLimit,
      TestID -> "nocoeff-message-wrong-coefficient-name-indexed@@Tests/FindRootOptim/findRootIntervalMessages.wlt:67,5-75,6"
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
      TestID -> "no-messages-on-valid-input@@Tests/FindRootOptim/findRootIntervalMessages.wlt:78,5-87,6"
    ]
  }
];

End[];
FernandoDuarte`LongRunRisk`Tests`FindRootOptim`tests
