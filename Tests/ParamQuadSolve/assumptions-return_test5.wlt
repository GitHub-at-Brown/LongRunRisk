BeginTestSection["assumptions-return"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Test: Assumptions key exists when no assumptions provided *)

VerificationTest[
  Module[{eqns, vars, res, ass, customAss},
    eqns = {x^2 == a, y == x + b};
    vars = {x, y};
    customAss = a > 0 && b > 0;
    res = pqs[eqns, vars, "Assumptions" -> customAss, "ValidationOption" -> False];
    ass = res["Assumptions"];
    (* Check that both custom and default assumptions are included *)
    StringContainsQ[ToString[ass, InputForm], "a > 0"] &&
    StringContainsQ[ToString[ass, InputForm], "b > 0"] &&
    StringContainsQ[ToString[ass, InputForm], "delta"] &&
    StringContainsQ[ToString[ass, InputForm], "gamma"]
  ],
  True,
  TestID -> "assumptions-combine-custom-and-defaults@@Tests/ParamQuadSolve/assumptions-return_test5.wlt:11,1-26,2"
]

EndTestSection[]
