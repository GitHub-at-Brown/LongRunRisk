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

eq$ = {x^2 + y^2 == 1, x^2 + 2 y^2 == 2};
vars$ = {x, y};
r$ = pqs[eq$, vars$, Domain -> Reals, Validation -> False];
steps$ = r$["Diagnostics"]["Steps"];
lastVar$ = vars$[[-1]];

VerificationTest[MemberQ[steps$, {"quadraticGB", lastVar$}], True, TestID -> "gb-fallback-used@@Tests/ParamQuadSolve/gb-fallback.wlt:24,1-24,147"]
VerificationTest[Length[Keys[r$["SignRootMap"]]] >= 1, True, TestID -> "sign-created-after-gb@@Tests/ParamQuadSolve/gb-fallback.wlt:25,1-25,146"]

End[];
