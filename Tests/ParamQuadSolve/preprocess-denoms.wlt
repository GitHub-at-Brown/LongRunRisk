BeginTestSection["preprocess-denoms Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`preprocessDenoms`"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

VerificationTest[
  Module[{x, y, a, b, psi, eq, vars, r, conds, condExpr, hasPsiDen},
    eq = {x == a/(1 - 1/psi), y == b/(1 + Exp[A[0]])};
    vars = {x, y};
    r = pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
    conds = r["Conditions"];
    condExpr = And @@ conds;
    hasPsiDen = Simplify[condExpr /. psi -> 1] === False;
    hasPsiDen
  ],
  True,
  {},
  TestID -> "psi-denom-cond@@Tests/ParamQuadSolve/preprocess-denoms.wlt:10,1-23,2"
]

VerificationTest[
  Module[{x, y, a, b, psi, eq, vars, r, conds, condExpr, hasExpDen},
    eq = {x == a/(1 - 1/psi), y == b/(1 + Exp[A[0]])};
    vars = {x, y};
    r = pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
    conds = r["Conditions"];
    condExpr = And @@ conds;
    hasExpDen = Simplify[condExpr /. Exp[A[0]] -> -1] === False;
    hasExpDen
  ],
  True,
  {},
  TestID -> "exp-denom-cond@@Tests/ParamQuadSolve/preprocess-denoms.wlt:25,1-38,2"
]

VerificationTest[
  Module[{x, y, a, b, psi, eq, vars, r, coeffKeysOK},
    eq = {x == a/(1 - 1/psi), y == b/(1 + Exp[A[0]])};
    vars = {x, y};
    r = pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
    coeffKeysOK = AssociationQ[r["Maps"]["CoeffMap"]] && Length[r["Maps"]["CoeffMap"]] >= 1;
    coeffKeysOK
  ],
  True,
  {},
  TestID -> "coeffmap-present@@Tests/ParamQuadSolve/preprocess-denoms.wlt:40,1-51,2"
]

VerificationTest[
  Module[{x, y, a, b, psi, eq, vars, r, noDummyInSol},
    eq = {x == a/(1 - 1/psi), y == b/(1 + Exp[A[0]])};
    vars = {x, y};
    r = pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
    noDummyInSol = FreeQ[r["Solution"], _Symbol?(StringMatchQ[SymbolName[#], "c$*"] &)];
    noDummyInSol
  ],
  True,
  {},
  TestID -> "no-dummy-in-solution@@Tests/ParamQuadSolve/preprocess-denoms.wlt:53,1-64,2"
]

End[]
EndTestSection[]
