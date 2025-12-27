BeginTestSection["orphan-variable-avoidance"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Test: Simple case with orphaned variable *)

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
  TestID -> "orphan-no-orphans-in-deferred@@Tests/ParamQuadSolve/orphan-variable-avoidance_test4.wlt:10,1-57,2"
]

EndTestSection[]
