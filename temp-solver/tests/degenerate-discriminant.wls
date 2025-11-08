(* Degenerate discriminant: x^2 == 0 collapses branches *)

Module[{testDir, pkgPath, eq, vars, r, signs, rules, tuples, uniqueTuples},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "", DirectoryName[$InputFileName], Directory[]];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  Get[pkgPath];

  eq = {x^2 + 2 x + 1 == 0, y == x + 1};
  vars = {x, y};
  r = ParamQuadSolver`ParamQuadSolve[eq, vars, Domain -> Reals, Validation -> True];
  signs = Keys[r["SignRootMap"]];
  rules = If[Length[signs] == 0, {r["Solution"]}, (r["Solution"] /. Thread[signs -> #]) & /@ Tuples[{-1, 1}, Length[signs]]];
  tuples = N[(vars /. #) & /@ rules, 30];
  uniqueX = DeleteDuplicates[tuples[[All, 1]], (Abs[#1 - #2] < 1.*^-12) &];

  Print @ TestReport @ {
    VerificationTest[Length[rules] >= 1, True, TestID -> "enumerated"],
    VerificationTest[Length[uniqueX] == 1, True, TestID -> "collapsed-branches"]
  };
]
