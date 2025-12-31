BeginTestSection["steps-linear-quadratic Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`stepsLinearQuadratic`"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

VerificationTest[
  Module[{x, y, eq, vars, r, steps},
    eq = {x^2 - 5 == 0, y + 2 x - 3 == 0};
    vars = {x, y};
    r = pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
    steps = r["Diagnostics"]["Steps"];
    MemberQ[steps, {"quadratic", x}]
  ],
  True,
  {},
  TestID -> "has-quadratic-x@@Tests/ParamQuadSolve/steps-linear-quadratic.wlt:10,1-21,2"
]

VerificationTest[
  Module[{x, y, eq, vars, r, steps},
    eq = {x^2 - 5 == 0, y + 2 x - 3 == 0};
    vars = {x, y};
    r = pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
    steps = r["Diagnostics"]["Steps"];
    MemberQ[steps, {"linear", y}] || MemberQ[steps, {"linear2", y}]
  ],
  True,
  {},
  TestID -> "has-linear-y@@Tests/ParamQuadSolve/steps-linear-quadratic.wlt:23,1-34,2"
]

End[]
EndTestSection[]
