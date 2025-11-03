(* Spec Example 2: two equations, two unknowns, two square roots, four solutions *)

Module[{testDir, pkgPath, eqns, vars, params, res, signKeys, assigns, ourRules, solveRules, sameQ},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  Get[pkgPath];

  params = {vv -> 3/5};
  eqns = {
    (vv x^2 + y == -3) /. params,
    (x - y^2 == 0)
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
    VerificationTest[Length[signKeys] === 2, True, TestID -> "two-sign-variables"],
    VerificationTest[Length[ourRules] === 4, True, TestID -> "four-branches"],
    VerificationTest[And @@ (AllTrue[Simplify[eqns //. #], TrueQ] & /@ ourRules), True, TestID -> "subs-all-branches"],
    VerificationTest[Length[solveRules] == Length[ourRules], True, TestID -> "solve-count-match"],
    VerificationTest[AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]], True, TestID -> "matches-Solve"]
  };
]
