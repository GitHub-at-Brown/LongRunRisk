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
tests = With[{f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`paramValidQ"]},
  {
    VerificationTest[
      f[A[0] > 0 && A[0] < 2 && a > 0 && a < 1, <|a -> 0.5|>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "complex-and-all-clauses-valid@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[A[0] > 0 && A[0] < 2 && a > 0 && a < 1, <|a -> 1.5|>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "complex-and-root-free-invalid@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[A[0] > 0 && A[0] < 2 && A[0] > 3, <|a -> 0.5|>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "complex-and-root-clauses-contradictory@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[A[0] > 0 && a > 0 && b > 0 && c > 0, <|a -> 1, b -> 1, c -> -1|>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "multiple-params-one-invalid@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[A[0] > 0 && a > 0 && b > 0 && c > 0, <|a -> 1, b -> 1, c -> 1|>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "multiple-params-all-valid@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[A[1][0] > 0 && A[1][0] < 2 && A[1][0] > 3, <||>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "indexed-root-contradictory-multiple@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[A[1][0] > 0 && A[2][0] > 0, <||>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "multiple-indexed-roots-valid@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[A[1][0] > 0 && A[1][0] < 0, <||>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "indexed-root-contradictory@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[A[1][0] > 0 && a > 0, <|a -> 1|>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "indexed-root-with-valid-root-free@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[B[0] > 0 && B[0] < 0, <||>, "B"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "different-coeff-name-contradictory@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[B[0] > 0 && a > 0, <|a -> 1|>, "B"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "different-coeff-name-valid@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[B[1][0] > 0 && B[1][0] < 2, <||>, "B"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "different-coeff-name-indexed-valid@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[A[0] > 0 && A[0] < 5 && A[0] > 2 && A[0] < 10, <||>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "overlapping-root-intervals-valid@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[A[0] > 0 && A[0] < 5 && A[0] > 6 && A[0] < 10, <||>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "non-overlapping-root-intervals-contradictory@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[a > 0 && b > a && c > b, <|a -> 1, b -> 2, c -> 3|>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "chained-inequalities-valid@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[a > 0 && b > a && c > b, <|a -> 1, b -> 0, c -> 3|>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "chained-inequalities-invalid@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[A[0] != 0 && a > 0, <|a -> 1|>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "root-inequality-with-valid-params@@test/FindRootOptim/paramValidQComplex.wlt"
    ],
    VerificationTest[
      f[A[0] == 1 && A[0] == 2, <||>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "root-equality-contradictory@@test/FindRootOptim/paramValidQComplex.wlt"
    ]
  }
];

tests
