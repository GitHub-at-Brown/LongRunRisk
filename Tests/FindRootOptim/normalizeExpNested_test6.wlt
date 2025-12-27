BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[Log[E^a * E^b]],
      Log[Exp[a] * Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-inside-Log@@Tests/FindRootOptim/normalizeExpNested_test6.wlt:10,1-15,6"
    ]

EndTestSection[]
