BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[Log[E^a * E^b]],
      Log[Exp[a] * Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-inside-Log@@Tests/FindRootOptim/normalizeExpNested.wlt:40,5-45,6"
    ]

EndTestSection[]
