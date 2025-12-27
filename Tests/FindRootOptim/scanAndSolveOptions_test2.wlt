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
    Module[{f, result},
      f[z_] := z[[1]] - 2.5;
      result = sas[f, {2.0, 3.0}, "BracketGrid" -> 16, AccuracyGoal -> 8];
      Length[result] == 1 && Abs[result[[1]] - 2.5] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-finds-zero@@Tests/FindRootOptim/scanAndSolveOptions_test2.wlt:19,1-28,4"
  ]

EndTestSection[]
