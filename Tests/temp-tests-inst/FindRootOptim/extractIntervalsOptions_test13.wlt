BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[(x == 5) || (x > 10), x, "InteriorShrink" -> 0.5, "RootUpperBound" -> 15],
    {{5., 5.}, {10.5, 14.5}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "point-and-unbounded-custom-options@@Tests/FindRootOptim/extractIntervalsOptions.wlt:95,3-101,4"
  ]

EndTestSection[]
