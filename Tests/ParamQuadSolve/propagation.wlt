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

eq$ = {x == 1, y == x + 1, z == y + 1};
vars$ = {x, y, z};
r$ = pqs[eq$, vars$, Validation -> False];
rhs$ = r$["Solution"][[All, 2]];

VerificationTest[FreeQ[rhs$, Alternatives @@ vars$], True, TestID -> "rhs-free-of-unknowns@@Tests/ParamQuadSolve/propagation.wlt:23,1-23,143"]

End[];
