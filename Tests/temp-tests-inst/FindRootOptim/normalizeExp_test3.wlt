BeginTestSection["normalizeExp"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[Sin[x]],
      Sin[x],
      TimeConstraint -> timeLimit,
      TestID -> "leaves-non-E-expressions-unchanged@@Tests/FindRootOptim/normalizeExp.wlt:22,5-27,6"
    ]

EndTestSection[]
