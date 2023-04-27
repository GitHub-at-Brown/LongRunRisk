(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeMoments`"];


(* ::Subsection:: *)
(*Public symbols*)


ev::usage = "ev[x,s] gives the expected value of x conditional on time s."; 
var::usage = "var[x,s] gives the variance of x conditional on time s."; 
cov::usage = "cov[x,y,s] gives the covariance of x and y conditional on time s."; 
uncondE::usage = "uncondE[x] gives the unconditional mean of x."; 
uncondVar::usage = "uncondVar[x] gives the unconditional variance of x."; 
uncondCov::usage = "uncondCov[x,y] gives the unconditional covariance of x and y."; 


Begin["`Private`"];


(* ::Subsection:: *)
(*Package Dependencies*)


Get["PacletizedResourceFunctions`"]


(* ::Subsection:: *)
(*Independent of Model*)


stript[x_[t+i_Integer:0]] := x
addt[x_] := x[Symbol["t"]]
stopLag[s_,t_]:=Refine[Simplify[s>t],Element[Flatten[{Variables[s],Variables[t]}],Reals]]
minTfun[x_]:= Module[{y,s,i},FullSimplify[Min[Cases[Variables[x] ,y_[t+s_:0,i___]:>t+s]],t>0]]


(* ::Subsection:: *)
(*Needs Model*)


Attributes[runInModel]={HoldFirst};
runInModel[expr_,model_]:=With[
	{
		modelAssumptions = model["modelAssumptions"],
		numStocks = model["numStocks"],
		modelStateVars = model["stateVars"],
		stateVars=DeleteDuplicates[DeleteCases[Cases[Variables[model["stateVars"] ],x_[_]:>x],0]],
		eqNames = Join[model["exogenousVars"],model["endogenousVars"]],
		varNames = StringDrop[#,-2]&/@Join[model["exogenousVars"],model["endogenousVars"]],
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]],
		assignParam=model["assignParam"],
		assignParamStocks=model["assignParamStocks"]
	},

	With[
		{
			stateVarsNoEps = Cases[stateVars,Except[Symbol["eps"][_]]],
			mapToStateVars = Cases[mapAll,Except[Alternatives@@(stateVars)->_]]
		},
		stateVarEq=(addt/@stateVarsNoEps)/.mapAll;
		mapAllt[t_]:= Module[{p,s,q},Replace[mapAll,p_Rule:>(p[[1]][s_,q___]/;stopLag[s,t]:>p[[2]][s,q]),2]];
		(* lag operators *)
		lagone[x_[t__,i___]]:=x[t,i]/.mapAll;
		lag[x_,t_,n_,i___]:=Nest[lagone,x[t,i],n] // Expand ;
		lagt[x_,t_]:= x//.mapAllt[t] ;
		lagStateVarst[x_,t_] := (lagt[x,t]) //. mapToStateVars;
		Evaluate[expr]
	]
]


(* ::Subsection:: *)
(*Conditional Moments*)


(* conditional moments *)
rulesE[t_]=SetSymbolsContext[FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t]]//.model["assignParam"]//.model["assignParamStocks"];
ev[x_,s_]:= ExpandAll[lagStateVarst[x,s]]//.rulesE[t_/;Refine[t>s,Element[Flatten[{Variables[s],Variables[t]}],Reals]]]
var[x_,s_]:=ev[(x-ev[x,s])^2,s]
cov[x_,y_,s_]:=ev[(x-ev[x,s])(y-ev[y,s]),s]



(* ::Subsection:: *)
(*Unconditional moments of state variables*)


evNoEps:= Module[
	{i,r,M,q,x,t,p},
	eps[i_][r_,M___]^q_. x_[t_]^p_.:> eps[i][r,M]^q If[FullSimplify[r<=t],lagStateVarst[x[t]^p,r-1],x[t]^p]/;MemberQ[stateVarsNoEps,x]
]
(*evNoEps:= Subscript[\[CurlyEpsilon],i_][r_,M___]^q_. x_[t_]^p_.:> Subscript[\[CurlyEpsilon],i][r,M]^q If[FullSimplify[r<=t],lagStateVarst[x[t]^p,r-1],x[t]^p]/;MemberQ[stateVarsNoEps,x];*)


uncondEStep[x_]:=Module[
	{
		xStateVars,
		xUncondStateVars,
		minTstep,
		xEshocks,
		y,
		s,
		i
	},
	minTstep=Min[Cases[Variables[x/.mapToStateVars] ,y_[s_,i___]/;MemberQ[ToExpression[varNames],y]:>s]];
	xStateVars = Expand[lagStateVarst[x,minTstep]]/.evNoEps;
	xEshocks = Expand[xStateVars]/.rulesE[_]
]

