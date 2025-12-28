BeginTestSection["gb-fallback Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`gbFallback`"]

(* --- merged from: gb-fallback_test1.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x^2 + y^2 == 1, x^2 + 2 y^2 == 2};
vars$ = {x, y};
r$ = pqs[eq$, vars$, "DomainOption" -> Reals, "ValidationOption" -> False];
steps$ = r$["Diagnostics"]["Steps"];
lastVar$ = vars$[[-1]];

VerificationTest[MemberQ[steps$, {"quadraticGB", lastVar$}], True, TestID -> "gb-fallback-used@@Tests/ParamQuadSolve/gb-fallback.wlt:16,1-16,153"]

(* --- merged from: gb-fallback_test2.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x^2 + y^2 == 1, x^2 + 2 y^2 == 2};
vars$ = {x, y};
r$ = pqs[eq$, vars$, "DomainOption" -> Reals, "ValidationOption" -> False];
steps$ = r$["Diagnostics"]["Steps"];
lastVar$ = vars$[[-1]];

VerificationTest[Length[Keys[r$["SignRootMap"]]] >= 1, True, TestID -> "sign-created-after-gb@@Tests/ParamQuadSolve/gb-fallback.wlt:30,1-30,152"]

End[]
EndTestSection[]
