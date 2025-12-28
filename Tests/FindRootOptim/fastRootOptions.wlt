BeginTestSection["fastRootOptions Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`fastRootOptions`"]

(* --- merged from: fastRootOptions_test1.wlt --- *)
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
      result = fastRoot[f1, {1., 2.}, Jacobian -> df1, Method -> "Secant"];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "method-secant-with-jacobian@@Tests/FindRootOptim/fastRootOptions.wlt:44,1-52,4"
  ]

(* --- merged from: fastRootOptions_test2.wlt --- *)
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
      (* Use non-bracketed interval to force Secant path *)
      result = fastRoot[f2, {1.5, 3.}, Jacobian -> df2, Method -> "Secant"];
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "method-secant-nonbracketed@@Tests/FindRootOptim/fastRootOptions.wlt:94,1-103,4"
  ]

(* --- merged from: fastRootOptions_test3.wlt --- *)
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
      (* Bracketed interval should use Brent when Method -> "Brent" *)
      result = fastRoot[fcos, {1., 2.}, Jacobian -> dfcos, Method -> "Brent"];
      NumericQ[result] && Abs[Cos[result]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "method-brent-bracketed@@Tests/FindRootOptim/fastRootOptions.wlt:145,1-154,4"
  ]

(* --- merged from: fastRootOptions_test4.wlt --- *)
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
      result = fastRoot[f1, {1., 2.}, Jacobian -> df1, "Return" -> "Rule"];
      MatchQ[result, {_ -> _?NumericQ}]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "return-rule-option@@Tests/FindRootOptim/fastRootOptions.wlt:196,1-204,4"
  ]

(* --- merged from: fastRootOptions_test5.wlt --- *)
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
      (* Default "Return" -> "Value" should return numeric value *)
      result = fastRoot[f1, {1., 2.}, Jacobian -> df1];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "return-value-default@@Tests/FindRootOptim/fastRootOptions.wlt:246,1-255,4"
  ]

(* --- merged from: fastRootOptions_test6.wlt --- *)
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
    Module[{resultRule, resultValue},
      (* Verify both forms return same numeric root *)
      resultRule = fastRoot[fcos, {1., 2.}, Jacobian -> dfcos, "Return" -> "Rule"];
      resultValue = fastRoot[fcos, {1., 2.}, Jacobian -> dfcos, "Return" -> "Value"];
      Abs[resultRule[[1, 2]] - resultValue] < 10^-8
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "return-rule-vs-value-consistency@@Tests/FindRootOptim/fastRootOptions.wlt:297,1-307,4"
  ]

(* --- merged from: fastRootOptions_test7.wlt --- *)
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
      (* Bracketed: f[1] = -1, f[2] = 2, root at sqrt(2) *)
      result = fastRoot[f1, {1., 2.}];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "no-jacobian-bracketed-brent@@Tests/FindRootOptim/fastRootOptions.wlt:349,1-358,4"
  ]

(* --- merged from: fastRootOptions_test8.wlt --- *)
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
      (* Bracketed trigonometric function *)
      result = fastRoot[fsin, {0., 1.}];
      NumericQ[result] && Abs[Sin[result] - 0.5] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "no-jacobian-bracketed-trig@@Tests/FindRootOptim/fastRootOptions.wlt:400,1-409,4"
  ]

(* --- merged from: fastRootOptions_test9.wlt --- *)
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
      (* Non-bracketed: both f[1.5] and f[3] are positive, should use Secant *)
      result = fastRoot[f2, {1.5, 3.}];
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "no-jacobian-nonbracketed-secant@@Tests/FindRootOptim/fastRootOptions.wlt:451,1-460,4"
  ]

(* --- merged from: fastRootOptions_test10.wlt --- *)
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
      (* Non-bracketed interval, both endpoints positive *)
      result = fastRoot[fexp, {0.5, 1.5}];
      NumericQ[result] && Abs[Exp[result] - 3] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "no-jacobian-nonbracketed-exp@@Tests/FindRootOptim/fastRootOptions.wlt:502,1-511,4"
  ]

