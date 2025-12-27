BeginTestSection["fastRootNewtonWithoutJacobian"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`"]

(* Load package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Access public function *)
fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot;

timeLimit = 10;

(* Simple quadratic for Method test *)
f1D[z_] := z[[1]]^2 - 4;

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
  TestID -> "newton-automatic-1d-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian_test5.wlt:18,1-28,2"
]

End[]
EndTestSection[]
