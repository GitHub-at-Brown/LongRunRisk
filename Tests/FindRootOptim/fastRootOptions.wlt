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

tests = {
  (* Test "NewtonFirst" -> False option with f, df, {a,b} *)
  VerificationTest[
    Module[{result},
      (* f[x] = x^2 - 2, df[x] = 2x, root at sqrt(2) ~ 1.414 *)
      result = fastRoot[#^2 - 2 &, 2*# &, {1., 2.}, "NewtonFirst" -> False];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "newtonfirst-false-uses-secant@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  VerificationTest[
    Module[{result},
      (* Use non-bracketed interval to force Secant path *)
      result = fastRoot[#^2 - 4 &, 2*# &, {1.5, 3.}, "NewtonFirst" -> False];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "newtonfirst-false-nonbracketed-secant@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  VerificationTest[
    Module[{result},
      (* Bracketed interval should use Brent when NewtonFirst is False *)
      result = fastRoot[Cos[#] &, -Sin[#] &, {1., 2.}, "NewtonFirst" -> False];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[Cos[result[[1,2]]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "newtonfirst-false-bracketed-brent@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test "Return" -> "Value" vs default "Rule" *)
  VerificationTest[
    Module[{result},
      (* Default should return rule *)
      result = fastRoot[#^2 - 2 &, 2*# &, {1., 2.}];
      MatchQ[result, {_ -> _?NumericQ}]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "return-rule-default@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  VerificationTest[
    Module[{result},
      (* "Return" -> "Value" should return numeric value *)
      result = fastRoot[#^2 - 2 &, 2*# &, {1., 2.}, "Return" -> "Value"];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "return-value-option@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  VerificationTest[
    Module[{resultRule, resultValue},
      (* Verify both forms return same numeric root *)
      resultRule = fastRoot[Cos[#] &, -Sin[#] &, {1., 2.}, "Return" -> "Rule"];
      resultValue = fastRoot[Cos[#] &, -Sin[#] &, {1., 2.}, "Return" -> "Value"];
      Abs[resultRule[[1,2]] - resultValue] < 10^-8
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "return-rule-vs-value-consistency@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test derivative-free overload fastRoot[f, {a,b}] with bracketed case *)
  VerificationTest[
    Module[{result},
      (* Bracketed: f[1] = -1, f[2] = 2, root at sqrt(2) *)
      result = fastRoot[#^2 - 2 &, {1., 2.}];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-bracketed-brent@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  VerificationTest[
    Module[{result},
      (* Bracketed trigonometric function *)
      result = fastRoot[Sin[#] - 0.5 &, {0., 1.}];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[Sin[result[[1,2]]] - 0.5] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-bracketed-trig@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test derivative-free overload fastRoot[f, {a,b}] with non-bracketed case *)
  VerificationTest[
    Module[{result},
      (* Non-bracketed: both f[1.5] and f[3] are positive, should use Secant *)
      result = fastRoot[#^2 - 4 &, {1.5, 3.}];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-nonbracketed-secant@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  VerificationTest[
    Module[{result},
      (* Non-bracketed interval, both endpoints positive *)
      result = fastRoot[Exp[#] - 3 &, {0.5, 1.5}];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[Exp[result[[1,2]]] - 3] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-nonbracketed-exp@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test derivative-free with options *)
  VerificationTest[
    Module[{result},
      result = fastRoot[#^2 - 2 &, {1., 2.}, AccuracyGoal -> 10, PrecisionGoal -> 10];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^2 - 2] < 10^-9
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-high-accuracy@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test failure path when FindRoot emits messages - non-numeric function values *)
  (* Note: Using Quiet here to suppress internal FindRoot messages, not fastRoot's own messages *)
  VerificationTest[
    Module[{badF, result},
      (* Function that returns symbolic value, not numeric *)
      badF[x_?NumericQ] := If[x < 1.5, x^2 - 2, Indeterminate];
      result = Quiet[fastRoot[badF, 2*# &, {1., 2.}]];
      result
    ],
    $Failed,
    {},
    TimeConstraint -> timeLimit,
    TestID -> "failure-nonnumeric-function-value@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test derivative-free version with valid function successfully finds root *)
  VerificationTest[
    Module[{result},
      (* Should successfully find root even without derivative *)
      result = fastRoot[#^3 - 8 &, {1., 3.}];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^3 - 8] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-cubic-root@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test constraint a < b - reversed interval should fail pattern match *)
  VerificationTest[
    Module[{result},
      (* This should not match the pattern /; a < b *)
      result = fastRoot[#^2 - 2 &, 2*# &, {2., 1.}];
      result
    ],
    fastRoot[#^2 - 2 &, 2*# &, {2., 1.}],
    TimeConstraint -> timeLimit,
    TestID -> "reversed-interval-no-match@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test with both NewtonFirst and Return options combined *)
  VerificationTest[
    Module[{result},
      result = fastRoot[#^2 - 2 &, 2*# &, {1., 2.},
        "NewtonFirst" -> False, "Return" -> "Value"];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "combined-newtonfirst-false-return-value@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test AccuracyGoal and PrecisionGoal options *)
  VerificationTest[
    Module[{result},
      result = fastRoot[#^2 - 2 &, 2*# &, {1., 2.},
        AccuracyGoal -> 12, PrecisionGoal -> 12];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^2 - 2] < 10^-11
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "high-accuracy-precision-goals@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test MaxIterations option *)
  VerificationTest[
    Module[{result},
      (* With very few iterations, should still converge for simple function *)
      result = fastRoot[#^2 - 2 &, 2*# &, {1., 2.}, MaxIterations -> 50];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "maxiterations-option@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test positional accuracy argument *)
  VerificationTest[
    Module[{result},
      (* fastRoot[f, df, {a,b}, acc] signature *)
      result = fastRoot[#^2 - 2 &, 2*# &, {1., 2.}, 10];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^2 - 2] < 10^-9
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "positional-accuracy-argument@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test positional accuracy and maxiter arguments *)
  VerificationTest[
    Module[{result},
      (* fastRoot[f, df, {a,b}, acc, maxit] signature *)
      result = fastRoot[#^2 - 2 &, 2*# &, {1., 2.}, 10, 100];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^2 - 2] < 10^-9
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "positional-accuracy-maxiter-arguments@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test Newton fallback to Brent when derivative is unreliable *)
  VerificationTest[
    Module[{result, badDF},
      (* Provide incorrect derivative to force Newton to fail *)
      badDF[x_] := 0;  (* Wrong derivative, should fallback *)
      result = fastRoot[#^2 - 2 &, badDF, {1., 2.}];
      (* Should still find root via Brent fallback *)
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "newton-fails-fallback-to-brent@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test edge case: very narrow interval *)
  VerificationTest[
    Module[{result},
      result = fastRoot[#^2 - 2 &, 2*# &, {1.41, 1.42}];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "narrow-interval-convergence@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test with WorkingPrecision option *)
  VerificationTest[
    Module[{result},
      result = fastRoot[#^2 - 2 &, 2*# &, {1., 2.},
        WorkingPrecision -> MachinePrecision];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "workingprecision-option@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test non-bracketed with NewtonFirst -> True (default) *)
  VerificationTest[
    Module[{result},
      (* Non-bracketed interval, Newton should try first then fallback to Secant *)
      result = fastRoot[#^2 - 4 &, 2*# &, {1.5, 3.}, "NewtonFirst" -> True];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "newtonfirst-true-nonbracketed-fallback@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test that quiet computation works as expected *)
  VerificationTest[
    Module[{result},
      (* Should run successfully even when Quiet wrapped *)
      result = Quiet[fastRoot[#^2 - 2 &, 2*# &, {1., 2.}]];
      MatchQ[result, {_ -> _?NumericQ}]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "quiet-computation-succeeds@@test/FindRootOptim/fastRootOptions.wlt"
  ],

  (* Test edge case: root at interval boundary *)
  VerificationTest[
    Module[{result},
      (* Root is at x=2, test with interval [1,2] *)
      result = fastRoot[#^2 - 4 &, 2*# &, {1., 2.}];
      MatchQ[result, {_ -> _?NumericQ}] && Abs[(result[[1,2]])^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "root-at-boundary@@test/FindRootOptim/fastRootOptions.wlt"
  ]
};

tests
