BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^(a*E^b)],
      Exp[a*Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-power-in-exponent-expression@@Tests/FindRootOptim/normalizeExpNested.wlt:82,5-87,6"
    ]

EndTestSection[]
