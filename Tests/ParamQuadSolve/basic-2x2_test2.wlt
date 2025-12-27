BeginTestSection["basic-2x2"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eqns$ = {
  x^2 - 5 == 0,
  y + 2 x - 3 == 0
};
vars$ = {x, y};
res$ = pqs[eqns$, vars$, "ValidationOption" -> True, "DomainOption" -> Reals];
signSym$ = First[Keys[res$["SignRootMap"]]];
rad$ = res$["SignRootMap"][signSym$];

VerificationTest[AllTrue[Flatten@res$["Verification"], TrueQ], True, TestID -> "verification-all-true@@Tests/ParamQuadSolve/basic-2x2_test2.wlt:16,1-16,152"]

EndTestSection[]
