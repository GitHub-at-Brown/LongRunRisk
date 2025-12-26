BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[x > 0, x, "InteriorShrink" -> 0.01, "RootUpperBound" -> 50],
    {{0.01, 49.99}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "small-shrink-large-upperbound@@Tests/FindRootOptim/extractIntervalsOptions.wlt:116,3-122,4"
  ]

EndTestSection[]
