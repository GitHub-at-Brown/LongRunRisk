BeginTestSection["signIdxs"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`signIdxs"];

VerificationTest[
      f[1 + other[2] + signB[5], "signA"],
      {},
      TimeConstraint -> timeLimit,
      TestID -> "returns-empty-when-no-matching-head@@Tests/FindRootOptim/signIdxs_test2.wlt:10,1-15,6"
    ]

EndTestSection[]
