BeginTestSection["steps-linear-quadratic Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`stepsLinearQuadratic`"]

(* --- merged from: steps-linear-quadratic_test1.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x^2 - 5 == 0, y + 2 x - 3 == 0};
vars$ = {x, y};
r$ = pqs[eq$, vars$, "DomainOption" -> Reals, "ValidationOption" -> False];
steps$ = r$["Diagnostics"]["Steps"];

VerificationTest[MemberQ[steps$, {"quadratic", x}], True, TestID -> "has-quadratic-x@@Tests/ParamQuadSolve/steps-linear-quadratic.wlt:15,1-15,154"]

(* --- merged from: steps-linear-quadratic_test2.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x^2 - 5 == 0, y + 2 x - 3 == 0};
vars$ = {x, y};
r$ = pqs[eq$, vars$, "DomainOption" -> Reals, "ValidationOption" -> False];
steps$ = r$["Diagnostics"]["Steps"];

VerificationTest[MemberQ[steps$, {"linear", y}] || MemberQ[steps$, {"linear2", y}], True, TestID -> "has-linear-y@@Tests/ParamQuadSolve/steps-linear-quadratic.wlt:28,1-28,183"]

End[]
EndTestSection[]
