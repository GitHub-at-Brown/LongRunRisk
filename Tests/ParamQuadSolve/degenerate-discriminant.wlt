Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`"];

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x^2 + 2 x + 1 == 0, y == x + 1};
vars$ = {x, y};
r$ = pqs[eq$, vars$, Domain -> Reals, Validation -> True];
signs$ = Keys[r$["SignRootMap"]];
rules$ = If[Length[signs$] == 0, {r$["Solution"]}, (r$["Solution"] /. Thread[signs$ -> #]) & /@ Tuples[{-1, 1}, Length[signs$]]];
tuples$ = N[(vars$ /. #) & /@ rules$, 30];
uniqueX$ = DeleteDuplicates[tuples$[[All, 1]], (Abs[#1 - #2] < 1.*^-12) &];

VerificationTest[Length[rules$] >= 1, True, TestID -> "enumerated@@Tests/ParamQuadSolve/degenerate-discriminant.wlt:26,1-26,130"]
VerificationTest[Length[uniqueX$] == 1, True, TestID -> "collapsed-branches@@Tests/ParamQuadSolve/degenerate-discriminant.wlt:27,1-27,140"]

End[];
