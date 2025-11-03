(* Two radicals + one bilinear-term unit test for ParamQuadSolve *)

Module[{testDir, pkgPath, eqns, vars, res, signKeys, radVals, radSq, rulesFor},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  Get[pkgPath];

  (* System: 3 vars, two quadratics (y,z), one bilinear linear-in-x equation *)
  eqns = {
    y^2 - 2 == 0,
    x*y + x - 1 == 0,
    z^2 + z - 3 == 0
  };
  vars = {x, y, z};

  res = ParamQuadSolver`ParamQuadSolve[eqns, vars,
    ParamQuadSolver`Validation -> True,
    ParamQuadSolver`Domain -> Reals
  ];

  signKeys = Keys[res["SignRootMap"]];
  radVals = Values[res["SignRootMap"]];
  radSq = Simplify[radVals^2];
  rulesFor[v1_, v2_] := Thread[signKeys -> {v1, v2}];

  Print @ TestReport @ {
    VerificationTest[AssociationQ[res], True, TestID -> "returns-association"],
    VerificationTest[Length[signKeys] === 2, True, TestID -> "two-sign-variables"],
    VerificationTest[Sort[Simplify /@ radSq] === Sort[{8, 13}], True, TestID -> "radicands-8-and-13"],
    VerificationTest[
      AllTrue[
        Simplify[res["Verification"] /. (ParamQuadSolver`signA|signA)[_]^2 -> 1],
        TrueQ
      ],
      True,
      TestID -> "verification-all-true"
    ],
    VerificationTest[AllTrue[Simplify[eqns /. res["Solution"] /. rulesFor[1, 1]], TrueQ], True, TestID -> "subs-++"],
    VerificationTest[AllTrue[Simplify[eqns /. res["Solution"] /. rulesFor[1, -1]], TrueQ], True, TestID -> "subs-+-"],
    VerificationTest[AllTrue[Simplify[eqns /. res["Solution"] /. rulesFor[-1, 1]], TrueQ], True, TestID -> "subs--+"],
    VerificationTest[AllTrue[Simplify[eqns /. res["Solution"] /. rulesFor[-1, -1]], TrueQ], True, TestID -> "subs----"],
    (* Cross-check against Solve: enumerate all four sign assignments and compare sets *)
    VerificationTest[
      Module[{assigns, ourRules, solveRules, sameQ},
        assigns = Tuples[{-1, 1}, Length[signKeys]];
        ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
        solveRules = Solve[eqns, vars, Reals];
        sameQ[r1_, r2_] := TrueQ@Simplify[(vars /. r1) == (vars /. r2)];
        Length[solveRules] == Length[ourRules] &&
          AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]]
      ],
      True, TestID -> "matches-Solve"
    ]
  };
]
