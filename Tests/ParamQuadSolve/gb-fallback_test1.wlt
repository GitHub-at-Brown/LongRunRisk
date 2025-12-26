BeginTestSection["gb-fallback"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x^2 + y^2 == 1, x^2 + 2 y^2 == 2};
vars$ = {x, y};
r$ = pqs[eq$, vars$, "DomainOption" -> Reals, "ValidationOption" -> False];
steps$ = r$["Diagnostics"]["Steps"];
lastVar$ = vars$[[-1]];

VerificationTest[MemberQ[steps$, {"quadraticGB", lastVar$}], True, TestID -> "gb-fallback-used@@Tests/ParamQuadSolve/gb-fallback.wlt:14,1-14,147"]

EndTestSection[]
