BeginTestSection["fastRootNewtonWithoutJacobian"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`"]

(* Load package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Access public function *)
fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot;

timeLimit = 10;

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
  TestID -> "1d-exponential-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian_test4.wlt:17,1-26,2"
]

End[]
EndTestSection[]
