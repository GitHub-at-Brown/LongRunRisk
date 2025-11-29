Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`"];

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

vars$ = {A[1], A[2], A[3], A[4], A[5], A[6], A[7]};
sys$ = {
  0 == ((1 - gamma) (-1 + psi) rhocp)/((1 - 1/psi) psi) - ((1 - gamma) A[1])/(1 - 1/psi) + (E^A[0] (1 - gamma) vpp A[7])/((1 + E^A[0]) (1 - 1/psi)),
  0 == ((1 - gamma) (-1 + psi) xic)/((1 - 1/psi) psi) - ((1 - gamma) A[2])/(1 - 1/psi),
  0 == (E^A[0] (1 - gamma) xip A[1])/((1 + E^A[0]) (1 - 1/psi)) - ((1 - gamma) A[3])/(1 - 1/psi),
  0 == (E^(2 A[0]) (1 - gamma)^2 phip A[1] A[2])/((1 + E^A[0])^2 (1 - 1/psi)^2) +
       A[2] ((E^A[0] (1 - gamma)^2 phicp (-1 + psi))/((1 + E^A[0]) (1 - 1/psi)^2 psi) + (E^(2 A[0]) (1 - gamma)^2 A[3])/((1 + E^A[0])^2 (1 - 1/psi)^2)) -
       (2 E^A[0] Esg (1 - gamma) (-1 + rhog) rhog A[5])/((1 + E^A[0]) (1 - 1/psi)) -
       (4 E^(2 A[0]) Esg (1 - gamma)^2 phig^2 (-1 + rhog) rhog A[5]^2)/((1 + E^A[0])^2 (1 - 1/psi)^2) +
       A[4] (((1 - gamma) (-1 + E^A[0] (-1 + rhog)))/((1 + E^A[0]) (1 - 1/psi)) + (2 E^(2 A[0]) (1 - gamma)^2 phig^2 rhog A[5])/((1 + E^A[0])^2 (1 - 1/psi)^2)),
  0 == (E^(2 A[0]) (1 - gamma)^2 A[2]^2)/(2 (1 + E^A[0])^2 (1 - 1/psi)^2) + ((1 - gamma) (-1 + E^A[0] (-1 + rhog^2)) A[5])/((1 + E^A[0]) (1 - 1/psi)) +
       (2 E^(2 A[0]) (1 - gamma)^2 phig^2 rhog^2 A[5]^2)/((1 + E^A[0])^2 (1 - 1/psi)^2),
  0 == ((1 - gamma) (-1 + psi) rhocpbar)/((1 - 1/psi) psi) + (E^A[0] (1 - gamma) rhoppbar A[1])/((1 + E^A[0]) (1 - 1/psi)) +
       ((1 - gamma) (-1 + E^A[0] (-1 + rhopbar)) A[6])/((1 + E^A[0]) (1 - 1/psi)) + (E^A[0] (1 - gamma) vppbar A[7])/((1 + E^A[0]) (1 - 1/psi)),
  0 == (E^(2 A[0]) (1 - gamma)^2 phipbarpb^2 A[6]^2)/(2 (1 + E^A[0])^2 (1 - 1/psi)^2) + ((1 - gamma) (-1 + E^A[0] (-1 + vp)) A[7])/((1 + E^A[0]) (1 - 1/psi))
};

params$ = {
  gamma -> 0.3, psi -> 1.5, A[0] -> 0.8,
  rhocp -> 0.2, xic -> 0.1, xip -> 0.15,
  phip -> 0.5, phicp -> 0.4, Esg -> 0.7,
  rhog -> 0.2, phig -> 0.3,
  rhocpbar -> 0.25, rhoppbar -> 0.2, rhopbar -> 0.1,
  vpp -> 0.4, vppbar -> 0.35, phipbarpb -> 0.6, vp -> 0.2
};

sysN$ = (sys$ /. params$);
res$ = pqs[sysN$, vars$, "ValidationOption" -> False, "DomainOption" -> Reals];
signKeys$ = Keys[res$["SignRootMap"]];
assigns$ = Tuples[{-1, 1}, Length[signKeys$]];
pkgSolRules$ = Map[(res$["Solution"] /. Thread[signKeys$ -> #]) &, assigns$];
pkgVals$ = (vars$ /. FixedPoint[(# /. #) &, #]) & /@ pkgSolRules$ // N;

eqResidualVec[vVals_] := Module[{lhsMinusRhs, rules},
  rules = Thread[vars$ -> vVals];
  lhsMinusRhs = (#[[1]] - #[[2]] /. rules) & /@ (sysN$ /. Equal -> List);
  Chop[N[lhsMinusRhs, 30]]
];
residualsPkg$ = eqResidualVec /@ pkgVals$;

(* Manual sequential Solve path to cross-check number of solutions *)
Module[{sol2, sol3, sol1, sol7, eq6sub, sol6, sol7full, sol1full, sol3full, eq5sub, sol5, eq4sub, sol4},
  sol2 = Solve[sysN$[[2]], A[2]][[1]];
  sol3 = Solve[sysN$[[3]], A[3]][[1]];
  sol1 = Solve[sysN$[[1]], A[1]][[1]];
  sol7 = Solve[sysN$[[7]], A[7]][[1]];
  eq6sub = sysN$[[6]] /. sol1 /. sol7;
  sol6 = Solve[eq6sub, A[6]];
  eq5sub = sysN$[[5]] /. sol2;
  sol5 = Solve[eq5sub, A[5]];
  manualSols$ = Flatten[Table[
    (
      sol7full = sol7 /. sol6[[i]];
      sol1full = sol1 /. sol7full;
      sol3full = sol3 /. sol1full;
      eq4sub = sysN$[[4]] /. sol2 /. sol3full /. sol1full /. sol5[[j]];
      sol4 = Solve[eq4sub, A[4]][[1]];
      Join[sol1full, sol2, sol3full, sol4, sol5[[j]], sol6[[i]], sol7full]
    )
    , {i, Length[sol6]}, {j, Length[sol5]}], 1];
];
manualVals$ = (vars$ /. FixedPoint[(# /. #) &, #]) & /@ manualSols$ // N;
residualsMan$ = eqResidualVec /@ manualVals$;

VerificationTest[AssociationQ[res$], True, TestID -> "returns-association@@Tests/ParamQuadSolve/seven-by-seven.wlt:72,1-72,129"]
VerificationTest[Length[signKeys$] === 2, True, TestID -> "two-sign-variables@@Tests/ParamQuadSolve/seven-by-seven.wlt:73,1-73,133"]
VerificationTest[Length[pkgVals$] === 4, True, TestID -> "four-branches@@Tests/ParamQuadSolve/seven-by-seven.wlt:74,1-74,127"]
VerificationTest[Length[manualVals$] === 4, True, TestID -> "manual-four@@Tests/ParamQuadSolve/seven-by-seven.wlt:75,1-75,128"]

End[];
