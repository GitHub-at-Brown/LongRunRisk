BeginTestSection["signIdxs Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`signIdxs`"]

(* --- merged from: signIdxs_test1.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`signIdxs"];

VerificationTest[
      f[signA[3] + signA[1]^2 + other[2] + signB[5], "signA"],
      {1, 3},
      TimeConstraint -> timeLimit,
      TestID -> "extracts-and-sorts-sign-indices@@Tests/FindRootOptim/signIdxs.wlt:12,1-17,6"
    ]

(* --- merged from: signIdxs_test2.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`signIdxs"];

VerificationTest[
      f[1 + other[2] + signB[5], "signA"],
      {},
      TimeConstraint -> timeLimit,
      TestID -> "returns-empty-when-no-matching-head@@Tests/FindRootOptim/signIdxs.wlt:27,1-32,6"
    ]

End[]
EndTestSection[]