(* --- merged from: fastRootOptions_test11.wlt --- *)
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
      result = fastRoot[f1, {1., 2.}, AccuracyGoal -> 10, PrecisionGoal -> 10];
      NumericQ[result] && Abs[result^2 - 2] < 10^-9
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "high-accuracy-goals@@Tests/FindRootOptim/fastRootOptions.wlt:553,1-561,4"
  ]

(* --- merged from: fastRootOptions_test12.wlt --- *)
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
    Module[{badF, result},
      badF[z_] := If[z[[1]] < 1.5, z[[1]]^2 - 2, Indeterminate];
      result = Quiet[fastRoot[badF, {1., 2.}, Jacobian -> df1]];
      result === $Failed
    ],
    True,
    {},
    TimeConstraint -> timeLimit,
    TestID -> "failure-nonnumeric-function-value@@Tests/FindRootOptim/fastRootOptions.wlt:603,1-613,4"
  ]

(* --- merged from: fastRootOptions_test13.wlt --- *)
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
      result = fastRoot[fcubic, {1., 3.}];
      NumericQ[result] && Abs[result^3 - 8] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "no-jacobian-cubic-root@@Tests/FindRootOptim/fastRootOptions.wlt:655,1-663,4"
  ]

(* --- merged from: fastRootOptions_test14.wlt --- *)
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
      result = fastRoot[f1, {2., 1.}, Jacobian -> df1];
      result === $Failed
    ],
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot::badbounds},
    TimeConstraint -> timeLimit,
    TestID -> "reversed-interval-badbounds@@Tests/FindRootOptim/fastRootOptions.wlt:705,1-714,4"
  ]

(* --- merged from: fastRootOptions_test15.wlt --- *)
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
      result = fastRoot[f1, {1., 2.}, Jacobian -> df1,
        Method -> "Secant", "Return" -> "Value"];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "combined-method-return-options@@Tests/FindRootOptim/fastRootOptions.wlt:756,1-765,4"
  ]

(* --- merged from: fastRootOptions_test16.wlt --- *)
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
      result = fastRoot[f1, {1., 2.}, Jacobian -> df1,
        AccuracyGoal -> 12, PrecisionGoal -> 12];
      NumericQ[result] && Abs[result^2 - 2] < 10^-11
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "high-accuracy-precision-goals@@Tests/FindRootOptim/fastRootOptions.wlt:807,1-816,4"
  ]

(* --- merged from: fastRootOptions_test17.wlt --- *)
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
      result = fastRoot[f1, {1., 2.}, Jacobian -> df1, MaxIterations -> 50];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "maxiterations-option@@Tests/FindRootOptim/fastRootOptions.wlt:858,1-866,4"
  ]

(* --- merged from: fastRootOptions_test18.wlt --- *)
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
    Module[{result, badDF},
      badDF[z_] := 0;
      result = fastRoot[f1, {1., 2.}, Jacobian -> badDF];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "newton-fails-fallback@@Tests/FindRootOptim/fastRootOptions.wlt:908,1-917,4"
  ]

(* --- merged from: fastRootOptions_test19.wlt --- *)
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
      result = fastRoot[f1, {1.41, 1.42}, Jacobian -> df1];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "narrow-interval-convergence@@Tests/FindRootOptim/fastRootOptions.wlt:959,1-967,4"
  ]

(* --- merged from: fastRootOptions_test20.wlt --- *)
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
      result = fastRoot[f1, {1., 2.}, Jacobian -> df1,
        WorkingPrecision -> MachinePrecision];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "workingprecision-option@@Tests/FindRootOptim/fastRootOptions.wlt:1009,1-1018,4"
  ]

(* --- merged from: fastRootOptions_test21.wlt --- *)
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
      result = fastRoot[f2, {1.5, 3.}, Jacobian -> df2, Method -> Automatic];
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "method-automatic-nonbracketed@@Tests/FindRootOptim/fastRootOptions.wlt:1060,1-1068,4"
  ]

(* --- merged from: fastRootOptions_test22.wlt --- *)
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
    TestID -> "quiet-computation-succeeds@@Tests/FindRootOptim/fastRootOptions.wlt:1110,1-1118,4"
  ]

