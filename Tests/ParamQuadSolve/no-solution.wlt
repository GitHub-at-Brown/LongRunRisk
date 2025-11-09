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

eq$ = {x == 0, x == 1, y == 0};
vars$ = {x, y};
r$ = pqs[eq$, vars$, Validation -> True];
leftover$ = r$["Diagnostics"]["LeftoverEquations"];
ver$ = r$["Verification"];

VerificationTest[AssociationQ[r$], True, TestID -> "assoc@@Tests/ParamQuadSolve/no-solution.wlt:24,1-24,110"]
VerificationTest[Length[leftover$] >= 1 || AnyTrue[Flatten@ver$, FalseQ], True, TestID -> "signaled-no-solution@@Tests/ParamQuadSolve/no-solution.wlt:25,1-25,164"]

End[];
