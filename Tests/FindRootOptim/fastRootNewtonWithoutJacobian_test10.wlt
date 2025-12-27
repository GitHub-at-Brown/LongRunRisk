BeginTestSection["fastRootNewtonWithoutJacobian"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`"]

(* Load package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Access public function *)
fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot;

timeLimit = 10;

(* Simple quadratic for starting point test *)
f1D[z_] := z[[1]]^2 - 4;

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
  TestID -> "different-starting-points@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian_test10.wlt:17,1-30,2"
]

End[]
EndTestSection[]
