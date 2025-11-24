Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`"];

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

VerificationTest[
  pqs[{x^2 + y^2 + z^2 == 3, x^2 + 2 x - 1 == 0}, {x, y, z}, "OnlyQuadTerms" -> True],
  $Failed,
  {FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve::nocover},
  TestID -> "onlyquad-reject-partial@@Tests/ParamQuadSolve/only-quad-terms.wlt:18,1-23,2"
]

VerificationTest[
  Module[{eqns, vars, res, solvedVars, diagnostics},
    eqns = {x^2 - 1 == 0, y^2 - 4 == 0, z^2 - 9 == 0};
    vars = {x, y, z};
    res = pqs[eqns, vars, "OnlyQuadTerms" -> True];
    solvedVars = Sort[res["Diagnostics"]["SolvedQuadraticVariables"]];
    diagnostics = res["Diagnostics"];
    AssociationQ[res] &&
    solvedVars === {x, y, z} &&
    diagnostics["DeferredVariables"] === {}
  ],
  True,
  TestID -> "onlyquad-all-covered@@Tests/ParamQuadSolve/only-quad-terms.wlt:25,1-38,2"
]

VerificationTest[
  Module[{eqns, vars, res, deferredEqns, deferredVars},
    eqns = {x^2 == 1, x^2 + y == 2, y + z == 1};
    vars = {x, y, z};
    res = pqs[eqns, vars, "OnlyQuadTerms" -> True];
    deferredEqns = res["DeferredEquations"];
    deferredVars = res["DeferredVariables"];
    AssociationQ[res] &&
    res["Solution"][[All, 1]] === {x} &&
    Length[deferredEqns] == 2 &&
    Sort[deferredVars] === {y, z}
  ],
  True,
  TestID -> "onlyquad-deferred-output@@Tests/ParamQuadSolve/only-quad-terms.wlt:40,1-54,2"
]

VerificationTest[
  pqs[{x + y == 1}, {x, y}, "OnlyQuadTerms" -> True],
  $Failed,
  {FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve::noquad},
  TestID -> "onlyquad-noquadratic@@Tests/ParamQuadSolve/only-quad-terms.wlt:56,1-61,2"
]

End[];
