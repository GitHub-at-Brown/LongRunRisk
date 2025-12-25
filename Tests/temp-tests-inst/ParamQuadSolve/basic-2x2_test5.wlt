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

VerificationTest[Simplify[rad$^2 == 20], True, TestID -> "discriminant-20@@Tests/ParamQuadSolve/basic-2x2.wlt:20,1-20,124"]

EndTestSection[]
