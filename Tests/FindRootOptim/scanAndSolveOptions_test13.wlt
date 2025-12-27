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
      f[z_] := Sin[2*Pi*z[[1]]];
      df[z_] := 2*Pi*Cos[2*Pi*z[[1]]];
      result = sas[f, df, {0.0, 2.5}, "BracketGrid" -> 50, "Tolerance" -> 10^-6, AccuracyGoal -> 8];
      (* Should find zeros at x = 0, 0.5, 1.0, 1.5, 2.0, 2.5 (but 0 may be excluded if at boundary) *)
      (* Depending on sign changes detected, should find 4-6 roots *)
      Length[result] >= 4 && Length[result] <= 6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "multiple-roots-custom-options@@Tests/FindRootOptim/scanAndSolveOptions_test13.wlt:19,1-31,4"
  ]

EndTestSection[]
