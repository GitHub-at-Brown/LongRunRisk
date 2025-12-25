BeginTestSection["extractIntervalsFromReduce"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[x > 20, x, "RootUpperBound" -> 15],
    {},
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce::nointervals},
    TestID -> "all-clauses-dropped-empty@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:87,3-92,4"
  ]

EndTestSection[]
