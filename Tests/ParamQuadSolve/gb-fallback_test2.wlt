BeginTestSection["gb-fallback"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x^2 + y^2 == 1, x^2 + 2 y^2 == 2};
vars$ = {x, y};
r$ = pqs[eq$, vars$, "DomainOption" -> Reals, "ValidationOption" -> False];
steps$ = r$["Diagnostics"]["Steps"];
lastVar$ = vars$[[-1]];

VerificationTest[Length[Keys[r$["SignRootMap"]]] >= 1, True, TestID -> "sign-created-after-gb@@Tests/ParamQuadSolve/gb-fallback_test2.wlt:14,1-14,146"]

EndTestSection[]
