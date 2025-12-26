BeginTestSection["normalizeExp"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[(E^a)[x]],
      Exp[a[x]],
      TimeConstraint -> timeLimit,
      TestID -> "wraps-E^a-application-as-Exp@@Tests/FindRootOptim/normalizeExp.wlt:10,5-15,6"
    ]

EndTestSection[]
