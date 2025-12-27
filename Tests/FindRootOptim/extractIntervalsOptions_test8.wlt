BeginTestSection["extractIntervalsOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce;
tolSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);
timeLimit = 5;

VerificationTest[
    eir[(x > 5) || (0 < x < 1), x, "InteriorShrink" -> 0.2, "RootUpperBound" -> 20],
    {{0.2, 0.8}, {5.2, 19.8}},
    SameTest -> tolSameTest,
    TimeConstraint -> timeLimit,
    TestID -> "mixed-bounded-unbounded-custom-options@@Tests/FindRootOptim/extractIntervalsOptions_test8.wlt:10,1-16,4"
  ]

EndTestSection[]
