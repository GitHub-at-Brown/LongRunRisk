(* Tests for OnlyQuadTerms option behaviour *)

Module[{testDir, pkgPath, loadRes},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  Get[pkgPath];

  Print @ TestReport @ {
    VerificationTest[
      ParamQuadSolver`ParamQuadSolve[{x^2 + y^2 + z^2 == 3, x^2 + 2 x - 1 == 0}, {x, y, z}, ParamQuadSolver`OnlyQuadTerms -> True],
      $Failed,
      {ParamQuadSolver`ParamQuadSolve::nocover},
      TestID -> "onlyquad-reject-partial"
    ],

    VerificationTest[
      Module[{eqns, vars, res, solvedVars, diagnostics},
        eqns = {x^2 - 1 == 0, y^2 - 4 == 0, z^2 - 9 == 0};
        vars = {x, y, z};
        res = ParamQuadSolver`ParamQuadSolve[eqns, vars, ParamQuadSolver`OnlyQuadTerms -> True];
        solvedVars = Sort[res["Diagnostics"]["SolvedQuadraticVariables"]];
        diagnostics = res["Diagnostics"];
        AssociationQ[res] &&
        solvedVars === {x, y, z} &&
        diagnostics["DeferredVariables"] === {}
      ],
      True,
      TestID -> "onlyquad-all-covered"
    ],

    VerificationTest[
      Module[{eqns, vars, res, deferredEqns, deferredVars},
        eqns = {x^2 == 1, x^2 + y == 2, y + z == 1};
        vars = {x, y, z};
        res = ParamQuadSolver`ParamQuadSolve[eqns, vars, ParamQuadSolver`OnlyQuadTerms -> True];
        deferredEqns = res["DeferredEquations"];
        deferredVars = res["DeferredVariables"];
        AssociationQ[res] &&
        res["Solution"][[All, 1]] === {x} &&
        Length[deferredEqns] == 2 &&
        Sort[deferredVars] === {y, z}
      ],
      True,
      TestID -> "onlyquad-deferred-output"
    ],

    VerificationTest[
      ParamQuadSolver`ParamQuadSolve[{x + y == 1}, {x, y}, ParamQuadSolver`OnlyQuadTerms -> True],
      $Failed,
      {ParamQuadSolver`ParamQuadSolve::noquad},
      TestID -> "onlyquad-noquadratic"
    ]
  }
]
