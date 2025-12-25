BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[(0.5 < x < 1.5) || (3 < x < 6), x, "InteriorShrink" -> 0.25, "RootUpperBound" -> 8],
    {{0.75, 1.25}, {3.25, 5.75}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "two-intervals-different-collapse-behavior@@Tests/FindRootOptim/extractIntervalsOptions.wlt:39,3-45,4"
  ]

EndTestSection[]
