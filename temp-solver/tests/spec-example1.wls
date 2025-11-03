(* Spec Example 1: two equations, two unknowns, one square root, two solutions *)

Module[{testDir, pkgPath, eqns, vars, params, res, signKeys, assigns, ourRules, solveRules, sameQ},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  Get[pkgPath];

  (* Spec system with numeric parameters to avoid degeneracy and keep speed *)
  params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
  eqns = {
    ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
    (c21 x + c23 x^2 - c24 y == y - 3 x) /. params
  };
  vars = {x, y};

  res = ParamQuadSolver`ParamQuadSolve[eqns, vars, ParamQuadSolver`Validation -> True, ParamQuadSolver`Domain -> Reals];
  signKeys = Keys[res["SignRootMap"]];
  assigns = Tuples[{-1, 1}, Length[signKeys]];
  ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
  solveRules = Solve[eqns, vars];
  sameQ[r1_, r2_] := Quiet[Chop[N[(vars //. r1) - (vars //. r2), 50]] == ConstantArray[0, Length[vars]]];

  Print @ TestReport @ {
    VerificationTest[AssociationQ[res], True, TestID -> "returns-association"],
    VerificationTest[Length[signKeys] === 1, True, TestID -> "one-sign-variable"],
    VerificationTest[Length[ourRules] === 2, True, TestID -> "two-branches"],
    VerificationTest[And @@ (AllTrue[Simplify[eqns //. #], TrueQ] & /@ ourRules), True, TestID -> "subs-all-branches"],
    VerificationTest[Length[solveRules] == Length[ourRules], True, TestID -> "solve-count-match"],
    VerificationTest[AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]], True, TestID -> "matches-Solve"]
  };
]
