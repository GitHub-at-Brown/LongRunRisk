Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval;

(* Note: Uses Quiet + Check to verify message without triggering VerificationTest MessagesFailure *)

tests = {
  (* Test: emptyinterval message when Reduce yields False/no interval *)
  (* Note: A[0] < 0 is valid (infinitely many solutions), use A[0] < 0 && A[0] > 0 for contradiction *)
  VerificationTest[
    Module[{result, messageEmitted = False},
      result = Quiet[
        Check[
          Block[{A}, fri[A[0] < 0 && A[0] > 0, <||>, {}, "CoeffName" -> "A"]],
          messageEmitted = True; $Failed,
          FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval
        ]
      ];
      result === $Failed && messageEmitted
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "emptyinterval-message-on-false@@Tests/FindRootOptim/findRootIntervalMessages.wlt:13,3-27,4"
  ],
  VerificationTest[
    Module[{result, messageEmitted = False},
      result = Quiet[
        Check[
          Block[{A}, fri[A[0] > 10 && A[0] < 5, <||>, {}, "CoeffName" -> "A"]],
          messageEmitted = True; $Failed,
          FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval
        ]
      ];
      result === $Failed && messageEmitted
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "emptyinterval-message-on-contradiction@@Tests/FindRootOptim/findRootIntervalMessages.wlt:28,3-42,4"
  ],
  VerificationTest[
    Module[{result, messageEmitted = False},
      result = Quiet[
        Check[
          Block[{A}, fri[A[0] > 0 && A[0] > 0 && A[0] < -1, <||>, {}, "CoeffName" -> "A"]],
          messageEmitted = True; $Failed,
          FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval
        ]
      ];
      result === $Failed && messageEmitted
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "emptyinterval-message-on-param-contradiction@@Tests/FindRootOptim/findRootIntervalMessages.wlt:43,3-57,4"
  ],

  (* Test: nocoeff message when no root variable matching "CoeffName" is present *)
  VerificationTest[
    Module[{result, messageEmitted = False},
      result = Quiet[
        Check[
          Block[{x}, fri[x > 0 && x < 10, <||>, {}, "CoeffName" -> "A"]],
          messageEmitted = True; $Failed,
          FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff
        ]
      ];
      result === $Failed && messageEmitted
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nocoeff-message-no-coefficient@@Tests/FindRootOptim/findRootIntervalMessages.wlt:60,3-74,4"
  ],
  VerificationTest[
    Module[{result, messageEmitted = False},
      result = Quiet[
        Check[
          Block[{a}, fri[a > 0, <|a -> 1|>, {}, "CoeffName" -> "A"]],
          messageEmitted = True; $Failed,
          FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff
        ]
      ];
      result === $Failed && messageEmitted
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nocoeff-message-only-parameters@@Tests/FindRootOptim/findRootIntervalMessages.wlt:75,3-89,4"
  ],
  VerificationTest[
    Module[{result, messageEmitted = False},
      result = Quiet[
        Check[
          Block[{B}, fri[B[0] > 1 && B[0] < 5, <||>, {}, "CoeffName" -> "A"]],
          messageEmitted = True; $Failed,
          FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff
        ]
      ];
      result === $Failed && messageEmitted
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nocoeff-message-wrong-coefficient-name@@Tests/FindRootOptim/findRootIntervalMessages.wlt:90,3-104,4"
  ],
  VerificationTest[
    Module[{result, messageEmitted = False},
      result = Quiet[
        Check[
          Block[{B}, fri[B[1][0] > 1 && B[1][0] < 5, <||>, {}, "CoeffName" -> "A"]],
          messageEmitted = True; $Failed,
          FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff
        ]
      ];
      result === $Failed && messageEmitted
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nocoeff-message-wrong-coefficient-name-indexed@@Tests/FindRootOptim/findRootIntervalMessages.wlt:105,3-119,4"
  ],

  (* Test: Valid case runs without messages *)
  VerificationTest[
    Module[{result, messageEmitted = False},
      result = Quiet[
        Check[
          Block[{A}, fri[A[0] > 1 && A[0] < 5, <||>, {}, "CoeffName" -> "A"]],
          messageEmitted = True; $Failed
        ]
      ];
      (* Should return something other than $Failed and have no messages *)
      result =!= $Failed && !messageEmitted
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "no-messages-on-valid-input@@Tests/FindRootOptim/findRootIntervalMessages.wlt:122,3-136,4"
  ]
};

tests
