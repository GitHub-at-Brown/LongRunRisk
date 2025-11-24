Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`"];

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Test: Assumptions key exists when no assumptions provided *)
VerificationTest[
  Module[{eqns, vars, res},
    eqns = {x^2 == 1, y == x + 1};
    vars = {x, y};
    res = pqs[eqns, vars, Validation -> False];
    KeyExistsQ[res, "Assumptions"]
  ],
  True,
  TestID -> "assumptions-key-exists-default@@Tests/ParamQuadSolve/assumptions-return.wlt:10,1-19,2"
]

(* Test: Assumptions include default assumptions when Automatic *)
VerificationTest[
  Module[{eqns, vars, res, ass},
    eqns = {x^2 == 1, y == x + 1};
    vars = {x, y};
    res = pqs[eqns, vars, Assumptions -> Automatic, Validation -> False];
    ass = res["Assumptions"];
    (* Check that default assumptions are included *)
    StringContainsQ[ToString[ass, InputForm], "delta"] &&
    StringContainsQ[ToString[ass, InputForm], "gamma"] &&
    StringContainsQ[ToString[ass, InputForm], "psi"]
  ],
  True,
  TestID -> "assumptions-include-defaults-automatic@@Tests/ParamQuadSolve/assumptions-return.wlt:22,1-35,2"
]

(* Test: Assumptions include default assumptions when not specified *)
VerificationTest[
  Module[{eqns, vars, res, ass},
    eqns = {x^2 == 1, y == x + 1};
    vars = {x, y};
    res = pqs[eqns, vars, Validation -> False];
    ass = res["Assumptions"];
    (* Check that default assumptions are included *)
    StringContainsQ[ToString[ass, InputForm], "delta"] &&
    StringContainsQ[ToString[ass, InputForm], "gamma"] &&
    StringContainsQ[ToString[ass, InputForm], "psi"]
  ],
  True,
  TestID -> "assumptions-include-defaults-omitted@@Tests/ParamQuadSolve/assumptions-return.wlt:38,1-51,2"
]

(* Test: Assumptions include sign constraints when there are sign variables *)
VerificationTest[
  Module[{eqns, vars, res, ass},
    eqns = {x^2 == a, y == x + b};
    vars = {x, y};
    res = pqs[eqns, vars, Validation -> False];
    ass = res["Assumptions"];
    (* Check that sign constraints are included *)
    StringContainsQ[ToString[ass, InputForm], "signA[1]^2 == 1"]
  ],
  True,
  TestID -> "assumptions-include-sign-constraints@@Tests/ParamQuadSolve/assumptions-return.wlt:54,1-65,2"
]

(* Test: Custom assumptions are combined with defaults *)
VerificationTest[
  Module[{eqns, vars, res, ass, customAss},
    eqns = {x^2 == a, y == x + b};
    vars = {x, y};
    customAss = a > 0 && b > 0;
    res = pqs[eqns, vars, Assumptions -> customAss, Validation -> False];
    ass = res["Assumptions"];
    (* Check that both custom and default assumptions are included *)
    StringContainsQ[ToString[ass, InputForm], "a > 0"] &&
    StringContainsQ[ToString[ass, InputForm], "b > 0"] &&
    StringContainsQ[ToString[ass, InputForm], "delta"] &&
    StringContainsQ[ToString[ass, InputForm], "gamma"]
  ],
  True,
  TestID -> "assumptions-combine-custom-and-defaults@@Tests/ParamQuadSolve/assumptions-return.wlt:68,1-83,2"
]

(* Test: No sign constraints when no quadratics *)
VerificationTest[
  Module[{eqns, vars, res, ass},
    eqns = {x == 1, y == x + 1};
    vars = {x, y};
    res = pqs[eqns, vars, Validation -> False];
    ass = res["Assumptions"];
    (* Should not contain sign constraints *)
    !StringContainsQ[ToString[ass, InputForm], "signA"]
  ],
  True,
  TestID -> "assumptions-no-sign-when-no-quadratics@@Tests/ParamQuadSolve/assumptions-return.wlt:86,1-97,2"
]

(* Test: Multiple sign variables create multiple constraints *)
VerificationTest[
  Module[{eqns, vars, res, ass},
    eqns = {x^2 == a, y^2 == b, z == x + y};
    vars = {x, y, z};
    res = pqs[eqns, vars, Validation -> False];
    ass = res["Assumptions"];
    (* Should contain multiple sign constraints *)
    StringContainsQ[ToString[ass, InputForm], "signA[1]^2 == 1"] &&
    StringContainsQ[ToString[ass, InputForm], "signA[2]^2 == 1"]
  ],
  True,
  TestID -> "assumptions-multiple-sign-constraints@@Tests/ParamQuadSolve/assumptions-return.wlt:100,1-112,2"
]

(* Test: Assumptions are used in Simplify operations *)
VerificationTest[
  Module[{eqns, vars, res, customAss},
    eqns = {x^2 == a, y == x + b};
    vars = {x, y};
    customAss = a > 0 && Element[a, Reals] && Element[b, Reals];
    res = pqs[eqns, vars, Assumptions -> customAss, Validation -> True];
    (* Verification should succeed if assumptions are properly used *)
    AssociationQ[res] && KeyExistsQ[res, "Verification"]
  ],
  True,
  TestID -> "assumptions-used-in-verification@@Tests/ParamQuadSolve/assumptions-return.wlt:115,1-126,2"
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
    res = pqs[eqns, vars, OnlyQuadTerms -> True, Validation -> False];
    ass = res["Assumptions"];
    (* Should have assumptions key even with OnlyQuadTerms *)
    AssociationQ[res] &&
    KeyExistsQ[res, "Assumptions"] &&
    StringContainsQ[ToString[ass, InputForm], "signA"]
  ],
  True,
  TestID -> "assumptions-with-only-quad-terms@@Tests/ParamQuadSolve/assumptions-return.wlt:129,1-146,2"
]

End[];
