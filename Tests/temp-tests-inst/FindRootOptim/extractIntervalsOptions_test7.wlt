BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[x > 0, x, "InteriorShrink" -> 0, "RootUpperBound" -> 100],
    {{0., 100.}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "zero-shrink-large-upperbound@@Tests/FindRootOptim/extractIntervalsOptions.wlt:53,3-59,4"
  ]

EndTestSection[]
