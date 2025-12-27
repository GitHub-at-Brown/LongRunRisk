BeginTestSection["fastRootOptions"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


(* Use the public symbol *)
fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot;
timeLimit = 5;

(* Define robust numeric comparison for rules *)
tolSameTest = Function[{actual, expected},
  Module[{a, e},
    (* Extract numeric values from rules, lists of rules, or plain numbers *)
    a = actual /. {Rule[_, v_?NumericQ] :> v, {Rule[_, v_?NumericQ]} :> v};
    e = expected /. {Rule[_, v_?NumericQ] :> v, {Rule[_, v_?NumericQ]} :> v};
    (* Ensure we have lists for Flatten - avoids Flatten::normal warnings *)
    Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^-6
  ]
];

(* Helper functions that take list argument, consistent with bindUnary API *)
f1[z_] := z[[1]]^2 - 2;           (* root at sqrt(2) ~ 1.414 *)
df1[z_] := 2*z[[1]];
f2[z_] := z[[1]]^2 - 4;           (* root at 2 *)
df2[z_] := 2*z[[1]];
fcos[z_] := Cos[z[[1]]];
dfcos[z_] := -Sin[z[[1]]];
fsin[z_] := Sin[z[[1]]] - 0.5;
fexp[z_] := Exp[z[[1]]] - 3;
fcubic[z_] := z[[1]]^3 - 8;       (* root at 2 *)

(* nD helper functions for testing nested x0 syntax *)
(* 2D system: x^2 + y - 3 = 0, x + y^2 - 3 = 0, symmetric root at x = y = (-1+Sqrt[13])/2 ~ 1.3028 *)
fND2[z_] := {z[[1]]^2 + z[[2]] - 3, z[[1]] + z[[2]]^2 - 3};
dfND2[z_] := {{2*z[[1]], 1}, {1, 2*z[[2]]}};
expectedND2 = (-1 + Sqrt[13])/2 // N;  (* ~ 1.3027756377319946 *)

(* 3D system for higher-dimension test *)
fND3[z_] := {z[[1]] + z[[2]] + z[[3]] - 3, z[[1]]*z[[2]] - 1, z[[2]]*z[[3]] - 1};  (* root at (1,1,1) *)
dfND3[z_] := {{1, 1, 1}, {z[[2]], z[[1]], 0}, {0, z[[3]], z[[2]]}};

VerificationTest[
    Module[{result},
      result = Quiet[fastRoot[f1, {1., 2.}, Jacobian -> df1]];
      NumericQ[result]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "quiet-computation-succeeds@@Tests/FindRootOptim/fastRootOptions_test22.wlt:42,1-50,4"
  ]

EndTestSection[]
