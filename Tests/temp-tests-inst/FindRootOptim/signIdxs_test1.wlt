BeginTestSection["signIdxs"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`signIdxs"];

VerificationTest[
      f[signA[3] + signA[1]^2 + other[2] + signB[5], "signA"],
      {1, 3},
      TimeConstraint -> timeLimit,
      TestID -> "extracts-and-sorts-sign-indices@@Tests/FindRootOptim/signIdxs.wlt:9,5-14,6"
    ]

EndTestSection[]
