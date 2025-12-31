BeginTestSection["spec-example1 Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`specExample1`"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

VerificationTest[
  Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res},
    params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
    eqns = {
      ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
      (c21 x + c23 x^2 - c24 y == y - 3 x) /. params
    };
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    AssociationQ[res]
  ],
  True,
  {},
  TestID -> "returns-association@@Tests/ParamQuadSolve/spec-example1.wlt:10,1-24,2"
]

VerificationTest[
  Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys},
    params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
    eqns = {
      ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
      (c21 x + c23 x^2 - c24 y == y - 3 x) /. params
    };
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    Length[signKeys] === 1
  ],
  True,
  {},
  TestID -> "one-sign-variable@@Tests/ParamQuadSolve/spec-example1.wlt:26,1-41,2"
]

VerificationTest[
  Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys, assigns, ourRules},
    params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
    eqns = {
      ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
      (c21 x + c23 x^2 - c24 y == y - 3 x) /. params
    };
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    assigns = Tuples[{-1, 1}, Length[signKeys]];
    ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
    Length[ourRules] === 2
  ],
  True,
  {},
  TestID -> "two-branches@@Tests/ParamQuadSolve/spec-example1.wlt:43,1-60,2"
]

VerificationTest[
  Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys, assigns, ourRules},
    params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
    eqns = {
      ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
      (c21 x + c23 x^2 - c24 y == y - 3 x) /. params
    };
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    assigns = Tuples[{-1, 1}, Length[signKeys]];
    ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
    And @@ (AllTrue[Simplify[eqns //. #], TrueQ] & /@ ourRules)
  ],
  True,
  {},
  TestID -> "subs-all-branches@@Tests/ParamQuadSolve/spec-example1.wlt:62,1-79,2"
]

VerificationTest[
  Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys, assigns, ourRules, solveRules},
    params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
    eqns = {
      ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
      (c21 x + c23 x^2 - c24 y == y - 3 x) /. params
    };
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    assigns = Tuples[{-1, 1}, Length[signKeys]];
    ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
    solveRules = Solve[eqns, vars];
    Length[solveRules] == Length[ourRules]
  ],
  True,
  {},
  TestID -> "solve-count-match@@Tests/ParamQuadSolve/spec-example1.wlt:81,1-99,2"
]

VerificationTest[
  Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys, assigns, ourRules, solveRules, sameQ},
    params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
    eqns = {
      ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
      (c21 x + c23 x^2 - c24 y == y - 3 x) /. params
    };
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    assigns = Tuples[{-1, 1}, Length[signKeys]];
    ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
    solveRules = Solve[eqns, vars];
    sameQ[r1_, r2_] := Quiet[Chop[N[(vars //. r1) - (vars //. r2), 50]] == ConstantArray[0, Length[vars]]];
    AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]]
  ],
  True,
  {},
  TestID -> "matches-Solve@@Tests/ParamQuadSolve/spec-example1.wlt:101,1-120,2"
]

End[]
EndTestSection[]
