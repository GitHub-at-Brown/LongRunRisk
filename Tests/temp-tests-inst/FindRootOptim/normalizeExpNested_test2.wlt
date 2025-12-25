BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^a + E^b + E^c],
      Exp[a] + Exp[b] + Exp[c],
      TimeConstraint -> timeLimit,
      TestID -> "multiple-E-powers-in-sum@@Tests/FindRootOptim/normalizeExpNested.wlt:16,5-21,6"
    ]

EndTestSection[]
