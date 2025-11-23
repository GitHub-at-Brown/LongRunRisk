Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`"];

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

sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"];
tolSameTest = Function[{actual, expected},
  Module[{a, e},
    a = actual /. {Rule[_, v_?NumericQ] :> v, {Rule[_, v_?NumericQ]} :> v};
    e = expected /. {Rule[_, v_?NumericQ] :> v, {Rule[_, v_?NumericQ]} :> v};
    Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^-6
  ]
];
timeLimit = 5;

tests = {
  (* Test: Derivative-free mode with no sign change but grid hit *)
  VerificationTest[
    Module[{f, result},
      f[x_?NumericQ] := (x - 2.5)^2;
      result = sas[f, {2.0, 3.0}, "BracketGrid" -> 32, AccuracyGoal -> 8];
      (* With 32 bins between 2.0 and 3.0, one grid point should land very close to 2.5 *)
      (* Grid points: 2.0, 2.03125, 2.0625, ..., 2.5, ..., 3.0 (33 points total) *)
      (* The parabola minimum at x=2.5 should be hit exactly or nearly *)
      Length[result] > 0 && result[[1]] >= 2.0 && result[[1]] <= 3.0
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-grid-hit@@test/FindRootOptim/scanAndSolveOptions.wlt"
  ],

  (* Test: Derivative-free mode finds actual zero near grid point *)
  VerificationTest[
    Module[{f, result},
      f[x_?NumericQ] := x - 2.5;
      result = sas[f, {2.0, 3.0}, "BracketGrid" -> 16, AccuracyGoal -> 8];
      Length[result] == 1 && Abs[result[[1]] - 2.5] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-finds-zero@@test/FindRootOptim/scanAndSolveOptions.wlt"
  ],

  (* Test: Custom BracketGrid option with coarser grid *)
  VerificationTest[
    Module[{f, df, result1, result2},
      f[x_?NumericQ] := Sin[10*x];
      df[x_?NumericQ] := 10*Cos[10*x];
      (* Fine grid should find more roots *)
      result1 = sas[f, df, {0.0, 1.0}, "BracketGrid" -> 8, AccuracyGoal -> 6];
      result2 = sas[f, df, {0.0, 1.0}, "BracketGrid" -> 64, AccuracyGoal -> 6];
      (* More bins should find more or equal number of roots *)
      Length[result2] >= Length[result1]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "custom-bracket-grid-coarse-vs-fine@@test/FindRootOptim/scanAndSolveOptions.wlt"
  ],

  (* Test: Custom BracketGrid with very coarse grid *)
  VerificationTest[
    Module[{f, df, result},
      f[x_?NumericQ] := (x - 1.5)*(x - 2.5);
      df[x_?NumericQ] := 2*x - 4.0;
      result = sas[f, df, {1.0, 3.0}, "BracketGrid" -> 4, AccuracyGoal -> 8];
      (* With only 4 bins, should still find both roots via sign changes *)
      Length[result] == 2 &&
      Min[Abs[result[[1]] - 1.5], Abs[result[[1]] - 2.5]] < 10^-6 &&
      Min[Abs[result[[2]] - 1.5], Abs[result[[2]] - 2.5]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "custom-bracket-grid-very-coarse@@test/FindRootOptim/scanAndSolveOptions.wlt"
  ],

  (* Test: Custom Tolerance option for grid hits *)
  VerificationTest[
    Module[{f, result},
      f[x_?NumericQ] := (x - 2.5)^4;
      (* With very tight tolerance, grid points far from exact zero won't count *)
      result = sas[f, {2.0, 3.0}, "BracketGrid" -> 32, "Tolerance" -> 10^-12, AccuracyGoal -> 8];
      (* Function value at grid points will be > 10^-12 except very close to 2.5 *)
      (* With 32 subdivisions, increment is 1/32 = 0.03125 *)
      (* f[2.5 +/- 0.03125]^4 = (0.03125)^4 ~ 9.5e-7, which is > 10^-12 *)
      (* So we shouldn't get many (if any) grid hits with such tight tolerance *)
      Length[result] <= 1
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "custom-tolerance-tight@@test/FindRootOptim/scanAndSolveOptions.wlt"
  ],

  (* Test: Custom Tolerance option for relaxed grid hits *)
  VerificationTest[
    Module[{f, result},
      f[x_?NumericQ] := (x - 2.5)^2;
      (* With relaxed tolerance, more grid points should qualify as "zeros" *)
      result = sas[f, {2.0, 3.0}, "BracketGrid" -> 16, "Tolerance" -> 0.01, AccuracyGoal -> 8];
      (* f[x] = (x-2.5)^2 < 0.01 when |x-2.5| < 0.1 *)
      (* With grid spacing ~0.0625, multiple points near 2.5 should qualify *)
      Length[result] >= 1
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "custom-tolerance-relaxed@@test/FindRootOptim/scanAndSolveOptions.wlt"
  ],

  (* Test: Tolerance-based deduplication of solutions *)
  VerificationTest[
    Module[{f, df, result},
      f[x_?NumericQ] := Sin[x];
      df[x_?NumericQ] := Cos[x];
      (* Pi is near a grid point with certain grid sizes *)
      (* The deduplication should prevent reporting the same root multiple times *)
      result = sas[f, df, {3.0, 3.2}, "BracketGrid" -> 32, "Tolerance" -> 10^-6, AccuracyGoal -> 8];
      (* Should find exactly one root near Pi, not duplicates *)
      Length[result] == 1 && Abs[result[[1]] - Pi] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "tolerance-deduplication-single-root@@test/FindRootOptim/scanAndSolveOptions.wlt"
  ],

  (* Test: Tolerance-based deduplication with multiple roots *)
  VerificationTest[
    Module[{f, df, result},
      f[x_?NumericQ] := (x - 1.0)*(x - 2.0)*(x - 3.0);
      df[x_?NumericQ] := (x - 2.0)*(x - 3.0) + (x - 1.0)*(x - 3.0) + (x - 1.0)*(x - 2.0);
      result = sas[f, df, {0.5, 3.5}, "BracketGrid" -> 64, "Tolerance" -> 10^-8, AccuracyGoal -> 8];
      (* Should find exactly 3 roots, deduplicated *)
      Length[result] == 3 &&
      Abs[result[[1]] - 1.0] < 10^-6 &&
      Abs[result[[2]] - 2.0] < 10^-6 &&
      Abs[result[[3]] - 3.0] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "tolerance-deduplication-multiple-roots@@test/FindRootOptim/scanAndSolveOptions.wlt"
  ],

  (* Test: Derivative provided but no sign changes, returns near-zero grid hits only *)
  VerificationTest[
    Module[{f, df, result},
      (* Function with no zeros in the interval, but with small minimum *)
      f[x_?NumericQ] := (x - 2.5)^2 + 10^-6;
      df[x_?NumericQ] := 2*(x - 2.5);
      result = sas[f, df, {2.0, 3.0}, "BracketGrid" -> 32, AccuracyGoal -> 8, "Tolerance" -> 10^-8];
      (* No sign changes, and minimum value is 10^-6 > 10^-8 (tolerance) *)
      (* Should return empty since no grid hits are within tolerance *)
      Length[result] == 0
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-no-sign-change-no-hits@@test/FindRootOptim/scanAndSolveOptions.wlt"
  ],

  (* Test: Derivative provided but no sign changes, with grid hit at minimum *)
  VerificationTest[
    Module[{f, df, result},
      (* Function with very small minimum that lands on or near a grid point *)
      f[x_?NumericQ] := (x - 2.5)^2;
      df[x_?NumericQ] := 2*(x - 2.5);
      result = sas[f, df, {2.0, 3.0}, "BracketGrid" -> 32, AccuracyGoal -> 8, "Tolerance" -> 10^-6];
      (* No sign changes (f is always >= 0), but minimum at x=2.5 *)
      (* With 32 bins, grid spacing is 1/32, and x=2.5 should be on or very near a grid point *)
      (* f[2.5] = 0 < tolerance, so should be captured as grid hit *)
      Length[result] >= 1 && Abs[result[[1]] - 2.5] < 0.1
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-no-sign-change-with-grid-hit@@test/FindRootOptim/scanAndSolveOptions.wlt"
  ],

  (* Test: Derivative-free mode with no sign changes and no grid hits *)
  VerificationTest[
    Module[{f, result},
      (* Function with no zeros and minimum well above tolerance *)
      f[x_?NumericQ] := (x - 2.5)^2 + 1.0;
      result = sas[f, {2.0, 3.0}, "BracketGrid" -> 16, AccuracyGoal -> 8];
      (* No sign changes, all values > 1.0, should return empty *)
      Length[result] == 0
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-no-hits-no-sign-change@@test/FindRootOptim/scanAndSolveOptions.wlt"
  ],

  (* Test: AccuracyGoal affects automatic tolerance *)
  VerificationTest[
    Module[{f, result1, result2},
      (* Function with small but nonzero minimum *)
      f[x_?NumericQ] := (x - 2.5)^2 + 10^-7;
      (* AccuracyGoal -> 6 means automatic tolerance = 10^-6 *)
      result1 = sas[f, {2.0, 3.0}, "BracketGrid" -> 32, AccuracyGoal -> 6];
      (* AccuracyGoal -> 8 means automatic tolerance = 10^-8 *)
      result2 = sas[f, {2.0, 3.0}, "BracketGrid" -> 32, AccuracyGoal -> 8];
      (* Minimum value 10^-7 is < 10^-6 but > 10^-8 *)
      (* So result1 should find grid hit, result2 should not *)
      Length[result1] > Length[result2]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "accuracy-goal-affects-automatic-tolerance@@test/FindRootOptim/scanAndSolveOptions.wlt"
  ],

  (* Test: Multiple roots found with custom grid and tolerance *)
  VerificationTest[
    Module[{f, df, result},
      f[x_?NumericQ] := Sin[2*Pi*x];
      df[x_?NumericQ] := 2*Pi*Cos[2*Pi*x];
      result = sas[f, df, {0.0, 2.5}, "BracketGrid" -> 50, "Tolerance" -> 10^-6, AccuracyGoal -> 8];
      (* Should find zeros at x = 0, 0.5, 1.0, 1.5, 2.0, 2.5 (but 0 may be excluded if at boundary) *)
      (* Depending on sign changes detected, should find 4-6 roots *)
      Length[result] >= 4 && Length[result] <= 6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "multiple-roots-custom-options@@test/FindRootOptim/scanAndSolveOptions.wlt"
  ]
};

End[];
FernandoDuarte`LongRunRisk`Tests`FindRootOptim`tests
