BeginTestSection["only-quad-terms"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

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
  TestID -> "onlyquad-deferred-output@@Tests/ParamQuadSolve/only-quad-terms_test3.wlt:8,1-22,2"
]

EndTestSection[]
