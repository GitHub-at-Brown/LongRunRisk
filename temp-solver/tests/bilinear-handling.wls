(* Tests covering bilinear terms and mixed linear/quadratic dependencies *)

Module[{testDir, pkgPath, loadRes, res, steps, eqns, vars},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  Get[pkgPath];

  Print @ TestReport @ {
    (* Bilinear system: x*y - 1 == 0 with y fixed should stay linear after substitution *)
    VerificationTest[
      Module[{eqns1, vars1, res1, steps1, sol},
        eqns1 = {x*y - 1 == 0, y - 2 == 0};
        vars1 = {x, y};
        res1 = ParamQuadSolver`ParamQuadSolve[eqns1, vars1];
        steps1 = res1["Diagnostics"]["Steps"];
        sol = res1["Solution"];
        AssociationQ[res1] &&
        Sort[sol] === Sort[{x -> 1/2, y -> 2}] &&
        FreeQ[steps1, {"quadratic", _}] &&
        FreeQ[steps1, {"quartic", _}]
      ],
      True,
      TestID -> "bilinear-linear-behaviour"
    ],

    (* Mixed system: x^2 + y == 1, y + z == 2.  Solution for x should depend on z. *)
    VerificationTest[
      Module[{eqns2, vars2, res2, sol, signMap, conds, yRule, xRule},
        eqns2 = {x^2 + y == 1, y + z == 2};
        vars2 = {x, y};
        res2 = ParamQuadSolver`ParamQuadSolve[eqns2, vars2];
        sol = res2["Solution"];
        signMap = res2["SignRootMap"];
        conds = res2["Conditions"];
        (* Extract rules by variable name, not position *)
        yRule = SelectFirst[sol, #[[1]] === y &];
        xRule = SelectFirst[sol, #[[1]] === x &];
        AssociationQ[res2] &&
        Simplify[yRule[[2]] == 2 - z] &&
        KeyExistsQ[signMap, ParamQuadSolver`signA[1]] &&
        Simplify[signMap[ParamQuadSolver`signA[1]]^2 == 4*(z - 1)] &&
        MemberQ[conds, z >= 1]
      ],
      True,
      TestID -> "mixed-quadratic-linear-parameter-dependence"
    ]
  }
]
