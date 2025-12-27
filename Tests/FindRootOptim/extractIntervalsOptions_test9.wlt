BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[(1 < x < 2) || (3 < x < 4) || (5 < x < 6), x, "InteriorShrink" -> 0.4, "RootUpperBound" -> 10],
    {{1.4, 1.6}, {3.4, 3.6}, {5.4, 5.6}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "three-intervals-mixed-collapse@@Tests/FindRootOptim/extractIntervalsOptions_test9.wlt:10,1-16,4"
  ]

EndTestSection[]
