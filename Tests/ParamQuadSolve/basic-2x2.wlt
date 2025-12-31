BeginTestSection["basic-2x2 Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`basic2x2`"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

VerificationTest[
  Module[{x, y, eqns, vars, res},
    eqns = {x^2 - 5 == 0, y + 2 x - 3 == 0};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    AssociationQ[res]
  ],
  True,
  {},
  TestID -> "returns-association@@Tests/ParamQuadSolve/basic-2x2.wlt:10,1-20,2"
]

VerificationTest[
  Module[{x, y, eqns, vars, res},
    eqns = {x^2 - 5 == 0, y + 2 x - 3 == 0};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    AllTrue[Flatten@res["Verification"], TrueQ]
  ],
  True,
  {},
  TestID -> "verification-all-true@@Tests/ParamQuadSolve/basic-2x2.wlt:22,1-32,2"
]

VerificationTest[
  Module[{x, y, eqns, vars, res, signSym},
    eqns = {x^2 - 5 == 0, y + 2 x - 3 == 0};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signSym = First[Keys[res["SignRootMap"]]];
    AllTrue[Simplify[eqns /. res["Solution"] /. signSym -> 1], TrueQ]
  ],
  True,
  {},
  TestID -> "subs-sign-+1@@Tests/ParamQuadSolve/basic-2x2.wlt:34,1-45,2"
]

VerificationTest[
  Module[{x, y, eqns, vars, res, signSym},
    eqns = {x^2 - 5 == 0, y + 2 x - 3 == 0};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signSym = First[Keys[res["SignRootMap"]]];
    AllTrue[Simplify[eqns /. res["Solution"] /. signSym -> -1], TrueQ]
  ],
  True,
  {},
  TestID -> "subs-sign--1@@Tests/ParamQuadSolve/basic-2x2.wlt:47,1-58,2"
]

VerificationTest[
  Module[{x, y, eqns, vars, res, signSym, rad},
    eqns = {x^2 - 5 == 0, y + 2 x - 3 == 0};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signSym = First[Keys[res["SignRootMap"]]];
    rad = res["SignRootMap"][signSym];
    Simplify[rad^2 == 20]
  ],
  True,
  {},
  TestID -> "discriminant-20@@Tests/ParamQuadSolve/basic-2x2.wlt:60,1-72,2"
]

VerificationTest[
  Module[{x, y, eqns, vars, res, signSym, signs, ourRules, solveRules, sameQ},
    eqns = {x^2 - 5 == 0, y + 2 x - 3 == 0};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
    signSym = First[Keys[res["SignRootMap"]]];
    signs = {1, -1};
    ourRules = (res["Solution"] /. signSym -> #) & /@ signs;
    solveRules = Solve[eqns, vars, Reals];
    sameQ[r1_, r2_] := TrueQ@Simplify[(vars /. r1) == (vars /. r2)];
    Length[solveRules] == Length[ourRules] && AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]]
  ],
  True,
  {},
  TestID -> "matches-Solve@@Tests/ParamQuadSolve/basic-2x2.wlt:74,1-89,2"
]

End[]
EndTestSection[]
