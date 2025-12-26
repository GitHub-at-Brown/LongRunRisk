BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[1 < x < 5, x, "InteriorShrink" -> 0.5, "RootUpperBound" -> 10],
    {{1.5, 4.5}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "large-shrink-wide-interval@@Tests/FindRootOptim/extractIntervalsOptions.wlt:11,3-17,4"
  ]

EndTestSection[]
