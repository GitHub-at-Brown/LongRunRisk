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
      (* Function with no zeros in the interval, but with small minimum *)
      f[z_] := (z[[1]] - 2.5)^2 + 10^-6;
      df[z_] := 2*(z[[1]] - 2.5);
      result = sas[f, df, {2.0, 3.0}, "BracketGrid" -> 32, AccuracyGoal -> 8, "Tolerance" -> 10^-8];
      (* No sign changes, and minimum value is 10^-6 > 10^-8 (tolerance) *)
      (* Should return empty since no grid hits are within tolerance *)
      Length[result] == 0
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-no-sign-change-no-hits@@Tests/FindRootOptim/scanAndSolveOptions.wlt:145,3-158,4"
  ]

EndTestSection[]
