BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[x > 0, x, "InteriorShrink" -> 4.9, "RootUpperBound" -> 10],
    {{4.9, 5.1}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "shrink-nearly-half-upperbound-collapses@@Tests/FindRootOptim/extractIntervalsOptions.wlt:32,3-38,4"
  ]

EndTestSection[]
