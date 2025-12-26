BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[x > 18, x, "InteriorShrink" -> 1, "RootUpperBound" -> 20],
    {{19., 19.}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "near-upperbound-with-shrink-collapses@@Tests/FindRootOptim/extractIntervalsOptions.wlt:88,3-94,4"
  ]

EndTestSection[]
