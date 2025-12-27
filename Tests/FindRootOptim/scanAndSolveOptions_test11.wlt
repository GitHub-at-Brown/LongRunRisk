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
      (* Function with no zeros and minimum well above tolerance *)
      f[z_] := (z[[1]] - 2.5)^2 + 1.0;
      result = sas[f, {2.0, 3.0}, "BracketGrid" -> 16, AccuracyGoal -> 8];
      (* No sign changes, all values > 1.0, should return empty *)
      Length[result] == 0
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "derivative-free-no-hits-no-sign-change@@Tests/FindRootOptim/scanAndSolveOptions_test11.wlt:19,1-30,4"
  ]

EndTestSection[]
