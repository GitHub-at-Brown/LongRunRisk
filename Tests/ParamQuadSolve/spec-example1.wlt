Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`"];

Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d], d = DirectoryName[d]];
  pacletRoot = d;
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "ComputationalEngine", "ParamQuadSolve.wl"}]];
  On[General::shdw];
];

pqs = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`Private`paramQuadSolve"];

params$ = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
eqns$ = {
  ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params$,
  (c21 x + c23 x^2 - c24 y == y - 3 x) /. params$
};
vars$ = {x, y};

res$ = pqs[eqns$, vars$, Validation -> True, Domain -> Reals];
signKeys$ = Keys[res$["SignRootMap"]];
assigns$ = Tuples[{-1, 1}, Length[signKeys$]];
ourRules$ = Map[(res$["Solution"] /. Thread[signKeys$ -> #]) &, assigns$];
solveRules$ = Solve[eqns$, vars$];
sameQ[r1_, r2_] := Quiet[Chop[N[(vars$ //. r1) - (vars$ //. r2), 50]] == ConstantArray[0, Length[vars$]]];

VerificationTest[AssociationQ[res$], True, TestID -> "returns-association@@Tests/ParamQuadSolve/spec-example1.wlt:32,1-32,128"]
VerificationTest[Length[signKeys$] === 1, True, TestID -> "one-sign-variable@@Tests/ParamQuadSolve/spec-example1.wlt:33,1-33,131"]
VerificationTest[Length[ourRules$] === 2, True, TestID -> "two-branches@@Tests/ParamQuadSolve/spec-example1.wlt:34,1-34,126"]
VerificationTest[And @@ (AllTrue[Simplify[eqns$ //. #], TrueQ] & /@ ourRules$), True, TestID -> "subs-all-branches@@Tests/ParamQuadSolve/spec-example1.wlt:35,1-35,169"]
VerificationTest[Length[solveRules$] == Length[ourRules$], True, TestID -> "solve-count-match@@Tests/ParamQuadSolve/spec-example1.wlt:36,1-36,148"]
VerificationTest[AllTrue[solveRules$, ssol |-> AnyTrue[ourRules$, sameQ[#, ssol] &]], True, TestID -> "matches-Solve@@Tests/ParamQuadSolve/spec-example1.wlt:37,1-37,171"]

End[];
