(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];


(* ::Subsection:: *)
(*Public symbols*)


ev::usage = "ev[x,s,model] gives the expected value of x conditional on time s for model."; 
var::usage = "var[x,s,model] gives the variance of x conditional on time s for model."; 
cov::usage = "cov[x,y,s,model] gives the covariance of x and y conditional on time s for model."; 
corr::usage = "corr[x,y,s,model] gives the correlation of x and y conditional on time s for model."; 


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];


(* ::Subsection:: *)
(*Conditional moments*)


(* ::Subsubsection:: *)
(*ev*)


Attributes[ev]={HoldFirst};
ev[expr_,conditionalTime_,model_]:=With[
	{
		assignParam=model["assignParam"],
		assignParamStocks=model["assignParamStocks"],
		rulesEfun = t |-> FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t]		
	},
	Module[{rulesE},
		rulesE[t_]:=rulesEfun[t]//.assignParam//.assignParamStocks;
		ExpandAll[lagStateVarst[expr,conditionalTime,model]]//. rulesE[t_/;Refine[t>conditionalTime,t>=0&&conditionalTime>=0]]
	]
]


(* ::Subsubsection:: *)
(*var*)


Attributes[var]={HoldFirst};
var[expr_,conditionalTime_,model_]:=ev[(expr-ev[expr,conditionalTime,model])^2,conditionalTime,model];


(* ::Subsubsection:: *)
(*cov*)


Attributes[cov]={HoldFirst};
cov[expr1_,expr2_,conditionalTime_,model_]:=ev[(expr1-ev[expr1,conditionalTime,model])(expr2-ev[expr2,conditionalTime,model]),conditionalTime,model];


(* ::Subsubsection:: *)
(*corr*)


Attributes[corr]={HoldFirst};
corr[expr1_,expr2_,conditionalTime_,model_]:=cov[expr1,expr2,conditionalTime,model]/(Sqrt[var[expr1,conditionalTime,model]]Sqrt[var[expr2,conditionalTime,model]])


(* ::Subsection:: *)
(*Helper functions*)


(* ::Subsubsection:: *)
(*lagStateVarst*)


Attributes[lagStateVarst]={HoldFirst};
lagStateVarst[expr_,conditionalTime_,model_]:=Module[
	{
		mapAllt,
		lagt
	},
	mapAllt[t_]:= Module[{s},Replace[Normal[Join[model["exogenousEq"],model["endogenousEq"]]],p_Rule :> ( (p[[1]][s_,q___]/;Refine[s>t,s>=0&&t>=0]) :> p[[2]][s,q] ),2]];
	lagt[x_,t_]:= x//.mapAllt[t] ;
	lagt[expr/.modelContextRules,conditionalTime]//. model["toStateVars"]
]


(* ::Subsubsection:: *)
(*modelContextRules*)


parametersContextPattern[parameter_String, context_String] := 
	(y_Symbol ? (MatchQ[parameter, SymbolName[#]]&)) :> ToExpression[context <> parameter]

shocksContextPattern[shock_String, context_String] := 
	(y_Symbol ? (MatchQ[shock, SymbolName[#]]&)[z__String][t__]) :> ToExpression[context <> shock][z][t]

eqsContextPattern[var_String, context_String] :=
	(y_Symbol ? (MatchQ[var, SymbolName[#]]&)[s__, i___]) :> ToExpression[context <> var][s, i]

parametersContextRules = parametersContextPattern[
	#,
	"FernandoDuarte`LongRunRisk`Model`Parameters`"
]& /@ FernandoDuarte`LongRunRisk`Model`Parameters`$parameters;

coefsContextRules = parametersContextPattern[
	#,
	"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"
]& /@ {
	SymbolName @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc,
		 SymbolName @ Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd,
		 SymbolName @ Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb,
		 SymbolName @ Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb
};

shocksContextRules = shocksContextPattern[
	#,
	"FernandoDuarte`LongRunRisk`Model`Shocks`"
]& /@ {"eps"};

eqsContextRules = Join[
	eqsContextPattern[
		#,
		"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"
	]& /@ (
		StringDrop[#, -2]& /@ FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars
	)
	,
	eqsContextPattern[
		#,
		"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"
	]& /@ (
		StringDrop[#, -2]& /@ FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars
	)
];

modelContextRules = Join[
	parametersContextRules, coefsContextRules, shocksContextRules, eqsContextRules
];


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
