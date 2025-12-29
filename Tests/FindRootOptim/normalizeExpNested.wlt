BeginTestSection["normalizeExpNested Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`normalizeExpNested`"]

(* --- merged from: normalizeExpNested_test1.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^a * E^b],
      Exp[a] * Exp[b],
      TimeConstraint -> timeLimit,
      TestID -> "multiple-E-powers-in-product@@Tests/FindRootOptim/normalizeExpNested.wlt:12,1-17,6"
    ]

(* --- merged from: normalizeExpNested_test2.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^a + E^b + E^c],
      Exp[a] + Exp[b] + Exp[c],
      TimeConstraint -> timeLimit,
      TestID -> "multiple-E-powers-in-sum@@Tests/FindRootOptim/normalizeExpNested.wlt:27,1-32,6"
    ]

(* --- merged from: normalizeExpNested_test3.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^(E^a)],
      Exp[Exp[a]],
      TimeConstraint -> timeLimit,
      TestID -> "doubly-nested-E-power@@Tests/FindRootOptim/normalizeExpNested.wlt:42,1-47,6"
    ]

(* --- merged from: normalizeExpNested_test4.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^(E^(E^a))],
      Exp[Exp[Exp[a]]],
      TimeConstraint -> timeLimit,
      TestID -> "triply-nested-E-power@@Tests/FindRootOptim/normalizeExpNested.wlt:57,1-62,6"
    ]

(* --- merged from: normalizeExpNested_test5.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[Sin[E^a] + Cos[E^b]],
      Sin[Exp[a]] + Cos[Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-inside-trigonometric-functions@@Tests/FindRootOptim/normalizeExpNested.wlt:72,1-77,6"
    ]

(* --- merged from: normalizeExpNested_test6.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[Log[E^a * E^b]],
      Log[Exp[a] * Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-inside-Log@@Tests/FindRootOptim/normalizeExpNested.wlt:87,1-92,6"
    ]

(* --- merged from: normalizeExpNested_test7.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[(E^a)[x] * (E^b)[y]],
      Exp[a[x]] * Exp[b[y]],
      TimeConstraint -> timeLimit,
      TestID -> "multiple-E-function-applications@@Tests/FindRootOptim/normalizeExpNested.wlt:102,1-107,6"
    ]

(* --- merged from: normalizeExpNested_test8.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^(a[x] + b[x]) * E^(c[y])],
      Exp[a[x] + b[x]] * Exp[c[y]],
      TimeConstraint -> timeLimit,
      TestID -> "mixed-complex-exponents-in-product@@Tests/FindRootOptim/normalizeExpNested.wlt:117,1-122,6"
    ]

(* --- merged from: normalizeExpNested_test9.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[1 + E^a + E^(E^b) + (E^c)[x]],
      1 + Exp[a] + Exp[Exp[b]] + Exp[c[x]],
      TimeConstraint -> timeLimit,
      TestID -> "deeply-nested-multiple-E-forms@@Tests/FindRootOptim/normalizeExpNested.wlt:132,1-137,6"
    ]

(* --- merged from: normalizeExpNested_test10.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[f1[E^a, E^b] + f2[(E^c)[x], E^(E^d)]],
      f1[Exp[a], Exp[b]] + f2[Exp[c[x]], Exp[Exp[d]]],
      TimeConstraint -> timeLimit,
      TestID -> "E-forms-in-function-arguments@@Tests/FindRootOptim/normalizeExpNested.wlt:147,1-152,6"
    ]

(* --- merged from: normalizeExpNested_test11.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[{E^a, {E^b, E^(E^c)}}],
      {Exp[a], {Exp[b], Exp[Exp[c]]}},
      TimeConstraint -> timeLimit,
      TestID -> "E-forms-in-nested-lists@@Tests/FindRootOptim/normalizeExpNested.wlt:162,1-167,6"
    ]

(* --- merged from: normalizeExpNested_test12.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[(E^a)[x] + E^(b[y])],
      Exp[a[x]] + Exp[b[y]],
      TimeConstraint -> timeLimit,
      TestID -> "mixed-application-and-standard-power@@Tests/FindRootOptim/normalizeExpNested.wlt:177,1-182,6"
    ]

(* --- merged from: normalizeExpNested_test13.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^(a*E^b)],
      Exp[a*Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-power-in-exponent-expression@@Tests/FindRootOptim/normalizeExpNested.wlt:192,1-197,6"
    ]

(* --- merged from: normalizeExpNested_test14.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[E^a / E^b],
      Exp[a] / Exp[b],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-in-division@@Tests/FindRootOptim/normalizeExpNested.wlt:207,1-212,6"
    ]

(* --- merged from: normalizeExpNested_test15.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"];

VerificationTest[
      f[(E^a)^2],
      (Exp[a])^2,
      TimeConstraint -> timeLimit,
      TestID -> "E-power-raised-to-power@@Tests/FindRootOptim/normalizeExpNested.wlt:222,1-227,6"
    ]

End[]
EndTestSection[]
