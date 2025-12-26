BeginTestSection["extractIntervalsFromReduce"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[1 < x < 3, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 10],
    {{1.1, 2.9}},
    TestID -> "wide-interval-applies-shrink@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:75,3-79,4"
  ]

EndTestSection[]
