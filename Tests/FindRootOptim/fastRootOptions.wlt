BeginTestSection["fastRootOptions"]

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
  (* ===== Basic 1D tests with new API ===== *)

  (* Test Method -> "Secant" option with bounds spec *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, {1., 2.}, Jacobian -> df1, Method -> "Secant"];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "method-secant-with-jacobian@@Tests/FindRootOptim/fastRootOptions.wlt:46,3-54,4"
  ],

  VerificationTest[
    Module[{result},
      (* Use non-bracketed interval to force Secant path *)
      result = fastRoot[f2, {1.5, 3.}, Jacobian -> df2, Method -> "Secant"];
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "method-secant-nonbracketed@@Tests/FindRootOptim/fastRootOptions.wlt:56,3-65,4"
  ],

  VerificationTest[
    Module[{result},
      (* Bracketed interval should use Brent when Method -> "Brent" *)
      result = fastRoot[fcos, {1., 2.}, Jacobian -> dfcos, Method -> "Brent"];
      NumericQ[result] && Abs[Cos[result]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "method-brent-bracketed@@Tests/FindRootOptim/fastRootOptions.wlt:67,3-76,4"
  ],

  (* Test "Return" -> "Value" vs "Rule" *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, {1., 2.}, Jacobian -> df1, "Return" -> "Rule"];
      MatchQ[result, {_ -> _?NumericQ}]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "return-rule-option@@Tests/FindRootOptim/fastRootOptions.wlt:79,3-87,4"
  ],

  VerificationTest[
    Module[{result},
      (* Default "Return" -> "Value" should return numeric value *)
      result = fastRoot[f1, {1., 2.}, Jacobian -> df1];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "return-value-default@@Tests/FindRootOptim/fastRootOptions.wlt:89,3-98,4"
  ],

  VerificationTest[
    Module[{resultRule, resultValue},
      (* Verify both forms return same numeric root *)
      resultRule = fastRoot[fcos, {1., 2.}, Jacobian -> dfcos, "Return" -> "Rule"];
      resultValue = fastRoot[fcos, {1., 2.}, Jacobian -> dfcos, "Return" -> "Value"];
      Abs[resultRule[[1, 2]] - resultValue] < 10^-8
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "return-rule-vs-value-consistency@@Tests/FindRootOptim/fastRootOptions.wlt:100,3-110,4"
  ],

  (* Test without Jacobian (derivative-free) with bracketed case *)
  VerificationTest[
    Module[{result},
      (* Bracketed: f[1] = -1, f[2] = 2, root at sqrt(2) *)
      result = fastRoot[f1, {1., 2.}];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "no-jacobian-bracketed-brent@@Tests/FindRootOptim/fastRootOptions.wlt:113,3-122,4"
  ],

  VerificationTest[
    Module[{result},
      (* Bracketed trigonometric function *)
      result = fastRoot[fsin, {0., 1.}];
      NumericQ[result] && Abs[Sin[result] - 0.5] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "no-jacobian-bracketed-trig@@Tests/FindRootOptim/fastRootOptions.wlt:124,3-133,4"
  ],

  (* Test without Jacobian with non-bracketed case *)
  VerificationTest[
    Module[{result},
      (* Non-bracketed: both f[1.5] and f[3] are positive, should use Secant *)
      result = fastRoot[f2, {1.5, 3.}];
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "no-jacobian-nonbracketed-secant@@Tests/FindRootOptim/fastRootOptions.wlt:136,3-145,4"
  ],

  VerificationTest[
    Module[{result},
      (* Non-bracketed interval, both endpoints positive *)
      result = fastRoot[fexp, {0.5, 1.5}];
      NumericQ[result] && Abs[Exp[result] - 3] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "no-jacobian-nonbracketed-exp@@Tests/FindRootOptim/fastRootOptions.wlt:147,3-156,4"
  ],

  (* Test with options *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, {1., 2.}, AccuracyGoal -> 10, PrecisionGoal -> 10];
      NumericQ[result] && Abs[result^2 - 2] < 10^-9
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "high-accuracy-goals@@Tests/FindRootOptim/fastRootOptions.wlt:159,3-167,4"
  ],

  (* Test failure path when FindRoot emits messages - non-numeric function values *)
  VerificationTest[
    Module[{badF, result},
      badF[z_] := If[z[[1]] < 1.5, z[[1]]^2 - 2, Indeterminate];
      result = Quiet[fastRoot[badF, {1., 2.}, Jacobian -> df1]];
      result === $Failed
    ],
    True,
    {},
    TimeConstraint -> timeLimit,
    TestID -> "failure-nonnumeric-function-value@@Tests/FindRootOptim/fastRootOptions.wlt:170,3-180,4"
  ],

  (* Test without Jacobian with valid function successfully finds root *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fcubic, {1., 3.}];
      NumericQ[result] && Abs[result^3 - 8] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "no-jacobian-cubic-root@@Tests/FindRootOptim/fastRootOptions.wlt:183,3-191,4"
  ],

  (* Test constraint lo < hi - reversed interval should emit badbounds message *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, {2., 1.}, Jacobian -> df1];
      result === $Failed
    ],
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot::badbounds},
    TimeConstraint -> timeLimit,
    TestID -> "reversed-interval-badbounds@@Tests/FindRootOptim/fastRootOptions.wlt:194,3-203,4"
  ],

  (* Test with both Method and Return options combined *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, {1., 2.}, Jacobian -> df1,
        Method -> "Secant", "Return" -> "Value"];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "combined-method-return-options@@Tests/FindRootOptim/fastRootOptions.wlt:206,3-215,4"
  ],

  (* Test AccuracyGoal and PrecisionGoal options *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, {1., 2.}, Jacobian -> df1,
        AccuracyGoal -> 12, PrecisionGoal -> 12];
      NumericQ[result] && Abs[result^2 - 2] < 10^-11
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "high-accuracy-precision-goals@@Tests/FindRootOptim/fastRootOptions.wlt:218,3-227,4"
  ],

  (* Test MaxIterations option *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, {1., 2.}, Jacobian -> df1, MaxIterations -> 50];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "maxiterations-option@@Tests/FindRootOptim/fastRootOptions.wlt:230,3-238,4"
  ],

  (* Test Newton fallback to default when derivative is unreliable *)
  VerificationTest[
    Module[{result, badDF},
      badDF[z_] := 0;
      result = fastRoot[f1, {1., 2.}, Jacobian -> badDF];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "newton-fails-fallback@@Tests/FindRootOptim/fastRootOptions.wlt:241,3-250,4"
  ],

  (* Test edge case: very narrow interval *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, {1.41, 1.42}, Jacobian -> df1];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "narrow-interval-convergence@@Tests/FindRootOptim/fastRootOptions.wlt:253,3-261,4"
  ],

  (* Test with WorkingPrecision option *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, {1., 2.}, Jacobian -> df1,
        WorkingPrecision -> MachinePrecision];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "workingprecision-option@@Tests/FindRootOptim/fastRootOptions.wlt:264,3-273,4"
  ],

  (* Test Method -> Automatic (default) with non-bracketed - should use Secant fallback *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f2, {1.5, 3.}, Jacobian -> df2, Method -> Automatic];
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "method-automatic-nonbracketed@@Tests/FindRootOptim/fastRootOptions.wlt:276,3-284,4"
  ],

  (* Test that quiet computation works as expected *)
  VerificationTest[
    Module[{result},
      result = Quiet[fastRoot[f1, {1., 2.}, Jacobian -> df1]];
      NumericQ[result]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "quiet-computation-succeeds@@Tests/FindRootOptim/fastRootOptions.wlt:287,3-295,4"
  ],

  (* Test edge case: root at interval boundary *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f2, {1., 2.}, Jacobian -> df2];
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "root-at-boundary@@Tests/FindRootOptim/fastRootOptions.wlt:298,3-306,4"
  ],

  (* ===== Tests for 1D full spec {x0, lo, hi} ===== *)

  VerificationTest[
    Module[{result},
      result = fastRoot[f1, {1.4, 1., 2.}, Jacobian -> df1];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-full-spec-with-jacobian@@Tests/FindRootOptim/fastRootOptions.wlt:310,3-318,4"
  ],

  VerificationTest[
    Module[{result},
      result = fastRoot[f1, {1.4, 1., 2.}];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-full-spec-no-jacobian@@Tests/FindRootOptim/fastRootOptions.wlt:320,3-328,4"
  ],

  (* Test Automatic x0 in full spec *)
  VerificationTest[
    Module[{result},
      result = fastRoot[f1, {Automatic, 1., 2.}, Jacobian -> df1];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-automatic-x0@@Tests/FindRootOptim/fastRootOptions.wlt:331,3-339,4"
  ],

  (* ===== Tests for 1D x0-only spec (scalar) ===== *)

  VerificationTest[
    Module[{result},
      result = fastRoot[f1, 1.4, Jacobian -> df1];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-scalar-x0-with-jacobian@@Tests/FindRootOptim/fastRootOptions.wlt:343,3-351,4"
  ],

  VerificationTest[
    Module[{result},
      result = fastRoot[f1, 1.4];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-scalar-x0-no-jacobian@@Tests/FindRootOptim/fastRootOptions.wlt:353,3-361,4"
  ],

  (* ===== Tests for nD nested x0 syntax {{x0_1, x0_2, ...}} ===== *)

  (* Test nD x0-only with Jacobian using nested syntax *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND2, {{1.2, 1.2}}, Jacobian -> dfND2];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-with-jacobian@@Tests/FindRootOptim/fastRootOptions.wlt:366,3-374,4"
  ],

  (* Test nD x0-only without Jacobian using nested syntax *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND2, {{1.2, 1.2}}];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-no-jacobian@@Tests/FindRootOptim/fastRootOptions.wlt:377,3-385,4"
  ],

  (* Test nD nested x0 returns correct root value *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND2, {{1.5, 1.5}}, Jacobian -> dfND2];
      VectorQ[result, NumericQ] && Max[Abs[result - {expectedND2, expectedND2}]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-correct-root@@Tests/FindRootOptim/fastRootOptions.wlt:388,3-396,4"
  ],

  (* Test nD with bounds - new format {{lo1,hi1}, {lo2,hi2}} *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND2, {{0.5, 2.}, {0.5, 2.}}, Jacobian -> dfND2];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-bounds-new-format@@Tests/FindRootOptim/fastRootOptions.wlt:399,3-407,4"
  ],

  (* Test nD full spec - new format {{x01,lo1,hi1}, {x02,lo2,hi2}} *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND2, {{1.2, 0.5, 2.}, {1.2, 0.5, 2.}}, Jacobian -> dfND2];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-full-spec-new-format@@Tests/FindRootOptim/fastRootOptions.wlt:410,3-418,4"
  ],

  (* Test disambiguation: flat {a, b} is 1D bounds, not 2D x0 *)
  VerificationTest[
    Module[{result},
      (* {1.2, 1.2} as 1D bounds where a=b should fail with badbounds *)
      result = fastRoot[f1, {1.2, 1.2}, Jacobian -> df1];
      result === $Failed
    ],
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot::badbounds},
    TimeConstraint -> timeLimit,
    TestID -> "disambiguation-flat-is-1D-bounds@@Tests/FindRootOptim/fastRootOptions.wlt:421,3-431,4"
  ],

  (* Test 3D nested x0 syntax *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND3, {{0.9, 0.9, 0.9}}, Jacobian -> dfND3];
      VectorQ[result, NumericQ] && Length[result] == 3 && Max[Abs[fND3[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-3D-nested-x0@@Tests/FindRootOptim/fastRootOptions.wlt:434,3-442,4"
  ],

  (* Test nD nested x0 with Return -> Rule option *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND2, {{1.2, 1.2}}, Jacobian -> dfND2, "Return" -> "Rule"];
      MatchQ[result, {(_ -> _?NumericQ) ..}] && Length[result] == 2
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-return-rule@@Tests/FindRootOptim/fastRootOptions.wlt:445,3-453,4"
  ],

  (* Test nD with Method -> "Secant" - should skip Newton *)
  VerificationTest[
    Module[{result},
      result = fastRoot[fND2, {{1.2, 1.2}}, Jacobian -> dfND2, Method -> "Secant"];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-method-secant@@Tests/FindRootOptim/fastRootOptions.wlt:456,3-464,4"
  ],

  (* ===== Tests for Newton failure with fallback ===== *)

  (* Test nD Newton failure with fallback - bad Jacobian *)
  VerificationTest[
    Module[{result, badDfND},
      badDfND[z_] := {{0., 0.}, {0., 0.}};
      result = fastRoot[fND2, {{1.2, 1.2}}, Jacobian -> badDfND];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-newton-fails-fallback@@Tests/FindRootOptim/fastRootOptions.wlt:469,3-478,4"
  ],

  (* Test nD with bounds - Newton failure with fallback *)
  VerificationTest[
    Module[{result, badDfND},
      badDfND[z_] := {{0., 0.}, {0., 0.}};
      result = fastRoot[fND2, {{0.5, 2.}, {0.5, 2.}}, Jacobian -> badDfND];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-bounds-newton-fails-fallback@@Tests/FindRootOptim/fastRootOptions.wlt:481,3-490,4"
  ],

  (* Test 1D bracketed - Newton failure falls back to Brent *)
  VerificationTest[
    Module[{result, badDF},
      badDF[z_] := 0.;
      result = fastRoot[f1, {1., 2.}, Jacobian -> badDF];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-bracketed-newton-fails-brent-fallback@@Tests/FindRootOptim/fastRootOptions.wlt:493,3-502,4"
  ],

  (* Test 1D non-bracketed - Newton failure falls back to Secant *)
  VerificationTest[
    Module[{result, badDF},
      badDF[z_] := 0.;
      result = fastRoot[f2, {2.5, 3.}, Jacobian -> badDF];
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-nonbracketed-newton-fails-secant-fallback@@Tests/FindRootOptim/fastRootOptions.wlt:505,3-514,4"
  ],

  (* Test 3D Newton failure with fallback *)
  VerificationTest[
    Module[{result, badDfND3},
      badDfND3[z_] := {{0., 0., 0.}, {0., 0., 0.}, {0., 0., 0.}};
      result = fastRoot[fND3, {{0.9, 0.9, 0.9}}, Jacobian -> badDfND3];
      VectorQ[result, NumericQ] && Length[result] == 3 && Max[Abs[fND3[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "3D-newton-fails-fallback@@Tests/FindRootOptim/fastRootOptions.wlt:517,3-526,4"
  ],

  (* ===== Tests for error messages ===== *)

  (* Test noautox0 error when Automatic x0 without bounds *)
  VerificationTest[
    fastRoot[f1, Automatic] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot::noautox0},
    TimeConstraint -> timeLimit,
    TestID -> "error-noautox0-scalar@@Tests/FindRootOptim/fastRootOptions.wlt:531,3-537,4"
  ],

  (* Test badspec error for invalid spec *)
  VerificationTest[
    fastRoot[f1, "invalid"] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot::badspec},
    TimeConstraint -> timeLimit,
    TestID -> "error-badspec-string@@Tests/FindRootOptim/fastRootOptions.wlt:540,3-546,4"
  ],

  (* Test badbounds error for nD bounds *)
  VerificationTest[
    fastRoot[fND2, {{2., 1.}, {0.5, 2.}}, Jacobian -> dfND2] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot::badbounds},
    TimeConstraint -> timeLimit,
    TestID -> "error-badbounds-nD@@Tests/FindRootOptim/fastRootOptions.wlt:549,3-555,4"
  ]
};


EndTestSection[]
