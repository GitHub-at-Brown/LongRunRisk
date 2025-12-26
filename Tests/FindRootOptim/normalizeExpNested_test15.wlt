BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[(E^a)^2],
      (Exp[a])^2,
      TimeConstraint -> timeLimit,
      TestID -> "E-power-raised-to-power@@Tests/FindRootOptim/normalizeExpNested.wlt:94,5-99,6"
    ]

EndTestSection[]
