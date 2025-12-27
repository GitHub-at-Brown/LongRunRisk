BeginTestSection["fastRootNewtonWithoutJacobian"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`"]

(* Load package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Access public function *)
fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot;

timeLimit = 10;

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
  TestID -> "1d-transcendental-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian_test3.wlt:17,1-26,2"
]

End[]
EndTestSection[]
