BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[1 + E^a + E^(E^b) + (E^c)[x]],
      1 + Exp[a] + Exp[Exp[b]] + Exp[c[x]],
      TimeConstraint -> timeLimit,
      TestID -> "deeply-nested-multiple-E-forms@@Tests/FindRootOptim/normalizeExpNested.wlt:58,5-63,6"
    ]

EndTestSection[]
