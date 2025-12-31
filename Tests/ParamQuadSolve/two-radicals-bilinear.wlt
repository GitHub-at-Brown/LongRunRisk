BeginTestSection["two-radicals-bilinear Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`twoRadicalsBilinear`"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

VerificationTest[
  Module[{x, y, z, eqns, vars, res},
    eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
    vars = {x, y, z};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    AssociationQ[res]
  ],
  True,
  {},
  TestID -> "returns-association@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:10,1-20,2"
]

VerificationTest[
  Module[{x, y, z, eqns, vars, res, signKeys},
    eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
    vars = {x, y, z};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    Length[signKeys] === 2
  ],
  True,
  {},
  TestID -> "two-sign-variables@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:22,1-33,2"
]

VerificationTest[
  Module[{x, y, z, eqns, vars, res, signKeys, radVals, radSq},
    eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
    vars = {x, y, z};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    radVals = Values[res["SignRootMap"]];
    radSq = Simplify[radVals^2];
    Sort[Simplify /@ radSq] === Sort[{8, 13}]
  ],
  True,
  {},
  TestID -> "radicands-8-and-13@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:35,1-48,2"
]

VerificationTest[
  Module[{x, y, z, eqns, vars, res, signKeys, heads},
    eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
    vars = {x, y, z};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    heads = DeleteDuplicates[Head /@ signKeys];
    AllTrue[Simplify[res["Verification"] /. (Alternatives @@ ((#[_]^2) & /@ heads)) -> 1], TrueQ]
  ],
  True,
  {},
  TestID -> "verification-all-true@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:50,1-62,2"
]

VerificationTest[
  Module[{x, y, z, eqns, vars, res, signKeys, rulesFor},
    eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
    vars = {x, y, z};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    rulesFor[v1_, v2_] := Thread[signKeys -> {v1, v2}];
    AllTrue[Simplify[eqns /. res["Solution"] /. rulesFor[1, 1]], TrueQ]
  ],
  True,
  {},
  TestID -> "subs-++@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:64,1-76,2"
]

VerificationTest[
  Module[{x, y, z, eqns, vars, res, signKeys, rulesFor},
    eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
    vars = {x, y, z};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    rulesFor[v1_, v2_] := Thread[signKeys -> {v1, v2}];
    AllTrue[Simplify[eqns /. res["Solution"] /. rulesFor[1, -1]], TrueQ]
  ],
  True,
  {},
  TestID -> "subs-+-@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:78,1-90,2"
]

VerificationTest[
  Module[{x, y, z, eqns, vars, res, signKeys, rulesFor},
    eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
    vars = {x, y, z};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    rulesFor[v1_, v2_] := Thread[signKeys -> {v1, v2}];
    AllTrue[Simplify[eqns /. res["Solution"] /. rulesFor[-1, 1]], TrueQ]
  ],
  True,
  {},
  TestID -> "subs--+@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:92,1-104,2"
]

VerificationTest[
  Module[{x, y, z, eqns, vars, res, signKeys, rulesFor},
    eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
    vars = {x, y, z};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    rulesFor[v1_, v2_] := Thread[signKeys -> {v1, v2}];
    AllTrue[Simplify[eqns /. res["Solution"] /. rulesFor[-1, -1]], TrueQ]
  ],
  True,
  {},
  TestID -> "subs----@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:106,1-118,2"
]

VerificationTest[
  Module[{x, y, z, eqns, vars, res, signKeys, assigns, ourRules, solveRules, sameQ},
    eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
    vars = {x, y, z};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signKeys = Keys[res["SignRootMap"]];
    assigns = Tuples[{-1, 1}, Length[signKeys]];
    ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
    solveRules = Solve[eqns, vars, Reals];
    sameQ[r1_, r2_] := TrueQ@Simplify[(vars /. r1) == (vars /. r2)];
    Length[solveRules] == Length[ourRules] && AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]]
  ],
  True,
  {},
  TestID -> "matches-Solve@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:120,1-135,2"
]

End[]
EndTestSection[]
