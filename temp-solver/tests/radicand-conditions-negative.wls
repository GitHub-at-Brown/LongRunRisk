(* Negative discriminant should yield False condition without warnings *)

Module[{testDir, pkgPath, params, eqns, vars, res, r, conds, radMap, signKeys},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  Get[pkgPath];

  params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4,
            c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
  eqns = {
    ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
    (c21 x + c23 x^2 - c24 y == y - 3 x) /. params
  };
  vars = {x, y};

  r = Check[ParamQuadSolver`ParamQuadSolve[eqns, vars, Validation -> True, Domain -> Reals], "fail", GreaterEqual::nord];
  conds = If[r === "fail", {}, r["Conditions"]];
  radMap = If[r === "fail", <||>, r["Diagnostics"]["SignRadicandMap"]];

  Print @ TestReport @ {
    VerificationTest[r =!= "fail", True, TestID -> "no-nord-warning"],
    VerificationTest[MemberQ[conds, False], True, TestID -> "false-condition-present"],
    VerificationTest[AssociationQ[radMap], True, TestID -> "radicand-map-present"]
  };
]

