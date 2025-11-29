Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`"];

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

params$ = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
eqns$ = {
  ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params$,
  (c21 x + c23 x^2 - c24 y == y - 3 x) /. params$
};
vars$ = {x, y};

res$ = pqs[eqns$, vars$, "ValidationOption" -> True, "DomainOption" -> Reals];
signKeys$ = Keys[res$["SignRootMap"]];
assigns$ = Tuples[{-1, 1}, Length[signKeys$]];
ourRules$ = Map[(res$["Solution"] /. Thread[signKeys$ -> #]) &, assigns$];
solveRules$ = Solve[eqns$, vars$];
sameQ[r1_, r2_] := Quiet[Chop[N[(vars$ //. r1) - (vars$ //. r2), 50]] == ConstantArray[0, Length[vars$]]];

VerificationTest[AssociationQ[res$], True, TestID -> "returns-association@@Tests/ParamQuadSolve/spec-example1.wlt:22,1-22,128"]
VerificationTest[Length[signKeys$] === 1, True, TestID -> "one-sign-variable@@Tests/ParamQuadSolve/spec-example1.wlt:23,1-23,131"]
VerificationTest[Length[ourRules$] === 2, True, TestID -> "two-branches@@Tests/ParamQuadSolve/spec-example1.wlt:24,1-24,126"]
VerificationTest[And @@ (AllTrue[Simplify[eqns$ //. #], TrueQ] & /@ ourRules$), True, TestID -> "subs-all-branches@@Tests/ParamQuadSolve/spec-example1.wlt:25,1-25,169"]
VerificationTest[Length[solveRules$] == Length[ourRules$], True, TestID -> "solve-count-match@@Tests/ParamQuadSolve/spec-example1.wlt:26,1-26,148"]
VerificationTest[AllTrue[solveRules$, ssol |-> AnyTrue[ourRules$, sameQ[#, ssol] &]], True, TestID -> "matches-Solve@@Tests/ParamQuadSolve/spec-example1.wlt:27,1-27,171"]

End[];
