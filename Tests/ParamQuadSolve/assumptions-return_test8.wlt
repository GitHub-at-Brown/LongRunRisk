BeginTestSection["assumptions-return"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Test: Assumptions key exists when no assumptions provided *)

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
  TestID -> "assumptions-used-in-verification@@Tests/ParamQuadSolve/assumptions-return_test8.wlt:11,1-22,2"
]

EndTestSection[]
