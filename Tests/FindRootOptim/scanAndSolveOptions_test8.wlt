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
    Module[{f, df, result},
      f[z_] := (z[[1]] - 1.0)*(z[[1]] - 2.0)*(z[[1]] - 3.0);
      df[z_] := (z[[1]] - 2.0)*(z[[1]] - 3.0) + (z[[1]] - 1.0)*(z[[1]] - 3.0) + (z[[1]] - 1.0)*(z[[1]] - 2.0);
      result = sas[f, df, {0.5, 3.5}, "BracketGrid" -> 64, "Tolerance" -> 10^-8, AccuracyGoal -> 8];
      (* Should find exactly 3 roots, deduplicated *)
      Length[result] == 3 &&
      Abs[result[[1]] - 1.0] < 10^-6 &&
      Abs[result[[2]] - 2.0] < 10^-6 &&
      Abs[result[[3]] - 3.0] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "tolerance-deduplication-multiple-roots@@Tests/FindRootOptim/scanAndSolveOptions_test8.wlt:19,1-33,4"
  ]

EndTestSection[]
