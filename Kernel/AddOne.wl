(* ::Package:: *)

BeginPackage[ "FernandoDuarte`LongRunRisk`" ]

<<FernandoDuarte`LongRunRisk`Subpackage`AddThree`; (*to use AddThree inside this file*)
AddOne::usage = "AddOne[x] adds one to x.";

Begin[ "`Private`" ]

AddOne[ x_Integer ] := x + 1  
AddThreePrivate[x_]:= AddThree[x]

End[ ]
EndPackage[ ]
