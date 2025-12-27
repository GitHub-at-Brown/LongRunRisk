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
  TestID -> "1d-quadratic-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:29,1-39,2"
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
  TestID -> "1d-cubic-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:44,1-53,2"
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
  TestID -> "1d-transcendental-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:58,1-67,2"
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
  TestID -> "1d-exponential-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:72,1-81,2"
]

(* ===== Test Method Priority ===== *)

(* Verify Newton is tried first even without Jacobian for 1D *)
VerificationTest[
  Module[{result},
    (* Method -> Automatic should try Newton first *)
    result = fastRoot[f1D, {1.5, 3.0}, Method -> Automatic, "Return" -> "Value"];
    NumericQ[result] && Abs[result^2 - 4] < 10^-6
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "newton-automatic-1d-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:86,1-96,2"
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
  TestID -> "newton-explicit-1d-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:98,1-108,2"
]

(* ===== Test 1D with Explicit Jacobian Still Works ===== *)

f1DJac[z_] := z[[1]]^2 - 4;
df1DJac[z_] := {2*z[[1]]};

VerificationTest[
  Module[{result},
    (* With explicit Jacobian - should still work *)
    result = fastRoot[f1DJac, {1.5, 3.}, Jacobian -> df1DJac, "Return" -> "Value"];
    NumericQ[result] && Abs[result^2 - 4] < 10^-6
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "1d-with-explicit-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:115,1-125,2"
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
  TestID -> "multiple-roots-finds-one@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:132,1-142,2"
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
  TestID -> "steep-gradient-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:147,1-156,2"
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
  TestID -> "different-starting-points@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:160,1-173,2"
]

End[]
EndTestSection[]
