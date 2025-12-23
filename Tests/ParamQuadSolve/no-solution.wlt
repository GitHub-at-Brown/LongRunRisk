BeginTestSection["no-solution"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`no-solution`"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x == 0, x == 1, y == 0};
vars$ = {x, y};
r$ = pqs[eq$, vars$, "ValidationOption" -> True];
leftover$ = r$["Diagnostics"]["LeftoverEquations"];
ver$ = r$["Verification"];

VerificationTest[AssociationQ[r$], True, TestID -> "assoc@@Tests/ParamQuadSolve/no-solution.wlt:12,1-12,109"]
VerificationTest[Length[leftover$] >= 1 || AnyTrue[Flatten@ver$, FalseQ], True, TestID -> "signaled-no-solution@@Tests/ParamQuadSolve/no-solution.wlt:13,1-13,164"]

End[]
EndTestSection[]