(* --- merged from: fastRootOptions_test23.wlt --- *)
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
      result = fastRoot[f2, {1., 2.}, Jacobian -> df2];
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "root-at-boundary@@Tests/FindRootOptim/fastRootOptions.wlt:1160,1-1168,4"
  ]

(* --- merged from: fastRootOptions_test24.wlt --- *)
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
      result = fastRoot[f1, {1.4, 1., 2.}, Jacobian -> df1];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-full-spec-with-jacobian@@Tests/FindRootOptim/fastRootOptions.wlt:1210,1-1218,4"
  ]

(* --- merged from: fastRootOptions_test25.wlt --- *)
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
      result = fastRoot[f1, {1.4, 1., 2.}];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-full-spec-no-jacobian@@Tests/FindRootOptim/fastRootOptions.wlt:1260,1-1268,4"
  ]

(* --- merged from: fastRootOptions_test26.wlt --- *)
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
      result = fastRoot[f1, {Automatic, 1., 2.}, Jacobian -> df1];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-automatic-x0@@Tests/FindRootOptim/fastRootOptions.wlt:1310,1-1318,4"
  ]

(* --- merged from: fastRootOptions_test27.wlt --- *)
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
      result = fastRoot[f1, 1.4, Jacobian -> df1];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-scalar-x0-with-jacobian@@Tests/FindRootOptim/fastRootOptions.wlt:1360,1-1368,4"
  ]

(* --- merged from: fastRootOptions_test28.wlt --- *)
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
      result = fastRoot[f1, 1.4];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-scalar-x0-no-jacobian@@Tests/FindRootOptim/fastRootOptions.wlt:1410,1-1418,4"
  ]

(* --- merged from: fastRootOptions_test29.wlt --- *)
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
      result = fastRoot[fND2, {{1.2, 1.2}}, Jacobian -> dfND2];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-with-jacobian@@Tests/FindRootOptim/fastRootOptions.wlt:1460,1-1468,4"
  ]

(* --- merged from: fastRootOptions_test30.wlt --- *)
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
      result = fastRoot[fND2, {{1.2, 1.2}}];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-no-jacobian@@Tests/FindRootOptim/fastRootOptions.wlt:1510,1-1518,4"
  ]

(* --- merged from: fastRootOptions_test31.wlt --- *)
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
      result = fastRoot[fND2, {{1.5, 1.5}}, Jacobian -> dfND2];
      VectorQ[result, NumericQ] && Max[Abs[result - {expectedND2, expectedND2}]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-correct-root@@Tests/FindRootOptim/fastRootOptions.wlt:1560,1-1568,4"
  ]

(* --- merged from: fastRootOptions_test32.wlt --- *)
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
      result = fastRoot[fND2, {{0.5, 2.}, {0.5, 2.}}, Jacobian -> dfND2];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-bounds-new-format@@Tests/FindRootOptim/fastRootOptions.wlt:1610,1-1618,4"
  ]

(* --- merged from: fastRootOptions_test33.wlt --- *)
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
      result = fastRoot[fND2, {{1.2, 0.5, 2.}, {1.2, 0.5, 2.}}, Jacobian -> dfND2];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-full-spec-new-format@@Tests/FindRootOptim/fastRootOptions.wlt:1660,1-1668,4"
  ]

(* --- merged from: fastRootOptions_test34.wlt --- *)
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
      (* {1.2, 1.2} as 1D bounds where a=b should fail with badbounds *)
      result = fastRoot[f1, {1.2, 1.2}, Jacobian -> df1];
      result === $Failed
    ],
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot::badbounds},
    TimeConstraint -> timeLimit,
    TestID -> "disambiguation-flat-is-1D-bounds@@Tests/FindRootOptim/fastRootOptions.wlt:1710,1-1720,4"
  ]

