BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[Sin[E^a] + Cos[E^b]],
      Sin[Exp[a]] + Cos[Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-inside-trigonometric-functions@@Tests/FindRootOptim/normalizeExpNested.wlt:34,5-39,6"
    ]

EndTestSection[]
