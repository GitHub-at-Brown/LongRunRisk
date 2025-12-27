BeginTestSection["fastRootNewtonWithoutJacobian"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`"]

(* Load package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Access public function *)
fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot;

timeLimit = 10;

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
  TestID -> "multiple-roots-finds-one@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian_test8.wlt:17,1-27,2"
]

End[]
EndTestSection[]
