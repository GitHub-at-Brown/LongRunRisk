BeginTestSection["normalizeExp Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`normalizeExp`"]

(* --- merged from: normalizeExp_test1.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[(E^a)[x]],
      Exp[a[x]],
      TimeConstraint -> timeLimit,
      TestID -> "wraps-E^a-application-as-Exp@@Tests/FindRootOptim/normalizeExp.wlt:12,1-17,6"
    ]

(* --- merged from: normalizeExp_test2.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^(a[x] + b[x])],
      Exp[a[x] + b[x]],
      TimeConstraint -> timeLimit,
      TestID -> "normalizes-standard-E-power@@Tests/FindRootOptim/normalizeExp.wlt:27,1-32,6"
    ]

(* --- merged from: normalizeExp_test3.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[Sin[x]],
      Sin[x],
      TimeConstraint -> timeLimit,
      TestID -> "leaves-non-E-expressions-unchanged@@Tests/FindRootOptim/normalizeExp.wlt:42,1-47,6"
    ]

End[]
EndTestSection[]
