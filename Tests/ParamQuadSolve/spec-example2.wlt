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

VerificationTest[AssociationQ[res$], True, TestID -> "returns-association@@Tests/ParamQuadSolve/spec-example2.wlt:22,1-22,128"]
VerificationTest[Length[signKeys$] === 2, True, TestID -> "two-sign-variables@@Tests/ParamQuadSolve/spec-example2.wlt:23,1-23,132"]
VerificationTest[Length[ourRules$] === 4, True, TestID -> "four-branches@@Tests/ParamQuadSolve/spec-example2.wlt:24,1-24,127"]
VerificationTest[And @@ (AllTrue[Simplify[eqns$ //. #], TrueQ] & /@ ourRules$), True, TestID -> "subs-all-branches@@Tests/ParamQuadSolve/spec-example2.wlt:25,1-25,169"]
VerificationTest[Length[solveRules$] == Length[ourRules$], True, TestID -> "solve-count-match@@Tests/ParamQuadSolve/spec-example2.wlt:26,1-26,148"]
VerificationTest[AllTrue[solveRules$, ssol |-> AnyTrue[ourRules$, sameQ[#, ssol] &]], True, TestID -> "matches-Solve@@Tests/ParamQuadSolve/spec-example2.wlt:27,1-27,171"]

EndTestSection[]
