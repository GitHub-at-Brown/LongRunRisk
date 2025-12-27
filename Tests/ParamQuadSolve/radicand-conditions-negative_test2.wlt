BeginTestSection["radicand-conditions-negative"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

params$ = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4,
            c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
eqns$ = {
  ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params$,
  (c21 x + c23 x^2 - c24 y == y - 3 x) /. params$
};
vars$ = {x, y};

r$ = Quiet@Check[pqs[eqns$, vars$, "ValidationOption" -> True, "DomainOption" -> Reals], "fail", GreaterEqual::nord];
conds$ = If[r$ === "fail", {}, r$["Conditions"]];
radMap$ = If[r$ === "fail", <||>, r$["Diagnostics"]["SignRadicandMap"]];

VerificationTest[MemberQ[conds$, False], True, TestID -> "false-condition-present@@Tests/ParamQuadSolve/radicand-conditions-negative_test2.wlt:20,1-20,151"]

EndTestSection[]
