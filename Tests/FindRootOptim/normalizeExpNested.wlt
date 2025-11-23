Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d], d = DirectoryName[d]];
  pacletRoot = d;
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "Tools", "FindRootOptim.wl"}]];
  On[General::shdw];
];

timeLimit = 5;

tests = With[{f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]},
  {
    VerificationTest[
      f[E^a * E^b],
      Exp[a] * Exp[b],
      TimeConstraint -> timeLimit,
      TestID -> "multiple-E-powers-in-product@@test/FindRootOptim/normalizeExpNested.wlt"
    ],
    VerificationTest[
      f[E^a + E^b + E^c],
      Exp[a] + Exp[b] + Exp[c],
      TimeConstraint -> timeLimit,
      TestID -> "multiple-E-powers-in-sum@@test/FindRootOptim/normalizeExpNested.wlt"
    ],
    VerificationTest[
      f[E^(E^a)],
      Exp[Exp[a]],
      TimeConstraint -> timeLimit,
      TestID -> "doubly-nested-E-power@@test/FindRootOptim/normalizeExpNested.wlt"
    ],
    VerificationTest[
      f[E^(E^(E^a))],
      Exp[Exp[Exp[a]]],
      TimeConstraint -> timeLimit,
      TestID -> "triply-nested-E-power@@test/FindRootOptim/normalizeExpNested.wlt"
    ],
    VerificationTest[
      f[Sin[E^a] + Cos[E^b]],
      Sin[Exp[a]] + Cos[Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-inside-trigonometric-functions@@test/FindRootOptim/normalizeExpNested.wlt"
    ],
    VerificationTest[
      f[Log[E^a * E^b]],
      Log[Exp[a] * Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-inside-Log@@test/FindRootOptim/normalizeExpNested.wlt"
    ],
    VerificationTest[
      f[(E^a)[x] * (E^b)[y]],
      Exp[a[x]] * Exp[b[y]],
      TimeConstraint -> timeLimit,
      TestID -> "multiple-E-function-applications@@test/FindRootOptim/normalizeExpNested.wlt"
    ],
    VerificationTest[
      f[E^(a[x] + b[x]) * E^(c[y])],
      Exp[a[x] + b[x]] * Exp[c[y]],
      TimeConstraint -> timeLimit,
      TestID -> "mixed-complex-exponents-in-product@@test/FindRootOptim/normalizeExpNested.wlt"
    ],
    VerificationTest[
      f[1 + E^a + E^(E^b) + (E^c)[x]],
      1 + Exp[a] + Exp[Exp[b]] + Exp[c[x]],
      TimeConstraint -> timeLimit,
      TestID -> "deeply-nested-multiple-E-forms@@test/FindRootOptim/normalizeExpNested.wlt"
    ],
    VerificationTest[
      f[f1[E^a, E^b] + f2[(E^c)[x], E^(E^d)]],
      f1[Exp[a], Exp[b]] + f2[Exp[c[x]], Exp[Exp[d]]],
      TimeConstraint -> timeLimit,
      TestID -> "E-forms-in-function-arguments@@test/FindRootOptim/normalizeExpNested.wlt"
    ],
    VerificationTest[
      f[{E^a, {E^b, E^(E^c)}}],
      {Exp[a], {Exp[b], Exp[Exp[c]]}},
      TimeConstraint -> timeLimit,
      TestID -> "E-forms-in-nested-lists@@test/FindRootOptim/normalizeExpNested.wlt"
    ],
    VerificationTest[
      f[(E^a)[x] + E^(b[y])],
      Exp[a[x]] + Exp[b[y]],
      TimeConstraint -> timeLimit,
      TestID -> "mixed-application-and-standard-power@@test/FindRootOptim/normalizeExpNested.wlt"
    ],
    VerificationTest[
      f[E^(a*E^b)],
      Exp[a*Exp[b]],
      TimeConstraint -> timeLimit,
      TestID -> "E-power-in-exponent-expression@@test/FindRootOptim/normalizeExpNested.wlt"
    ],
    VerificationTest[
      f[E^a / E^b],
      Exp[a] / Exp[b],
      TimeConstraint -> timeLimit,
      TestID -> "E-powers-in-division@@test/FindRootOptim/normalizeExpNested.wlt"
    ],
    VerificationTest[
      f[(E^a)^2],
      (Exp[a])^2,
      TimeConstraint -> timeLimit,
      TestID -> "E-power-raised-to-power@@test/FindRootOptim/normalizeExpNested.wlt"
    ]
  }
];

tests
