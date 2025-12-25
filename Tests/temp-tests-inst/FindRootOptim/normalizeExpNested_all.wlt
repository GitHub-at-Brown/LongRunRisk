BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

tests = With[{f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]},
  {
    VerificationTest[
      f[E^a * E^b],
      Exp[a] * Exp[b],
      TimeConstraint -> timeLimit,
      TestID -> "multiple-E-powers-in-product@@Tests/FindRootOptim/normalizeExpNested.wlt:10,5-15,6"
    ],
    VerificationTest[
      f[E^a + E^b + E^c],
      Exp[a] + Exp[b] + Exp[c],
      TimeConstraint -> timeLimit,
      TestID -> "multiple-E-powers-in-sum@@Tests/FindRootOptim/normalizeExpNested.wlt:16,5-21,6"
    ],
    VerificationTest[
      f[E^(E^a)],
      Exp[Exp[a]],
      TimeConstraint -> timeLimit,
      TestID -> "doubly-nested-E-power@@Tests/FindRootOptim/normalizeExpNested.wlt:22,5-27,6"
    ],
    VerificationTest[
      f[E^(E^(E^a))],
      Exp[Exp[Exp[a]]],
      TimeConstraint -> timeLimit,
      TestID -> "triply-nested-E-power@@Tests/FindRootOptim/normalizeExpNested.wlt:28,5-33,6"
    ],
    VerificationTest[
      f[Sin[E^a] + Cos[E^b]],
      Sin[Exp[a]] + Cos[Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-inside-trigonometric-functions@@Tests/FindRootOptim/normalizeExpNested.wlt:34,5-39,6"
    ],
    VerificationTest[
      f[Log[E^a * E^b]],
      Log[Exp[a] * Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-inside-Log@@Tests/FindRootOptim/normalizeExpNested.wlt:40,5-45,6"
    ],
    VerificationTest[
      f[(E^a)[x] * (E^b)[y]],
      Exp[a[x]] * Exp[b[y]],
      TimeConstraint -> timeLimit,
      TestID -> "multiple-E-function-applications@@Tests/FindRootOptim/normalizeExpNested.wlt:46,5-51,6"
    ],
    VerificationTest[
      f[E^(a[x] + b[x]) * E^(c[y])],
      Exp[a[x] + b[x]] * Exp[c[y]],
      TimeConstraint -> timeLimit,
      TestID -> "mixed-complex-exponents-in-product@@Tests/FindRootOptim/normalizeExpNested.wlt:52,5-57,6"
    ],
    VerificationTest[
      f[1 + E^a + E^(E^b) + (E^c)[x]],
      1 + Exp[a] + Exp[Exp[b]] + Exp[c[x]],
      TimeConstraint -> timeLimit,
      TestID -> "deeply-nested-multiple-E-forms@@Tests/FindRootOptim/normalizeExpNested.wlt:58,5-63,6"
    ],
    VerificationTest[
      f[f1[E^a, E^b] + f2[(E^c)[x], E^(E^d)]],
      f1[Exp[a], Exp[b]] + f2[Exp[c[x]], Exp[Exp[d]]],
      TimeConstraint -> timeLimit,
      TestID -> "E-forms-in-function-arguments@@Tests/FindRootOptim/normalizeExpNested.wlt:64,5-69,6"
    ],
    VerificationTest[
      f[{E^a, {E^b, E^(E^c)}}],
      {Exp[a], {Exp[b], Exp[Exp[c]]}},
      TimeConstraint -> timeLimit,
      TestID -> "E-forms-in-nested-lists@@Tests/FindRootOptim/normalizeExpNested.wlt:70,5-75,6"
    ],
    VerificationTest[
      f[(E^a)[x] + E^(b[y])],
      Exp[a[x]] + Exp[b[y]],
      TimeConstraint -> timeLimit,
      TestID -> "mixed-application-and-standard-power@@Tests/FindRootOptim/normalizeExpNested.wlt:76,5-81,6"
    ],
    VerificationTest[
      f[E^(a*E^b)],
      Exp[a*Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-power-in-exponent-expression@@Tests/FindRootOptim/normalizeExpNested.wlt:82,5-87,6"
    ],
    VerificationTest[
      f[E^a / E^b],
      Exp[a] / Exp[b],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-in-division@@Tests/FindRootOptim/normalizeExpNested.wlt:88,5-93,6"
    ],
    VerificationTest[
      f[(E^a)^2],
      (Exp[a])^2,
      TimeConstraint -> timeLimit,
      TestID -> "E-power-raised-to-power@@Tests/FindRootOptim/normalizeExpNested.wlt:94,5-99,6"
    ]
  }
];


EndTestSection[]
