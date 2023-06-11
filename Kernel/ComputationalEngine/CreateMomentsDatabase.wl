(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`"];


(* ::Subsection:: *)
(*Public symbols*)


uncondVarLong::usage = "uncondVarLong[expression, toExogenous] computes the unconditional variance of expression using toExogenous to map endogenous variables to exogenous variables, and the default covariance function covLong to compute covariances of exogenous variables."
					   "uncondVarLong[expression, toExogenous, covfun] uses the covariance function covfun."
uncondCovLong::usage = "uncondCovLong[expression1,expression2, toExogenous] computes the unconditional covariance of expression1 and expression2 using toExogenous to map endogenous variables to exogenous variables, and the default covariance function covLong to compute covariances of exogenous variables."
					   "uncondCovLong[expression1,expression2, toExogenous, covfun] computes the unconditional covariance of expression1 and expression2 using the covariance function covfun."


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];


(* ::Subsection:: *)
(*uncondCovLong*)


(*write variables in terms of exogenous variables*)
(*expand= Reverse/@FilterRules[Reverse/@mapAll,$endogenousVars];*)
	
SetAttributes[uncondCovLong,HoldAll]
uncondCovLong[expression1_, expression2_, toExogenous_List, covfun_:covLong]:=Module[
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
Echo[Expand[expression1//.toExogenous],"expression1"];Echo[Expand[expression2//.toExogenous],"expression2"];
		p1=plusToList@(Expand[expression1//.toExogenous]);p2=plusToList@(Expand[expression2//.toExogenous]);
Echo[p1,"p1"];Echo[p2,"p2"];
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
				Plus@@((covfun@@@Keys[groups])*Values[groups])
				]
]

SetAttributes[uncondVarLong,HoldAll]
uncondVarLong[expression_, toExogenous_List, covfun_:covLong]:=uncondCovLong[expression,expression,toExogenous,covfun]


(* ::Subsubsection:: *)
(*powerToProduct*)


powerToProduct[expr_]:= Module[
	{a,x},
	Hold[expr]/. a_. * (x_^n_Integer?Positive)/;(!FreeQ[x,t] && FreeQ[a,t]):>RuleCondition@(Prepend[Table[x,n],a])/. List->Times
];


(* ::Subsubsection:: *)
(*plusToList*)


plusToList[expr_]:= Module[
	{x,n},
	Cases[1+ExpandAll[expr],Plus[x_^n_./;(!FreeQ[x,t] && Element[n,PositiveIntegers])]:>powerToProduct[x^n],{1}]
];


(* ::Subsubsection:: *)
(*split*)


split[expr_]:= Cases[expr, vv_[(b_.) + t,i___]:>{{b,vv,{i}},vv[b+ t,i]},Infinity]


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
