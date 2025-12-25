BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[(E^a)[x] + E^(b[y])],
      Exp[a[x]] + Exp[b[y]],
      TimeConstraint -> timeLimit,
      TestID -> "mixed-application-and-standard-power@@Tests/FindRootOptim/normalizeExpNested.wlt:76,5-81,6"
    ]

EndTestSection[]
