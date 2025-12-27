BeginTestSection["no-solution"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x == 0, x == 1, y == 0};
vars$ = {x, y};
r$ = pqs[eq$, vars$, "ValidationOption" -> True];
leftover$ = r$["Diagnostics"]["LeftoverEquations"];
ver$ = r$["Verification"];

VerificationTest[AssociationQ[r$], True, TestID -> "assoc@@Tests/ParamQuadSolve/no-solution_test1.wlt:14,1-14,110"]

EndTestSection[]
