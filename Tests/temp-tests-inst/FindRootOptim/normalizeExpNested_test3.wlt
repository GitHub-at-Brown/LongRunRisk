BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^(E^a)],
      Exp[Exp[a]],
      TimeConstraint -> timeLimit,
      TestID -> "doubly-nested-E-power@@Tests/FindRootOptim/normalizeExpNested.wlt:22,5-27,6"
    ]

EndTestSection[]
