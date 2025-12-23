BeginTestSection["extractIntervalsFromReduce"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`extractIntervalsFromReduce`"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

tests = {
  VerificationTest[
    eir[(x > 10) || (1 < x < 2), x, "InteriorShrink" -> 0],
    {{1., 2.}, {10., 15.}},
    TestID -> "mixed-two-sided-and-upper-fallback@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:10,3-14,4"
  ],

  VerificationTest[
    eir[(x == 3) || (x > 10), x, "InteriorShrink" -> 0],
    {{3., 3.}, {10., 15.}},
    TestID -> "single-point-and-upper-fallback@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:16,3-20,4"
  ],

  VerificationTest[
    eir[(x > 20) || (1 < x < 2), x, "InteriorShrink" -> 0, "RootUpperBound" -> 15],
    {{1., 2.}},
    TestID -> "drops-above-upper-bound-clause@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:22,3-26,4"
  ],

  VerificationTest[
    eir[x < -1, x, "InteriorShrink" -> 0, "RootUpperBound" -> 10],
    {},
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce::nointervals},
    TestID -> "drops-below-zero-clause-and-returns-empty@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:28,3-33,4"
  ],

  VerificationTest[
    eir[0 < x < 0.0015, x, "InteriorShrink" -> 0.001, "RootUpperBound" -> 1],
    {{0.00075, 0.00075}},
    TestID -> "collapses-narrow-interval-to-midpoint@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:35,3-39,4"
  ],

  VerificationTest[
    eir[True, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5],
    {{0.2, 4.8}},
    SameTest -> (Max[Abs[Flatten[#1] - Flatten[#2]]] < 10^-10 &),
    TestID -> "true-branch-full-range@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:41,3-46,4"
  ],

  VerificationTest[
    eir[False, x],
    {},
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce::nointervals},
    TestID -> "false-branch-empty@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:48,3-53,4"
  ],

  VerificationTest[
    eir[x > 1, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5],
    {{1.1, 4.9}},
    TestID -> "one-sided-lower-clamped-to-upper@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:55,3-59,4"
  ],

  VerificationTest[
    eir[x > 4.9, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5],
    {{4.95, 4.95}},
    TestID -> "one-sided-near-upper-clamps-and-collapses@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:61,3-65,4"
  ],

  VerificationTest[
    eir[2 < x < 2.2, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 10],
    {{2.1, 2.1}},
    TestID -> "width-equal-2xshrink-collapses-to-midpoint@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:67,3-71,4"
  ],

  VerificationTest[
    eir[1 < x < 3, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 10],
    {{1.1, 2.9}},
    TestID -> "wide-interval-applies-shrink@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:73,3-77,4"
  ],

  VerificationTest[
    eir[(x >= 4 && x <= 4.2) || (1 <= x <= 2) || (x >= 10), x, "InteriorShrink" -> 0],
    {{1., 2.}, {4., 4.2}, {10., 15.}},
    TestID -> "open-closed-mix-and-sorting@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:79,3-83,4"
  ],

  VerificationTest[
    eir[x > 20, x, "RootUpperBound" -> 15],
    {},
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce::nointervals},
    TestID -> "all-clauses-dropped-empty@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:85,3-90,4"
  ]
};


End[]
EndTestSection[]
