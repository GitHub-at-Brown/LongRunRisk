BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[(0 < x <= 1) || (2 <= x < 3), x, "InteriorShrink" -> 0.4, "RootUpperBound" -> 8],
    {{0.4, 0.6}, {2.4, 2.6}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "mixed-inequality-types-custom-shrink@@Tests/FindRootOptim/extractIntervalsOptions_test17.wlt:10,1-16,4"
  ]

EndTestSection[]
