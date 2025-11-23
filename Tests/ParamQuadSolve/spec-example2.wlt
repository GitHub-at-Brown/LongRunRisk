Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`"];

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

params$ = {vv -> 3/5};
eqns$ = {
  (vv x^2 + y == -3) /. params$,
  (x - y^2 == 0)
};
vars$ = {x, y};

res$ = pqs[eqns$, vars$, Validation -> True, Domain -> Reals];
signKeys$ = Keys[res$["SignRootMap"]];
assigns$ = Tuples[{-1, 1}, Length[signKeys$]];
ourRules$ = Map[(res$["Solution"] /. Thread[signKeys$ -> #]) &, assigns$];
solveRules$ = Solve[eqns$, vars$];
sameQ[r1_, r2_] := Quiet[Chop[N[(vars$ //. r1) - (vars$ //. r2), 50]] == ConstantArray[0, Length[vars$]]];

VerificationTest[AssociationQ[res$], True, TestID -> "returns-association@@Tests/ParamQuadSolve/spec-example2.wlt:32,1-32,128"]
VerificationTest[Length[signKeys$] === 2, True, TestID -> "two-sign-variables@@Tests/ParamQuadSolve/spec-example2.wlt:33,1-33,132"]
VerificationTest[Length[ourRules$] === 4, True, TestID -> "four-branches@@Tests/ParamQuadSolve/spec-example2.wlt:34,1-34,127"]
VerificationTest[And @@ (AllTrue[Simplify[eqns$ //. #], TrueQ] & /@ ourRules$), True, TestID -> "subs-all-branches@@Tests/ParamQuadSolve/spec-example2.wlt:35,1-35,169"]
VerificationTest[Length[solveRules$] == Length[ourRules$], True, TestID -> "solve-count-match@@Tests/ParamQuadSolve/spec-example2.wlt:36,1-36,148"]
VerificationTest[AllTrue[solveRules$, ssol |-> AnyTrue[ourRules$, sameQ[#, ssol] &]], True, TestID -> "matches-Solve@@Tests/ParamQuadSolve/spec-example2.wlt:37,1-37,171"]

End[];
