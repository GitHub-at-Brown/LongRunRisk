BeginTestSection["gb-fallback Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`gbFallback`"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

VerificationTest[
  Module[{x, y, eq, vars, r, steps, lastVar},
    eq = {x^2 + y^2 == 1, x^2 + 2 y^2 == 2};
    vars = {x, y};
    r = pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
    steps = r["Diagnostics"]["Steps"];
    lastVar = vars[[-1]];
    MemberQ[steps, {"quadraticGB", lastVar}]
  ],
  True,
  {},
  TestID -> "gb-fallback-used@@Tests/ParamQuadSolve/gb-fallback.wlt:10,1-22,2"
]

VerificationTest[
  Module[{x, y, eq, vars, r},
    eq = {x^2 + y^2 == 1, x^2 + 2 y^2 == 2};
    vars = {x, y};
    r = pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
    Length[Keys[r["SignRootMap"]]] >= 1
  ],
  True,
  {},
  TestID -> "sign-created-after-gb@@Tests/ParamQuadSolve/gb-fallback.wlt:24,1-34,2"
]

End[]
EndTestSection[]
