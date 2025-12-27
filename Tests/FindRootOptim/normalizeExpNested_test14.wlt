BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^a / E^b],
      Exp[a] / Exp[b],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-in-division@@Tests/FindRootOptim/normalizeExpNested_test14.wlt:10,1-15,6"
    ]

EndTestSection[]
