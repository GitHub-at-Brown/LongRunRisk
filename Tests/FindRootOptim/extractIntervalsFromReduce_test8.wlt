BeginTestSection["extractIntervalsFromReduce"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[x > 1, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5],
    {{1.1, 4.9}},
    TestID -> "one-sided-lower-clamped-to-upper@@Tests/FindRootOptim/extractIntervalsFromReduce_test8.wlt:11,1-15,4"
  ]

EndTestSection[]
