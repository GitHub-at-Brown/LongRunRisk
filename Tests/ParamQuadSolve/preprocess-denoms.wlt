Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`"];

Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d], d = DirectoryName[d]];
  pacletRoot = d;
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "ComputationalEngine", "ParamQuadSolve.wl"}]];
  On[General::shdw];
];

pqs = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`Private`paramQuadSolve"];

eq$ = {x == a/(1 - 1/psi), y == b/(1 + Exp[A[0]])};
vars$ = {x, y};
r$ = pqs[eq$, vars$, Domain -> Reals, Validation -> False];
conds$ = r$["Conditions"];
condExpr$ = And @@ conds$;
hasPsiDen$ = Simplify[condExpr$ /. psi -> 1] === False;
hasExpDen$ = Simplify[condExpr$ /. Exp[A[0]] -> -1] === False;

coeffKeysOK$ = AssociationQ[r$["CoeffMap"]] && Length[r$["CoeffMap"]] >= 1;
noDummyInSol$ = FreeQ[r$["Solution"], _Symbol?(StringMatchQ[SymbolName[#], "c$*"] & )];

VerificationTest[hasPsiDen$, True, TestID -> "psi-denom-cond@@Tests/ParamQuadSolve/preprocess-denoms.wlt:29,1-29,119"]
VerificationTest[hasExpDen$, True, TestID -> "exp-denom-cond@@Tests/ParamQuadSolve/preprocess-denoms.wlt:30,1-30,119"]
VerificationTest[coeffKeysOK$, True, TestID -> "coeffmap-present@@Tests/ParamQuadSolve/preprocess-denoms.wlt:31,1-31,123"]
VerificationTest[noDummyInSol$, True, TestID -> "no-dummy-in-solution@@Tests/ParamQuadSolve/preprocess-denoms.wlt:32,1-32,128"]

End[];
