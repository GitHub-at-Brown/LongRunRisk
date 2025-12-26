BeginTestSection["no-solution"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x == 0, x == 1, y == 0};
vars$ = {x, y};
r$ = pqs[eq$, vars$, "ValidationOption" -> True];
leftover$ = r$["Diagnostics"]["LeftoverEquations"];
ver$ = r$["Verification"];

VerificationTest[Length[leftover$] >= 1 || AnyTrue[Flatten@ver$, FalseQ], True, TestID -> "signaled-no-solution@@Tests/ParamQuadSolve/no-solution.wlt:15,1-15,164"]

EndTestSection[]
