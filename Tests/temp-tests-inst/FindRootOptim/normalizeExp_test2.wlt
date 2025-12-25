BeginTestSection["normalizeExp"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^(a[x] + b[x])],
      Exp[a[x] + b[x]],
      TimeConstraint -> timeLimit,
      TestID -> "normalizes-standard-E-power@@Tests/FindRootOptim/normalizeExp.wlt:16,5-21,6"
    ]

EndTestSection[]
