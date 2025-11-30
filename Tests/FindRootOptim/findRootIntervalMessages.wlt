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
      TestID -> "emptyinterval-message-on-false"
    ],
    VerificationTest[
      Block[{A},
        fri[A[0] > 10 && A[0] < 5, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::emptyinterval},
      TimeConstraint -> timeLimit,
      TestID -> "emptyinterval-message-on-contradiction"
    ],
    VerificationTest[
      Block[{A},
        fri[A[0] > 0 && A[0] > 0 && A[0] < -1, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::emptyinterval},
      TimeConstraint -> timeLimit,
      TestID -> "emptyinterval-message-on-param-contradiction"
    ],

    (* Test: nocoeff message when no root variable matching "CoeffName" is present *)
    VerificationTest[
      Block[{x},
        fri[x > 0 && x < 10, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::nocoeff},
      TimeConstraint -> timeLimit,
      TestID -> "nocoeff-message-no-coefficient"
    ],
    VerificationTest[
      Block[{a},
        fri[a > 0, <|a -> 1|>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::nocoeff},
      TimeConstraint -> timeLimit,
      TestID -> "nocoeff-message-only-parameters"
    ],
    VerificationTest[
      Block[{B},
        fri[B[0] > 1 && B[0] < 5, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::nocoeff},
      TimeConstraint -> timeLimit,
      TestID -> "nocoeff-message-wrong-coefficient-name"
    ],
    VerificationTest[
      Block[{B},
        fri[B[1][0] > 1 && B[1][0] < 5, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::nocoeff},
      TimeConstraint -> timeLimit,
      TestID -> "nocoeff-message-wrong-coefficient-name-indexed"
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
      TestID -> "no-messages-on-valid-input"
    ]
  }
];

tests
