(* Dependency propagation: RHS should not contain unknowns after fixed-point *)

Module[{testDir, pkgPath, eq, vars, r, rhs},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "", DirectoryName[$InputFileName], Directory[]];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  Get[pkgPath];

  eq = {x == 1, y == x + 1, z == y + 1};
  vars = {x, y, z};
  r = ParamQuadSolver`ParamQuadSolve[eq, vars, ParamQuadSolver`Validation -> False];
  rhs = r["Solution"][[All, 2]];

  Print @ TestReport @ {
    VerificationTest[FreeQ[rhs, Alternatives @@ vars], True, TestID -> "rhs-free-of-unknowns"]
  };
]

