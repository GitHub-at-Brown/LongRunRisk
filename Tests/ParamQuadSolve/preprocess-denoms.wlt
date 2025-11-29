Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`"];

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x == a/(1 - 1/psi), y == b/(1 + Exp[A[0]])};
vars$ = {x, y};
r$ = pqs[eq$, vars$, "DomainOption" -> Reals, "ValidationOption" -> False];
conds$ = r$["Conditions"];
condExpr$ = And @@ conds$;
hasPsiDen$ = Simplify[condExpr$ /. psi -> 1] === False;
hasExpDen$ = Simplify[condExpr$ /. Exp[A[0]] -> -1] === False;

coeffKeysOK$ = AssociationQ[r$["CoeffMap"]] && Length[r$["CoeffMap"]] >= 1;
noDummyInSol$ = FreeQ[r$["Solution"], _Symbol?(StringMatchQ[SymbolName[#], "c$*"] & )];

VerificationTest[hasPsiDen$, True, TestID -> "psi-denom-cond@@Tests/ParamQuadSolve/preprocess-denoms.wlt:19,1-19,119"]
VerificationTest[hasExpDen$, True, TestID -> "exp-denom-cond@@Tests/ParamQuadSolve/preprocess-denoms.wlt:20,1-20,119"]
VerificationTest[coeffKeysOK$, True, TestID -> "coeffmap-present@@Tests/ParamQuadSolve/preprocess-denoms.wlt:21,1-21,123"]
VerificationTest[noDummyInSol$, True, TestID -> "no-dummy-in-solution@@Tests/ParamQuadSolve/preprocess-denoms.wlt:22,1-22,128"]

End[];
