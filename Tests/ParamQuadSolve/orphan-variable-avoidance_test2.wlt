BeginTestSection["orphan-variable-avoidance"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Test: Simple case with orphaned variable *)

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
  TestID -> "orphan-prefer-no-orphans@@Tests/ParamQuadSolve/orphan-variable-avoidance_test2.wlt:10,1-32,2"
]

EndTestSection[]
