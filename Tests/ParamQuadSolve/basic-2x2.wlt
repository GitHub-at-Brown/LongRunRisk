BeginTestSection["basic-2x2 Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`basic2x2`"]

(* --- merged from: basic-2x2_test1.wlt --- *)
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

VerificationTest[AssociationQ[res$], True, TestID -> "returns-association@@Tests/ParamQuadSolve/basic-2x2.wlt:18,1-18,130"]

(* --- merged from: basic-2x2_test2.wlt --- *)
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

VerificationTest[AllTrue[Flatten@res$["Verification"], TrueQ], True, TestID -> "verification-all-true@@Tests/ParamQuadSolve/basic-2x2.wlt:34,1-34,158"]

(* --- merged from: basic-2x2_test3.wlt --- *)
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

VerificationTest[AllTrue[Simplify[eqns$ /. res$["Solution"] /. signSym$ -> 1], TrueQ], True, TestID -> "subs-sign-+1@@Tests/ParamQuadSolve/basic-2x2.wlt:50,1-50,173"]

(* --- merged from: basic-2x2_test4.wlt --- *)
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

VerificationTest[AllTrue[Simplify[eqns$ /. res$["Solution"] /. signSym$ -> -1], TrueQ], True, TestID -> "subs-sign--1@@Tests/ParamQuadSolve/basic-2x2.wlt:66,1-66,174"]

(* --- merged from: basic-2x2_test5.wlt --- *)
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

VerificationTest[Simplify[rad$^2 == 20], True, TestID -> "discriminant-20@@Tests/ParamQuadSolve/basic-2x2.wlt:82,1-82,130"]

(* --- merged from: basic-2x2_test6.wlt --- *)
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

VerificationTest[
 Module[{signs, ourRules, solveRules, sameQ},
   signs = {1, -1};
   ourRules = (res$["Solution"] /. signSym$ -> #) & /@ signs;
   solveRules = Solve[eqns$, vars$, Reals];
   sameQ[r1_, r2_] := TrueQ@Simplify[(vars$ /. r1) == (vars$ /. r2)];
   Length[solveRules] == Length[ourRules] && AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]]
 ], True, TestID -> "matches-Solve@@Tests/ParamQuadSolve/basic-2x2.wlt:98,1-106,2"
]

End[]
EndTestSection[]
