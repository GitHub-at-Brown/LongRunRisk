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

eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

tests = {
  VerificationTest[
    eir[1 < x < 5, x, "InteriorShrink" -> 0.5, "RootUpperBound" -> 10],
    {{1.5, 4.5}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "large-shrink-wide-interval@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[1 < x < 2, x, "InteriorShrink" -> 0.5, "RootUpperBound" -> 10],
    {{1.5, 1.5}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "large-shrink-collapses-narrow-interval@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[x > 0, x, "InteriorShrink" -> 2, "RootUpperBound" -> 10],
    {{2., 8.}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "shrink-two-upperbound-ten@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[x > 0, x, "InteriorShrink" -> 4.9, "RootUpperBound" -> 10],
    {{4.9, 5.1}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "shrink-nearly-half-upperbound-collapses@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[(0.5 < x < 1.5) || (3 < x < 6), x, "InteriorShrink" -> 0.25, "RootUpperBound" -> 8],
    {{0.75, 1.25}, {3.25, 5.75}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "two-intervals-different-collapse-behavior@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[x > 0, x, "InteriorShrink" -> 0.0001, "RootUpperBound" -> 2],
    {{0.0001, 1.9999}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "very-small-shrink-small-upperbound@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[x > 0, x, "InteriorShrink" -> 0, "RootUpperBound" -> 100],
    {{0., 100.}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "zero-shrink-large-upperbound@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[(x > 5) || (0 < x < 1), x, "InteriorShrink" -> 0.2, "RootUpperBound" -> 20],
    {{0.2, 0.8}, {5.2, 19.8}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "mixed-bounded-unbounded-custom-options@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[(1 < x < 2) || (3 < x < 4) || (5 < x < 6), x, "InteriorShrink" -> 0.4, "RootUpperBound" -> 10],
    {{1.4, 1.6}, {3.4, 3.6}, {5.4, 5.6}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "three-intervals-mixed-collapse@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[0.1 < x < 0.3, x, "InteriorShrink" -> 0.05, "RootUpperBound" -> 5],
    {{0.15, 0.25}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "small-interval-small-shrink-no-collapse@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[0.1 < x < 0.2, x, "InteriorShrink" -> 0.05, "RootUpperBound" -> 5],
    {{0.15, 0.15}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "small-interval-small-shrink-collapses@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[x > 18, x, "InteriorShrink" -> 1, "RootUpperBound" -> 20],
    {{19., 19.}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "near-upperbound-with-shrink-collapses@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[(x == 5) || (x > 10), x, "InteriorShrink" -> 0.5, "RootUpperBound" -> 15],
    {{5., 5.}, {10.5, 14.5}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "point-and-unbounded-custom-options@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[x > 0, x, "InteriorShrink" -> 1.5, "RootUpperBound" -> 3],
    {{1.5, 1.5}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "shrink-equals-half-upperbound-collapses@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[(0.5 < x < 2) || (10 < x < 15), x, "InteriorShrink" -> 0.3, "RootUpperBound" -> 12],
    {{0.8, 1.7}, {10.3, 11.7}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "second-interval-clipped-by-upperbound@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[x > 0, x, "InteriorShrink" -> 0.01, "RootUpperBound" -> 50],
    {{0.01, 49.99}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "small-shrink-large-upperbound@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[(0 < x <= 1) || (2 <= x < 3), x, "InteriorShrink" -> 0.4, "RootUpperBound" -> 8],
    {{0.4, 0.6}, {2.4, 2.6}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "mixed-inequality-types-custom-shrink@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[(0.01 < x < 0.02) || (0.03 < x < 0.04), x, "InteriorShrink" -> 0.004, "RootUpperBound" -> 1],
    {{0.014, 0.016}, {0.034, 0.036}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "tiny-intervals-small-shrink-no-collapse@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ],
  VerificationTest[
    eir[x > 0, x, "InteriorShrink" -> 3, "RootUpperBound" -> 8],
    {{3., 5.}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "large-shrink-moderate-upperbound@@test/FindRootOptim/extractIntervalsOptions.wlt"
  ]
};

tests
