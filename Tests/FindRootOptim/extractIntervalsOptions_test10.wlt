BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[0.1 < x < 0.3, x, "InteriorShrink" -> 0.05, "RootUpperBound" -> 5],
    {{0.15, 0.25}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "small-interval-small-shrink-no-collapse@@Tests/FindRootOptim/extractIntervalsOptions_test10.wlt:10,1-16,4"
  ]

EndTestSection[]
