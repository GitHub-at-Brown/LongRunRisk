BeginTestSection["propagation"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`propagation`"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

VerificationTest[
  Module[{x, y, z, eq, vars, r, rhs},
    eq = {x == 1, y == x + 1, z == y + 1};
    vars = {x, y, z};
    r = pqs[eq, vars, "ValidationOption" -> False];
    rhs = r["Solution"][[All, 2]];
    FreeQ[rhs, Alternatives @@ vars]
  ],
  True,
  {},
  TestID -> "rhs-free-of-unknowns@@Tests/ParamQuadSolve/propagation_test1.wlt:10,1-21,2"
]

End[]
EndTestSection[]
