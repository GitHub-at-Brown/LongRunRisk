(* No-solution system: x==0 and x==1 with y==0 *)

Module[{testDir, pkgPath, eq, vars, r, leftover, ver},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "", DirectoryName[$InputFileName], Directory[]];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  Get[pkgPath];

  eq = {x == 0, x == 1, y == 0};
  vars = {x, y};
  r = ParamQuadSolver`ParamQuadSolve[eq, vars, Validation -> True];
  leftover = r["Diagnostics"]["LeftoverEquations"];
  ver = r["Verification"];

  Print @ TestReport @ {
    VerificationTest[AssociationQ[r], True, TestID -> "assoc"],
    VerificationTest[Length[leftover] >= 1 || AnyTrue[Flatten@ver, FalseQ], True, TestID -> "signaled-no-solution"]
  };
]

