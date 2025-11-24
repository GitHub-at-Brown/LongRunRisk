Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`"];

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eqns$ = {
  x^2 - 5 == 0,
  y + 2 x - 3 == 0
};
vars$ = {x, y};
res$ = pqs[eqns$, vars$, "ValidationOption" -> True, "DomainOption" -> Reals];
signSym$ = First[Keys[res$["SignRootMap"]]];
rad$ = res$["SignRootMap"][signSym$];

VerificationTest[AssociationQ[res$], True, TestID -> "returns-association@@Tests/ParamQuadSolve/basic-2x2.wlt:27,1-27,124"]
VerificationTest[AllTrue[Flatten@res$["Verification"], TrueQ], True, TestID -> "verification-all-true@@Tests/ParamQuadSolve/basic-2x2.wlt:28,1-28,152"]
VerificationTest[AllTrue[Simplify[eqns$ /. res$["Solution"] /. signSym$ -> 1], TrueQ], True, TestID -> "subs-sign-+1@@Tests/ParamQuadSolve/basic-2x2.wlt:29,1-29,167"]
VerificationTest[AllTrue[Simplify[eqns$ /. res$["Solution"] /. signSym$ -> -1], TrueQ], True, TestID -> "subs-sign--1@@Tests/ParamQuadSolve/basic-2x2.wlt:30,1-30,168"]
VerificationTest[Simplify[rad$^2 == 20], True, TestID -> "discriminant-20@@Tests/ParamQuadSolve/basic-2x2.wlt:31,1-31,124"]
VerificationTest[
 Module[{signs, ourRules, solveRules, sameQ},
   signs = {1, -1};
   ourRules = (res$["Solution"] /. signSym$ -> #) & /@ signs;
   solveRules = Solve[eqns$, vars$, Reals];
   sameQ[r1_, r2_] := TrueQ@Simplify[(vars$ /. r1) == (vars$ /. r2)];
   Length[solveRules] == Length[ourRules] && AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]]
 ], True, TestID -> "matches-Solve@@Tests/ParamQuadSolve/basic-2x2.wlt:32,1-40,2"
]

End[];
