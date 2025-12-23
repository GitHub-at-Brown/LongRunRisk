BeginTestSection["basic-2x2"]

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

VerificationTest[AssociationQ[res$], True, TestID -> "returns-association@@Tests/ParamQuadSolve/basic-2x2.wlt:17,1-17,124"]
VerificationTest[AllTrue[Flatten@res$["Verification"], TrueQ], True, TestID -> "verification-all-true@@Tests/ParamQuadSolve/basic-2x2.wlt:18,1-18,152"]
VerificationTest[AllTrue[Simplify[eqns$ /. res$["Solution"] /. signSym$ -> 1], TrueQ], True, TestID -> "subs-sign-+1@@Tests/ParamQuadSolve/basic-2x2.wlt:19,1-19,167"]
VerificationTest[AllTrue[Simplify[eqns$ /. res$["Solution"] /. signSym$ -> -1], TrueQ], True, TestID -> "subs-sign--1@@Tests/ParamQuadSolve/basic-2x2.wlt:20,1-20,168"]
VerificationTest[Simplify[rad$^2 == 20], True, TestID -> "discriminant-20@@Tests/ParamQuadSolve/basic-2x2.wlt:21,1-21,124"]
VerificationTest[
 Module[{signs, ourRules, solveRules, sameQ},
   signs = {1, -1};
   ourRules = (res$["Solution"] /. signSym$ -> #) & /@ signs;
   solveRules = Solve[eqns$, vars$, Reals];
   sameQ[r1_, r2_] := TrueQ@Simplify[(vars$ /. r1) == (vars$ /. r2)];
   Length[solveRules] == Length[ourRules] && AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]]
 ], True, TestID -> "matches-Solve@@Tests/ParamQuadSolve/basic-2x2.wlt:22,1-30,2"
]

EndTestSection[]
