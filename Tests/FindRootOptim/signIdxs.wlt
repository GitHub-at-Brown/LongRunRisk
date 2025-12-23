BeginTestSection["signIdxs"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`signIdxs`"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;
tests = With[{f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`signIdxs"]},
  {
    VerificationTest[
      f[signA[3] + signA[1]^2 + other[2] + signB[5], "signA"],
      {1, 3},
      TimeConstraint -> timeLimit,
      TestID -> "extracts-and-sorts-sign-indices@@Tests/FindRootOptim/signIdxs.wlt:7,5-12,6"
    ],
    VerificationTest[
      f[1 + other[2] + signB[5], "signA"],
      {},
      TimeConstraint -> timeLimit,
      TestID -> "returns-empty-when-no-matching-head@@Tests/FindRootOptim/signIdxs.wlt:13,5-18,6"
    ]
  }
];


End[]
EndTestSection[]
