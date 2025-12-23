BeginTestSection["only-quad-terms"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

VerificationTest[
  pqs[{x^2 + y^2 + z^2 == 3, x^2 + 2 x - 1 == 0}, {x, y, z}, "OnlyQuadTerms" -> True],
  $Failed,
  {FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve::nocover},
  TestID -> "onlyquad-reject-partial@@Tests/ParamQuadSolve/only-quad-terms.wlt:9,1-14,2"
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
  TestID -> "onlyquad-all-covered@@Tests/ParamQuadSolve/only-quad-terms.wlt:16,1-29,2"
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
  TestID -> "onlyquad-deferred-output@@Tests/ParamQuadSolve/only-quad-terms.wlt:31,1-45,2"
]

VerificationTest[
  pqs[{x + y == 1}, {x, y}, "OnlyQuadTerms" -> True],
  $Failed,
  {FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve::noquad},
  TestID -> "onlyquad-noquadratic@@Tests/ParamQuadSolve/only-quad-terms.wlt:47,1-52,2"
]

EndTestSection[]
