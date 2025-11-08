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
      Module[{eqns, vars, res, solvedVars, deferredVars, diagnostics},
        eqns = {x^2 + y^2 + z^2 == 3, x^2 + 2 x - 1 == 0};
        vars = {x, y, z};
        res = ParamQuadSolver`ParamQuadSolve[eqns, vars, ParamQuadSolver`OnlyQuadTerms -> True];
        solvedVars = Sort[res["Solution"][[All, 1]]];
        deferredVars = res["DeferredVariables"];
        diagnostics = res["Diagnostics"];
        AssociationQ[res] &&
        solvedVars === {x, y} &&
        deferredVars === {z} &&
        diagnostics["OnlyQuadTermsApplied"] === True
      ],
      True,
      TestID -> "onlyquad-selects-subset"
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
      SameMessages -> {ParamQuadSolve::noquad},
      TestID -> "onlyquad-noquadratic"
    ]
  ];
]
