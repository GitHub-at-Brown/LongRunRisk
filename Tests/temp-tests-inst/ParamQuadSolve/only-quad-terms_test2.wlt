BeginTestSection["only-quad-terms"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

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
  TestID -> "onlyquad-all-covered@@Tests/ParamQuadSolve/only-quad-terms.wlt:15,1-28,2"
]

EndTestSection[]
