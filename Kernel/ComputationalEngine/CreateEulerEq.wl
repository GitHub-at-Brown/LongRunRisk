(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`"];


(* ::Subsection:: *)
(*Public symbols*)


findEulerEqConstants::usage = "findEulerEqConstants[x[t]] or findEulerEqConstants[x[t,i]] finds \
the constants of the price-dividend ratio of the asset whose return is x[t] or x[t,i]."; 
niceEulerEq::usage = "temp"
niceNomEulerEq::usage = "temp"

findBondRecursion::usage = "findBondRecursion[b[t,m]]] finds the recursion satisfied by \
the bond price coefficients in bondeq[t,m] for a bond with maturity m."; 

eulereq::usage = "eulereq[x[t],s,model] or eulereq[x[t,i],s,model] gives the Euler equation for (real) \
	return x[t] or x[t,i] conditional on time s."
nomeulereq::usage = "nomeulereq[x[t],s,model] or nomeulereq[x[t,i],s,model]  gives the Euler equation for \
	nominal return x[t] or x[t,i] conditional on time s."


Begin["`Private`"];


(* ::Subsection:: *)
(*niceEulerEq*)


Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];


(* Euler equation *)
eulereq[x_[t_,i___],s_,model_] := ev[sdf[t],s,model]+(1/2)var[sdf[t],s,model]+ev[x[t,i],s,model]+(1/2)var[x[t,i],s,model]+cov[sdf[t],x[t,i],s,model] 
nomeulereq[x_[t_,i___],s_,model_] := ev[nomsdf[t],s,model]+(1/2)var[nomsdf[t],s,model]+ev[x[t,i],s,model]+(1/2)var[x[t,i],s,model]+cov[nomsdf[t],x[t,i],s,model] 



orderingToTarget[list_,sourceIds_,targetIds_]:=list[[Ordering@sourceIds]][[Ordering@Ordering@targetIds]]
	
niceEulerEq[x_[t_,i___],model_,nominalFlag_:False]:=With[
	{
		stateVars=DeleteDuplicates[DeleteCases[Cases[Variables[model["stateVars"][t] ],z_[_]:>z],0]],
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]]
	},
	Module[
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
		newC,
		G,
		F
	},
	stateVarsAnyt:=Alternatives@@Map[Function[{y},y[r_]],stateVars];
	ratio=If[{i} === {},wc[t-1]/.mapAll,pd[t-1,i]/.mapAll];
	unknowns=If[
		{i} === {},
		Sort[Cases[Variables[ratio],FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc[j_]]],
		Sort[Cases[Variables[ratio],FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[j_]  ]]
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
		PolynomialReduce[Expand[nomeulereq[x[t,i],t-1,model]],Factor[sortedNewRules],timeVars],
		PolynomialReduce[Expand[eulereq[x[t,i],t-1,model]],Factor[sortedNewRules],timeVars]
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
]

(* wrapper for nominal euler eq *)
niceNomEulerEq[x_[t_,i___],model_]:=niceEulerEq[x[t,i],model,True] (* flag True indicates nominal *)


(* ::Subsection:: *)
(*findEulerEqConstants*)


(* find Euler equation for return on consumption portfolio *)
findEulerEqConstants[x_[t_,i___],model_,nominalFlag_:False]:=With[
	{
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]],
		thetaRule=FernandoDuarte`LongRunRisk`Model`Parameters`theta->(1-FernandoDuarte`LongRunRisk`Model`Parameters`gamma)/(1-1/FernandoDuarte`LongRunRisk`Model`Parameters`psi)
	},
	Module[
	{
		ruleToEqual,
		eulerEqCoeff,
		systemEq,
		ratio,
		unknownCoefficients
	},
	(* first define some formatting rules *)
	ruleToEqual[a_->b_] := (0==b);

	(* find Euler equation *)
	eulerEqCoeff = niceEulerEq[x[t,i],model,nominalFlag];
	
	(* convert to system of equations on coefficients *)
	systemEq=Map[ruleToEqual,eulerEqCoeff[[2]]];
	ratio=If[{i} === {},wc[t-1]/.mapAll,pd[t-1,i]/.mapAll];
	unknownCoefficients=If[
		{i} === {},
		Sort[Cases[Variables[ratio],FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc[j_]]],
		Sort[Cases[Variables[ratio],FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[j_]  ]]
	];

	(* return system of equations and the unknowns of the system  *)
	{systemEq/.thetaRule,unknownCoefficients}
]
]
(* solve system of equations *)
(* if the system is solvable symbolically, you can solve with the following line *)
(* wSol=Solve[systemEqCons,unknownCoefficients] // Simplify; *)



(* ::Subsection:: *)
(*findBondRecursion*)


(* find Euler equation for bonds, which gives a recursion *)
findBondRecursion[t_,n_,model_]:=With[
	{
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]]
	},
	Module[
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
	eulerEqBond = niceEulerEq[bondret[t,n],model];
	eulerEqNomBond = niceNomEulerEq[nombondret[t,n],model]; 

	(* convert to a system of recursive equations *)
	systemEqBond=Map[ruleToEqual,eulerEqBond[[2]]];
	unknownsCondBond=Sort[Cases[bond[t,n]/.mapAll,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[m_],Infinity]];
	initialCondBond=Thread[(unknownsCondBond/.(n->0))==0];
	(*systemEqBond=Flatten[Solve[systemEqBond,unknownsCondBond]]/.Rule->Equal;*)(* solves for the highest n coefficient, can comment out and recursion will be a set of implicit equations *)
	
	systemEqNomBond=Map[ruleToEqual,eulerEqNomBond[[2]]]/.
		If[
			(*if inflation not defined, set it equal to zero*)
			FreeQ[Join[model["endogenousVars"],model["exogenousVars"]],"pieq"],
			_Symbol?(MatchQ[SymbolName@#,"pi"]&)[__]->0,
			{}
		];
	unknownsCondNomBond = Sort[Cases[nombond[t,n]/.mapAll,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[m_],Infinity]];
	initialCondNomBond =Thread[(unknownsCondNomBond/.(n->0))==0];
	(*(*systemEqNomBond=Flatten[Solve[systemEqNomBond,unknownsCondNomBond]]/.Rule->Equal;*) *)	

	(* return all elements of the recursion *)
	{	
		{"Real Bonds",systemEqBond,initialCondBond,unknownsCondBond,n},
		{"Nominal Bonds",systemEqNomBond,initialCondNomBond,unknownsCondNomBond,n}
	}
]
]
(* solve recursion *)
(* if the recursion is solvable symbolically, you can solve with the following line *)
(* solBond=RSolve[Flatten[{systemEqBond,initialCondBond}],unknownsCondBond,n]; *)


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
