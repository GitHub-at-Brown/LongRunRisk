BeginTestSection["propagation"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`propagation`"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x == 1, y == x + 1, z == y + 1};
vars$ = {x, y, z};
r$ = pqs[eq$, vars$, "ValidationOption" -> False];
rhs$ = r$["Solution"][[All, 2]];

VerificationTest[FreeQ[rhs$, Alternatives @@ vars$], True, TestID -> "rhs-free-of-unknowns@@Tests/ParamQuadSolve/propagation.wlt:11,1-11,142"]

End[]
EndTestSection[]
