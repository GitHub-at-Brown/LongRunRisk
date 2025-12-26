BeginTestSection["assumptions-return"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Test: Assumptions key exists when no assumptions provided *)

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
  TestID -> "assumptions-no-sign-when-no-quadratics@@Tests/ParamQuadSolve/assumptions-return.wlt:86,1-97,2"
]

EndTestSection[]
