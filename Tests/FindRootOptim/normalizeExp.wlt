Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

tests = With[{f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]},
  {
    VerificationTest[
      f[(E^a)[x]],
      Exp[a[x]],
      TimeConstraint -> timeLimit,
      TestID -> "wraps-E^a-application-as-Exp@@Tests/FindRootOptim/normalizeExp.wlt:8,5-13,6"
    ],
    VerificationTest[
      f[E^(a[x] + b[x])],
      Exp[a[x] + b[x]],
      TimeConstraint -> timeLimit,
      TestID -> "normalizes-standard-E-power@@Tests/FindRootOptim/normalizeExp.wlt:14,5-19,6"
    ],
    VerificationTest[
      f[Sin[x]],
      Sin[x],
      TimeConstraint -> timeLimit,
      TestID -> "leaves-non-E-expressions-unchanged@@Tests/FindRootOptim/normalizeExp.wlt:20,5-25,6"
    ]
  }
];

tests
