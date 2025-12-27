BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[{E^a, {E^b, E^(E^c)}}],
      {Exp[a], {Exp[b], Exp[Exp[c]]}},
      TimeConstraint -> timeLimit,
      TestID -> "E-forms-in-nested-lists@@Tests/FindRootOptim/normalizeExpNested_test11.wlt:10,1-15,6"
    ]

EndTestSection[]
