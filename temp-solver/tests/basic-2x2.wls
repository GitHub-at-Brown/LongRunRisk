(* Basic 2x2 unit test for ParamQuadSolve *)

Module[{testDir, pkgPath, loadRes, eqns, vars, res, signSym, rad},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  Get[pkgPath];

  eqns = {
    x^2 - 5 == 0,
    y + 2 x - 3 == 0
  };
  vars = {x, y};

  res = ParamQuadSolver`ParamQuadSolve[eqns, vars, Validation -> True, Domain -> Reals];
  signSym = First[Keys[res["SignRootMap"]]];
  rad = res["SignRootMap"][signSym];

  Print @ TestReport @ {
    VerificationTest[AssociationQ[res], True, TestID -> "returns-association"],
    VerificationTest[AllTrue[Flatten@res["Verification"], TrueQ], True, TestID -> "verification-all-true"],
    VerificationTest[AllTrue[Simplify[eqns /. res["Solution"] /. signSym -> 1], TrueQ], True, TestID -> "subs-sign-+1"],
    VerificationTest[AllTrue[Simplify[eqns /. res["Solution"] /. signSym -> -1], TrueQ], True, TestID -> "subs-sign--1"],
    VerificationTest[Simplify[rad^2 == 20], True, TestID -> "discriminant-20"],
    VerificationTest[
      Module[{signs, ourRules, solveRules, sameQ},
        signs = {1, -1};
        ourRules = (res["Solution"] /. signSym -> #) & /@ signs;
        solveRules = Solve[eqns, vars, Reals];
        sameQ[r1_, r2_] := TrueQ@Simplify[(vars /. r1) == (vars /. r2)];
        Length[solveRules] == Length[ourRules] &&
          AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]]
      ],
      True, TestID -> "matches-Solve"
    ]
  };
]
