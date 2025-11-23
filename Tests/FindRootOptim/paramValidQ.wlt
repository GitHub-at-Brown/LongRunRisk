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
      f[True, <||>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "returns-true-for-true-assumptions@@test/FindRootOptim/paramValidQ.wlt"
    ],
    VerificationTest[
      f[False, <||>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "returns-false-for-false-assumptions@@test/FindRootOptim/paramValidQ.wlt"
    ],
    VerificationTest[
      f[a > 0 && A[0] > 0, <|a -> 1|>, "A"],
      True,
      TimeConstraint -> timeLimit,
      TestID -> "accepts-consistent-root-and-root-free-clauses@@test/FindRootOptim/paramValidQ.wlt"
    ],
    VerificationTest[
      f[A[0] > 0 && A[0] < 0, <||>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "rejects-contradictory-root-clauses@@test/FindRootOptim/paramValidQ.wlt"
    ],
    VerificationTest[
      f[a > 0 && a < 0, <|a -> 1|>, "A"],
      False,
      TimeConstraint -> timeLimit,
      TestID -> "rejects-contradictory-root-free-clauses@@test/FindRootOptim/paramValidQ.wlt"
    ]
  }
];

tests
