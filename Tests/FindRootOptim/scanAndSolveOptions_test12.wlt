BeginTestSection["scanAndSolveOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"];
tolSameTest = Function[{actual, expected},
  Module[{a, e},
    a = actual /. {Rule[_, v_?NumericQ] :> v, {Rule[_, v_?NumericQ]} :> v};
    e = expected /. {Rule[_, v_?NumericQ] :> v, {Rule[_, v_?NumericQ]} :> v};
    Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^-6
  ]
];
timeLimit = 5;

(* Note: scanAndSolve internally wraps scalar inputs as lists via fnum[x] := f[{x}]
   So all functions must accept vector/list input and use z[[1]] to extract the scalar *)

VerificationTest[
    Module[{f, result1, result2},
      (* Function with small but nonzero minimum *)
      f[z_] := (z[[1]] - 2.5)^2 + 10^-7;
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
    TestID -> "accuracy-goal-affects-automatic-tolerance@@Tests/FindRootOptim/scanAndSolveOptions_test12.wlt:19,1-34,4"
  ]

EndTestSection[]
