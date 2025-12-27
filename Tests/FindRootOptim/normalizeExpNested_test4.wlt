BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^(E^(E^a))],
      Exp[Exp[Exp[a]]],
      TimeConstraint -> timeLimit,
      TestID -> "triply-nested-E-power@@Tests/FindRootOptim/normalizeExpNested_test4.wlt:10,1-15,6"
    ]

EndTestSection[]
