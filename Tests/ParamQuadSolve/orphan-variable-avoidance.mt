Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Test: Simple case with orphaned variable *)
VerificationTest[
  Module[{eqns, vars, res, selectedEqs, deferredEqs},
    (* System where eq 3 has orphaned variable w *)
    eqns = {
      x^2 == 1,           (* eq 1: has x *)
      y^2 == 4,           (* eq 2: has y *)
      x^2 + y + w == 0,   (* eq 3: has x, y, w (w is orphaned) *)
      z == 5              (* eq 4: has z *)
    };
    vars = {x, y, z, w};
    res = pqs[eqns, vars, "OnlyQuadTerms" -> True];
    deferredEqs = res["Diagnostics"]["DeferredEquationsIndices"];
    selectedEqs = Complement[Range[4], deferredEqs];

    (* Should select eqs 1, 2 (avoid eq 3 with orphaned w) *)
    (* Should defer eqs 3, 4 so w can be solved from deferred system *)
    AssociationQ[res] &&
    Sort[selectedEqs] === {1, 2} &&
    MemberQ[deferredEqs, 3] &&
    MemberQ[res["DeferredVariables"], w]
  ],
  True,
  TestID -> "orphan-simple-avoidance@@Tests/ParamQuadSolve/orphan-variable-avoidance.wlt:7,1-30,2"
]

(* Test: Multiple equations with quadratics, one has orphaned variable *)
VerificationTest[
  Module[{eqns, vars, res, selectedEqs, deferredEqs},
    eqns = {
      a^2 == 1,         (* eq 1: quadratic in a *)
      a^2 + b^2 == 2,   (* eq 2: quadratic in a, b *)
      b^2 + c == 3,     (* eq 3: quadratic in b, linear in c (c orphaned if selected) *)
      d == 4            (* eq 4: linear in d *)
    };
    vars = {a, b, c, d};
    res = pqs[eqns, vars, "OnlyQuadTerms" -> True];
    selectedEqs = Complement[Range[4], res["Diagnostics"]["DeferredEquationsIndices"]];
    deferredEqs = res["Diagnostics"]["DeferredEquationsIndices"];

    (* Should select eqs 1, 2 (both have no orphans) *)
    (* Should defer eq 3 so c can be solved *)
    AssociationQ[res] &&
    Sort[selectedEqs] === {1, 2} &&
    MemberQ[deferredEqs, 3] &&
    MemberQ[res["DeferredVariables"], c]
  ],
  True,
  TestID -> "orphan-prefer-no-orphans@@Tests/ParamQuadSolve/orphan-variable-avoidance.wlt:33,1-55,2"
]

(* Test: Long-run risk model system - the motivating example *)
VerificationTest[
  Module[{sys, vars, res, deferredEqs, varsInDeferred},
    sys = {
      0 == ((1 - gamma) (-1 + psi) rhocp)/((1 - 1/psi) psi) -
        ((1 - gamma) A[1])/(1 - 1/psi) +
        (E^A[0] (1 - gamma) vpp A[7])/((1 + E^A[0]) (1 - 1/psi)),
      0 == ((1 - gamma) (-1 + psi) xic)/((1 - 1/psi) psi) -
        ((1 - gamma) A[2])/(1 - 1/psi),
      0 == (E^A[0] (1 - gamma) xip A[1])/((1 + E^A[0]) (1 - 1/psi)) -
        ((1 - gamma) A[3])/(1 - 1/psi),
      0 == (E^(2 A[0]) (1 - gamma)^2 phip A[1] A[2])/((1 + E^A[0])^2 (1 - 1/psi)^2) +
        A[2] ((E^A[0] (1 - gamma)^2 phicp (-1 + psi))/((1 + E^A[0]) (1 - 1/psi)^2 psi) +
          (E^(2 A[0]) (1 - gamma)^2 A[3])/((1 + E^A[0])^2 (1 - 1/psi)^2)) -
        (2 E^A[0] Esg (1 - gamma) (-1 + rhog) rhog A[5])/((1 + E^A[0]) (1 - 1/psi)) -
        (4 E^(2 A[0]) Esg (1 - gamma)^2 phig^2 (-1 + rhog) rhog A[5]^2)/((1 + E^A[0])^2 (1 - 1/psi)^2) +
        A[4] (((1 - gamma) (-1 + E^A[0] (-1 + rhog)))/((1 + E^A[0]) (1 - 1/psi)) +
          (2 E^(2 A[0]) (1 - gamma)^2 phig^2 rhog A[5])/((1 + E^A[0])^2 (1 - 1/psi)^2)),
      0 == (E^(2 A[0]) (1 - gamma)^2 A[2]^2)/(2 (1 + E^A[0])^2 (1 - 1/psi)^2) +
        ((1 - gamma) (-1 + E^A[0] (-1 + rhog^2)) A[5])/((1 + E^A[0]) (1 - 1/psi)) +
        (2 E^(2 A[0]) (1 - gamma)^2 phig^2 rhog^2 A[5]^2)/((1 + E^A[0])^2 (1 - 1/psi)^2),
      0 == ((1 - gamma) (-1 + psi) rhocpbar)/((1 - 1/psi) psi) +
        (E^A[0] (1 - gamma) rhoppbar A[1])/((1 + E^A[0]) (1 - 1/psi)) +
        ((1 - gamma) (-1 + E^A[0] (-1 + rhopbar)) A[6])/((1 + E^A[0]) (1 - 1/psi)) +
        (E^A[0] (1 - gamma) vppbar A[7])/((1 + E^A[0]) (1 - 1/psi)),
      0 == (E^(2 A[0]) (1 - gamma)^2 phipbarpb^2 A[6]^2)/(2 (1 + E^A[0])^2 (1 - 1/psi)^2) +
        ((1 - gamma) (-1 + E^A[0] (-1 + vp)) A[7])/((1 + E^A[0]) (1 - 1/psi))
    };
    vars = {A[1], A[2], A[3], A[4], A[5], A[6], A[7]};

    res = pqs[sys, vars, "OnlyQuadTerms" -> True];
    deferredEqs = res["Diagnostics"]["DeferredEquationsIndices"];

    (* Equation 4 contains A[4] which appears nowhere else *)
    (* The orphan count fix should defer equation 4 *)
    (* This ensures A[4] can be solved from the deferred system *)
    AssociationQ[res] &&
    MemberQ[deferredEqs, 4] &&
    MemberQ[res["DeferredVariables"], A[4]] &&
    !FreeQ[res["DeferredEquations"][[Position[deferredEqs, 4][[1, 1]]]], A[4]]
  ],
  True,
  TestID -> "orphan-longrunrisk-eq4-deferred@@Tests/ParamQuadSolve/orphan-variable-avoidance.wlt:58,1-100,2"
]

