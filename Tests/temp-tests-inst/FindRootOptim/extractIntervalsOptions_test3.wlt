BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[x > 0, x, "InteriorShrink" -> 2, "RootUpperBound" -> 10],
    {{2., 8.}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "shrink-two-upperbound-ten@@Tests/FindRootOptim/extractIntervalsOptions.wlt:25,3-31,4"
  ]

EndTestSection[]
