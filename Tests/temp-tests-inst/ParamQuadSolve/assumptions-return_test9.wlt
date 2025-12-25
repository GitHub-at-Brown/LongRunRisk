BeginTestSection["assumptions-return"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Test: Assumptions key exists when no assumptions provided *)

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
  TestID -> "assumptions-with-only-quad-terms@@Tests/ParamQuadSolve/assumptions-return.wlt:129,1-146,2"
]

EndTestSection[]
