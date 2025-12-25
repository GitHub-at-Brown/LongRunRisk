BeginTestSection["extractIntervalsFromReduce"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[2 < x < 2.2, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 10],
    {{2.1, 2.1}},
    TestID -> "width-equal-2xshrink-collapses-to-midpoint@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:69,3-73,4"
  ]

EndTestSection[]
