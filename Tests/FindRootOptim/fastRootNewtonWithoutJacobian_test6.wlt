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

VerificationTest[
  Module[{result},
    (* Explicitly request Newton without Jacobian *)
    result = fastRoot[f1D, {1.5, 3.0}, Method -> "Newton", "Return" -> "Value"];
    NumericQ[result] && Abs[result^2 - 4] < 10^-6
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "newton-explicit-1d-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian_test6.wlt:17,1-27,2"
]

End[]
EndTestSection[]
