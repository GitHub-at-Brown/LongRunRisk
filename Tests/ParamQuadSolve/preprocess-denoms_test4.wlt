BeginTestSection["preprocess-denoms"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

eq$ = {x == a/(1 - 1/psi), y == b/(1 + Exp[A[0]])};
vars$ = {x, y};
r$ = pqs[eq$, vars$, "DomainOption" -> Reals, "ValidationOption" -> False];
conds$ = r$["Conditions"];
condExpr$ = And @@ conds$;
hasPsiDen$ = Simplify[condExpr$ /. psi -> 1] === False;
hasExpDen$ = Simplify[condExpr$ /. Exp[A[0]] -> -1] === False;

coeffKeysOK$ = AssociationQ[r$["Maps"]["CoeffMap"]] && Length[r$["Maps"]["CoeffMap"]] >= 1;
noDummyInSol$ = FreeQ[r$["Solution"], _Symbol?(StringMatchQ[SymbolName[#], "c$*"] & )];

VerificationTest[noDummyInSol$, True, TestID -> "no-dummy-in-solution@@Tests/ParamQuadSolve/preprocess-denoms_test4.wlt:19,1-19,128"]

EndTestSection[]
