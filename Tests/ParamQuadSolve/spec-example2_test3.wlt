BeginTestSection["spec-example2"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

params$ = {vv -> 3/5};
eqns$ = {
  (vv x^2 + y == -3) /. params$,
  (x - y^2 == 0)
};
vars$ = {x, y};

res$ = pqs[eqns$, vars$, "ValidationOption" -> True, "DomainOption" -> Reals];
signKeys$ = Keys[res$["SignRootMap"]];
assigns$ = Tuples[{-1, 1}, Length[signKeys$]];
ourRules$ = Map[(res$["Solution"] /. Thread[signKeys$ -> #]) &, assigns$];
solveRules$ = Solve[eqns$, vars$];
sameQ[r1_, r2_] := Quiet[Chop[N[(vars$ //. r1) - (vars$ //. r2), 50]] == ConstantArray[0, Length[vars$]]];

VerificationTest[Length[ourRules$] === 4, True, TestID -> "four-branches@@Tests/ParamQuadSolve/spec-example2_test3.wlt:22,1-22,127"]

EndTestSection[]
