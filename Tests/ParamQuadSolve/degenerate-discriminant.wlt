BeginTestSection["degenerate-discriminant Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`degenerateDiscriminant`"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

VerificationTest[
  Module[{x, y, eq, vars, r, signs, rules},
    eq = {x^2 + 2 x + 1 == 0, y == x + 1};
    vars = {x, y};
    r = pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> True];
    signs = Keys[r["SignRootMap"]];
    rules = If[Length[signs] == 0, {r["Solution"]}, (r["Solution"] /. Thread[signs -> #]) & /@ Tuples[{-1, 1}, Length[signs]]];
    Length[rules] >= 1
  ],
  True,
  {},
  TestID -> "enumerated@@Tests/ParamQuadSolve/degenerate-discriminant.wlt:10,1-22,2"
]

VerificationTest[
  Module[{x, y, eq, vars, r, signs, rules, tuples, uniqueX},
    eq = {x^2 + 2 x + 1 == 0, y == x + 1};
    vars = {x, y};
    r = pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> True];
    signs = Keys[r["SignRootMap"]];
    rules = If[Length[signs] == 0, {r["Solution"]}, (r["Solution"] /. Thread[signs -> #]) & /@ Tuples[{-1, 1}, Length[signs]]];
    tuples = N[(vars /. #) & /@ rules, 30];
    uniqueX = DeleteDuplicates[tuples[[All, 1]], (Abs[#1 - #2] < 1.*^-12) &];
    Length[uniqueX] == 1
  ],
  True,
  {},
  TestID -> "collapsed-branches@@Tests/ParamQuadSolve/degenerate-discriminant.wlt:24,1-38,2"
]

End[]
EndTestSection[]
