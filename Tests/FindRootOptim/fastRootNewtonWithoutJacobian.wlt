BeginTestSection["fastRootNewtonWithoutJacobian"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`"]

(* Load package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Access public function *)
fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot;

(* Test parameters *)
timeLimit = 10;

(* Define tolerance for numeric comparisons *)
tolSameTest = Function[{actual, expected},
  Module[{a, e},
    a = actual /. {Rule[_, v_?NumericQ] :> v, {Rule[_, v_?NumericQ]} :> v};
    e = expected /. {Rule[_, v_?NumericQ] :> v, {Rule[_, v_?NumericQ]} :> v};
    Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^-6
  ]
];

(* ===== Test 1D Functions Without Explicit Jacobian ===== *)

(* Simple quadratic *)
f1D[z_] := z[[1]]^2 - 4;

VerificationTest[
  Module[{result},
    (* No Jacobian provided - should use Newton with numerical derivatives *)
    result = fastRoot[f1D, {1.5, 3.}, "Return" -> "Value"];
    NumericQ[result] && Abs[result^2 - 4] < 10^-6
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "1d-quadratic-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt"
]

(* Cubic function *)
fCubic[z_] := z[[1]]^3 - 8;

VerificationTest[
  Module[{result},
    result = fastRoot[fCubic, {1.5, 3.}, "Return" -> "Value"];
    NumericQ[result] && Abs[result^3 - 8] < 10^-6
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "1d-cubic-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt"
]

(* Transcendental function *)
fTranscendental[z_] := Cos[z[[1]]] - 0.5;

VerificationTest[
  Module[{result},
    result = fastRoot[fTranscendental, {0.5, 1.5}, "Return" -> "Value"];
    NumericQ[result] && Abs[Cos[result] - 0.5] < 10^-6
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "1d-transcendental-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt"
]

(* Exponential function *)
fExp[z_] := Exp[z[[1]]] - 3;

VerificationTest[
  Module[{result},
    result = fastRoot[fExp, {0.5, 1.5}, "Return" -> "Value"];
    NumericQ[result] && Abs[Exp[result] - 3] < 10^-6
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "1d-exponential-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt"
]

(* ===== Test nD Functions Without Explicit Jacobian ===== *)

(* 2D system: x^2 + y - 3 = 0, x + y^2 - 3 = 0 *)
f2D[z_] := {z[[1]]^2 + z[[2]] - 3, z[[1]] + z[[2]]^2 - 3};
expectedND2 = (-1 + Sqrt[13])/2 // N;  (* ~ 1.3027756377319946 *)

VerificationTest[
  Module[{result},
    result = fastRoot[f2D, {{1.0, 1.5}, {1.0, 1.5}}, "Return" -> "Value"];
    VectorQ[result, NumericQ] &&
    Max[Abs[result - {expectedND2, expectedND2}]] < 10^-6
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "2d-system-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt"
]

(* 3D linear system *)
f3D[z_] := {z[[1]] + z[[2]] + z[[3]] - 3, z[[1]] - z[[2]] - 1, z[[2]] - z[[3]] - 1};

VerificationTest[
  Module[{result},
    (* Use better starting point closer to solution *)
    result = fastRoot[f3D, {{1.8, 2.2}, {0.8, 1.2}, {-0.2, 0.2}}, "Return" -> "Value"];
    VectorQ[result, NumericQ] &&
    Max[Abs[result - {2, 1, 0}]] < 10^-5
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "3d-linear-system-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt"
]

(* ===== Test Method Priority ===== *)

(* Verify Newton is tried first even without Jacobian *)
VerificationTest[
  Module[{result},
    (* Method -> Automatic should try Newton first *)
    result = fastRoot[f1D, {1.5, 3.0}, Method -> Automatic, "Return" -> "Value"];
    NumericQ[result] && Abs[result^2 - 4] < 10^-6
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "newton-automatic-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt"
]

VerificationTest[
  Module[{result},
    (* Explicitly request Newton without Jacobian *)
    result = fastRoot[f1D, {1.5, 3.0}, Method -> "Newton", "Return" -> "Value"];
    NumericQ[result] && Abs[result^2 - 4] < 10^-6
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "newton-explicit-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt"
]

(* ===== Test Edge Cases ===== *)

(* Function with multiple roots *)
fMultiRoot[z_] := (z[[1]] - 1)*(z[[1]] - 2)*(z[[1]] - 3);

VerificationTest[
  Module[{result},
    (* Starting near 1.5, should find root at 1 or 2 *)
    result = fastRoot[fMultiRoot, {1.2, 1.8}, "Return" -> "Value"];
    NumericQ[result] && (Abs[result - 1] < 10^-6 || Abs[result - 2] < 10^-6)
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "multiple-roots-finds-one@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt"
]

(* Function with steep gradient *)
fSteep[z_] := z[[1]]^10 - 1024;

VerificationTest[
  Module[{result},
    result = fastRoot[fSteep, {1.5, 2.5}, "Return" -> "Value"];
    NumericQ[result] && Abs[result^10 - 1024] < 10^-4
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "steep-gradient-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt"
]

(* ===== Test Different Starting Points ===== *)

VerificationTest[
  Module[{result1, result2},
    (* Same function, different starting points *)
    result1 = fastRoot[f1D, {1.5, 2.5}, "Return" -> "Value"];
    result2 = fastRoot[f1D, {-3., -1.5}, "Return" -> "Value"];
    NumericQ[result1] && NumericQ[result2] &&
    Abs[result1 - 2] < 10^-6 &&
    Abs[result2 - (-2)] < 10^-6
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "different-starting-points@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt"
]

End[]
EndTestSection[]
