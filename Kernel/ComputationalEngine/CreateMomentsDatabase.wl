(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`"];


(* ::Subsection:: *)
(*Public symbols*)


uncondVarLongExo::usage = "uncondVarLong[toExogenous, expression, ] computes the unconditional variance of expression using toExogenous to map endogenous variables to exogenous variables, and the default covariance function covLong to compute covariances of exogenous variables."<>"\n"<>
					      "uncondVarLong[toExogenous, expression, covfun] uses the covariance function covfun."
uncondCovLongExo::usage = "uncondCovLong[toExogenous, expression1, expression2] computes the unconditional covariance of expression1 and expression2 using toExogenous to map endogenous variables to exogenous variables, and the default covariance function covLong to compute covariances of exogenous variables."<>"\n"<>
					      "uncondCovLong[toExogenous, expression1, expression2, covfun] computes the unconditional covariance of expression1 and expression2 using the covariance function covfun.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


(*Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];*)


(* ::Subsection:: *)
(*uncondCovLong*)


(*write variables in terms of exogenous variables*)
(*expand= Reverse/@FilterRules[Reverse/@mapAll,$endogenousVars];*)
	
SetAttributes[uncondCovLongExo,HoldRest]
uncondCovLongExo[
	toExogenous_,
	expression1_,
	expression2_,
	covfun_
]:=Module[
	{
		p1,p2,
		split1,split2,
		coeff1,coeff2,
		e1,e2,
		perm,
		times,
		first,
		rest,
		lags,
		vars,
		stocks,
		collect,
		groups
	},
	(*convert sums to lists*)
		p1=plusToList[Expand[expression1//.toExogenous]];
		p2=plusToList[Expand[expression2//.toExogenous]];
			If[p1=={} || p2=={},
			(*if expression1 or expression2 is constant, return 0*)
			0,
			(*if expression1 and expression2 are not constant, compute covariance*) 
			(*for each item in the list, extract variable name, time difference from t, stock index, item without coefficient*)
				split1=split/@p1;split2=split/@p2;
			(*find coefficient for each term in the sum*)
				coeff1=ReleaseHold[p1]/(Times@@@Part[split1,All,All,-1]);coeff2=ReleaseHold[p2]/(Times@@@Part[split2,All,All,-1]);
			(*find all terms of the product of sums*)
				e1=Part[split1,All,All,1;;-2];e2=Part[split2,All,All,1;;-2];
				perm=Tuples[{e1,e2}];
			(*get time indices for variables in each term*)
				times=(Flatten/@Map[Flatten[#[[;;,;;,1]]]&,perm,{2}]);
				first=First/@times;rest=Rest/@times;
			(*find time difference between first and rest*)
				lags=rest-first;
			(*get variables in each term without time or stock indices*)
				vars=Map[Replace[Flatten[#[[;;,;;,2]]],List[x_]:>x]&,perm,{2}];
			(*get stock indices*)
				stocks=Map[Flatten[#[[;;,;;,;;,3]]]&,perm,{1}];
			(*collect to apply GroupBy*)
				collect=Partition[Riffle[Times@@@Tuples[{coeff1,coeff2}],Join[vars,lags,stocks,2]],2];
			(*collect terms that only differ by their coefficient*)
				groups=GroupBy[collect,Last->First,Total];
			(*compute covfun of each term*)

(*Echo[p1,"p1"];Echo[p2,"p2"];Echo[split1,"split1"];Echo[split2,"split2"];Echo[coeff1,"coeff1"];Echo[coeff2,"coeff2"];Echo[e1,"e1"];Echo[e2,"e2"];
Echo[perm,"perm"];Echo[times,"times"];Echo[first,"first"];Echo[rest,"rest"];
Echo[lags,"lags"];Echo[vars,"vars"];Echo[stocks,"stocks"];Echo[collect,"collect"];Echo[groups,"groups"];Z*)
			
				Plus@@((covfun@@@Keys[groups])*Values[groups])
			]
]

SetAttributes[uncondVarLongExo,HoldRest]
uncondVarLongExo[toExogenous_, expression_, covfun_]:=uncondCovLongExo[toExogenous, expression, expression, covfun]


(* ::Subsubsection:: *)
(*powerToProduct*)


powerToProduct[expr_, t_]:= Module[
	{a,z},
	Hold[expr]/. a_. * (z_^n_Integer?Positive)/;(!FreeQ[z,t] && FreeQ[a,t]):>RuleCondition@(Prepend[Table[z,n],a])/. List->Times
];

(*powerToProduct[expr_, stateVarsNoEps_]:= Module[
	{a,z},
	ReplaceAll[
		Hold[expr],
		 (a_.) * 
		 (z_Symbol?(MemberQ[Alternatives@@(SymbolName/@stateVarsNoEps), SymbolName[#]]&)[t_, i___]^n_Integer?Positive) :> 
		 RuleCondition@(Prepend[Table[z,n],a])/. List->Times
	]
];*)


(* ::Subsubsection:: *)
(*plusToList*)


plusToList[expr_]:= With[
	{
		(*find all time indices, pick first one*)
		timeIndex=First@Cases[expr,t_Symbol/;SameQ[SymbolName[t],"t"],Infinity]
	},
	With[
	{
		(*make all time indices the same*)
		exprSingleTimeIndex=ReplaceAll[expr,t_Symbol/;SameQ[SymbolName[t],"t"]:>timeIndex]
	},
		Module[
			{z,n},
			Cases[1+ExpandAll[exprSingleTimeIndex],Plus[z_^n_./;(!FreeQ[z,timeIndex] && Element[n,PositiveIntegers])]:>powerToProduct[z^n,timeIndex],{1}]
		]
	]
];
(*plusToList[expr_, stateVarsNoEps_]:= Module[
	{z,n},
	Cases[
		1+ExpandAll[expr],
		Plus[
			(z_Symbol?(MemberQ[Alternatives@@(SymbolName/@stateVarsNoEps), SymbolName[#]]&)[t_, i___]^n_.)/;Element[n, PositiveIntegers]
		] :> powerToProduct[z[t,i]^n, stateVarsNoEps],
		{1}
	]
];*)


(* ::Subsubsection:: *)
(*split*)


(*split[expr_,t_]:= Cases[expr, vv_[(b_.)+t, i___] :> {{b, vv, {i}}, vv[b+t, i]}, Infinity]*)

 split[expr_]:=With[
	{
		(*find all time indices, pick first one*)
		timeIndex=First@Cases[expr,t_Symbol/;SameQ[SymbolName[t],"t"],Infinity]
	},
	With[
		{
			(*make all time indices the same*)
			exprSingleTimeIndex=ReplaceAll[expr,t_Symbol/;SameQ[SymbolName[t],"t"]:>timeIndex]
		},
		Cases[exprSingleTimeIndex, vv_[(b_.)+timeIndex, i___] :> {{b, vv, {i}}, vv[b+timeIndex, i]}, Infinity]
	]
];
(*split[expr_]:= Cases[expr,v_[e_Symbol?(MatchQ[SymbolName[#], "t"]&)+b_., i___] :> {{b, v, {i}}, v[e+b, i]}, Infinity]*)


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
