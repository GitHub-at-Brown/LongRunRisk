(* Preprocessing: denominator conditions and coefficient map basic checks *)

Module[{testDir, pkgPath, eq, vars, r, conds, hasPsiDen, hasExpDen, coeffKeysOK, noDummyInSol},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "", DirectoryName[$InputFileName], Directory[]];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  Get[pkgPath];

  eq = {x == a/(1 - 1/psi), y == b/(1 + Exp[A[0]])};
  vars = {x, y};
  r = ParamQuadSolver`ParamQuadSolve[eq, vars, ParamQuadSolver`Domain -> Reals, ParamQuadSolver`Validation -> False];
  conds = r["Conditions"];
  condExpr = And @@ conds;
  hasPsiDen = Simplify[condExpr /. psi -> 1] === False;
  hasExpDen = Simplify[condExpr /. Exp[A[0]] -> -1] === False;

  coeffKeysOK = AssociationQ[r["CoeffMap"]] && Length[r["CoeffMap"]] >= 1;
  noDummyInSol = FreeQ[r["Solution"], _Symbol?(StringMatchQ[SymbolName[#], "c$*"] & )];

  Print @ TestReport @ {
    VerificationTest[hasPsiDen, True, TestID -> "psi-denom-cond"],
    VerificationTest[hasExpDen, True, TestID -> "exp-denom-cond"],
    VerificationTest[coeffKeysOK, True, TestID -> "coeffmap-present"],
    VerificationTest[noDummyInSol, True, TestID -> "no-dummy-in-solution"]
  };
]
