Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`"];

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x == 0, x == 1, y == 0};
vars$ = {x, y};
r$ = pqs[eq$, vars$, Validation -> True];
leftover$ = r$["Diagnostics"]["LeftoverEquations"];
ver$ = r$["Verification"];

VerificationTest[AssociationQ[r$], True, TestID -> "assoc@@Tests/ParamQuadSolve/no-solution.wlt:24,1-24,110"]
VerificationTest[Length[leftover$] >= 1 || AnyTrue[Flatten@ver$, FalseQ], True, TestID -> "signaled-no-solution@@Tests/ParamQuadSolve/no-solution.wlt:25,1-25,164"]

End[];
