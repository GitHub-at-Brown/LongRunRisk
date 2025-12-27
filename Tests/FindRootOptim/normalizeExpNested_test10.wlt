BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[f1[E^a, E^b] + f2[(E^c)[x], E^(E^d)]],
      f1[Exp[a], Exp[b]] + f2[Exp[c[x]], Exp[Exp[d]]],
      TimeConstraint -> timeLimit,
      TestID -> "E-forms-in-function-arguments@@Tests/FindRootOptim/normalizeExpNested_test10.wlt:10,1-15,6"
    ]

EndTestSection[]
