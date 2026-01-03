(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ParamQuadSolve/seven-by-seven.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`sevenbyseven`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["seven-by-seven Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`sevenBySeven`"]],
    HoldComplete[Null],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"]; ],
    HoldComplete[pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve; ],
    HoldComplete[vars$ = {A[1], A[2], A[3], A[4], A[5], A[6], A[7]}; ],
    HoldComplete[sys$ = {0 == ((1 - gamma)*(-1 + psi)*rhocp)/((1 - 1/psi)*psi) - ((1 - gamma)*A[1])/(1 - 1/psi) + (E^A[0]*(1 - gamma)*vpp*A[7])/((1 + E^A[0])*(1 - 1/psi)), 0 == ((1 - gamma)*(-1 + psi)*xic)/((1 - 1/psi)*psi) - ((1 - gamma)*A[2])/(1 - 1/psi), 0 == (E^A[0]*(1 - gamma)*xip*A[1])/((1 + E^A[0])*(1 - 1/psi)) - ((1 - gamma)*A[3])/(1 - 1/psi), 0 == (E^(2*A[0])*(1 - gamma)^2*phip*A[1]*A[2])/((1 + E^A[0])^2*(1 - 1/psi)^2) + A[2]*((E^A[0]*(1 - gamma)^2*phicp*(-1 + psi))/((1 + E^A[0])*(1 - 1/psi)^2*psi) + (E^(2*A[0])*(1 - gamma)^2*A[3])/((1 + E^A[0])^2*(1 - 1/psi)^2)) - (2*E^A[0]*Esg*(1 - gamma)*(-1 + rhog)*rhog*A[5])/((1 + E^A[0])*(1 - 1/psi)) - (4*E^(2*A[0])*Esg*(1 - gamma)^2*phig^2*(-1 + rhog)*rhog*A[5]^2)/((1 + E^A[0])^2*(1 - 1/psi)^2) + A[4]*(((1 - gamma)*(-1 + E^A[0]*(-1 + rhog)))/((1 + E^A[0])*(1 - 1/psi)) + (2*E^(2*A[0])*(1 - gamma)^2*phig^2*rhog*A[5])/((1 + E^A[0])^2*(1 - 1/psi)^2)), 0 == (E^(2*A[0])*(1 - gamma)^2*A[2]^2)/(2*(1 + E^A[0])^2*(1 - 1/psi)^2) + ((1 - gamma)*(-1 + E^A[0]*(-1 + rhog^2))*A[5])/((1 + E^A[0])*(1 - 1/psi)) + (2*E^(2*A[0])*(1 - gamma)^2*phig^2*rhog^2*A[5]^2)/((1 + E^A[0])^2*(1 - 1/psi)^2), 0 == ((1 - gamma)*(-1 + psi)*rhocpbar)/((1 - 1/psi)*psi) + (E^A[0]*(1 - gamma)*rhoppbar*A[1])/((1 + E^A[0])*(1 - 1/psi)) + ((1 - gamma)*(-1 + E^A[0]*(-1 + rhopbar))*A[6])/((1 + E^A[0])*(1 - 1/psi)) + (E^A[0]*(1 - gamma)*vppbar*A[7])/((1 + E^A[0])*(1 - 1/psi)), 0 == (E^(2*A[0])*(1 - gamma)^2*phipbarpb^2*A[6]^2)/(2*(1 + E^A[0])^2*(1 - 1/psi)^2) + ((1 - gamma)*(-1 + E^A[0]*(-1 + vp))*A[7])/((1 + E^A[0])*(1 - 1/psi))}; ],
    HoldComplete[params$ = {gamma -> 0.3, psi -> 1.5, A[0] -> 0.8, rhocp -> 0.2, xic -> 0.1, xip -> 0.15, phip -> 0.5, phicp -> 0.4, Esg -> 0.7, rhog -> 0.2, phig -> 0.3, rhocpbar -> 0.25, rhoppbar -> 0.2, rhopbar -> 0.1, vpp -> 0.4, vppbar -> 0.35, phipbarpb -> 0.6, vp -> 0.2}; ],
    HoldComplete[sysN$ = sys$ /. params$; ],
    HoldComplete[res$ = pqs[sysN$, vars$, "ValidationOption" -> False, "DomainOption" -> Reals]; ],
    HoldComplete[signKeys$ = Keys[res$["SignRootMap"]]; ],
    HoldComplete[assigns$ = Tuples[{-1, 1}, Length[signKeys$]]; ],
    HoldComplete[pkgSolRules$ = (res$["Solution"] /. Thread[signKeys$ -> #1] & ) /@ assigns$; ],
    HoldComplete[pkgVals$ = N[(vars$ /. FixedPoint[#1 /. #1 & , #1] & ) /@ pkgSolRules$]; ],
    HoldComplete[eqResidualVec[vVals_] := Module[{lhsMinusRhs, rules}, rules = Thread[vars$ -> vVals]; lhsMinusRhs = (#1[[1]] - #1[[2]] /. rules & ) /@ (sysN$ /. Equal -> List); Chop[N[lhsMinusRhs, 30]]]; ],
    HoldComplete[residualsPkg$ = eqResidualVec /@ pkgVals$; ],
    HoldComplete[Null],
    HoldComplete[Module[{sol2, sol3, sol1, sol7, eq6sub, sol6, sol7full, sol1full, sol3full, eq5sub, sol5, eq4sub, sol4}, sol2 = Solve[sysN$[[2]], A[2]][[1]]; sol3 = Solve[sysN$[[3]], A[3]][[1]]; sol1 = Solve[sysN$[[1]], A[1]][[1]]; sol7 = Solve[sysN$[[7]], A[7]][[1]]; eq6sub = sysN$[[6]] /. sol1 /. sol7; sol6 = Solve[eq6sub, A[6]]; eq5sub = sysN$[[5]] /. sol2; sol5 = Solve[eq5sub, A[5]]; manualSols$ = Flatten[Table[sol7full = sol7 /. sol6[[i]]; sol1full = sol1 /. sol7full; sol3full = sol3 /. sol1full; eq4sub = sysN$[[4]] /. sol2 /. sol3full /. sol1full /. sol5[[j]]; sol4 = Solve[eq4sub, A[4]][[1]]; Join[sol1full, sol2, sol3full, sol4, sol5[[j]], sol6[[i]], sol7full], {i, Length[sol6]}, {j, Length[sol5]}], 1]; ]; ],
    HoldComplete[manualVals$ = N[(vars$ /. FixedPoint[#1 /. #1 & , #1] & ) /@ manualSols$]; ],
    HoldComplete[residualsMan$ = eqResidualVec /@ manualVals$; ],
    HoldComplete[VerificationTest[AssociationQ[res$], True, TestID -> "returns-association@@Tests/ParamQuadSolve/seven-by-seven.wlt:74,1-74,129"]],
    HoldComplete[Null],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"]; ],
    HoldComplete[pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve; ],
    HoldComplete[vars$ = {A[1], A[2], A[3], A[4], A[5], A[6], A[7]}; ],
    HoldComplete[sys$ = {0 == ((1 - gamma)*(-1 + psi)*rhocp)/((1 - 1/psi)*psi) - ((1 - gamma)*A[1])/(1 - 1/psi) + (E^A[0]*(1 - gamma)*vpp*A[7])/((1 + E^A[0])*(1 - 1/psi)), 0 == ((1 - gamma)*(-1 + psi)*xic)/((1 - 1/psi)*psi) - ((1 - gamma)*A[2])/(1 - 1/psi), 0 == (E^A[0]*(1 - gamma)*xip*A[1])/((1 + E^A[0])*(1 - 1/psi)) - ((1 - gamma)*A[3])/(1 - 1/psi), 0 == (E^(2*A[0])*(1 - gamma)^2*phip*A[1]*A[2])/((1 + E^A[0])^2*(1 - 1/psi)^2) + A[2]*((E^A[0]*(1 - gamma)^2*phicp*(-1 + psi))/((1 + E^A[0])*(1 - 1/psi)^2*psi) + (E^(2*A[0])*(1 - gamma)^2*A[3])/((1 + E^A[0])^2*(1 - 1/psi)^2)) - (2*E^A[0]*Esg*(1 - gamma)*(-1 + rhog)*rhog*A[5])/((1 + E^A[0])*(1 - 1/psi)) - (4*E^(2*A[0])*Esg*(1 - gamma)^2*phig^2*(-1 + rhog)*rhog*A[5]^2)/((1 + E^A[0])^2*(1 - 1/psi)^2) + A[4]*(((1 - gamma)*(-1 + E^A[0]*(-1 + rhog)))/((1 + E^A[0])*(1 - 1/psi)) + (2*E^(2*A[0])*(1 - gamma)^2*phig^2*rhog*A[5])/((1 + E^A[0])^2*(1 - 1/psi)^2)), 0 == (E^(2*A[0])*(1 - gamma)^2*A[2]^2)/(2*(1 + E^A[0])^2*(1 - 1/psi)^2) + ((1 - gamma)*(-1 + E^A[0]*(-1 + rhog^2))*A[5])/((1 + E^A[0])*(1 - 1/psi)) + (2*E^(2*A[0])*(1 - gamma)^2*phig^2*rhog^2*A[5]^2)/((1 + E^A[0])^2*(1 - 1/psi)^2), 0 == ((1 - gamma)*(-1 + psi)*rhocpbar)/((1 - 1/psi)*psi) + (E^A[0]*(1 - gamma)*rhoppbar*A[1])/((1 + E^A[0])*(1 - 1/psi)) + ((1 - gamma)*(-1 + E^A[0]*(-1 + rhopbar))*A[6])/((1 + E^A[0])*(1 - 1/psi)) + (E^A[0]*(1 - gamma)*vppbar*A[7])/((1 + E^A[0])*(1 - 1/psi)), 0 == (E^(2*A[0])*(1 - gamma)^2*phipbarpb^2*A[6]^2)/(2*(1 + E^A[0])^2*(1 - 1/psi)^2) + ((1 - gamma)*(-1 + E^A[0]*(-1 + vp))*A[7])/((1 + E^A[0])*(1 - 1/psi))}; ],
    HoldComplete[params$ = {gamma -> 0.3, psi -> 1.5, A[0] -> 0.8, rhocp -> 0.2, xic -> 0.1, xip -> 0.15, phip -> 0.5, phicp -> 0.4, Esg -> 0.7, rhog -> 0.2, phig -> 0.3, rhocpbar -> 0.25, rhoppbar -> 0.2, rhopbar -> 0.1, vpp -> 0.4, vppbar -> 0.35, phipbarpb -> 0.6, vp -> 0.2}; ],
    HoldComplete[sysN$ = sys$ /. params$; ],
    HoldComplete[res$ = pqs[sysN$, vars$, "ValidationOption" -> False, "DomainOption" -> Reals]; ],
    HoldComplete[signKeys$ = Keys[res$["SignRootMap"]]; ],
    HoldComplete[assigns$ = Tuples[{-1, 1}, Length[signKeys$]]; ],
    HoldComplete[pkgSolRules$ = (res$["Solution"] /. Thread[signKeys$ -> #1] & ) /@ assigns$; ],
    HoldComplete[pkgVals$ = N[(vars$ /. FixedPoint[#1 /. #1 & , #1] & ) /@ pkgSolRules$]; ],
    HoldComplete[eqResidualVec[vVals_] := Module[{lhsMinusRhs, rules}, rules = Thread[vars$ -> vVals]; lhsMinusRhs = (#1[[1]] - #1[[2]] /. rules & ) /@ (sysN$ /. Equal -> List); Chop[N[lhsMinusRhs, 30]]]; ],
    HoldComplete[residualsPkg$ = eqResidualVec /@ pkgVals$; ],
    HoldComplete[Null],
    HoldComplete[Module[{sol2, sol3, sol1, sol7, eq6sub, sol6, sol7full, sol1full, sol3full, eq5sub, sol5, eq4sub, sol4}, sol2 = Solve[sysN$[[2]], A[2]][[1]]; sol3 = Solve[sysN$[[3]], A[3]][[1]]; sol1 = Solve[sysN$[[1]], A[1]][[1]]; sol7 = Solve[sysN$[[7]], A[7]][[1]]; eq6sub = sysN$[[6]] /. sol1 /. sol7; sol6 = Solve[eq6sub, A[6]]; eq5sub = sysN$[[5]] /. sol2; sol5 = Solve[eq5sub, A[5]]; manualSols$ = Flatten[Table[sol7full = sol7 /. sol6[[i]]; sol1full = sol1 /. sol7full; sol3full = sol3 /. sol1full; eq4sub = sysN$[[4]] /. sol2 /. sol3full /. sol1full /. sol5[[j]]; sol4 = Solve[eq4sub, A[4]][[1]]; Join[sol1full, sol2, sol3full, sol4, sol5[[j]], sol6[[i]], sol7full], {i, Length[sol6]}, {j, Length[sol5]}], 1]; ]; ],
    HoldComplete[manualVals$ = N[(vars$ /. FixedPoint[#1 /. #1 & , #1] & ) /@ manualSols$]; ],
    HoldComplete[residualsMan$ = eqResidualVec /@ manualVals$; ],
    HoldComplete[VerificationTest[Length[signKeys$] === 2, True, TestID -> "two-sign-variables@@Tests/ParamQuadSolve/seven-by-seven.wlt:146,1-146,135"]],
    HoldComplete[Null],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"]; ],
    HoldComplete[pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve; ],
    HoldComplete[vars$ = {A[1], A[2], A[3], A[4], A[5], A[6], A[7]}; ],
    HoldComplete[sys$ = {0 == ((1 - gamma)*(-1 + psi)*rhocp)/((1 - 1/psi)*psi) - ((1 - gamma)*A[1])/(1 - 1/psi) + (E^A[0]*(1 - gamma)*vpp*A[7])/((1 + E^A[0])*(1 - 1/psi)), 0 == ((1 - gamma)*(-1 + psi)*xic)/((1 - 1/psi)*psi) - ((1 - gamma)*A[2])/(1 - 1/psi), 0 == (E^A[0]*(1 - gamma)*xip*A[1])/((1 + E^A[0])*(1 - 1/psi)) - ((1 - gamma)*A[3])/(1 - 1/psi), 0 == (E^(2*A[0])*(1 - gamma)^2*phip*A[1]*A[2])/((1 + E^A[0])^2*(1 - 1/psi)^2) + A[2]*((E^A[0]*(1 - gamma)^2*phicp*(-1 + psi))/((1 + E^A[0])*(1 - 1/psi)^2*psi) + (E^(2*A[0])*(1 - gamma)^2*A[3])/((1 + E^A[0])^2*(1 - 1/psi)^2)) - (2*E^A[0]*Esg*(1 - gamma)*(-1 + rhog)*rhog*A[5])/((1 + E^A[0])*(1 - 1/psi)) - (4*E^(2*A[0])*Esg*(1 - gamma)^2*phig^2*(-1 + rhog)*rhog*A[5]^2)/((1 + E^A[0])^2*(1 - 1/psi)^2) + A[4]*(((1 - gamma)*(-1 + E^A[0]*(-1 + rhog)))/((1 + E^A[0])*(1 - 1/psi)) + (2*E^(2*A[0])*(1 - gamma)^2*phig^2*rhog*A[5])/((1 + E^A[0])^2*(1 - 1/psi)^2)), 0 == (E^(2*A[0])*(1 - gamma)^2*A[2]^2)/(2*(1 + E^A[0])^2*(1 - 1/psi)^2) + ((1 - gamma)*(-1 + E^A[0]*(-1 + rhog^2))*A[5])/((1 + E^A[0])*(1 - 1/psi)) + (2*E^(2*A[0])*(1 - gamma)^2*phig^2*rhog^2*A[5]^2)/((1 + E^A[0])^2*(1 - 1/psi)^2), 0 == ((1 - gamma)*(-1 + psi)*rhocpbar)/((1 - 1/psi)*psi) + (E^A[0]*(1 - gamma)*rhoppbar*A[1])/((1 + E^A[0])*(1 - 1/psi)) + ((1 - gamma)*(-1 + E^A[0]*(-1 + rhopbar))*A[6])/((1 + E^A[0])*(1 - 1/psi)) + (E^A[0]*(1 - gamma)*vppbar*A[7])/((1 + E^A[0])*(1 - 1/psi)), 0 == (E^(2*A[0])*(1 - gamma)^2*phipbarpb^2*A[6]^2)/(2*(1 + E^A[0])^2*(1 - 1/psi)^2) + ((1 - gamma)*(-1 + E^A[0]*(-1 + vp))*A[7])/((1 + E^A[0])*(1 - 1/psi))}; ],
    HoldComplete[params$ = {gamma -> 0.3, psi -> 1.5, A[0] -> 0.8, rhocp -> 0.2, xic -> 0.1, xip -> 0.15, phip -> 0.5, phicp -> 0.4, Esg -> 0.7, rhog -> 0.2, phig -> 0.3, rhocpbar -> 0.25, rhoppbar -> 0.2, rhopbar -> 0.1, vpp -> 0.4, vppbar -> 0.35, phipbarpb -> 0.6, vp -> 0.2}; ],
    HoldComplete[sysN$ = sys$ /. params$; ],
    HoldComplete[res$ = pqs[sysN$, vars$, "ValidationOption" -> False, "DomainOption" -> Reals]; ],
    HoldComplete[signKeys$ = Keys[res$["SignRootMap"]]; ],
    HoldComplete[assigns$ = Tuples[{-1, 1}, Length[signKeys$]]; ],
    HoldComplete[pkgSolRules$ = (res$["Solution"] /. Thread[signKeys$ -> #1] & ) /@ assigns$; ],
    HoldComplete[pkgVals$ = N[(vars$ /. FixedPoint[#1 /. #1 & , #1] & ) /@ pkgSolRules$]; ],
    HoldComplete[eqResidualVec[vVals_] := Module[{lhsMinusRhs, rules}, rules = Thread[vars$ -> vVals]; lhsMinusRhs = (#1[[1]] - #1[[2]] /. rules & ) /@ (sysN$ /. Equal -> List); Chop[N[lhsMinusRhs, 30]]]; ],
    HoldComplete[residualsPkg$ = eqResidualVec /@ pkgVals$; ],
    HoldComplete[Null],
    HoldComplete[Module[{sol2, sol3, sol1, sol7, eq6sub, sol6, sol7full, sol1full, sol3full, eq5sub, sol5, eq4sub, sol4}, sol2 = Solve[sysN$[[2]], A[2]][[1]]; sol3 = Solve[sysN$[[3]], A[3]][[1]]; sol1 = Solve[sysN$[[1]], A[1]][[1]]; sol7 = Solve[sysN$[[7]], A[7]][[1]]; eq6sub = sysN$[[6]] /. sol1 /. sol7; sol6 = Solve[eq6sub, A[6]]; eq5sub = sysN$[[5]] /. sol2; sol5 = Solve[eq5sub, A[5]]; manualSols$ = Flatten[Table[sol7full = sol7 /. sol6[[i]]; sol1full = sol1 /. sol7full; sol3full = sol3 /. sol1full; eq4sub = sysN$[[4]] /. sol2 /. sol3full /. sol1full /. sol5[[j]]; sol4 = Solve[eq4sub, A[4]][[1]]; Join[sol1full, sol2, sol3full, sol4, sol5[[j]], sol6[[i]], sol7full], {i, Length[sol6]}, {j, Length[sol5]}], 1]; ]; ],
    HoldComplete[manualVals$ = N[(vars$ /. FixedPoint[#1 /. #1 & , #1] & ) /@ manualSols$]; ],
    HoldComplete[residualsMan$ = eqResidualVec /@ manualVals$; ],
    HoldComplete[VerificationTest[Length[pkgVals$] === 4, True, TestID -> "four-branches@@Tests/ParamQuadSolve/seven-by-seven.wlt:218,1-218,129"]],
    HoldComplete[Null],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"]; ],
    HoldComplete[pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve; ],
    HoldComplete[vars$ = {A[1], A[2], A[3], A[4], A[5], A[6], A[7]}; ],
    HoldComplete[sys$ = {0 == ((1 - gamma)*(-1 + psi)*rhocp)/((1 - 1/psi)*psi) - ((1 - gamma)*A[1])/(1 - 1/psi) + (E^A[0]*(1 - gamma)*vpp*A[7])/((1 + E^A[0])*(1 - 1/psi)), 0 == ((1 - gamma)*(-1 + psi)*xic)/((1 - 1/psi)*psi) - ((1 - gamma)*A[2])/(1 - 1/psi), 0 == (E^A[0]*(1 - gamma)*xip*A[1])/((1 + E^A[0])*(1 - 1/psi)) - ((1 - gamma)*A[3])/(1 - 1/psi), 0 == (E^(2*A[0])*(1 - gamma)^2*phip*A[1]*A[2])/((1 + E^A[0])^2*(1 - 1/psi)^2) + A[2]*((E^A[0]*(1 - gamma)^2*phicp*(-1 + psi))/((1 + E^A[0])*(1 - 1/psi)^2*psi) + (E^(2*A[0])*(1 - gamma)^2*A[3])/((1 + E^A[0])^2*(1 - 1/psi)^2)) - (2*E^A[0]*Esg*(1 - gamma)*(-1 + rhog)*rhog*A[5])/((1 + E^A[0])*(1 - 1/psi)) - (4*E^(2*A[0])*Esg*(1 - gamma)^2*phig^2*(-1 + rhog)*rhog*A[5]^2)/((1 + E^A[0])^2*(1 - 1/psi)^2) + A[4]*(((1 - gamma)*(-1 + E^A[0]*(-1 + rhog)))/((1 + E^A[0])*(1 - 1/psi)) + (2*E^(2*A[0])*(1 - gamma)^2*phig^2*rhog*A[5])/((1 + E^A[0])^2*(1 - 1/psi)^2)), 0 == (E^(2*A[0])*(1 - gamma)^2*A[2]^2)/(2*(1 + E^A[0])^2*(1 - 1/psi)^2) + ((1 - gamma)*(-1 + E^A[0]*(-1 + rhog^2))*A[5])/((1 + E^A[0])*(1 - 1/psi)) + (2*E^(2*A[0])*(1 - gamma)^2*phig^2*rhog^2*A[5]^2)/((1 + E^A[0])^2*(1 - 1/psi)^2), 0 == ((1 - gamma)*(-1 + psi)*rhocpbar)/((1 - 1/psi)*psi) + (E^A[0]*(1 - gamma)*rhoppbar*A[1])/((1 + E^A[0])*(1 - 1/psi)) + ((1 - gamma)*(-1 + E^A[0]*(-1 + rhopbar))*A[6])/((1 + E^A[0])*(1 - 1/psi)) + (E^A[0]*(1 - gamma)*vppbar*A[7])/((1 + E^A[0])*(1 - 1/psi)), 0 == (E^(2*A[0])*(1 - gamma)^2*phipbarpb^2*A[6]^2)/(2*(1 + E^A[0])^2*(1 - 1/psi)^2) + ((1 - gamma)*(-1 + E^A[0]*(-1 + vp))*A[7])/((1 + E^A[0])*(1 - 1/psi))}; ],
    HoldComplete[params$ = {gamma -> 0.3, psi -> 1.5, A[0] -> 0.8, rhocp -> 0.2, xic -> 0.1, xip -> 0.15, phip -> 0.5, phicp -> 0.4, Esg -> 0.7, rhog -> 0.2, phig -> 0.3, rhocpbar -> 0.25, rhoppbar -> 0.2, rhopbar -> 0.1, vpp -> 0.4, vppbar -> 0.35, phipbarpb -> 0.6, vp -> 0.2}; ],
    HoldComplete[sysN$ = sys$ /. params$; ],
    HoldComplete[res$ = pqs[sysN$, vars$, "ValidationOption" -> False, "DomainOption" -> Reals]; ],
    HoldComplete[signKeys$ = Keys[res$["SignRootMap"]]; ],
    HoldComplete[assigns$ = Tuples[{-1, 1}, Length[signKeys$]]; ],
    HoldComplete[pkgSolRules$ = (res$["Solution"] /. Thread[signKeys$ -> #1] & ) /@ assigns$; ],
    HoldComplete[pkgVals$ = N[(vars$ /. FixedPoint[#1 /. #1 & , #1] & ) /@ pkgSolRules$]; ],
    HoldComplete[eqResidualVec[vVals_] := Module[{lhsMinusRhs, rules}, rules = Thread[vars$ -> vVals]; lhsMinusRhs = (#1[[1]] - #1[[2]] /. rules & ) /@ (sysN$ /. Equal -> List); Chop[N[lhsMinusRhs, 30]]]; ],
    HoldComplete[residualsPkg$ = eqResidualVec /@ pkgVals$; ],
    HoldComplete[Null],
    HoldComplete[Module[{sol2, sol3, sol1, sol7, eq6sub, sol6, sol7full, sol1full, sol3full, eq5sub, sol5, eq4sub, sol4}, sol2 = Solve[sysN$[[2]], A[2]][[1]]; sol3 = Solve[sysN$[[3]], A[3]][[1]]; sol1 = Solve[sysN$[[1]], A[1]][[1]]; sol7 = Solve[sysN$[[7]], A[7]][[1]]; eq6sub = sysN$[[6]] /. sol1 /. sol7; sol6 = Solve[eq6sub, A[6]]; eq5sub = sysN$[[5]] /. sol2; sol5 = Solve[eq5sub, A[5]]; manualSols$ = Flatten[Table[sol7full = sol7 /. sol6[[i]]; sol1full = sol1 /. sol7full; sol3full = sol3 /. sol1full; eq4sub = sysN$[[4]] /. sol2 /. sol3full /. sol1full /. sol5[[j]]; sol4 = Solve[eq4sub, A[4]][[1]]; Join[sol1full, sol2, sol3full, sol4, sol5[[j]], sol6[[i]], sol7full], {i, Length[sol6]}, {j, Length[sol5]}], 1]; ]; ],
    HoldComplete[manualVals$ = N[(vars$ /. FixedPoint[#1 /. #1 & , #1] & ) /@ manualSols$]; ],
    HoldComplete[residualsMan$ = eqResidualVec /@ manualVals$; ],
    HoldComplete[VerificationTest[Length[manualVals$] === 4, True, TestID -> "manual-four@@Tests/ParamQuadSolve/seven-by-seven.wlt:290,1-290,130"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "seven-by-seven",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ParamQuadSolve/seven-by-seven.wlt"
};

(* --- internal helpers --- *)
testExprQ[HoldComplete[VerificationTest[___]]] := True;
testExprQ[HoldComplete[TestCreate[___]]] := True;
testExprQ[HoldComplete[IntermediateTest[___]]] := True;
testExprQ[_] := False;

hasOptionQ[hc_HoldComplete, sym_Symbol] := !FreeQ[hc, HoldPattern[(sym -> _) | (sym :> _)]];

removeOption[hc_HoldComplete, sym_Symbol] :=
    FixedPoint[
        ReplaceAll[
            #,
            HoldComplete[head_[pre___, (sym -> _) | (sym :> _), post___]] :> HoldComplete[head[pre, post]]
        ] &,
        hc
    ];

appendOption[hc_HoldComplete, rule_] := hc /. HoldComplete[head_[args___]] :> HoldComplete[head[args, rule]];

convertTestHead[hc_HoldComplete, Automatic] := hc;
convertTestHead[hc_HoldComplete, newHead_Symbol] :=
    hc /. HoldComplete[(VerificationTest | TestCreate | IntermediateTest)[args___]] :> HoldComplete[newHead[args]];

stripForHash[hc_HoldComplete] := removeOption[removeOption[hc, TestID], TimeConstraint];

shortHash[hc_HoldComplete, n_Integer?Positive] :=
    Module[{h = IntegerString[Hash[stripForHash[hc], "SHA256"], 36]}, StringTake[h, UpTo[n]]];

makeTestID[prefix_String, key_String, occ_Integer] :=
    If[occ <= 1, StringJoin[prefix, "-", key], StringJoin[prefix, "-", key, "-", IntegerString[occ]]];

ensureTestID[hc_HoldComplete, id_, preserveQ_] :=
    Module[{out = hc},
        If[preserveQ && hasOptionQ[out, TestID], Return[out]];
        out = removeOption[out, TestID];
        appendOption[out, TestID -> id]
    ];

ensureTimeConstraint[hc_HoldComplete, tc_, preserveQ_] :=
    Module[{out = hc},
        If[preserveQ && hasOptionQ[out, TimeConstraint], Return[out]];
        out = removeOption[out, TimeConstraint];
        appendOption[out, TimeConstraint -> tc]
    ];

transformTest[hc_HoldComplete, id_, opts:OptionsPattern[GenerateWLT]] :=
    Module[{out = hc, head, tc, keepID, keepTC},
        head  = OptionValue["OutputTestHead"];
        tc    = OptionValue["DefaultTimeConstraint"];
        keepID = TrueQ @ OptionValue["PreserveExistingTestIDs"];
        keepTC = TrueQ @ OptionValue["PreserveExistingTimeConstraints"];
        out = convertTestHead[out, head];
        out = ensureTestID[out, id, keepID];
        out = ensureTimeConstraint[out, tc, keepTC];
        out
    ];

stripHold[HoldComplete[e_]] :=
    Module[{s = ToString[HoldForm[e], InputForm, PageWidth -> Infinity]},
        If[StringStartsQ[s, "HoldForm["] && StringEndsQ[s, "]"], StringTake[s, {10, -2}], s]
    ];

writeHeldExpressions[file_String, exprs_List] :=
    Module[{res},
        res = Quiet@Check[Export[file, exprs, "HeldExpressions"], $Failed];
        If[res === $Failed,
            Export[file, StringRiffle[stripHold /@ exprs, "\n\n"], "Text"];
        ];
        file
    ];

defaultTarget[opts:OptionsPattern[GenerateWLT]] :=
    Module[{rel = OptionValue["TargetRelativeWLTPath"], here},
        here = If[StringQ[$InputFileName] && $InputFileName =!= "", DirectoryName[$InputFileName], Directory[]];
        ExpandFileName @ FileNameJoin[{here, rel}]
    ];

GenerateWLT[target_: Automatic, opts:OptionsPattern[]] :=
    Module[{outFile, outExprs, seen = <||>, prefix, n, key, occ, id},
        outFile = Replace[target, Automatic :> defaultTarget[opts]];
        CreateDirectory[DirectoryName[outFile], CreateIntermediateDirectories -> True];
        prefix = OptionValue["TestIDPrefix"];
        prefix = If[StringQ[prefix], prefix, ToString[prefix, InputForm]];
        n = OptionValue["HashLength"];
        n = If[IntegerQ[n] && n > 0, n, 8];
        outExprs = Map[
            Function[hc,
                If[testExprQ[hc],
                    key = shortHash[hc, n];
                    occ = Lookup[seen, key, 0] + 1;
                    seen[key] = occ;
                    id = makeTestID[prefix, key, occ];
                    transformTest[hc, id, opts],
                    hc
                ]
            ],
            $sourceExpressions
        ];
        writeHeldExpressions[outFile, outExprs];
        outFile
    ];

End[];
EndPackage[];
