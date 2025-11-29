Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;
tests = With[{f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`paramValidQ"]},
  {
    VerificationTest[
      f[A[0] > 0 && A[0] < 2 && a > 0 && a < 1, <|a -> 0.5|>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "complex-and-all-clauses-valid@@Tests/FindRootOptim/paramValidQComplex.wlt:7,5-12,6"
    ],
    VerificationTest[
      f[A[0] > 0 && A[0] < 2 && a > 0 && a < 1, <|a -> 1.5|>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "complex-and-root-free-invalid@@Tests/FindRootOptim/paramValidQComplex.wlt:13,5-18,6"
    ],
    VerificationTest[
      f[A[0] > 0 && A[0] < 2 && A[0] > 3, <|a -> 0.5|>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "complex-and-root-clauses-contradictory@@Tests/FindRootOptim/paramValidQComplex.wlt:19,5-24,6"
    ],
    VerificationTest[
      f[A[0] > 0 && a > 0 && b > 0 && c > 0, <|a -> 1, b -> 1, c -> -1|>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "multiple-params-one-invalid@@Tests/FindRootOptim/paramValidQComplex.wlt:25,5-30,6"
    ],
    VerificationTest[
      f[A[0] > 0 && a > 0 && b > 0 && c > 0, <|a -> 1, b -> 1, c -> 1|>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "multiple-params-all-valid@@Tests/FindRootOptim/paramValidQComplex.wlt:31,5-36,6"
    ],
    VerificationTest[
      f[A[1][0] > 0 && A[1][0] < 2 && A[1][0] > 3, <||>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "indexed-root-contradictory-multiple@@Tests/FindRootOptim/paramValidQComplex.wlt:37,5-42,6"
    ],
    VerificationTest[
      f[A[1][0] > 0 && A[2][0] > 0, <||>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "multiple-indexed-roots-valid@@Tests/FindRootOptim/paramValidQComplex.wlt:43,5-48,6"
    ],
    VerificationTest[
      f[A[1][0] > 0 && A[1][0] < 0, <||>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "indexed-root-contradictory@@Tests/FindRootOptim/paramValidQComplex.wlt:49,5-54,6"
    ],
    VerificationTest[
      f[A[1][0] > 0 && a > 0, <|a -> 1|>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "indexed-root-with-valid-root-free@@Tests/FindRootOptim/paramValidQComplex.wlt:55,5-60,6"
    ],
    VerificationTest[
      f[B[0] > 0 && B[0] < 0, <||>, "B"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "different-coeff-name-contradictory@@Tests/FindRootOptim/paramValidQComplex.wlt:61,5-66,6"
    ],
    VerificationTest[
      f[B[0] > 0 && a > 0, <|a -> 1|>, "B"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "different-coeff-name-valid@@Tests/FindRootOptim/paramValidQComplex.wlt:67,5-72,6"
    ],
    VerificationTest[
      f[B[1][0] > 0 && B[1][0] < 2, <||>, "B"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "different-coeff-name-indexed-valid@@Tests/FindRootOptim/paramValidQComplex.wlt:73,5-78,6"
    ],
    VerificationTest[
      f[A[0] > 0 && A[0] < 5 && A[0] > 2 && A[0] < 10, <||>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "overlapping-root-intervals-valid@@Tests/FindRootOptim/paramValidQComplex.wlt:79,5-84,6"
    ],
    VerificationTest[
      f[A[0] > 0 && A[0] < 5 && A[0] > 6 && A[0] < 10, <||>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "non-overlapping-root-intervals-contradictory@@Tests/FindRootOptim/paramValidQComplex.wlt:85,5-90,6"
    ],
    VerificationTest[
      f[a > 0 && b > a && c > b, <|a -> 1, b -> 2, c -> 3|>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "chained-inequalities-valid@@Tests/FindRootOptim/paramValidQComplex.wlt:91,5-96,6"
    ],
    VerificationTest[
      f[a > 0 && b > a && c > b, <|a -> 1, b -> 0, c -> 3|>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "chained-inequalities-invalid@@Tests/FindRootOptim/paramValidQComplex.wlt:97,5-102,6"
    ],
    VerificationTest[
      f[A[0] != 0 && a > 0, <|a -> 1|>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "root-inequality-with-valid-params@@Tests/FindRootOptim/paramValidQComplex.wlt:103,5-108,6"
    ],
    VerificationTest[
      f[A[0] == 1 && A[0] == 2, <||>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "root-equality-contradictory@@Tests/FindRootOptim/paramValidQComplex.wlt:109,5-114,6"
    ]
  }
];

tests
