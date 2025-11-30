Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eqns$ = {
  y^2 - 2 == 0,
  x*y + x - 1 == 0,
  z^2 + z - 3 == 0
};
vars$ = {x, y, z};

res$ = pqs[eqns$, vars$, "ValidationOption" -> True, "DomainOption" -> Reals];

signKeys$ = Keys[res$["SignRootMap"]];
radVals$ = Values[res$["SignRootMap"]];
radSq$ = Simplify[radVals$^2];
rulesFor[v1_, v2_] := Thread[signKeys$ -> {v1, v2}];

VerificationTest[AssociationQ[res$], True, TestID -> "returns-association"]
VerificationTest[Length[signKeys$] === 2, True, TestID -> "two-sign-variables"]
VerificationTest[Sort[Simplify /@ radSq$] === Sort[{8, 13}], True, TestID -> "radicands-8-and-13"]
VerificationTest[
  Module[{heads},
    heads = DeleteDuplicates[Head /@ signKeys$];
    AllTrue[Simplify[res$["Verification"] /. (Alternatives @@ ((#[_]^2) & /@ heads)) -> 1], TrueQ]
  ],
  True,
  TestID -> "verification-all-true"
]
VerificationTest[AllTrue[Simplify[eqns$ /. res$["Solution"] /. rulesFor[1, 1]], TrueQ], True, TestID -> "subs-++"]
VerificationTest[AllTrue[Simplify[eqns$ /. res$["Solution"] /. rulesFor[1, -1]], TrueQ], True, TestID -> "subs-+-"]
VerificationTest[AllTrue[Simplify[eqns$ /. res$["Solution"] /. rulesFor[-1, 1]], TrueQ], True, TestID -> "subs--+"]
VerificationTest[AllTrue[Simplify[eqns$ /. res$["Solution"] /. rulesFor[-1, -1]], TrueQ], True, TestID -> "subs----"]
VerificationTest[
  Module[{assigns, ourRules, solveRules, sameQ},
    assigns = Tuples[{-1, 1}, Length[signKeys$]];
    ourRules = Map[(res$["Solution"] /. Thread[signKeys$ -> #]) &, assigns];
    solveRules = Solve[eqns$, vars$, Reals];
    sameQ[r1_, r2_] := TrueQ@Simplify[(vars$ /. r1) == (vars$ /. r2)];
    Length[solveRules] == Length[ourRules] && AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]]
  ],
  True, TestID -> "matches-Solve"
]
