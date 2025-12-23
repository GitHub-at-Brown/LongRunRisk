BeginTestSection["normalizeExpNested"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


timeLimit = 5;

tests = With[{f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]},
  {
    VerificationTest[
      f[E^a * E^b],
      Exp[a] * Exp[b],
      TimeConstraint -> timeLimit,
      TestID -> "multiple-E-powers-in-product@@Tests/FindRootOptim/normalizeExpNested.wlt:11,5-16,6"
    ],
    VerificationTest[
      f[E^a + E^b + E^c],
      Exp[a] + Exp[b] + Exp[c],
      TimeConstraint -> timeLimit,
      TestID -> "multiple-E-powers-in-sum@@Tests/FindRootOptim/normalizeExpNested.wlt:17,5-22,6"
    ],
    VerificationTest[
      f[E^(E^a)],
      Exp[Exp[a]],
      TimeConstraint -> timeLimit,
      TestID -> "doubly-nested-E-power@@Tests/FindRootOptim/normalizeExpNested.wlt:23,5-28,6"
    ],
    VerificationTest[
      f[E^(E^(E^a))],
      Exp[Exp[Exp[a]]],
      TimeConstraint -> timeLimit,
      TestID -> "triply-nested-E-power@@Tests/FindRootOptim/normalizeExpNested.wlt:29,5-34,6"
    ],
    VerificationTest[
      f[Sin[E^a] + Cos[E^b]],
      Sin[Exp[a]] + Cos[Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-inside-trigonometric-functions@@Tests/FindRootOptim/normalizeExpNested.wlt:35,5-40,6"
    ],
    VerificationTest[
      f[Log[E^a * E^b]],
      Log[Exp[a] * Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-inside-Log@@Tests/FindRootOptim/normalizeExpNested.wlt:41,5-46,6"
    ],
    VerificationTest[
      f[(E^a)[x] * (E^b)[y]],
      Exp[a[x]] * Exp[b[y]],
      TimeConstraint -> timeLimit,
      TestID -> "multiple-E-function-applications@@Tests/FindRootOptim/normalizeExpNested.wlt:47,5-52,6"
    ],
    VerificationTest[
      f[E^(a[x] + b[x]) * E^(c[y])],
      Exp[a[x] + b[x]] * Exp[c[y]],
      TimeConstraint -> timeLimit,
      TestID -> "mixed-complex-exponents-in-product@@Tests/FindRootOptim/normalizeExpNested.wlt:53,5-58,6"
    ],
    VerificationTest[
      f[1 + E^a + E^(E^b) + (E^c)[x]],
      1 + Exp[a] + Exp[Exp[b]] + Exp[c[x]],
      TimeConstraint -> timeLimit,
      TestID -> "deeply-nested-multiple-E-forms@@Tests/FindRootOptim/normalizeExpNested.wlt:59,5-64,6"
    ],
    VerificationTest[
      f[f1[E^a, E^b] + f2[(E^c)[x], E^(E^d)]],
      f1[Exp[a], Exp[b]] + f2[Exp[c[x]], Exp[Exp[d]]],
      TimeConstraint -> timeLimit,
      TestID -> "E-forms-in-function-arguments@@Tests/FindRootOptim/normalizeExpNested.wlt:65,5-70,6"
    ],
    VerificationTest[
      f[{E^a, {E^b, E^(E^c)}}],
      {Exp[a], {Exp[b], Exp[Exp[c]]}},
      TimeConstraint -> timeLimit,
      TestID -> "E-forms-in-nested-lists@@Tests/FindRootOptim/normalizeExpNested.wlt:71,5-76,6"
    ],
    VerificationTest[
      f[(E^a)[x] + E^(b[y])],
      Exp[a[x]] + Exp[b[y]],
      TimeConstraint -> timeLimit,
      TestID -> "mixed-application-and-standard-power@@Tests/FindRootOptim/normalizeExpNested.wlt:77,5-82,6"
    ],
    VerificationTest[
      f[E^(a*E^b)],
      Exp[a*Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-power-in-exponent-expression@@Tests/FindRootOptim/normalizeExpNested.wlt:83,5-88,6"
    ],
    VerificationTest[
      f[E^a / E^b],
      Exp[a] / Exp[b],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-in-division@@Tests/FindRootOptim/normalizeExpNested.wlt:89,5-94,6"
    ],
    VerificationTest[
      f[(E^a)^2],
      (Exp[a])^2,
      TimeConstraint -> timeLimit,
      TestID -> "E-power-raised-to-power@@Tests/FindRootOptim/normalizeExpNested.wlt:95,5-100,6"
    ]
  }
];


EndTestSection[]
