BeginTestSection["no-solution Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`noSolution`"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

VerificationTest[
  Module[{x, y, eq, vars, r},
    eq = {x == 0, x == 1, y == 0};
    vars = {x, y};
    r = pqs[eq, vars, "ValidationOption" -> True];
    AssociationQ[r]
  ],
  True,
  {},
  TestID -> "assoc@@Tests/ParamQuadSolve/no-solution.wlt:10,1-20,2"
]

VerificationTest[
  Module[{x, y, eq, vars, r, leftover, ver},
    eq = {x == 0, x == 1, y == 0};
    vars = {x, y};
    r = pqs[eq, vars, "ValidationOption" -> True];
    leftover = r["Diagnostics"]["LeftoverEquations"];
    ver = r["Verification"];
    Length[leftover] >= 1 || AnyTrue[Flatten@ver, FalseQ]
  ],
  True,
  {},
  TestID -> "signaled-no-solution@@Tests/ParamQuadSolve/no-solution.wlt:22,1-34,2"
]

End[]
EndTestSection[]
