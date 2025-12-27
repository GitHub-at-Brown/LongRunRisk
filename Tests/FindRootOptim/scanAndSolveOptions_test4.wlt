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
      f[z_] := (z[[1]] - 1.5)*(z[[1]] - 2.5);
      df[z_] := 2*z[[1]] - 4.0;
      result = sas[f, df, {1.0, 3.0}, "BracketGrid" -> 4, AccuracyGoal -> 8];
      (* With only 4 bins, should still find both roots via sign changes *)
      Length[result] == 2 &&
      Min[Abs[result[[1]] - 1.5], Abs[result[[1]] - 2.5]] < 10^-6 &&
      Min[Abs[result[[2]] - 1.5], Abs[result[[2]] - 2.5]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "custom-bracket-grid-very-coarse@@Tests/FindRootOptim/scanAndSolveOptions_test4.wlt:19,1-32,4"
  ]

EndTestSection[]
