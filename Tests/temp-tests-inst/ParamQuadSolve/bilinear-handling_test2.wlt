BeginTestSection["bilinear-handling"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Bilinear system: x*y - 1 == 0 with y fixed should stay linear after substitution *)

VerificationTest[
 Module[{eqns2, vars2, res2, sol, signMap, conds, yRule, xRule},
   eqns2 = {x^2 + y == 1, y + z == 2};
   vars2 = {x, y};
   res2 = pqs[eqns2, vars2];
   sol = res2["Solution"];
   signMap = res2["SignRootMap"];
   conds = res2["Conditions"];
   yRule = SelectFirst[sol, #[[1]] === y &];
   xRule = SelectFirst[sol, #[[1]] === x &];
   AssociationQ[res2] &&
   Simplify[yRule[[2]] == 2 - z] &&
   Length[Keys[signMap]] >= 1 &&
   Module[{sk = First[Keys[signMap]]}, Simplify[signMap[sk]^2 == 4*(z - 1)]] &&
   MemberQ[conds, z >= 1]
 ], True, TestID -> "mixed-quadratic-linear-parameter-dependence@@Tests/ParamQuadSolve/bilinear-handling.wlt:24,1-40,2"
]

EndTestSection[]