(* --- merged from: fastRootOptions_test35.wlt --- *)
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
      result = fastRoot[fND3, {{0.9, 0.9, 0.9}}, Jacobian -> dfND3];
      VectorQ[result, NumericQ] && Length[result] == 3 && Max[Abs[fND3[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-3D-nested-x0@@Tests/FindRootOptim/fastRootOptions.wlt:1762,1-1770,4"
  ]

(* --- merged from: fastRootOptions_test36.wlt --- *)
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
      result = fastRoot[fND2, {{1.2, 1.2}}, Jacobian -> dfND2, "Return" -> "Rule"];
      MatchQ[result, {(_ -> _?NumericQ) ..}] && Length[result] == 2
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-return-rule@@Tests/FindRootOptim/fastRootOptions.wlt:1812,1-1820,4"
  ]

(* --- merged from: fastRootOptions_test37.wlt --- *)
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
      result = fastRoot[fND2, {{1.2, 1.2}}, Jacobian -> dfND2, Method -> "Secant"];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-nested-x0-method-secant@@Tests/FindRootOptim/fastRootOptions.wlt:1862,1-1870,4"
  ]

(* --- merged from: fastRootOptions_test38.wlt --- *)
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
    Module[{result, badDfND},
      badDfND[z_] := {{0., 0.}, {0., 0.}};
      result = fastRoot[fND2, {{1.2, 1.2}}, Jacobian -> badDfND];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-newton-fails-fallback@@Tests/FindRootOptim/fastRootOptions.wlt:1912,1-1921,4"
  ]

(* --- merged from: fastRootOptions_test39.wlt --- *)
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
    Module[{result, badDfND},
      badDfND[z_] := {{0., 0.}, {0., 0.}};
      result = fastRoot[fND2, {{0.5, 2.}, {0.5, 2.}}, Jacobian -> badDfND];
      VectorQ[result, NumericQ] && Max[Abs[fND2[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "nD-bounds-newton-fails-fallback@@Tests/FindRootOptim/fastRootOptions.wlt:1963,1-1972,4"
  ]

(* --- merged from: fastRootOptions_test40.wlt --- *)
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
    Module[{result, badDF},
      badDF[z_] := 0.;
      result = fastRoot[f1, {1., 2.}, Jacobian -> badDF];
      NumericQ[result] && Abs[result^2 - 2] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-bracketed-newton-fails-brent-fallback@@Tests/FindRootOptim/fastRootOptions.wlt:2014,1-2023,4"
  ]

(* --- merged from: fastRootOptions_test41.wlt --- *)
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
    Module[{result, badDF},
      badDF[z_] := 0.;
      result = fastRoot[f2, {2.5, 3.}, Jacobian -> badDF];
      NumericQ[result] && Abs[result^2 - 4] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "1D-nonbracketed-newton-fails-secant-fallback@@Tests/FindRootOptim/fastRootOptions.wlt:2065,1-2074,4"
  ]

(* --- merged from: fastRootOptions_test42.wlt --- *)
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
    Module[{result, badDfND3},
      badDfND3[z_] := {{0., 0., 0.}, {0., 0., 0.}, {0., 0., 0.}};
      result = fastRoot[fND3, {{0.9, 0.9, 0.9}}, Jacobian -> badDfND3];
      VectorQ[result, NumericQ] && Length[result] == 3 && Max[Abs[fND3[result]]] < 10^-6
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "3D-newton-fails-fallback@@Tests/FindRootOptim/fastRootOptions.wlt:2116,1-2125,4"
  ]

(* --- merged from: fastRootOptions_test43.wlt --- *)
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
    fastRoot[f1, Automatic] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot::noautox0},
    TimeConstraint -> timeLimit,
    TestID -> "error-noautox0-scalar@@Tests/FindRootOptim/fastRootOptions.wlt:2167,1-2173,4"
  ]

(* --- merged from: fastRootOptions_test44.wlt --- *)
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
    fastRoot[f1, "invalid"] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot::badspec},
    TimeConstraint -> timeLimit,
    TestID -> "error-badspec-string@@Tests/FindRootOptim/fastRootOptions.wlt:2215,1-2221,4"
  ]

(* --- merged from: fastRootOptions_test45.wlt --- *)
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
    fastRoot[fND2, {{2., 1.}, {0.5, 2.}}, Jacobian -> dfND2] === $Failed,
    True,
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot::badbounds},
    TimeConstraint -> timeLimit,
    TestID -> "error-badbounds-nD@@Tests/FindRootOptim/fastRootOptions.wlt:2263,1-2269,4"
  ]

End[]
EndTestSection[]
