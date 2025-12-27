BeginTestSection["fastRootNewtonWithoutJacobian"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`"]

(* Load package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Access public function *)
fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot;

timeLimit = 10;

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
  TestID -> "steep-gradient-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian_test9.wlt:17,1-26,2"
]

End[]
EndTestSection[]
