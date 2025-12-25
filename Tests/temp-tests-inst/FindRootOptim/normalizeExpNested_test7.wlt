BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[(E^a)[x] * (E^b)[y]],
      Exp[a[x]] * Exp[b[y]],
      TimeConstraint -> timeLimit,
      TestID -> "multiple-E-function-applications@@Tests/FindRootOptim/normalizeExpNested.wlt:46,5-51,6"
    ]

EndTestSection[]
