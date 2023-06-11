(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`"];


(* ::Subsection:: *)
(*Public symbols*)


eulereq::usage = "eulereq[x[t], s, model] or eulereq[x[t,i], s, model] give the Euler equation for an asset with real return x[t] or x[t, i] conditional on time s for model."
nomeulereq::usage = "nomeulereq[x[t], s, model] or nomeulereq[x[t,i], s, model] give the Euler equation for an asset with nominal return x[t] or x[t, i] conditional on time s for model."
findEulerEqConstants::usage = "findEulerEqConstants[x[t], model] or findEulerEqConstants[x[t,i], model] gives a system of equations whose unknowns are the coefficients in front of the state variables for the wealth-consumption or price-dividend ratios, where x[t] is the real return on the wealth portfolio (for the wealth-consumption ratio) and x[t,i] is the real return on stock i for the price-dividend ratio."<>"\n"<>
							  "findEulerEqConstants[x[t], model, True] or findEulerEqConstants[x[t,i], model, True] assume x[t] or x[t,i] are nominal returns.";
findBondRecursion::usage = "findBondRecursion[t, n, model] finds the recursions satisfied by the coefficients in front of the state variables for a bond price with maturity n at time t for model."; 


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];


(* ::Subsection:: *)
(*eulereq, nomeulereq*)


eulereq[x_[t_,i___], s_, model_] := ev[sdf[t], s, model] +
										(1/2)var[sdf[t], s, model] +
										ev[x[t,i], s, model] +
										(1/2)var[x[t,i], s, model] +
										cov[sdf[t], x[t,i], s, model]
nomeulereq[x_[t_,i___], s_, model_] := ev[nomsdf[t], s, model] +
										(1/2)var[nomsdf[t], s, model] +
										ev[x[t,i], s, model] +
										(1/2)var[x[t,i], s, model] +
										cov[nomsdf[t], x[t,i], s, model] 


(* ::Subsection:: *)
(*niceEulerEq*)


niceEulerEq[x_[t_,i___],model_,nominalFlag_:False]:=With[
	{
		stateVars=DeleteDuplicates[DeleteCases[Cases[Variables[model["stateVars"][t] ],z_[_]:>z],0]],
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]]
	},
	Module[
		{
			stateVarsAnyt,
			ratio,
			unknowns,
			timeVars,
			(*timeVarsPolyu,*)
			newRules,
			newRulesNoConst,
			sortF,
			sortedNewRules,
			newCoeff,
			newReminder,
			coeffC,
			(*crRules,*)
			newPoly,
			newC,
			G,
			F
		},
		stateVarsAnyt := Alternatives@@Map[Function[{y}, y[r_]], stateVars];
		ratio=If[{i} === {}, wc[t-1]/.mapAll, pd[t-1,i]/.mapAll];
		unknowns=If[
			{i} === {},
			Sort[Cases[Variables[ratio], FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc[j_] ]],
			Sort[Cases[Variables[ratio], FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[j_] ]]
		];
		timeVars=DeleteDuplicates[Cases[ratio, stateVarsAnyt, Infinity]];
		(*timeVarsPolyu=DeleteCases[Flatten[CoefficientList[ratio, unknowns]], 0|1]; *)
		newRules=CoefficientRules[ratio, unknowns];
		newRulesNoConst = newRules[[2;;,2]];
		sortF[lst_]:=SortBy[lst, {-Total@#, -Max@#}&[Exponent[#, Variables[timeVars] ]]& ];(*orders newRules for PolynomialReduce*)
		sortedNewRules=sortF[newRulesNoConst];
		(* use real or nominal euler equation depending on nominalFlag *)
		{newCoeff,newReminder}=If[
			nominalFlag,
			PolynomialReduce[Expand[nomeulereq[x[t,i], t-1, model]], Factor[sortedNewRules], timeVars],
			PolynomialReduce[Expand[eulereq[x[t,i], t-1, model]], Factor[sortedNewRules], timeVars]
		];
		(* undo ordering *)
		newCoeff=orderingToTarget[newCoeff, sortedNewRules, newRulesNoConst];
		coeffC=If[
			{i} === {},
			Table[ G[j], {j, 0, Length[newCoeff]} ],
			Table[ F[i, j], {j, 0, Length[newCoeff]} ]
		];
		newPoly=coeffC . Flatten[{1, newRulesNoConst}];
		newPoly=Replace[
			SortBy[
				List@@newPoly,
				Cases[#,(G|F)[j_, p___]:>{j, p}]&
			],
			List[y__]:>HoldForm[Plus[y]]
		];
		newC=Flatten[{
			coeffC[[1]]->Collect[newReminder, unknowns, Simplify],
			MapThread[ #1->#2&, {coeffC[[2;;-1]], Collect[newCoeff, unknowns, Simplify]} ]
		}];
		{newPoly, newC}
	]
]
(* wrapper for nominal euler eq *)
niceNomEulerEq[ x_[t_, i___], model_ ]:=niceEulerEq[ x[t, i], model, True] (* flag True indicates nominal *)


(* ::Subsubsection:: *)
(*orderingToTarget*)


orderingToTarget[list_,sourceIds_,targetIds_]:=list[[Ordering@sourceIds]][[Ordering@Ordering@targetIds]]


(* ::Subsection:: *)
(*findEulerEqConstants*)


findEulerEqConstants[x_[t_,i___],model_,nominalFlag_:False]:=With[
	{
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]],
		thetaRule=FernandoDuarte`LongRunRisk`Model`Parameters`theta->
			(1-FernandoDuarte`LongRunRisk`Model`Parameters`gamma)/(1-1/FernandoDuarte`LongRunRisk`Model`Parameters`psi)
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
		eulerEqCoeff = niceEulerEq[x[t,i], model, nominalFlag];
		
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


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
