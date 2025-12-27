BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[(0.5 < x < 2) || (10 < x < 15), x, "InteriorShrink" -> 0.3, "RootUpperBound" -> 12],
    {{0.8, 1.7}, {10.3, 11.7}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "second-interval-clipped-by-upperbound@@Tests/FindRootOptim/extractIntervalsOptions_test15.wlt:10,1-16,4"
  ]

EndTestSection[]
