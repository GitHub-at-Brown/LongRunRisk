(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];


(* ::Subsection:: *)
(*Public symbols*)


ev::usage = "ev[x,s] gives the expected value of x conditional on time s."; 
var::usage = "var[x,s] gives the variance of x conditional on time s."; 
cov::usage = "cov[x,y,s] gives the covariance of x and y conditional on time s."; 


Begin["`Private`"];


(* ::Subsection:: *)
(*Package Dependencies*)


Needs["PacletizedResourceFunctions`"]


(* ::Subsection:: *)
(*Independent of Model*)


stript[x_[t+i_Integer:0]] := x


(*With[
	{
		stateVars=DeleteDuplicates[DeleteCases[Cases[Variables[model["stateVars"] ],x_[_]:>x],0]],
		varNames = StringDrop[#,-2]&/@Join[model["exogenousVars"],model["endogenousVars"]],
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]],
		assignParam=model["assignParam"],
		assignParamStocks=model["assignParamStocks"],
		rulesEfun = t|->SetSymbolsContext[FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t]]
	},
		With[
		{
			stateVarsNoEps = Cases[stateVars,Except[Symbol["eps"][_]]],
			mapToStateVars = Cases[mapAll,Except[Alternatives@@(stateVars)->_]]
		},
		addt[x_] := x[Symbol["t"]];addt/@stateVarsNoEps;
		lagStateVarst;
		(*rules to compute expectations of shocks*)
		rulesE[t_]:=rulesEfun[t]//.assignParam//.assignParamStocks;
		ev;
		minTfun;
		]

]*)


(* ::Subsection:: *)
(*Needs Model*)


minTfun[x_,subsetVars_]:= Module[
	{y,s,i,timeIndices},
	timeIndices=Cases[Variables[x] , (y_Symbol?(MemberQ[subsetVars,SymbolName[#]]&)[s__,i___]):>s];
	minTime=Refine[Min[timeIndices],Thread[timeIndices>=0]]
]	


Attributes[lagStateVarst]={HoldFirst};
lagStateVarst[expr_,conditionalTime_,model_]:=With[
	{
		conditionalTimeLocal=ReplaceAll[conditionalTime,x_Symbol:>Symbol@SymbolName@x], (*strip context*)
		stateVars=DeleteDuplicates[DeleteCases[Cases[Variables[model["stateVars"] ],x_[_]:>x],0]],
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]]
	},

	With[
		{
			stateVarsNoEps = Complement[stateVars,Cases[stateVars,x_Symbol?(MatchQ[SymbolName[#],"eps"]&)[y___]:>x[y],Infinity,Heads->True]]
		},
		With[
		{
			mapToStateVars = Cases[mapAll,Rule[a_,b_]/;FreeQ[a,Alternatives@@(SymbolName/@stateVarsNoEps)]]
		},
			(*addt[x_] := x[Symbol["t"]];*)
			(*stopLag[s_,t_]:=Refine[s>t,s>=0&&t>=0];*)
			(*minTfun[x_]:= Module[{y,s,i},FullSimplify[Min[Cases[Variables[x] ,y_[t+s_:0,i___]:>t+s]],t>0]];*)
			(*stateVarEq=(addt/@stateVarsNoEps)/.mapAll;*)
			mapAllt[t_]:= Module[{p,s,q},Replace[mapAll,p_Rule :> ( (p[[1]][s_,q___]/;Refine[s>t,s>=0&&t>=0]) :> p[[2]][s,q] ),2]];
			(* lag operators *)
(*			lagone[x_[t__,i___]]:=x[t,i]/.mapAll;
			lag[x_,t_,n_,i___]:=Nest[lagone,x[t,i],n] // Expand ;*)
			lagt[x_,t_]:= x//.mapAllt[t] ;
			lagt[expr,conditionalTimeLocal]//. mapToStateVars
		]
	]
]

Attributes[ev]={HoldFirst};
ev[expr_,conditionalTime_,model_]:=With[
	{
		conditionalTimeLocal=SetSymbolsContext[conditionalTime],
		assignParam=model["assignParam"],
		assignParamStocks=model["assignParamStocks"],
		epsPattern=(_Symbol?((SymbolName[#]==="eps")&)),
		rulesEfun = t |-> FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t]		
	},
		(*rules to compute expectations of shocks*)
		rulesE[t_]:=rulesEfun[t]//.assignParam//.assignParamStocks;
		ExpandAll[lagStateVarst[expr,conditionalTimeLocal,model]] /. epsPattern:>eps //. rulesE[t_/;Refine[t>conditionalTimeLocal,t>=0&&conditionalTimeLocal>=0]]
		
(*		{
		ExpandAll[lagStateVarst[expr,conditionalTimeLocal,model]],
		rulesE[t_/;Refine[t>conditionalTimeLocal,t>=0&&conditionalTimeLocal>=0]]
		}*)

]



(* ::Subsection:: *)
(*Conditional Moments*)


(* conditional moments *)
Attributes[var]={HoldFirst};
var[expr_,conditionalTime_,model_]:=ev[(expr-ev[expr,conditionalTime,model])^2,conditionalTime,model];

Attributes[cov]={HoldFirst};
cov[expr1_,expr2_,conditionalTime_,model_]:=ev[(expr1-ev[expr1,conditionalTime,model])(expr2-ev[expr2,conditionalTime,model]),conditionalTime,model];




(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
