Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

tests = With[{f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]},
  {
    VerificationTest[
      f[(E^a)[x]],
      Exp[a[x]],
      TimeConstraint -> timeLimit,
      TestID -> "wraps-E^a-application-as-Exp@@test/FindRootOptim/normalizeExp.wlt"
    ],
    VerificationTest[
      f[E^(a[x] + b[x])],
      Exp[a[x] + b[x]],
      TimeConstraint -> timeLimit,
      TestID -> "normalizes-standard-E-power@@test/FindRootOptim/normalizeExp.wlt"
    ],
    VerificationTest[
      f[Sin[x]],
      Sin[x],
      TimeConstraint -> timeLimit,
      TestID -> "leaves-non-E-expressions-unchanged@@test/FindRootOptim/normalizeExp.wlt"
    ]
  }
];

tests
