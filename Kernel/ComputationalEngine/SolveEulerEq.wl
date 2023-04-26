(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];


(* ::Subsection:: *)
(*Public symbols*)


Begin["`Private`"];


(* ::Subsection:: *)
(*niceEulerEq*)


(* formatting functions *)
stateVarsAnyt:=Alternatives@@Map[Function[{x},x[t_]],stateVars]
orderingToTarget[list_,sourceIds_,targetIds_]:=list[[Ordering@sourceIds]][[Ordering@Ordering@targetIds]]

niceEulerEq[x_[t_,i___],nominalFlag_:False]:=Module[
	{
		ratio,
		unknowns,
		timeVars,
		timeVarsPolyu,
		newRules,
		newRulesNoConst,
		sortF,
		sortedNewRules,
		newCoeff,
		newReminder,
		coeffC,
		crRules,
		newPoly,
		newC
	},	
	ratio=If[{i} === {},wc[t-1]/.mapAll,pd[t-1,i]/.mapAll];
	unknowns=If[
		{i} === {},
		Sort[Cases[Variables[ratio],A[j_]]],
		Sort[Cases[Variables[ratio],B[i][j_]  ]]
	];
	timeVars=DeleteDuplicates[Cases[ratio,stateVarsAnyt,Infinity]];
	timeVarsPolyu=DeleteCases[Flatten[CoefficientList[ratio,unknowns]],0|1]; 
	newRules=CoefficientRules[ratio,unknowns];
	newRulesNoConst = newRules[[2;;,2]];
	sortF[lst_]:=SortBy[lst,{-Total@#,-Max@#}&[Exponent[#,Variables[timeVars] ]]&];(*orders newRules for PolynomialReduce*)
	sortedNewRules=sortF[newRulesNoConst];
	(* use real or nominal euler equation depending on nominalFlag *)
	{newCoeff,newReminder}=If[
		nominalFlag,
		PolynomialReduce[Expand[nomeuler[x[t,i],t-1]/.mapAll],Factor[sortedNewRules],timeVars],
		PolynomialReduce[Expand[euler[x[t,i],t-1]/.mapAll],Factor[sortedNewRules],timeVars]
	];
	(* undo ordering *)
	newCoeff=orderingToTarget[newCoeff,sortedNewRules,newRulesNoConst];
	coeffC=If[
		{i} === {},
		Table[G[j],{j,0,Length[newCoeff]}],
		Table[F[i,j],{j,0,Length[newCoeff]}]
	];
	newPoly=coeffC . Flatten[{1,newRulesNoConst}];
	newPoly=Replace[
		SortBy[
			List@@newPoly,
			Cases[#,(G|F)[j_,p___]:>{j,p}]&
		],
		List[y__]:>HoldForm[Plus[y]]
	];
	newC=Flatten[{
		coeffC[[1]]->Collect[newReminder,unknowns,Simplify],
		MapThread[#1->#2&,{coeffC[[2;;-1]],Collect[newCoeff,unknowns,Simplify]}]
	}];
	{newPoly,newC}
]

(* wrapper for nominal euler eq *)
niceNomEulerEq[x_[t_,i___]]:=niceEulerEq[x[t,i],True] (* flag True indicates nominal *)


(* ::Subsection:: *)
(*findEulerEqConstants*)


(* find Euler equation for return on consumption portfolio *)
findEulerEqConstants[x_[t_,i___],nominalFlag_:False]:=Module[{ruleToEqual,eulerEqCoeff,systemEq,ratio,unknownCoefficients},
	(* first define some formatting rules *)
	ruleToEqual[a_->b_]:=0==b/theta;

	(* find Euler equation *)
	eulerEqCoeff = niceEulerEq[x[t,i],nominalFlag];
	
	(* convert to system of equations on coefficients *)
	systemEq=Map[ruleToEqual,eulerEqCoeff[[2]]];
	ratio=If[{i} === {},wc[t-1]/.mapAll,pd[t-1,i]/.mapAll];
	unknownCoefficients=If[
		{i} === {},
		Sort[Cases[Variables[ratio],A[j_]]],
		Sort[Cases[Variables[ratio],B[i][j_]  ]]
	];

	(* return system of equations and the unknowns of the system  *)
	{systemEq,unknownCoefficients}
]

(* solve system of equations *)
(* if the system is solvable symbolically, you can solve with the following line *)
(* wSol=Solve[systemEqCons,unknownCoefficients] // Simplify; *)



(* ::Subsection:: *)
(*findBondRecursion*)


(* find Euler equation for bonds, which gives a recursion *)
findBondRecursion[t_,n_]:=Module[
	{
		ruleToEqual,
		eulerEqBond,
		eulerEqNomBond,
		systemEqBond,
		unknownsCondBond,
		initialCondBond,
		systemEqNomBond,
		unknownsCondNomBond,
		initialCondNomBond
	},
	(* first define formatting rules *)
	ruleToEqual[x_->y_]:=0==y;

	(* get Euler equation for the bonds *)
	eulerEqBond = niceEulerEq[bondret[t+1,n-1]/.mapAll];
	eulerEqNomBond = niceNomEulerEq[nombondret[t+1,n-1]/.mapAll]; 

	(* convert to a system of recursive equations *)
	systemEqBond=Map[ruleToEqual,eulerEqBond[[2]]];
	unknownsCondBond=Sort[Cases[bondeq[t,n]/.mapAll,Subscript[R,_][n],Infinity]];
	initialCondBond=Thread[(unknownsCondBond/.n->0)==0];
	systemEqBond=Flatten[Solve[systemEqBond,unknownsCondBond]]/.Rule->Equal;(* solves for the highest n coefficient, can comment out and recursion will be a set of implicit equations *)
	
	systemEqNomBond=Map[ruleToEqual,eulerEqNomBond[[2]]];
	unknownsCondNomBond = Sort[Cases[nombond[t,n]/.mapAll,Subscript[P,_][n],Infinity]];
	initialCondNomBond =Thread[(unknownsCondNomBond/.n->0)==0];
	systemEqNomBond=Flatten[Solve[systemEqNomBond,unknownsCondNomBond]]/.Rule->Equal; 	

	(* return all elements of the recursion *)
	{
		{"Real Bonds",systemEqBond,initialCondBond,unknownsCondBond,n},
		{"Nominal Bonds",systemEqNomBond,initialCondNomBond,unknownsCondNomBond,n}
	}
]

(* solve recursion *)
(* if the recursion is solvable symbolically, you can solve with the following line *)
(* solBond=RSolve[Flatten[{systemEqBond,initialCondBond}],unknownsCondBond,n]; *)


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
