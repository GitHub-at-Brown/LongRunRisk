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
      f[z_] := (z[[1]] - 2.5)^2;
      result = sas[f, {2.0, 3.0}, "BracketGrid" -> 32, AccuracyGoal -> 8];
      (* With 32 bins between 2.0 and 3.0, one grid point should land very close to 2.5 *)
      (* Grid points: 2.0, 2.03125, 2.0625, ..., 2.5, ..., 3.0 (33 points total) *)
      (* The parabola minimum at x=2.5 should be hit exactly or nearly *)
      Length[result] > 0 && result[[1]] >= 2.0 && result[[1]] <= 3.0
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-grid-hit@@Tests/FindRootOptim/scanAndSolveOptions.wlt:21,3-33,4"
  ]

EndTestSection[]
