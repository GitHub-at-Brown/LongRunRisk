BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[x > 0, x, "InteriorShrink" -> 0.0001, "RootUpperBound" -> 2],
    {{0.0001, 1.9999}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "very-small-shrink-small-upperbound@@Tests/FindRootOptim/extractIntervalsOptions_test6.wlt:10,1-16,4"
  ]

EndTestSection[]
