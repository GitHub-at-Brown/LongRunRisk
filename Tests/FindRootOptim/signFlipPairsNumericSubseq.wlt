Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;
tests = With[{f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`signFlipPairsNumericSubseq"]},
  {
    VerificationTest[
      f[{1, -2, 0, 3, -4}],
      {{1, 2}, {4, 5}},
      TimeConstraint -> timeLimit,
      TestID -> "detects-sign-flips-among-numeric-entries@@test/FindRootOptim/signFlipPairsNumericSubseq.wlt"
    ],
    VerificationTest[
      f[{1, "x", -1}],
      {{1, 3}},
      TimeConstraint -> timeLimit,
      TestID -> "skips-nonnumeric-entries-in-positioning@@test/FindRootOptim/signFlipPairsNumericSubseq.wlt"
    ],
    VerificationTest[
      f[{1, 2, 3}],
      {},
      TimeConstraint -> timeLimit,
      TestID -> "returns-empty-when-no-sign-change@@test/FindRootOptim/signFlipPairsNumericSubseq.wlt"
    ]
  }
];

tests
