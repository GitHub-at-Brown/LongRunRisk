BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^(a[x] + b[x]) * E^(c[y])],
      Exp[a[x] + b[x]] * Exp[c[y]],
      TimeConstraint -> timeLimit,
      TestID -> "mixed-complex-exponents-in-product@@Tests/FindRootOptim/normalizeExpNested_test8.wlt:10,1-15,6"
    ]

EndTestSection[]
