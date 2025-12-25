BeginTestSection["extractIntervalsFromReduce"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[False, x],
    {},
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce::nointervals},
    TestID -> "false-branch-empty@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:50,3-55,4"
  ]

EndTestSection[]
