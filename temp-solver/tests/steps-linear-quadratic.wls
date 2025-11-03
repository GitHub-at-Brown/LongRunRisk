(* Steps should include a quadratic solve then a linear solve *)

Module[{testDir, pkgPath, eq, vars, r, steps},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "", DirectoryName[$InputFileName], Directory[]];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  Get[pkgPath];

  eq = {x^2 - 5 == 0, y + 2 x - 3 == 0};
  vars = {x, y};
  r = ParamQuadSolver`ParamQuadSolve[eq, vars, ParamQuadSolver`Domain -> Reals, ParamQuadSolver`Validation -> False];
  steps = r["Diagnostics"]["Steps"];

  Print @ TestReport @ {
    VerificationTest[MemberQ[steps, {"quadratic", x}], True, TestID -> "has-quadratic-x"],
    VerificationTest[MemberQ[steps, {"linear", y}] || MemberQ[steps, {"linear2", y}], True, TestID -> "has-linear-y"]
  };
]

