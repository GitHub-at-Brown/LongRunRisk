BeginTestSection["assumptions-return Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`assumptionsReturn`"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Test: Assumptions key exists when no assumptions provided *)

VerificationTest[
  Module[{x, y, eqns, vars, res},
    eqns = {x^2 == 1, y == x + 1};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> False];
    KeyExistsQ[res, "Assumptions"]
  ],
  True,
  {},
  TestID -> "assumptions-key-exists-default@@Tests/ParamQuadSolve/assumptions-return.wlt:12,1-22,2"
]

VerificationTest[
  Module[{x, y, eqns, vars, res, ass},
    eqns = {x^2 == 1, y == x + 1};
    vars = {x, y};
    res = pqs[eqns, vars, "Assumptions" -> Automatic, "ValidationOption" -> False];
    ass = res["Assumptions"];
    StringContainsQ[ToString[ass, InputForm], "delta"] &&
    StringContainsQ[ToString[ass, InputForm], "gamma"] &&
    StringContainsQ[ToString[ass, InputForm], "psi"]
  ],
  True,
  {},
  TestID -> "assumptions-include-defaults-automatic@@Tests/ParamQuadSolve/assumptions-return.wlt:24,1-37,2"
]

VerificationTest[
  Module[{x, y, eqns, vars, res, ass},
    eqns = {x^2 == 1, y == x + 1};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> False];
    ass = res["Assumptions"];
    StringContainsQ[ToString[ass, InputForm], "delta"] &&
    StringContainsQ[ToString[ass, InputForm], "gamma"] &&
    StringContainsQ[ToString[ass, InputForm], "psi"]
  ],
  True,
  {},
  TestID -> "assumptions-include-defaults-omitted@@Tests/ParamQuadSolve/assumptions-return.wlt:39,1-52,2"
]

VerificationTest[
  Module[{x, y, a, b, eqns, vars, res, ass},
    eqns = {x^2 == a, y == x + b};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> False];
    ass = res["Assumptions"];
    StringContainsQ[ToString[ass, InputForm], "signA[1]^2 == 1"]
  ],
  True,
  {},
  TestID -> "assumptions-include-sign-constraints@@Tests/ParamQuadSolve/assumptions-return.wlt:54,1-65,2"
]

VerificationTest[
  Module[{x, y, a, b, eqns, vars, customAss, res, ass, assStr},
    eqns = {x^2 == a, y == x + b};
    vars = {x, y};
    customAss = a > 0 && b > 0;
    res = pqs[eqns, vars, "Assumptions" -> customAss, "ValidationOption" -> False];
    ass = res["Assumptions"];
    assStr = ToString[ass, InputForm];
    (* Module renames a to a$nnn, so check for pattern a$digits > 0 *)
    StringContainsQ[assStr, RegularExpression["a\\$\\d+ > 0"]] &&
    StringContainsQ[assStr, RegularExpression["b\\$\\d+ > 0"]] &&
    StringContainsQ[assStr, "delta"] &&
    StringContainsQ[assStr, "gamma"]
  ],
  True,
  {},
  TestID -> "assumptions-combine-custom-and-defaults@@Tests/ParamQuadSolve/assumptions-return.wlt:67,1-84,2"
]

VerificationTest[
  Module[{x, y, eqns, vars, res, ass},
    eqns = {x == 1, y == x + 1};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> False];
    ass = res["Assumptions"];
    !StringContainsQ[ToString[ass, InputForm], "signA"]
  ],
  True,
  {},
  TestID -> "assumptions-no-sign-when-no-quadratics@@Tests/ParamQuadSolve/assumptions-return.wlt:86,1-97,2"
]

VerificationTest[
  Module[{x, y, z, a, b, eqns, vars, res, ass},
    eqns = {x^2 == a, y^2 == b, z == x + y};
    vars = {x, y, z};
    res = pqs[eqns, vars, "ValidationOption" -> False];
    ass = res["Assumptions"];
    StringContainsQ[ToString[ass, InputForm], "signA[1]^2 == 1"] &&
    StringContainsQ[ToString[ass, InputForm], "signA[2]^2 == 1"]
  ],
  True,
  {},
  TestID -> "assumptions-multiple-sign-constraints@@Tests/ParamQuadSolve/assumptions-return.wlt:99,1-111,2"
]

VerificationTest[
  Module[{x, y, a, b, eqns, vars, customAss, res},
    eqns = {x^2 == a, y == x + b};
    vars = {x, y};
    customAss = a > 0 && Element[a, Reals] && Element[b, Reals];
    res = pqs[eqns, vars, "Assumptions" -> customAss, "ValidationOption" -> True];
    AssociationQ[res] && KeyExistsQ[res, "Verification"]
  ],
  True,
  {},
  TestID -> "assumptions-used-in-verification@@Tests/ParamQuadSolve/assumptions-return.wlt:113,1-124,2"
]

VerificationTest[
  Module[{x, y, z, eqns, vars, res, ass},
    eqns = {x^2 == 1, y^2 == 4, z == 5};
    vars = {x, y, z};
    res = pqs[eqns, vars, "OnlyQuadTerms" -> True, "ValidationOption" -> False];
    ass = res["Assumptions"];
    AssociationQ[res] &&
    KeyExistsQ[res, "Assumptions"] &&
    StringContainsQ[ToString[ass, InputForm], "signA"]
  ],
  True,
  {},
  TestID -> "assumptions-with-only-quad-terms@@Tests/ParamQuadSolve/assumptions-return.wlt:126,1-139,2"
]

End[]
EndTestSection[]
