Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

tests = {
  VerificationTest[
    eir[(x > 10) || (1 < x < 2), x, "InteriorShrink" -> 0],
    {{1., 2.}, {10., 15.}},
    TestID -> "mixed-two-sided-and-upper-fallback@@test/FindRootOptim/extractIntervalsFromReduce.wlt"
  ],

  VerificationTest[
    eir[(x == 3) || (x > 10), x, "InteriorShrink" -> 0],
    {{3., 3.}, {10., 15.}},
    TestID -> "single-point-and-upper-fallback@@test/FindRootOptim/extractIntervalsFromReduce.wlt"
  ],

  VerificationTest[
    eir[(x > 20) || (1 < x < 2), x, "InteriorShrink" -> 0, "RootUpperBound" -> 15],
    {{1., 2.}},
    TestID -> "drops-above-upper-bound-clause@@test/FindRootOptim/extractIntervalsFromReduce.wlt"
  ],

  VerificationTest[
    eir[x < -1, x, "InteriorShrink" -> 0, "RootUpperBound" -> 10],
    {},
    {extractIntervalsFromReduce::nointervals},
    TestID -> "drops-below-zero-clause-and-returns-empty@@test/FindRootOptim/extractIntervalsFromReduce.wlt"
  ],

  VerificationTest[
    eir[0 < x < 0.0015, x, "InteriorShrink" -> 0.001, "RootUpperBound" -> 1],
    {{0.00075, 0.00075}},
    TestID -> "collapses-narrow-interval-to-midpoint@@test/FindRootOptim/extractIntervalsFromReduce.wlt"
  ],

  VerificationTest[
    eir[True, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5],
    {{0.1, 4.9}},
    TestID -> "true-branch-full-range@@test/FindRootOptim/extractIntervalsFromReduce.wlt"
  ],

  VerificationTest[
    eir[False, x],
    {},
    TestID -> "false-branch-empty@@test/FindRootOptim/extractIntervalsFromReduce.wlt"
  ],

  VerificationTest[
    eir[x > 1, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5],
    {{1.1, 4.9}},
    TestID -> "one-sided-lower-clamped-to-upper@@test/FindRootOptim/extractIntervalsFromReduce.wlt"
  ],

  VerificationTest[
    eir[x > 4.9, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5],
    {{4.95, 4.95}},
    TestID -> "one-sided-near-upper-clamps-and-collapses@@test/FindRootOptim/extractIntervalsFromReduce.wlt"
  ],

  VerificationTest[
    eir[2 < x < 2.2, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 10],
    {{2.1, 2.1}},
    TestID -> "width-equal-2xshrink-collapses-to-midpoint@@test/FindRootOptim/extractIntervalsFromReduce.wlt"
  ],

  VerificationTest[
    eir[1 < x < 3, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 10],
    {{1.1, 2.9}},
    TestID -> "wide-interval-applies-shrink@@test/FindRootOptim/extractIntervalsFromReduce.wlt"
  ],

  VerificationTest[
    eir[(x >= 4 && x <= 4.2) || (1 <= x <= 2) || (x >= 10), x, "InteriorShrink" -> 0],
    {{1., 2.}, {4., 4.2}, {10., 15.}},
    TestID -> "open-closed-mix-and-sorting@@test/FindRootOptim/extractIntervalsFromReduce.wlt"
  ],

  VerificationTest[
    eir[x > 20, x, "RootUpperBound" -> 15],
    {},
    {extractIntervalsFromReduce::nointervals},
    TestID -> "all-clauses-dropped-empty@@test/FindRootOptim/extractIntervalsFromReduce.wlt"
  ]
};

tests
