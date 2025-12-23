BeginTestSection["gb-fallback"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`gb-fallback`"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x^2 + y^2 == 1, x^2 + 2 y^2 == 2};
vars$ = {x, y};
r$ = pqs[eq$, vars$, "DomainOption" -> Reals, "ValidationOption" -> False];
steps$ = r$["Diagnostics"]["Steps"];
lastVar$ = vars$[[-1]];

VerificationTest[MemberQ[steps$, {"quadraticGB", lastVar$}], True, TestID -> "gb-fallback-used@@Tests/ParamQuadSolve/gb-fallback.wlt:12,1-12,146"]
VerificationTest[Length[Keys[r$["SignRootMap"]]] >= 1, True, TestID -> "sign-created-after-gb@@Tests/ParamQuadSolve/gb-fallback.wlt:13,1-13,145"]

End[]
EndTestSection[]
