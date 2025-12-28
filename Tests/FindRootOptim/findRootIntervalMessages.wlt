BeginTestSection["findRootIntervalMessages Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`findRootIntervalMessages`"]

(* --- merged from: findRootIntervalMessages_test1.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval;

VerificationTest[
    Block[{A},
      fri[A[0] < 0 && A[0] > 0, <||>, {}, "CoeffName" -> "A"]
    ] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval},
    TimeConstraint -> timeLimit,
    TestID -> "emptyinterval-message-on-false@@Tests/FindRootOptim/findRootIntervalMessages.wlt:12,1-20,4"
  ]

(* --- merged from: findRootIntervalMessages_test2.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval;

VerificationTest[
    Block[{A},
      fri[A[0] > 10 && A[0] < 5, <||>, {}, "CoeffName" -> "A"]
    ] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval},
    TimeConstraint -> timeLimit,
    TestID -> "emptyinterval-message-on-contradiction@@Tests/FindRootOptim/findRootIntervalMessages.wlt:30,1-38,4"
  ]

(* --- merged from: findRootIntervalMessages_test3.wlt --- *)
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
    TestID -> "emptyinterval-message-on-param-contradiction@@Tests/FindRootOptim/findRootIntervalMessages.wlt:48,1-56,4"
  ]

(* --- merged from: findRootIntervalMessages_test4.wlt --- *)
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
    TestID -> "nocoeff-message-no-coefficient@@Tests/FindRootOptim/findRootIntervalMessages.wlt:66,1-74,4"
  ]

(* --- merged from: findRootIntervalMessages_test5.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval;

VerificationTest[
    Block[{a},
      fri[a > 0, <|a -> 1|>, {}, "CoeffName" -> "A"]
    ] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff},
    TimeConstraint -> timeLimit,
    TestID -> "nocoeff-message-only-parameters@@Tests/FindRootOptim/findRootIntervalMessages.wlt:84,1-92,4"
  ]

(* --- merged from: findRootIntervalMessages_test6.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval;

VerificationTest[
    Block[{B},
      fri[B[0] > 1 && B[0] < 5, <||>, {}, "CoeffName" -> "A"]
    ] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff},
    TimeConstraint -> timeLimit,
    TestID -> "nocoeff-message-wrong-coefficient-name@@Tests/FindRootOptim/findRootIntervalMessages.wlt:102,1-110,4"
  ]

(* --- merged from: findRootIntervalMessages_test7.wlt --- *)
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
    TestID -> "nocoeff-message-wrong-coefficient-name-indexed@@Tests/FindRootOptim/findRootIntervalMessages.wlt:120,1-128,4"
  ]

(* --- merged from: findRootIntervalMessages_test8.wlt --- *)
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
    TestID -> "no-messages-on-valid-input@@Tests/FindRootOptim/findRootIntervalMessages.wlt:138,1-147,4"
  ]

End[]
EndTestSection[]
