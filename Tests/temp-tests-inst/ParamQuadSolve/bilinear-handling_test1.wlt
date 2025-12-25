BeginTestSection["bilinear-handling"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Bilinear system: x*y - 1 == 0 with y fixed should stay linear after substitution *)

VerificationTest[
 Module[{eqns1, vars1, res1, steps1, sol},
   eqns1 = {x*y - 1 == 0, y - 2 == 0};
   vars1 = {x, y};
   res1 = pqs[eqns1, vars1];
   steps1 = res1["Diagnostics"]["Steps"];
   sol = res1["Solution"];
   AssociationQ[res1] &&
   Sort[sol] === Sort[{x -> 1/2, y -> 2}] &&
   FreeQ[steps1, {"quadratic", _}] &&
   FreeQ[steps1, {"quartic", _}]
 ], True, TestID -> "bilinear-linear-behaviour@@Tests/ParamQuadSolve/bilinear-handling.wlt:9,1-21,2"
]

EndTestSection[]
