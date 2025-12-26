BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[0.1 < x < 0.2, x, "InteriorShrink" -> 0.05, "RootUpperBound" -> 5],
    {{0.15, 0.15}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "small-interval-small-shrink-collapses@@Tests/FindRootOptim/extractIntervalsOptions.wlt:81,3-87,4"
  ]

EndTestSection[]
