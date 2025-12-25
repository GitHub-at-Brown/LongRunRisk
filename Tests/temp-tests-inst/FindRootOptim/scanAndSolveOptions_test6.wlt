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
      (* With relaxed tolerance, more grid points should qualify as "zeros" *)
      result = sas[f, {2.0, 3.0}, "BracketGrid" -> 16, "Tolerance" -> 0.01, AccuracyGoal -> 8];
      (* f[x] = (x-2.5)^2 < 0.01 when |x-2.5| < 0.1 *)
      (* With grid spacing ~0.0625, multiple points near 2.5 should qualify *)
      Length[result] >= 1
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "custom-tolerance-relaxed@@Tests/FindRootOptim/scanAndSolveOptions.wlt:97,3-109,4"
  ]

EndTestSection[]
