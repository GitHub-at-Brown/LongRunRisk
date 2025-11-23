Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`"];

Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d], d = DirectoryName[d]];
  pacletRoot = d;
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "Tools", "FindRootOptim.wl"}]];
  On[General::shdw];
];

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
      TestID -> "emptyinterval-message-on-false@@test/FindRootOptim/findRootIntervalMessages.wlt"
    ],
    VerificationTest[
      Block[{A},
        fri[A[0] > 10 && A[0] < 5, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::emptyinterval},
      TimeConstraint -> timeLimit,
      TestID -> "emptyinterval-message-on-contradiction@@test/FindRootOptim/findRootIntervalMessages.wlt"
    ],
    VerificationTest[
      Block[{A},
        fri[A[0] > 0 && A[0] > 0 && A[0] < -1, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::emptyinterval},
      TimeConstraint -> timeLimit,
      TestID -> "emptyinterval-message-on-param-contradiction@@test/FindRootOptim/findRootIntervalMessages.wlt"
    ],

    (* Test: nocoeff message when no root variable matching "CoeffName" is present *)
    VerificationTest[
      Block[{x},
        fri[x > 0 && x < 10, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::nocoeff},
      TimeConstraint -> timeLimit,
      TestID -> "nocoeff-message-no-coefficient@@test/FindRootOptim/findRootIntervalMessages.wlt"
    ],
    VerificationTest[
      Block[{a},
        fri[a > 0, <|a -> 1|>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::nocoeff},
      TimeConstraint -> timeLimit,
      TestID -> "nocoeff-message-only-parameters@@test/FindRootOptim/findRootIntervalMessages.wlt"
    ],
    VerificationTest[
      Block[{B},
        fri[B[0] > 1 && B[0] < 5, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::nocoeff},
      TimeConstraint -> timeLimit,
      TestID -> "nocoeff-message-wrong-coefficient-name@@test/FindRootOptim/findRootIntervalMessages.wlt"
    ],
    VerificationTest[
      Block[{B},
        fri[B[1][0] > 1 && B[1][0] < 5, <||>, {}, "CoeffName" -> "A"]
      ],
      $Failed,
      {fri::nocoeff},
      TimeConstraint -> timeLimit,
      TestID -> "nocoeff-message-wrong-coefficient-name-indexed@@test/FindRootOptim/findRootIntervalMessages.wlt"
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
      TestID -> "no-messages-on-valid-input@@test/FindRootOptim/findRootIntervalMessages.wlt"
    ]
  }
];

End[];
FernandoDuarte`LongRunRisk`Tests`FindRootOptim`tests