uncondEStep[x_,rules_]:= uncondEStep[x]/.rules


createSystem::nomom = "Unconditional moments cannot be computed for state variables. "<>
"The term `1` in the equation for the moment `2` contains `3`, which is a product of state "<>
"variables at different time periods and is not currently handled. "<>
"Consider adding an equation for `3` as an additional moment in the system of equations"<>
"that computes uncoditional moments of state variables in ComputationalEngine.wl";
	

createSystem[n_]:=Module[
{
	stateVarsNoEpst=addt/@stateVarsNoEps,
	stateVarsTuples,
	stateVarsProducts,
	stateVarsEqs0,
	stateVarsEqs,
	times0,
	times,
	stateVarsNewTimes,
	pos,
	term,
	prod,
	posEqs,
	eq,
	powers,
	powersString,
	stateVarsNoEpsString,
	stateVarsPowers,
	unknowns,
	nameRules,
	system
},
	(*create products of powers of state variables up to order n*)
	stateVarsTuples=Flatten[Table[Tuples[stateVarsNoEpst,i],{i,n}],1];
	stateVarsProducts=DeleteDuplicates@Replace[stateVarsTuples,List->Times,{2},Heads->True];
	(*evaluate products of powers using equations for exogenous processes*)
	stateVarsMapAll=stateVarsProducts/.mapAll;
	(*lag state variables until shocks are in the future (using evNoEps), then
	compute expectation of the products of powers of state variables, 
	conditional on the earliest time index found*)
	stateVarsEqs0=ev[ExpandAll[#]/.evNoEps,minTfun[stateVarsMapAll]]&/@stateVarsMapAll;
	stateVarsEqs=uncondEStep[#]&/@stateVarsEqs0;
	(*find time indices of state variables for each summand of each equation*)
	times0=Cases[#,(k:Alternatives@@stateVars)[g_]:>g,Infinity]&/@(Flatten@(List@@@stateVarsEqs));
	times=times0/.{}->Sequence[];
	
	If[
		(*if all state variables have the same time index within each summand*)
		And@@(SameQ@@@times)
		,
		(*compute unconditional moments*)
		stateVarsNewTimes=(# @@@ (DeleteDuplicates/@times) )&/@stateVarsNoEps;
		(*create names for each moment, which are the unknowns we solve for*)
		powers =CoefficientRules[stateVarsProducts,stateVarsNoEpst][[;;,1,1]];
		powersString=IntegerString@powers;
		stateVarsNoEpsString=ToString/@stateVarsNoEps;
		stateVarsPowers=Riffle[ToString/@stateVarsNoEpsString,#]&/@powersString;
		unknowns=ToExpression/@Apply[StringJoin,stateVarsPowers,{1}];
		nameRules=Thread[(stateVarsProducts/.t->t_)->unknowns];
		(*create system of equations to solve for moments*)
		system=Thread[stateVarsProducts==stateVarsEqs]/.nameRules;
		(*return system, unknowns, and naming rules*)
		{system,unknowns,nameRules}
		,		
		(*find the problematic term, issue message, return unsolved stateVarsEqs*)
		pos=Position[SameQ@@@times0,False,1,1];
		term=Extract[Flatten@(List@@@stateVarsEqs),pos];
		prod=Times@@Cases[term,(k:Alternatives@@stateVars)[g_]:>k[g],Infinity];
		posEqs=Position[stateVarsEqs,term[[1]]];
		eq=Inactive[uncondE][stateVarsProducts[[posEqs[[1,1]]]]];
		Message[createSystem::nomom,term,eq,prod];
		{stateVarsEqs,stateVarsProducts,$Failed}
	]
]


(*maxMoment=2;
{system,unknowns,nameRules}=createSystem[maxMoment];
uncondMomStateVars=Flatten@Solve[system,unknowns];*)


(* unconditional moments of any expression *)
uncondE::nmom="Moment(s) `1` not computed. Try increasing maxMoment or maxCrossMoment in llr.wl";
uncondE[x_]:= Module[{mom},
	mom=Simplify[FixedPoint[uncondEStep[#,nameRules]&,x] //. uncondMomStateVars,TimeConstraint->{5,60}]
]

(* unconditional variances and covariances *)
uncondVar[x_]:=uncondE[(x-uncondE[x])^2]
uncondCov[x_,y_]:=uncondE[(x-uncondE[x])(y-uncondE[y])]
uncondCorr[x_,y_]:=uncondCov[x,y]/(Sqrt[uncondVar[x]]Sqrt[uncondVar[y]])


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
