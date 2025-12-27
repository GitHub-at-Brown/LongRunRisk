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
      f[z_] := (z[[1]] - 2.5)^4;
      (* With very tight tolerance, grid points far from exact zero won't count *)
      result = sas[f, {2.0, 3.0}, "BracketGrid" -> 32, "Tolerance" -> 10^-12, AccuracyGoal -> 8];
      (* Function value at grid points will be > 10^-12 except very close to 2.5 *)
      (* With 32 subdivisions, increment is 1/32 = 0.03125 *)
      (* f[2.5 +/- 0.03125]^4 = (0.03125)^4 ~ 9.5e-7, which is > 10^-12 *)
      (* So we shouldn't get many (if any) grid hits with such tight tolerance *)
      Length[result] <= 1
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "custom-tolerance-tight@@Tests/FindRootOptim/scanAndSolveOptions_test5.wlt:19,1-33,4"
  ]

EndTestSection[]
