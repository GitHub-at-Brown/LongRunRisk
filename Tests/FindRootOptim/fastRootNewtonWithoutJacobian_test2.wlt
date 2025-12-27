BeginTestSection["fastRootNewtonWithoutJacobian"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`"]

(* Load package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Access public function *)
fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot;

timeLimit = 10;

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
  TestID -> "1d-cubic-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian_test2.wlt:17,1-26,2"
]

End[]
EndTestSection[]
