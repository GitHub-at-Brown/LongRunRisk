BeginTestSection["spec-example2 Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`specExample2`"]

(* --- merged from: spec-example2_test1.wlt --- *)
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

VerificationTest[AssociationQ[res$], True, TestID -> "returns-association@@Tests/ParamQuadSolve/spec-example2.wlt:24,1-24,134"]

(* --- merged from: spec-example2_test2.wlt --- *)
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

VerificationTest[Length[signKeys$] === 2, True, TestID -> "two-sign-variables@@Tests/ParamQuadSolve/spec-example2.wlt:46,1-46,138"]

(* --- merged from: spec-example2_test3.wlt --- *)
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

VerificationTest[Length[ourRules$] === 4, True, TestID -> "four-branches@@Tests/ParamQuadSolve/spec-example2.wlt:68,1-68,133"]

(* --- merged from: spec-example2_test4.wlt --- *)
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

VerificationTest[And @@ (AllTrue[Simplify[eqns$ //. #], TrueQ] & /@ ourRules$), True, TestID -> "subs-all-branches@@Tests/ParamQuadSolve/spec-example2.wlt:90,1-90,175"]

(* --- merged from: spec-example2_test5.wlt --- *)
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

VerificationTest[Length[solveRules$] == Length[ourRules$], True, TestID -> "solve-count-match@@Tests/ParamQuadSolve/spec-example2.wlt:112,1-112,154"]

(* --- merged from: spec-example2_test6.wlt --- *)
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

VerificationTest[AllTrue[solveRules$, ssol |-> AnyTrue[ourRules$, sameQ[#, ssol] &]], True, TestID -> "matches-Solve@@Tests/ParamQuadSolve/spec-example2.wlt:134,1-134,177"]

End[]
EndTestSection[]