(* Test: Verify deferred system is solvable (no orphaned variables) *)
VerificationTest[
  Module[{sys, vars, res, deferredEqs, deferredVars, varsInDeferredEqs, orphanedVars},
    sys = {
      0 == ((1 - gamma) (-1 + psi) rhocp)/((1 - 1/psi) psi) -
        ((1 - gamma) A[1])/(1 - 1/psi) +
        (E^A[0] (1 - gamma) vpp A[7])/((1 + E^A[0]) (1 - 1/psi)),
      0 == ((1 - gamma) (-1 + psi) xic)/((1 - 1/psi) psi) -
        ((1 - gamma) A[2])/(1 - 1/psi),
      0 == (E^A[0] (1 - gamma) xip A[1])/((1 + E^A[0]) (1 - 1/psi)) -
        ((1 - gamma) A[3])/(1 - 1/psi),
      0 == (E^(2 A[0]) (1 - gamma)^2 phip A[1] A[2])/((1 + E^A[0])^2 (1 - 1/psi)^2) +
        A[2] ((E^A[0] (1 - gamma)^2 phicp (-1 + psi))/((1 + E^A[0]) (1 - 1/psi)^2 psi) +
          (E^(2 A[0]) (1 - gamma)^2 A[3])/((1 + E^A[0])^2 (1 - 1/psi)^2)) -
        (2 E^A[0] Esg (1 - gamma) (-1 + rhog) rhog A[5])/((1 + E^A[0]) (1 - 1/psi)) -
        (4 E^(2 A[0]) Esg (1 - gamma)^2 phig^2 (-1 + rhog) rhog A[5]^2)/((1 + E^A[0])^2 (1 - 1/psi)^2) +
        A[4] (((1 - gamma) (-1 + E^A[0] (-1 + rhog)))/((1 + E^A[0]) (1 - 1/psi)) +
          (2 E^(2 A[0]) (1 - gamma)^2 phig^2 rhog A[5])/((1 + E^A[0])^2 (1 - 1/psi)^2)),
      0 == (E^(2 A[0]) (1 - gamma)^2 A[2]^2)/(2 (1 + E^A[0])^2 (1 - 1/psi)^2) +
        ((1 - gamma) (-1 + E^A[0] (-1 + rhog^2)) A[5])/((1 + E^A[0]) (1 - 1/psi)) +
        (2 E^(2 A[0]) (1 - gamma)^2 phig^2 rhog^2 A[5]^2)/((1 + E^A[0])^2 (1 - 1/psi)^2),
      0 == ((1 - gamma) (-1 + psi) rhocpbar)/((1 - 1/psi) psi) +
        (E^A[0] (1 - gamma) rhoppbar A[1])/((1 + E^A[0]) (1 - 1/psi)) +
        ((1 - gamma) (-1 + E^A[0] (-1 + rhopbar)) A[6])/((1 + E^A[0]) (1 - 1/psi)) +
        (E^A[0] (1 - gamma) vppbar A[7])/((1 + E^A[0]) (1 - 1/psi)),
      0 == (E^(2 A[0]) (1 - gamma)^2 phipbarpb^2 A[6]^2)/(2 (1 + E^A[0])^2 (1 - 1/psi)^2) +
        ((1 - gamma) (-1 + E^A[0] (-1 + vp)) A[7])/((1 + E^A[0]) (1 - 1/psi))
    };
    vars = {A[1], A[2], A[3], A[4], A[5], A[6], A[7]};

    res = pqs[sys, vars, "OnlyQuadTerms" -> True];
    deferredEqs = res["DeferredEquations"];
    deferredVars = res["DeferredVariables"];

    (* Find all variables that appear in deferred equations *)
    varsInDeferredEqs = Union[Flatten[
      Cases[deferredEqs, A[i_] :> A[i], Infinity]
    ]];

    (* Variables in deferred vars but NOT in deferred equations are orphaned *)
    orphanedVars = Complement[deferredVars, varsInDeferredEqs];

    (* The orphan count fix ensures no orphaned variables *)
    AssociationQ[res] &&
    orphanedVars === {}
  ],
  True,
  TestID -> "orphan-no-orphans-in-deferred@@Tests/ParamQuadSolve/orphan-variable-avoidance.wlt:103,1-150,2"
]
