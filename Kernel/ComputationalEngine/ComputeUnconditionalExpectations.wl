(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];


(* ::Subsection:: *)
(*Public symbols*)


uncondE::usage = "uncondE[expr,model] gives the unconditional expectation of expr for model ."; 
uncondVar::usage = "uncondVar[expr,model] gives the unconditional variance of expr for model ."; 
uncondCov::usage = "uncondCov[expr1,expr2,model] gives the unconditional covariance of expr1 and expr2 for model ."; 
uncondCorr::usage = "uncondCorr[expr1,expr2,model] gives the unconditional correlation of expr1 and expr2 for model ."; 


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"->"cond`"]


(* ::Subsection:: *)
(*uncondE*)


uncondE::nmom="Moment(s) `1` not computed. Try increasing maxMoment or maxCrossMoment in llr.wl";


uncondE[x_,model_]:= With[
	{
		uncondMomOfStateVars = model["uncondMomOfStateVars"]
	},
	uncondEStep[x,model] //. uncondMomOfStateVars
]


(* ::Subsubsection:: *)
(*uncondEStep*)


uncondEStep[expr_,model_]:=With[
	{
		stateVarst = model["stateVars"],
		assignParam = model["assignParam"],
		assignParamStocks = model["assignParamStocks"],
		rulesEfun = t |-> FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t]		
	},
	With[
		{
			stateVars=DeleteDuplicates[DeleteCases[Cases[Variables[stateVarst[t]],x_[_]:>x],0]]
		},
		With[
			{
				stateVarsNoEps = Complement[stateVars,Cases[stateVars,x_Symbol?(MatchQ[SymbolName[#],"eps"]&)[y___]:>x[y],Infinity,Heads->True]]
			},
			rulesE[t_]:=rulesEfun[t]//.assignParam//.assignParamStocks;
			FixedPoint[evNoEpsStateVarsProduct[#,model,stateVarsNoEps]&,(expr/.cond`Private`modelContextRules)//.Normal@model["endogenousEq"]/.model["toStateVars"]]/.rulesE[_]	
		]
	]
]


(* ::Subsubsection:: *)
(*evNoEpsStateVarsProduct*)


evNoEpsStateVarsProduct[expr_,model_,variablesToLag_]:= Module[
	{
		exprLagStateVarsProduct,
		exprEvNoEps
	},
	exprLagStateVarsProduct=ExpandAll[expr/.cond`Private`modelContextRules]//.lagStateVarsProduct[model,variablesToLag];
	exprEvNoEps=ExpandAll[exprLagStateVarsProduct]//.evNoEps[model,variablesToLag];
	ExpandAll[exprEvNoEps]
]


(* ::Subsubsection:: *)
(*evNoEps*)


evNoEps[model_, variablesToLag_] :=Module[
	{e, i, r, M, q, x, t, j, p, rest}
	,
	rest_. * (
		(e_Symbol?(MatchQ[SymbolName[#], "eps"]&)[i__][r__, M___]^(q_.)) * 
		(x_Symbol?(MemberQ[Alternatives@@(SymbolName/@variablesToLag), SymbolName[#]]&)[t__, j___]^(p_.))
	) :> cond`Private`lagStateVarst[
			rest * e[i][r, M]^q * x[t, j]^p,
			If[FullSimplify[r<=t, r>=0 && t>=0], r-1, t],
			model
		]
]


(* ::Subsubsection:: *)
(*lagStateVarsProduct*)


lagStateVarsProduct[model_, variablesToLag_] :=Module[
	{x1, x2, t1, t2, i1, i2, q1, q2, rest}
	,
	(rest_.) * (
		(x1_Symbol?(MemberQ[Alternatives@@(SymbolName/@variablesToLag), SymbolName[#]]&)[t1_, i1___]^q1_.) *
		(x2_Symbol?(MemberQ[Alternatives@@(SymbolName/@variablesToLag), SymbolName[#]]&)[t2_, i2___]^q2_.)
	) :> cond`Private`lagStateVarst[
			rest * x1[t1, i1]^q1 * x2[t2, i2]^q2,
			FullSimplify[Min[t1, t2], t1>=0 && t2>=0],
			model
		]
]


(* ::Subsection::Closed:: *)
(*uncondVar*)


uncondVar[x_,model_]:=uncondE[(x-uncondE[x,model])^2,model]


(* ::Subsection:: *)
(*uncondCov*)


uncondCov[x_,y_,model_]:=uncondE[(x-uncondE[x,model])(y-uncondE[y,model]),model]


(* ::Subsection::Closed:: *)
(*uncondCorr*)


uncondCorr[x_,y_,model_]:=uncondCov[x,y,model]/(Sqrt[uncondVar[x,model]]Sqrt[uncondVar[y,model]])


(* ::Subsection:: *)
(*Unconditional moments of state variables*)


createSystem::nomom = "Unconditional moments cannot be computed for state variables. "<>
	"The term `1` in the equation for the moment `2` contains `3`, which is a product of state "<>
	"variables at different time periods and is not currently handled. "<>
	"Consider adding an equation for `3` as an additional moment in the system of equations"<>
	"that computes uncoditional moments of state variables in ComputeUnconditionalExpectations.wl";


(*unconditional moments of state variables are found  by solving a system of equations*)
createSystem[n_, model_]:=Block[{t},With[
	{
		stateVars=DeleteDuplicates[DeleteCases[Cases[Variables[model["stateVars"][t] ],x_[_]:>x],0]],
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]]
	},
	With[
		{
			stateVarsNoEps = Complement[stateVars,Cases[stateVars,x_Symbol?(MatchQ[SymbolName[#],"eps"]&)[y___]:>x[y],Infinity,Heads->True]]
		},	
		Module[
		{				
			stateVarsTuples,
			stateVarsSets,
			addt,
			stateVarsProducts,
			stateVarsMapAll,
			stateVarsEqs,
			times0,
			times
		},
			(*create products of powers of state variables up to order n*)
			stateVarsTuples=Flatten[Table[Tuples[stateVarsNoEps,i],{i,n}],1];
			stateVarsSets=DeleteDuplicatesBy[Sort]@stateVarsTuples;
			addt[x_] := x[t];
			stateVarsProducts=Replace[Map[addt,stateVarsSets,{2}],List->Times,{2},Heads->True];
			(*evaluate products of powers using equations for exogenous processes*)
			stateVarsMapAll=stateVarsProducts/.mapAll;
			stateVarsEqs = uncondEStep[stateVarsMapAll,model];
			(*find time indices of state variables for each summand of each equation*)
			times0=Cases[#,k_Symbol?(MemberQ[Alternatives@@(SymbolName/@stateVarsNoEps),SymbolName[#]]&)[g_]:>g,Infinity]&/@(Flatten@(List@@@stateVarsEqs));
			times=times0/.{}->Sequence[];
			If[And@@(SameQ@@@times),
				(*if all state variables have the same time index within each summand*)
				Module[
					{
						powers,
						powersString,
						stateVarsNoEpsString,
						unknowns,
						nameRulesUnsorted,
						sortOrder,
						sortFun,
						nameRules,
						system
					},
					(*create names for each moment, which are the unknowns we solve for*)
					powers =CoefficientRules[stateVarsProducts,addt/@stateVarsNoEps][[;;,1,1]];
					powersString=IntegerString@powers;
					stateVarsNoEpsString=ToString/@stateVarsNoEps;
					(*unknowns = Symbol /@ Map[StringJoin, Map[If[IntegerQ[#],IntegerString[#],SymbolName[#]]&, (Tally /@ stateVarsSets), {3}], {1}];*)
					unknowns = Symbol["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`"<>#]& /@ Map[StringJoin, Map[If[IntegerQ[#],IntegerString[#],SymbolName[#]]&, (Tally /@ stateVarsSets), {3}], {1}];
					nameRulesUnsorted=Thread[(stateVarsProducts/. x_Symbol?(MatchQ[SymbolName[#],"t"]&) ->_ )->unknowns];
					(*sort nameRulesUnsorted to apply products of a larger number of variables first*)
					sortOrder=Count[#,0]&/@powers;
					sortFun[namerule_]:=First@Extract[sortOrder,Position[nameRulesUnsorted,namerule]];
					nameRules=Sort[nameRulesUnsorted,(sortFun[#1]<sortFun[#2])&];
					(*create system of equations*)
					system=Thread[stateVarsProducts==stateVarsEqs]/.nameRules;
					{nameRules,system,unknowns}
				]
				, (*if And@@(SameQ@@@times) is False*)		
				(*find the problematic term, issue message, return $Failed*)
				Module[
					{
						pos,
						term,
						prod,
						posEqs,
						eq
					},
					pos=Position[SameQ@@@times0,False,1,1];
					term=Extract[Flatten@(List@@@stateVarsEqs),pos];
					prod=Times@@Cases[term,k_Symbol?(MemberQ[Alternatives@@(SymbolName/@stateVarsNoEps),SymbolName[#]]&)[g_]:>Symbol[SymbolName[k]][g],Infinity];
					posEqs=Position[stateVarsEqs,term[[1]]];
					eq=Inactive[uncondE][stateVarsProducts[[posEqs[[1,1]]]]];
					Message[createSystem::nomom,term,eq,prod];
					{$Failed,$Failed,$Failed}
				]
			]
		]
	]
]
]


solveSystem[n_Integer, model_Association, Optional[maxSolveTime_?NumberQ, 60], sys_List:{}]:=With[
	{
		(*create sys if not passed by user*)
		sysLocal=If[sys==={}, createSystem[n, model], sys]
	},
	Join[
		First@sysLocal,
		TimeConstrained[
			Flatten@(Solve@@(Rest@sysLocal)),
			maxSolveTime,
			sol[n, model, Rest@sysLocal]
		]
	]
]


(*base case for recursion*)
sol[2, model_, sys_:{}] := With[
	{
		sysLocal=If[sys==={}, Rest@createSystem[2, model], sys]
	},
	Flatten@(Solve@@sysLocal)
]

(*solve for n given solution to n-1*)
sol[n_Integer?((#>2) &), model_, sys_]:=With[
	{
		(*create systems with moments of state variables up to order n-1*)
		sys1 = Rest@createSystem[n-1, model]
	},
	(*combine with solution to sys1*)
	With[
		{
			(*create system for n-1*)
			sol1=sol[n-1, model, sys1],
			(*solve system of equations in sys that are not in sys1*)
			sysNot1=Flatten@Solve[Complement[First@sys, First@sys1],Complement[Last@sys, Last@sys1]]
			
		},
		(*Join[sol1, sysNot1/.sol1]*)
		Join[sol1, sysNot1]
	]
]


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
