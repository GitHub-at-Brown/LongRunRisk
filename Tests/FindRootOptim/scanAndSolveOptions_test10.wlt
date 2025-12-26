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
      (* Function with very small minimum that lands on or near a grid point *)
      f[z_] := (z[[1]] - 2.5)^2;
      df[z_] := 2*(z[[1]] - 2.5);
      result = sas[f, df, {2.0, 3.0}, "BracketGrid" -> 32, AccuracyGoal -> 8, "Tolerance" -> 10^-6];
      (* No sign changes (f is always >= 0), but minimum at x=2.5 *)
      (* With 32 bins, grid spacing is 1/32, and x=2.5 should be on or very near a grid point *)
      (* f[2.5] = 0 < tolerance, so should be captured as grid hit *)
      Length[result] >= 1 && Abs[result[[1]] - 2.5] < 0.1
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-no-sign-change-with-grid-hit@@Tests/FindRootOptim/scanAndSolveOptions.wlt:161,3-175,4"
  ]

EndTestSection[]
