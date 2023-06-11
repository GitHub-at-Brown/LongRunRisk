(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];


(* ::Subsection:: *)
(*Public symbols*)


uncondE::usage = "uncondE[x,model] gives the unconditional mean of x for model."; 
uncondVar::usage = "uncondVar[x,model] gives the unconditional variance of x for model."; 
uncondCov::usage = "uncondCov[x,y,model] gives the unconditional covariance of x and y for model."; 
uncondCorr::usage = "uncondCorr[x,y,model] gives the unconditional correlation of x and y for model."; 


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"->"cond`"]


(* ::Subsection::Closed:: *)
(*uncondE*)


uncondE::nmom="Moment(s) `1` not computed. Try increasing maxMoment or maxCrossMoment in llr.wl";


uncondE[x_,model_]:= With[
	{
		uncondMomOfStateVars = model["uncondMomOfStateVars"]
	},
	uncondEStep[x,model] //. uncondMomOfStateVars
]


(* ::Subsubsection::Closed:: *)
(*uncondEStep*)


uncondEStep[expr_,model_]:=With[
	{
		stateVarst = model["stateVars"],
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]],
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
			With[
				{
					mapToStateVars = Cases[mapAll,Rule[a_,b_]/;FreeQ[a,Alternatives@@(SymbolName/@stateVarsNoEps)]]
				},
				rulesE[t_]:=rulesEfun[t]//.assignParam//.assignParamStocks;				
				FixedPoint[evNoEpsStateVarsProduct[#,model,stateVarsNoEps]&,(expr/.cond`Private`modelContextRules)//.Normal@model["endogenousEq"]/.mapToStateVars]/.rulesE[_]	
			]
		]
	]
]


(* ::Subsubsection::Closed:: *)
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


(* ::Subsubsection::Closed:: *)
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


(* ::Subsubsection::Closed:: *)
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


(* ::Subsection::Closed:: *)
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
createSystem[n_,model_]:=With[
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
			addt[x_] := x[Symbol["t"]];
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
					unknowns = Symbol /@ Map[StringJoin, Map[If[IntegerQ[#],IntegerString[#],SymbolName[#]]&, (Tally /@ stateVarsSets), {3}], {1}];
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


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
