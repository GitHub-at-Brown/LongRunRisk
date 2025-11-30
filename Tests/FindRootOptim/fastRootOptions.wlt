Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


(* Use the public symbol *)
fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot;
timeLimit = 5;

(* Define robust numeric comparison for rules *)
tolSameTest = Function[{actual, expected},
  Module[{a, e},
    (* Extract numeric values from rules, lists of rules, or plain numbers *)
    a = actual /. {Rule[_, v_?NumericQ] :> v, {Rule[_, v_?NumericQ]} :> v};
    e = expected /. {Rule[_, v_?NumericQ] :> v, {Rule[_, v_?NumericQ]} :> v};
    (* Ensure we have lists for Flatten - avoids Flatten::normal warnings *)
    Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^-6
  ]
];

(* Helper functions that take list argument, consistent with bindUnary API *)
f1[z_] := z[[1]]^2 - 2;           (* root at sqrt(2) ~ 1.414 *)
df1[z_] := 2*z[[1]];
f2[z_] := z[[1]]^2 - 4;           (* root at 2 *)
df2[z_] := 2*z[[1]];
fcos[z_] := Cos[z[[1]]];
dfcos[z_] := -Sin[z[[1]]];
fsin[z_] := Sin[z[[1]]] - 0.5;
fexp[z_] := Exp[z[[1]]] - 3;
fcubic[z_] := z[[1]]^3 - 8;       (* root at 2 *)

(* nD helper functions for testing nested x0 syntax *)
(* 2D system: x^2 + y - 3 = 0, x + y^2 - 3 = 0, symmetric root at x = y = (-1+Sqrt[13])/2 ~ 1.3028 *)
fND2[z_] := {z[[1]]^2 + z[[2]] - 3, z[[1]] + z[[2]]^2 - 3};
dfND2[z_] := {{2*z[[1]], 1}, {1, 2*z[[2]]}};
expectedND2 = (-1 + Sqrt[13])/2 // N;  (* ~ 1.3027756377319946 *)

(* 3D system for higher-dimension test *)
fND3[z_] := {z[[1]] + z[[2]] + z[[3]] - 3, z[[1]]*z[[2]] - 1, z[[2]]*z[[3]] - 1};  (* root at (1,1,1) *)
dfND3[z_] := {{1, 1, 1}, {z[[2]], z[[1]], 0}, {0, z[[3]], z[[2]]}};

