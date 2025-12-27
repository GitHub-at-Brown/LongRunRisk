BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[(0.01 < x < 0.02) || (0.03 < x < 0.04), x, "InteriorShrink" -> 0.004, "RootUpperBound" -> 1],
    {{0.014, 0.016}, {0.034, 0.036}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "tiny-intervals-small-shrink-no-collapse@@Tests/FindRootOptim/extractIntervalsOptions_test18.wlt:10,1-16,4"
  ]

EndTestSection[]
