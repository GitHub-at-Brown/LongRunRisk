BeginTestSection["orphan-variable-avoidance"]

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
  TestID -> "orphan-simple-avoidance@@Tests/ParamQuadSolve/orphan-variable-avoidance.wlt:9,1-32,2"
]

EndTestSection[]
