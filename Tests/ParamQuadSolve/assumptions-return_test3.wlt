BeginTestSection["assumptions-return"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Test: Assumptions key exists when no assumptions provided *)

VerificationTest[
  Module[{eqns, vars, res, ass},
    eqns = {x^2 == 1, y == x + 1};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> False];
    ass = res["Assumptions"];
    (* Check that default assumptions are included *)
    StringContainsQ[ToString[ass, InputForm], "delta"] &&
    StringContainsQ[ToString[ass, InputForm], "gamma"] &&
    StringContainsQ[ToString[ass, InputForm], "psi"]
  ],
  True,
  TestID -> "assumptions-include-defaults-omitted@@Tests/ParamQuadSolve/assumptions-return_test3.wlt:11,1-24,2"
]

EndTestSection[]
