BeginTestSection["normalizeExp"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

tests = With[{f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]},
  {
    VerificationTest[
      f[(E^a)[x]],
      Exp[a[x]],
      TimeConstraint -> timeLimit,
      TestID -> "wraps-E^a-application-as-Exp@@Tests/FindRootOptim/normalizeExp.wlt:11,5-16,6"
    ],
    VerificationTest[
      f[E^(a[x] + b[x])],
      Exp[a[x] + b[x]],
      TimeConstraint -> timeLimit,
      TestID -> "normalizes-standard-E-power@@Tests/FindRootOptim/normalizeExp.wlt:17,5-22,6"
    ],
    VerificationTest[
      f[Sin[x]],
      Sin[x],
      TimeConstraint -> timeLimit,
      TestID -> "leaves-non-E-expressions-unchanged@@Tests/FindRootOptim/normalizeExp.wlt:23,5-28,6"
    ]
  }
];


EndTestSection[]