tests = {
  (* Test "NewtonFirst" -> False option with f, df, {a,b} *)
  VerificationTest[
    Module[{result},
      (* f[x] = x^2 - 2, df[x] = 2x, root at sqrt(2) ~ 1.414 *)
      result = fastRoot[f1, df1, {1., 2.}, "NewtonFirst" -> False];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "newtonfirst-false-uses-secant"
  ],

  VerificationTest[
    Module[{result},
      (* Use non-bracketed interval to force Secant path *)
      result = fastRoot[f2, df2, {1.5, 3.}, "NewtonFirst" -> False];
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "newtonfirst-false-nonbracketed-secant"
  ],

  VerificationTest[
    Module[{result},
      (* Bracketed interval should use Brent when NewtonFirst is False *)
      result = fastRoot[fcos, dfcos, {1., 2.}, "NewtonFirst" -> False];
      NumericQ[result] && Abs[Cos[result]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "newtonfirst-false-bracketed-brent"
  ],

  (* Test "Return" -> "Value" vs "Rule" *)
  VerificationTest[
    Module[{result},
      (* "Return" -> "Rule" should return rule *)
      result = fastRoot[f1, df1, {1., 2.}, "Return" -> "Rule"];
      MatchQ[result, {_ -> _?NumericQ}]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "return-rule-option"
  ],

  VerificationTest[
    Module[{result},
      (* Default "Return" -> "Value" should return numeric value *)
      result = fastRoot[f1, df1, {1., 2.}];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "return-value-default"
  ],

  VerificationTest[
    Module[{resultRule, resultValue},
      (* Verify both forms return same numeric root *)
      resultRule = fastRoot[fcos, dfcos, {1., 2.}, "Return" -> "Rule"];
      resultValue = fastRoot[fcos, dfcos, {1., 2.}, "Return" -> "Value"];
      Abs[resultRule[[1,2]] - resultValue] < 10^-8
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "return-rule-vs-value-consistency"
  ],

  (* Test derivative-free overload fastRoot[f, {a,b}] with bracketed case *)
  VerificationTest[
    Module[{result},
      (* Bracketed: f[1] = -1, f[2] = 2, root at sqrt(2) *)
      result = fastRoot[f1, {1., 2.}];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-bracketed-brent"
  ],

  VerificationTest[
    Module[{result},
      (* Bracketed trigonometric function *)
      result = fastRoot[fsin, {0., 1.}];
      NumericQ[result] && Abs[Sin[result] - 0.5] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-bracketed-trig"
  ],

  (* Test derivative-free overload fastRoot[f, {a,b}] with non-bracketed case *)
  VerificationTest[
    Module[{result},
      (* Non-bracketed: both f[1.5] and f[3] are positive, should use Secant *)
      result = fastRoot[f2, {1.5, 3.}];
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-nonbracketed-secant"
  ],

  VerificationTest[
    Module[{result},
      (* Non-bracketed interval, both endpoints positive *)
      result = fastRoot[fexp, {0.5, 1.5}];
      NumericQ[result] && Abs[Exp[result] - 3] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-nonbracketed-exp"
  ],

  (* Test derivative-free with options *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, {1., 2.}, AccuracyGoal -> 10, PrecisionGoal -> 10];
      NumericQ[result] && Abs[result^2 - 2] < 10^-9
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-high-accuracy"
  ],

  (* Test failure path when FindRoot emits messages - non-numeric function values *)
  VerificationTest[
    Module[{badF, result},
      (* Function that returns symbolic value, not numeric *)
      badF[z_] := If[z[[1]] < 1.5, z[[1]]^2 - 2, Indeterminate];
      result = Quiet[fastRoot[badF, df1, {1., 2.}]];
      result
    ],
    $Failed,
    {},
    TimeConstraint -> timeLimit,
    TestID -> "failure-nonnumeric-function-value"
  ],

  (* Test derivative-free version with valid function successfully finds root *)
  VerificationTest[
    Module[{result},
      (* Should successfully find root even without derivative *)
      result = fastRoot[fcubic, {1., 3.}];
      NumericQ[result] && Abs[result^3 - 8] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-cubic-root"
  ],

  (* Test constraint a < b - reversed interval should emit badbnds message *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, df1, {2., 1.}];
      result
    ],
    $Failed,
    {fastRoot::badbnds},
    TimeConstraint -> timeLimit,
    TestID -> "reversed-interval-badbnds"
  ],

  (* Test with both NewtonFirst and Return options combined *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, df1, {1., 2.},
        "NewtonFirst" -> False, "Return" -> "Value"];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "combined-newtonfirst-false-return-value"
  ],

  (* Test AccuracyGoal and PrecisionGoal options *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, df1, {1., 2.},
        AccuracyGoal -> 12, PrecisionGoal -> 12];
      NumericQ[result] && Abs[result^2 - 2] < 10^-11
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "high-accuracy-precision-goals"
  ],

  (* Test MaxIterations option *)
  VerificationTest[
    Module[{result},
      (* With very few iterations, should still converge for simple function *)
      result = fastRoot[f1, df1, {1., 2.}, MaxIterations -> 50];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "maxiterations-option"
  ],

  (* Test positional accuracy argument *)
  VerificationTest[
    Module[{result},
      (* fastRoot[f, df, {a,b}, acc] signature *)
      result = fastRoot[f1, df1, {1., 2.}, 10];
      NumericQ[result] && Abs[result^2 - 2] < 10^-9
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "positional-accuracy-argument"
  ],

  (* Test positional accuracy and maxiter arguments *)
  VerificationTest[
    Module[{result},
      (* fastRoot[f, df, {a,b}, acc, maxit] signature *)
      result = fastRoot[f1, df1, {1., 2.}, 10, 100];
      NumericQ[result] && Abs[result^2 - 2] < 10^-9
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "positional-accuracy-maxiter-arguments"
  ],

  (* Test Newton fallback to default when derivative is unreliable *)
  VerificationTest[
    Module[{result, badDF},
      (* Provide incorrect derivative to force Newton to fail *)
      badDF[z_] := 0;  (* Wrong derivative, should fallback *)
      result = fastRoot[f1, badDF, {1., 2.}];
      (* Should still find root via fallback *)
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "newton-fails-fallback"
  ],

  (* Test edge case: very narrow interval *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, df1, {1.41, 1.42}];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "narrow-interval-convergence"
  ],

  (* Test with WorkingPrecision option *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, df1, {1., 2.},
        WorkingPrecision -> MachinePrecision];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "workingprecision-option"
  ],

  (* Test non-bracketed with NewtonFirst -> True (default) *)
  VerificationTest[
    Module[{result},
      (* Non-bracketed interval, Newton should try first then fallback to Secant *)
      result = fastRoot[f2, df2, {1.5, 3.}, "NewtonFirst" -> True];
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "newtonfirst-true-nonbracketed-fallback"
  ],

  (* Test that quiet computation works as expected *)
  VerificationTest[
    Module[{result},
      (* Should run successfully even when Quiet wrapped *)
      result = Quiet[fastRoot[f1, df1, {1., 2.}]];
      NumericQ[result]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "quiet-computation-succeeds"
  ],

  (* Test edge case: root at interval boundary *)
  VerificationTest[
    Module[{result},
      (* Root is at x=2, test with interval [1,2] *)
      result = fastRoot[f2, df2, {1., 2.}];
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "root-at-boundary"
  ],

  (* ===== Tests for nD nested x0 syntax {{x0_1, x0_2, ...}} ===== *)

  (* Test nD x0-only with derivative using nested syntax *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND2, dfND2, {{1.2, 1.2}}];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-with-derivative"
  ],

  (* Test nD x0-only without derivative using nested syntax *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND2, {{1.2, 1.2}}];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-no-derivative"
  ],

  (* Test nD nested x0 returns correct root value *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND2, dfND2, {{1.5, 1.5}}];
      VectorQ[result, NumericQ] && Max[Abs[result - {expectedND2, expectedND2}]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-correct-root"
  ],

  (* Test nD with bounds still works *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND2, dfND2, {{0.5, 0.5}, {2., 2.}}];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-bounds-still-works"
  ],

  (* Test disambiguation: flat {a, b} is 1D bounds, not 2D x0 *)
  VerificationTest[
    Module[{result},
      (* {1.2, 1.2} as 1D bounds where a=b should fail with badbnds *)
      result = fastRoot[f1, df1, {1.2, 1.2}];
      result === $Failed
    ],
    True,
    {fastRoot::badbnds},
    TimeConstraint -> timeLimit,
    TestID -> "disambiguation-flat-is-1D-bounds"
  ],

  (* Test 3D nested x0 syntax *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND3, dfND3, {{0.9, 0.9, 0.9}}];
      VectorQ[result, NumericQ] && Length[result] == 3 && Max[Abs[fND3[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-3D-nested-x0"
  ],

  (* Test nD nested x0 with Return -> Rule option *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND2, dfND2, {{1.2, 1.2}}, "Return" -> "Rule"];
      MatchQ[result, {(_ -> _?NumericQ) ..}] && Length[result] == 2
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-return-rule"
  ],

  (* Test nD nested x0 with NewtonFirst -> False *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND2, dfND2, {{1.2, 1.2}}, "NewtonFirst" -> False];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-newtonfirst-false"
  ],

  (* ===== Tests for Newton failure with fallback ===== *)

  (* Test nD Newton failure with fallback - bad Jacobian *)
  VerificationTest[
    Module[{result, badDfND},
      (* Jacobian that returns zeros - Newton will fail *)
      badDfND[z_] := {{0., 0.}, {0., 0.}};
      result = fastRoot[fND2, badDfND, {{1.2, 1.2}}];
      (* Should still find root via fallback to default method *)
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-newton-fails-fallback"
  ],

  (* Test nD with bounds - Newton failure with fallback *)
  VerificationTest[
    Module[{result, badDfND},
      badDfND[z_] := {{0., 0.}, {0., 0.}};
      result = fastRoot[fND2, badDfND, {{0.5, 0.5}, {2., 2.}}];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-bounds-newton-fails-fallback"
  ],

  (* Test 1D bracketed - Newton failure falls back to Brent *)
  VerificationTest[
    Module[{result, badDF},
      (* Bad derivative causes Newton to fail *)
      badDF[z_] := 0.;
      (* Bracketed interval: f1[1] < 0, f1[2] > 0 *)
      result = fastRoot[f1, badDF, {1., 2.}];
      (* Should fall back to Brent and find root *)
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-bracketed-newton-fails-brent-fallback"
  ],

  (* Test 1D non-bracketed - Newton failure falls back to Secant *)
  VerificationTest[
    Module[{result, badDF},
      badDF[z_] := 0.;
      (* Non-bracketed: both f2[2.5] and f2[3] are positive *)
      result = fastRoot[f2, badDF, {2.5, 3.}];
      (* Should fall back to Secant and find root at 2 *)
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-nonbracketed-newton-fails-secant-fallback"
  ],

  (* Test 3D Newton failure with fallback *)
  VerificationTest[
    Module[{result, badDfND3},
      badDfND3[z_] := {{0., 0., 0.}, {0., 0., 0.}, {0., 0., 0.}};
      result = fastRoot[fND3, badDfND3, {{0.9, 0.9, 0.9}}];
      VectorQ[result, NumericQ] && Length[result] == 3 && Max[Abs[fND3[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "3D-newton-fails-fallback"
  ]
};

tests
