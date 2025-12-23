BeginTestSection["assumptions-return"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Test: Assumptions key exists when no assumptions provided *)
VerificationTest[
  Module[{eqns, vars, res},
    eqns = {x^2 == 1, y == x + 1};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> False];
    KeyExistsQ[res, "Assumptions"]
  ],
  True,
  TestID -> "assumptions-key-exists-default@@Tests/ParamQuadSolve/assumptions-return.wlt:11,1-20,2"
]

(* Test: Assumptions include default assumptions when Automatic *)
VerificationTest[
  Module[{eqns, vars, res, ass},
    eqns = {x^2 == 1, y == x + 1};
    vars = {x, y};
    res = pqs[eqns, vars, "Assumptions" -> Automatic, "ValidationOption" -> False];
    ass = res["Assumptions"];
    (* Check that default assumptions are included *)
    StringContainsQ[ToString[ass, InputForm], "delta"] &&
    StringContainsQ[ToString[ass, InputForm], "gamma"] &&
    StringContainsQ[ToString[ass, InputForm], "psi"]
  ],
  True,
  TestID -> "assumptions-include-defaults-automatic@@Tests/ParamQuadSolve/assumptions-return.wlt:23,1-36,2"
]

(* Test: Assumptions include default assumptions when not specified *)
VerificationTest[
  Module[{eqns, vars, res, ass},
    eqns = {x^2 == 1, y == x + 1};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> False];
    ass = res["Assumptions"];
    (* Check that default assumptions are included *)
    StringContainsQ[ToString[ass, InputForm], "delta"] &&
    StringContainsQ[ToString[ass, InputForm], "gamma"] &&
    StringContainsQ[ToString[ass, InputForm], "psi"]
  ],
  True,
  TestID -> "assumptions-include-defaults-omitted@@Tests/ParamQuadSolve/assumptions-return.wlt:39,1-52,2"
]

(* Test: Assumptions include sign constraints when there are sign variables *)
VerificationTest[
  Module[{eqns, vars, res, ass},
    eqns = {x^2 == a, y == x + b};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> False];
    ass = res["Assumptions"];
    (* Check that sign constraints are included *)
    StringContainsQ[ToString[ass, InputForm], "signA[1]^2 == 1"]
  ],
  True,
  TestID -> "assumptions-include-sign-constraints@@Tests/ParamQuadSolve/assumptions-return.wlt:55,1-66,2"
]

(* Test: Custom assumptions are combined with defaults *)
VerificationTest[
  Module[{eqns, vars, res, ass, customAss},
    eqns = {x^2 == a, y == x + b};
    vars = {x, y};
    customAss = a > 0 && b > 0;
    res = pqs[eqns, vars, "Assumptions" -> customAss, "ValidationOption" -> False];
    ass = res["Assumptions"];
    (* Check that both custom and default assumptions are included *)
    StringContainsQ[ToString[ass, InputForm], "a > 0"] &&
    StringContainsQ[ToString[ass, InputForm], "b > 0"] &&
    StringContainsQ[ToString[ass, InputForm], "delta"] &&
    StringContainsQ[ToString[ass, InputForm], "gamma"]
  ],
  True,
  TestID -> "assumptions-combine-custom-and-defaults@@Tests/ParamQuadSolve/assumptions-return.wlt:69,1-84,2"
]

(* Test: No sign constraints when no quadratics *)
VerificationTest[
  Module[{eqns, vars, res, ass},
    eqns = {x == 1, y == x + 1};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> False];
    ass = res["Assumptions"];
    (* Should not contain sign constraints *)
    !StringContainsQ[ToString[ass, InputForm], "signA"]
  ],
  True,
  TestID -> "assumptions-no-sign-when-no-quadratics@@Tests/ParamQuadSolve/assumptions-return.wlt:87,1-98,2"
]

(* Test: Multiple sign variables create multiple constraints *)
VerificationTest[
  Module[{eqns, vars, res, ass},
    eqns = {x^2 == a, y^2 == b, z == x + y};
    vars = {x, y, z};
    res = pqs[eqns, vars, "ValidationOption" -> False];
    ass = res["Assumptions"];
    (* Should contain multiple sign constraints *)
    StringContainsQ[ToString[ass, InputForm], "signA[1]^2 == 1"] &&
    StringContainsQ[ToString[ass, InputForm], "signA[2]^2 == 1"]
  ],
  True,
  TestID -> "assumptions-multiple-sign-constraints@@Tests/ParamQuadSolve/assumptions-return.wlt:101,1-113,2"
]

(* Test: Assumptions are used in Simplify operations *)
VerificationTest[
  Module[{eqns, vars, res, customAss},
    eqns = {x^2 == a, y == x + b};
    vars = {x, y};
    customAss = a > 0 && Element[a, Reals] && Element[b, Reals];
    res = pqs[eqns, vars, "Assumptions" -> customAss, "ValidationOption" -> True];
    (* Verification should succeed if assumptions are properly used *)
    AssociationQ[res] && KeyExistsQ[res, "Verification"]
  ],
  True,
  TestID -> "assumptions-used-in-verification@@Tests/ParamQuadSolve/assumptions-return.wlt:116,1-127,2"
]

(* Test: Assumptions with OnlyQuadTerms option *)
VerificationTest[
  Module[{eqns, vars, res, ass},
    eqns = {
      x^2 == 1,
      y^2 == 4,
      z == 5
    };
    vars = {x, y, z};
    res = pqs[eqns, vars, "OnlyQuadTerms" -> True, "ValidationOption" -> False];
    ass = res["Assumptions"];
    (* Should have assumptions key even with OnlyQuadTerms *)
    AssociationQ[res] &&
    KeyExistsQ[res, "Assumptions"] &&
    StringContainsQ[ToString[ass, InputForm], "signA"]
  ],
  True,
  TestID -> "assumptions-with-only-quad-terms@@Tests/ParamQuadSolve/assumptions-return.wlt:130,1-147,2"
]

EndTestSection[]
