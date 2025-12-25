BeginTestSection["steps-linear-quadratic"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x^2 - 5 == 0, y + 2 x - 3 == 0};
vars$ = {x, y};
r$ = pqs[eq$, vars$, "DomainOption" -> Reals, "ValidationOption" -> False];
steps$ = r$["Diagnostics"]["Steps"];

VerificationTest[MemberQ[steps$, {"quadratic", x}], True, TestID -> "has-quadratic-x@@Tests/ParamQuadSolve/steps-linear-quadratic.wlt:13,1-13,148"]

EndTestSection[]
