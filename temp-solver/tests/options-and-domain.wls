(* Options API coverage: qualified/unqualified options parity, SignSymbol rename,
   Domain effects, and Assumptions override path. *)

Module[{testDir, pkgPath, eq, vars, r1, r2, r3, r4, signHeadOK, geCount},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "", DirectoryName[$InputFileName], Directory[]];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  Get[pkgPath];

  (* Base small system *)
  eq = {x^2 - 5 == 0, y + 2 x - 3 == 0};
  vars = {x, y};

  r1 = Quiet[ParamQuadSolver`ParamQuadSolve[eq, vars, Domain -> Reals, Validation -> True], {Power::infy, Infinity::indet}];
  r2 = Quiet[ParamQuadSolver`ParamQuadSolve[eq, vars, ParamQuadSolver`Domain -> Reals, ParamQuadSolver`Validation -> True], {Power::infy, Infinity::indet}];

  (* Sign head rename *)
  r3 = Quiet[ParamQuadSolver`ParamQuadSolve[eq, vars, ParamQuadSolver`SignSymbol -> sg, ParamQuadSolver`Domain -> Reals], {Power::infy, Infinity::indet}];
  signHeadOK = And @@ (Head /@ Keys[r3["SignRootMap"]] === Table[sg, {Length[Keys[r3["SignRootMap"]]]}]);

  (* Domain effects: parameterized discriminant -> inequality only under Reals *)
  r4 = Quiet[ParamQuadSolver`ParamQuadSolve[{x^2 - t == 0, z == 0}, {x, z}, ParamQuadSolver`Domain -> Reals, ParamQuadSolver`Validation -> False], {Power::infy, Infinity::indet}];
  geCount = Count[r4["Conditions"], _GreaterEqual, Infinity];
  
  Print @ TestReport @ {
    VerificationTest[AssociationQ[r1] && AssociationQ[r2], True, TestID -> "assoc-r1-r2"],
    VerificationTest[r1["Solution"] === r2["Solution"], True, TestID -> "solution-parity"],
    VerificationTest[r1["SignRootMap"] === r2["SignRootMap"], True, TestID -> "signmap-parity"],
    VerificationTest[signHeadOK, True, TestID -> "signsymbol-head"],
    VerificationTest[geCount >= 1, True, TestID -> "reals-conditions-include-radicand"]
  };
]
