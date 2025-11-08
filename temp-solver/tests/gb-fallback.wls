(* GB fallback should be used when no equation is linear or univariate initially *)

Module[{testDir, pkgPath, eq, vars, r, steps, lastVar},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "", DirectoryName[$InputFileName], Directory[]];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  Get[pkgPath];

  eq = {x^2 + y^2 == 1, x^2 + 2 y^2 == 2};
  vars = {x, y};
  r = ParamQuadSolver`ParamQuadSolve[eq, vars, Domain -> Reals, Validation -> False];
  steps = r["Diagnostics"]["Steps"];
  lastVar = vars[[-1]];

  Print @ TestReport @ {
    VerificationTest[MemberQ[steps, {"quadraticGB", lastVar}], True, TestID -> "gb-fallback-used"],
    VerificationTest[Length[Keys[r["SignRootMap"]]] >= 1, True, TestID -> "sign-created-after-gb"]
  };
]

