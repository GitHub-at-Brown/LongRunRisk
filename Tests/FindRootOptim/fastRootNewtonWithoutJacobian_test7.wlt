BeginTestSection["fastRootNewtonWithoutJacobian"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`"]

(* Load package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Access public function *)
fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot;

timeLimit = 10;

(* Test 1D with Explicit Jacobian Still Works *)
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
  TestID -> "1d-with-explicit-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian_test7.wlt:18,1-28,2"
]

End[]
EndTestSection[]
