BeginTestSection["assumptions-return"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Test: Assumptions key exists when no assumptions provided *)

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
  TestID -> "assumptions-include-sign-constraints@@Tests/ParamQuadSolve/assumptions-return_test4.wlt:11,1-22,2"
]

EndTestSection[]
