Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`"];

Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d], d = DirectoryName[d]];
  pacletRoot = d;
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "ComputationalEngine", "ParamQuadSolve.wl"}]];
  On[General::shdw];
];

pqs = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`Private`paramQuadSolve"];

eq$ = {x^2 - 5 == 0, y + 2 x - 3 == 0};
vars$ = {x, y};
r$ = pqs[eq$, vars$, Domain -> Reals, Validation -> False];
steps$ = r$["Diagnostics"]["Steps"];

VerificationTest[MemberQ[steps$, {"quadratic", x}], True, TestID -> "has-quadratic-x@@Tests/ParamQuadSolve/steps-linear-quadratic.wlt:23,1-23,148"]
VerificationTest[MemberQ[steps$, {"linear", y}] || MemberQ[steps$, {"linear2", y}], True, TestID -> "has-linear-y@@Tests/ParamQuadSolve/steps-linear-quadratic.wlt:24,1-24,177"]

End[];
