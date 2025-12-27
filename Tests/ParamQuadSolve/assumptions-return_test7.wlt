BeginTestSection["assumptions-return"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Test: Assumptions key exists when no assumptions provided *)

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
  TestID -> "assumptions-multiple-sign-constraints@@Tests/ParamQuadSolve/assumptions-return_test7.wlt:11,1-23,2"
]

EndTestSection[]
