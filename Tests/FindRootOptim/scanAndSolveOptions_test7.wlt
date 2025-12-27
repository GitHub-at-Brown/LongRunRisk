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
      f[z_] := Sin[z[[1]]];
      df[z_] := Cos[z[[1]]];
      (* Pi is near a grid point with certain grid sizes *)
      (* The deduplication should prevent reporting the same root multiple times *)
      result = sas[f, df, {3.0, 3.2}, "BracketGrid" -> 32, "Tolerance" -> 10^-6, AccuracyGoal -> 8];
      (* Should find exactly one root near Pi, not duplicates *)
      Length[result] == 1 && Abs[result[[1]] - Pi] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "tolerance-deduplication-single-root@@Tests/FindRootOptim/scanAndSolveOptions_test7.wlt:19,1-32,4"
  ]

EndTestSection[]
