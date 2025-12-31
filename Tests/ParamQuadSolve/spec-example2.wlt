BeginTestSection["spec-example2 Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`specExample2`"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

VerificationTest[
  Module[{x, y, vv, params, eqns, vars, res},
    params = {vv -> 3/5};
    eqns = {(vv x^2 + y == -3) /. params, (x - y^2 == 0)};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    AssociationQ[res]
  ],
  True,
  {},
  TestID -> "returns-association@@Tests/ParamQuadSolve/spec-example2.wlt:10,1-21,2"
]

VerificationTest[
  Module[{x, y, vv, params, eqns, vars, res, signKeys},
    params = {vv -> 3/5};
    eqns = {(vv x^2 + y == -3) /. params, (x - y^2 == 0)};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    Length[signKeys] === 2
  ],
  True,
  {},
  TestID -> "two-sign-variables@@Tests/ParamQuadSolve/spec-example2.wlt:23,1-35,2"
]

VerificationTest[
  Module[{x, y, vv, params, eqns, vars, res, signKeys, assigns, ourRules},
    params = {vv -> 3/5};
    eqns = {(vv x^2 + y == -3) /. params, (x - y^2 == 0)};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    assigns = Tuples[{-1, 1}, Length[signKeys]];
    ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
    Length[ourRules] === 4
  ],
  True,
  {},
  TestID -> "four-branches@@Tests/ParamQuadSolve/spec-example2.wlt:37,1-51,2"
]

VerificationTest[
  Module[{x, y, vv, params, eqns, vars, res, signKeys, assigns, ourRules},
    params = {vv -> 3/5};
    eqns = {(vv x^2 + y == -3) /. params, (x - y^2 == 0)};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    assigns = Tuples[{-1, 1}, Length[signKeys]];
    ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
    And @@ (AllTrue[Simplify[eqns //. #], TrueQ] & /@ ourRules)
  ],
  True,
  {},
  TestID -> "subs-all-branches@@Tests/ParamQuadSolve/spec-example2.wlt:53,1-67,2"
]

VerificationTest[
  Module[{x, y, vv, params, eqns, vars, res, signKeys, assigns, ourRules, solveRules},
    params = {vv -> 3/5};
    eqns = {(vv x^2 + y == -3) /. params, (x - y^2 == 0)};
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
  TestID -> "solve-count-match@@Tests/ParamQuadSolve/spec-example2.wlt:69,1-84,2"
]

VerificationTest[
  Module[{x, y, vv, params, eqns, vars, res, signKeys, assigns, ourRules, solveRules, sameQ},
    params = {vv -> 3/5};
    eqns = {(vv x^2 + y == -3) /. params, (x - y^2 == 0)};
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
  TestID -> "matches-Solve@@Tests/ParamQuadSolve/spec-example2.wlt:86,1-102,2"
]

End[]
EndTestSection[]
