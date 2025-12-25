BeginTestSection["extractIntervalsFromReduce"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[x < -1, x, "InteriorShrink" -> 0, "RootUpperBound" -> 10],
    {},
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce::nointervals},
    TestID -> "drops-below-zero-clause-and-returns-empty@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:30,3-35,4"
  ]

EndTestSection[]
