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
    Module[{f, df, result1, result2},
      f[z_] := Sin[10*z[[1]]];
      df[z_] := 10*Cos[10*z[[1]]];
      (* Fine grid should find more roots *)
      result1 = sas[f, df, {0.0, 1.0}, "BracketGrid" -> 8, AccuracyGoal -> 6];
      result2 = sas[f, df, {0.0, 1.0}, "BracketGrid" -> 64, AccuracyGoal -> 6];
      (* More bins should find more or equal number of roots *)
      Length[result2] >= Length[result1]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "custom-bracket-grid-coarse-vs-fine@@Tests/FindRootOptim/scanAndSolveOptions_test3.wlt:19,1-32,4"
  ]

EndTestSection[]
