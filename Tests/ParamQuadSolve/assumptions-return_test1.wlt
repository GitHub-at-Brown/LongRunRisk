BeginTestSection["assumptions-return"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Test: Assumptions key exists when no assumptions provided *)

VerificationTest[
  Module[{eqns, vars, res},
    eqns = {x^2 == 1, y == x + 1};
    vars = {x, y};
    res = pqs[eqns, vars, "ValidationOption" -> False];
    KeyExistsQ[res, "Assumptions"]
  ],
  True,
  TestID -> "assumptions-key-exists-default@@Tests/ParamQuadSolve/assumptions-return.wlt:10,1-19,2"
]

EndTestSection[]
