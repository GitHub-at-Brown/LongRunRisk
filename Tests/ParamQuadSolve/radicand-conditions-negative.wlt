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

params$ = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4,
            c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
eqns$ = {
  ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params$,
  (c21 x + c23 x^2 - c24 y == y - 3 x) /. params$
};
vars$ = {x, y};

r$ = Quiet@Check[pqs[eqns$, vars$, Validation -> True, Domain -> Reals], "fail", GreaterEqual::nord];
conds$ = If[r$ === "fail", {}, r$["Conditions"]];
radMap$ = If[r$ === "fail", <||>, r$["Diagnostics"]["SignRadicandMap"]];

VerificationTest[r$ =!= "fail", True, TestID -> "no-nord-warning@@Tests/ParamQuadSolve/radicand-conditions-negative.wlt:30,1-30,134"]
VerificationTest[MemberQ[conds$, False], True, TestID -> "false-condition-present@@Tests/ParamQuadSolve/radicand-conditions-negative.wlt:31,1-31,151"]
VerificationTest[AssociationQ[radMap$], True, TestID -> "radicand-map-present@@Tests/ParamQuadSolve/radicand-conditions-negative.wlt:32,1-32,147"]

End[];
