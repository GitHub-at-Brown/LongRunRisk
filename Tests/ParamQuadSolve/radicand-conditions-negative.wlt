BeginTestSection["radicand-conditions-negative Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`radicandConditionsNegative`"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

VerificationTest[
  Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, r},
    params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
    eqns = {
      ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
      (c21 x + c23 x^2 - c24 y == y - 3 x) /. params
    };
    vars = {x, y};
    r = Quiet@Check[pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals], "fail", GreaterEqual::nord];
    r =!= "fail"
  ],
  True,
  {},
  TestID -> "no-nord-warning@@Tests/ParamQuadSolve/radicand-conditions-negative.wlt:10,1-24,2"
]

VerificationTest[
  Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, r, conds},
    params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
    eqns = {
      ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
      (c21 x + c23 x^2 - c24 y == y - 3 x) /. params
    };
    vars = {x, y};
    r = Quiet@Check[pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals], "fail", GreaterEqual::nord];
    conds = If[r === "fail", {}, r["Conditions"]];
    MemberQ[conds, False]
  ],
  True,
  {},
  TestID -> "false-condition-present@@Tests/ParamQuadSolve/radicand-conditions-negative.wlt:26,1-41,2"
]

VerificationTest[
  Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, r, radMap},
    params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
    eqns = {
      ((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
      (c21 x + c23 x^2 - c24 y == y - 3 x) /. params
    };
    vars = {x, y};
    r = Quiet@Check[pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals], "fail", GreaterEqual::nord];
    radMap = If[r === "fail", <||>, r["Diagnostics"]["SignRadicandMap"]];
    AssociationQ[radMap]
  ],
  True,
  {},
  TestID -> "radicand-map-present@@Tests/ParamQuadSolve/radicand-conditions-negative.wlt:43,1-58,2"
]

End[]
EndTestSection[]
