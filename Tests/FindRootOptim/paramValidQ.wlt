Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;
tests = With[{f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`paramValidQ"]},
  {
    VerificationTest[
      f[True, <||>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "returns-true-for-true-assumptions@@Tests/FindRootOptim/paramValidQ.wlt:7,5-12,6"
    ],
    VerificationTest[
      f[False, <||>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "returns-false-for-false-assumptions@@Tests/FindRootOptim/paramValidQ.wlt:13,5-18,6"
    ],
    VerificationTest[
      f[a > 0 && A[0] > 0, <|a -> 1|>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "accepts-consistent-root-and-root-free-clauses@@Tests/FindRootOptim/paramValidQ.wlt:19,5-24,6"
    ],
    VerificationTest[
      f[A[0] > 0 && A[0] < 0, <||>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "rejects-contradictory-root-clauses@@Tests/FindRootOptim/paramValidQ.wlt:25,5-30,6"
    ],
    VerificationTest[
      f[a > 0 && a < 0, <|a -> 1|>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "rejects-contradictory-root-free-clauses@@Tests/FindRootOptim/paramValidQ.wlt:31,5-36,6"
    ]
  }
];

tests
