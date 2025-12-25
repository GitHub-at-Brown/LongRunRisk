BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[x > 0, x, "InteriorShrink" -> 1.5, "RootUpperBound" -> 3],
    {{1.5, 1.5}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "shrink-equals-half-upperbound-collapses@@Tests/FindRootOptim/extractIntervalsOptions.wlt:102,3-108,4"
  ]

EndTestSection[]
