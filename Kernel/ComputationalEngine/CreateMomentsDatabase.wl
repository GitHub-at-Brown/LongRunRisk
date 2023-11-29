(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`"];


(* ::Subsection:: *)
(*Public symbols*)


uncondVarLongExo
uncondCovLongExo
createDatabase


(* ::Subsubsection:: *)
(*Usage*)


uncondVarLongExo::usage = "uncondVarLongExo[toExogenous, expression] computes the unconditional variance of expression using toExogenous to map endogenous variables to exogenous variables, and the default covariance function covLong to compute covariances of exogenous variables."<>"\n"<>
					      "uncondVarLongExo[toExogenous, expression, covfun] uses the covariance function covfun.";
uncondCovLongExo::usage = "uncondCovLongExo[toExogenous, expression1, expression2] computes the unconditional covariance of expression1 and expression2 using toExogenous to map endogenous variables to exogenous variables, and the default covariance function covLong to compute covariances of exogenous variables."<>"\n"<>
					      "uncondCovLongExo[toExogenous, expression1, expression2, covfun] computes the unconditional covariance of expression1 and expression2 using the covariance function covfun.";
createDatabase::usage = "createDatabase[model_Association, covLongFilename_String] computes moments for model, memoizes the results, and stores them in covLongFilename.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


(*Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];*)
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"]
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]


(* ::Subsection:: *)
(*Helper functions*)


(*functions not available before Mathematica 13*)
If[$VersionNumber<13,
	(*LexicographicSort*)
	ClearAll[LexicographicSort];
	LexicographicSort[{},_:None]:={};
	LexicographicSort[{x_},_:None]:={x};
	LexicographicSort[l_List]:=LexicographicSort[l,1];
	LexicographicSort[l_List,lev_]:=With[{min=Min[Length/@l]},Composition[Flatten[#,1]&,Map[If[Length[#]==1,#,With[{smallest=LengthWhile[#,Length[#]==lev&]},Take[#,smallest]~Join~LexicographicSort[Drop[#,smallest],lev+1]]]&],SplitBy[#,Take[#,{lev,min}]&]&,SortBy[Take[#,{lev,min}]&]]@l];
	(*ReplaceAt*)
	ReplaceAt[expr_,rules_,part_]:=MapAt[Replace[#,rules]&,expr,part];
	(*protect so that save does not save functions to file, which will clash with built-in definitions in version +13*)
	Protect[ReplaceAt];
	Protect[LexicographicSort];
	(*ResourceFunction["ReplaceAt"]
	LexicographicSort[list,p] is equivalent to Sort[list,LexicographicOrder[p]]*)
];


exo = Join[
	Symbol["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"<>#]&/@FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`$exogenousVarsNoStocksPrivate,
	FernandoDuarte`LongRunRisk`Model`Shocks`eps[#]&/@FernandoDuarte`LongRunRisk`Model`Shocks`Private`shockNamesNoStocks
];
exoStocks = Join[
	Symbol["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"<>#]&/@FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`$exogenousVarsStocksPrivate,
	FernandoDuarte`LongRunRisk`Model`Shocks`eps[#]&/@FernandoDuarte`LongRunRisk`Model`Shocks`Private`shockNamesStocks
];


(* ::Subsubsection:: *)
(*validArgsQ*)


(*returns True if arguments passed to covLong are valid*)
validArgsQ[components_]:=With[
	{
		vars=Most@components,
		ind=Last@components,
		alt=Alternatives@@exoStocks
	},
	With[
		{
			v1=Flatten@{First@vars}, (*first set of variables, converted to list if they are not*)
			v2=Flatten@{Last@vars}, (*second set of variables, converted to list if they are not*)
			ns=Count[vars,alt,{1,2}](*number of stock-related variables*)
		},
		(*arrange components*)
		With[
			{
				indSplit=TakeList[ind,{-ns,All}](*split ind into a component that denotes stock indices and a component for time shifts*)
			},
			(*ind has the right number of elements*)
			(Length@Flatten@vars-1+ns === Length[ind]) &&
			(*all time shifts are integers*)
			And@@(IntegerQ/@(Last@indSplit)) &&
			(*v1 and v2 are lists of exogenous variables*)
			VectorQ[v1,MemberQ[Join[exo,exoStocks],#]&] &&
			VectorQ[v2,MemberQ[Join[exo,exoStocks],#]&]
		](*With*)
	](*With*)
](*With*)


(* ::Subsection:: *)
(*uncondCovLongExo*)


SetAttributes[uncondCovLongExo,HoldRest]


uncondCovLongExo//Options ={
	"IterationLimit" -> $IterationLimit/4
};


uncondCovLongExo[
	(*toExogenous_,*)
	model_,
	expression1_,
	expression2_,
	covfun_,
	opts : OptionsPattern[{uncondCovLongExo}]
]:=Module[
	{
		toExogenous=Normal@model["endogenousEq"],
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
		groups,
		result,
		covResult,
		noCovLongDownValue,
		covResultNoCovLong
	},
	(*convert sums to lists*)
	p1=plusToList[Expand[expression1//.toExogenous]];
	p2=plusToList[Expand[expression2//.toExogenous]];

	If[
		p1=={} || p2=={},
		(*if expression1 or expression2 is constant, return 0*)
			0,
		Catch[
			(*if p1 or p2 contain square roots, compute using uncondCov*)
			If[
				{{},{}}=!=Position[#, Power[base_,Rational[1,2] | 0.5]/;(Cases[base,vv_[b_, i___]/;modelVarQ[vv], {0,Infinity}]=!={}),{3}]&/@{p1,p2},
				Throw[uncondCov[expression1,expression2,model]]
			];
			(*if expression1 and expression2 are not constant, compute covariance*) 
			(*for each item in the list, extract variable name, time difference from t, stock index, item without coefficient*)
				split1=split/@p1;split2=split/@p2;
			(*find coefficient for each term in the sum*)
				coeff1=ReleaseHold[p1]/(Times@@@Part[split1,All,All,-1]);coeff2=ReleaseHold[p2]/(Times@@@Part[split2,All,All,-1]);
				(*if coeff1 or coeff2 contain variables from the model, compute using uncondCov*)
				If[
					{}=!=Cases[Join[coeff1,coeff2],vv_[b_, i___]/;modelVarQ[vv], Infinity],
					Throw[uncondCov[expression1,expression2,model]]
				];
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
			(*compute covfun of each term preventing iteration limit quietly and keeping last value before iteration limit is reached*)
			covResult=Last@Quiet[
				Block[
					{$IterationLimit=OptionValue["IterationLimit"]},
					Check[
						result=Trace[Plus@@((covfun@@@Keys[groups])*Values[groups])],
						result,
						$IterationLimit::itlim
					]
				]
				,
				$IterationLimit::itlim
			];
			
			(*if there are any instances of covfun left, compute them using uncondCov*)
			If[
				FreeQ[covResult,covfun],
				ReleaseHold@ReleaseHold@covResult,
				noCovLongDownValue=DeleteDuplicates@Cases[covResult,covfun[expr1_,expr2_,ind__]:>{expr1,expr2,{ind}},{0,Infinity}];
				covResultNoCovLong=covResult/.Thread[(covfun @@@ MapAt[Sequence @@ # &, noCovLongDownValue, {All,-1}]) -> (uncondCov[##, model]& @@@ Map[First @ covLongToUncondCov @ # &, noCovLongDownValue])];
				ReleaseHold@ReleaseHold@covResultNoCovLong
			](*If*)
		](*Catch*)
	](*If*)
](*Module*)


(* ::Subsubsection:: *)
(*uncondVarLongExo*)


SetAttributes[uncondVarLongExo,HoldRest]


(*uncondVarLongExo[toExogenous_, expression_, covfun_, opts : OptionsPattern[{uncondCovLongExo}]]:=uncondCovLongExo[toExogenous, expression, expression, covfun, opts]*)

uncondVarLongExo[model_, expression_, covfun_, opts : OptionsPattern[{uncondCovLongExo}]]:=uncondCovLongExo[model, expression, expression, covfun, opts]


(* ::Subsubsection:: *)
(*powerToProduct*)


powerToProduct[expr_, t_]:= Module[
	{a,z},
	Hold[expr]/. a_. * (z_^n_Integer?Positive)/;(!FreeQ[z,t] && FreeQ[a,t]):>RuleCondition@(Prepend[Table[z,n],a])/. List->Times
];


(* ::Subsubsection:: *)
(*plusToList*)


plusToList[expr_]:= With[
	{
		(*find all time indices, pick first one*)
		timeIndex0=Cases[expr,t_Symbol/;SameQ[SymbolName[t],"t"],Infinity]
	},
	With[
		{
			(*find all time indices, pick first one*)
			timeIndex=If[timeIndex0==={},{},First@timeIndex0]
		},
		With[
			{
				(*make all time indices the same*)
				exprSingleTimeIndex=ReplaceAll[expr,t_Symbol/;SameQ[SymbolName[t],"t"]:>timeIndex]
			},
			Module[
				{z,n},
				Cases[
					1+ExpandAll[exprSingleTimeIndex],
					Plus[
						z_^n_./;
						(
							!FreeQ[z,timeIndex] && 
							Element[n,PositiveIntegers] 
						)
					] :> powerToProduct[z^n,timeIndex],
					{1}
				]
			]
		]
	]
];


(* ::Subsubsection:: *)
(*split*)


epsQ[x_Symbol[s_String]]/;(SymbolName[x]==="eps" && MemberQ[Alternatives@@FernandoDuarte`LongRunRisk`Model`Shocks`Private`shockNames,s]):=True
epsQ[x_]:=False
modelVarQ[x_]:=epsQ[x]||MemberQ[Alternatives@@FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`$exogenousVarsPrivate,Quiet[Check[SymbolName@x,(*Abort[]*)False,SymbolName::sym]]] 


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
		Cases[
			exprSingleTimeIndex,
			vv_[(b_.)+timeIndex, i___]/;modelVarQ[vv] :> {{b, vv, {i}}, vv[b+timeIndex, i]},
			Infinity
		]
	]
];


(* ::Subsection:: *)
(*createDatabase*)


createDatabase::done = "Finished computing moments for `1`";


createDatabase//Options ={
	"maxMomentsLagsToCreate" -> 8,
	"startSequenceAtLag" -> 3,
	"simplifyDownValues" -> False
};


createDatabase[
	model_Association,
	covLongFilename_String,
	opts : OptionsPattern[{createDatabase, uncondCovLongExo}]
]:= With[
	{
		covLong = Symbol["FernandoDuarte`LongRunRisk`covLong" <> model["shortname"]],
		toExogenous = Normal @ model["endogenousEq"],
		maxLag = OptionValue["maxMomentsLagsToCreate"],
		seqStart = OptionValue["startSequenceAtLag"],
		t = FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t,
		uncondCovLongExoOpts = FilterRules[Flatten[{opts}],Options[uncondCovLongExo]]
	},
	(*load packages*)
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
	If[
		Length[ParallelKernels[]]>1,
		ParallelEvaluate[
			Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
			Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
		];
	];
	(*construct covLong database*)
	(*moments without stocks*)
	ParallelDo[
		With[
			{
				v1=exo[[ind1]],
				v2=exo[[ind2]]
			},
			With[
				{
					tempNeg = Table[{T, uncondCov[v1[t], v2[t + T], model]}, {T, -maxLag - 1, -seqStart}],
					tempPos = Table[{T, uncondCov[v1[t], v2[t + T], model]}, {T, seqStart, maxLag + 1}],
					s = seqStart
				}
				,
				covLong[v1, v2, q_ /; q <= (-s)] = seqfun[tempNeg, q, v1, v2];
				covLong[v1, v2, 0] = uncondCov[v1[t], v2[t], model];
				covLong[v1, v2, q_ /; q >= s] = seqfun[tempPos, q, v1, v2];
				Do[
					covLong[v1, v2, -qInd] = uncondCov[v1[t], v2[t - qInd], model];
					covLong[v1, v2, qInd] = uncondCov[v1[t], v2[t + qInd], model];
					,
					{qInd, s - 1}
				];
				If[
					v1 =!= v2
					,
					covLong[v2, v1, q_Integer] = covLong[v1, v2, -q]
				];
			];(*With*)
		];(*With*)
		,
		{ind1, Length[exo]}
		,
		{ind2, ind1}
		,
		DistributedContexts -> All
	];
	(*moments with one stock*)
	ParallelDo[
		With[
			{
				v1 = exoStocks[[ind1]],
				v2 = exo[[ind2]],
				s = seqStart
			},
			Module[
				{tempNeg, tempPos}
				,
				tempNeg[j_] = Table[{T, uncondCov[v1[t, j], v2[t + T], model]}, {T, -maxLag - 1, -seqStart}];
				tempPos[j_] = Table[{T, uncondCov[v1[t, j], v2[t + T], model]}, {T, seqStart, maxLag + 1}];
				covLong[v1, v2, q_ /; q <= (-s), j_] = seqfun[tempNeg[j], q, v1, v2];
				covLong[v1, v2, 0, j_] = uncondCov[v1[t, j], v2[t], model];
				covLong[v1, v2, q_ /; q >= s, j_] = seqfun[tempPos[j], q, v1, v2];
				Do[
					covLong[v1, v2, -qInd, j_] = uncondCov[v1[t, j], v2[t - qInd], model];
					covLong[v1, v2, qInd, j_] = uncondCov[v1[t, j], v2[t + qInd], model];
					,
					{qInd, s - 1}
				];
				covLong[v2, v1, q_Integer, j_] = covLong[v1, v2, -q, j];
			];(*Module*)
		];(*With*)
		,
		{ind1, Length[exoStocks]}
		,
		{ind2, Length[exo]}
		,
		DistributedContexts -> All
	];
	(*moments with two stocks*)
	ParallelDo[
		With[
			{
				v1 = exoStocks[[ind1]],
				v2 = exoStocks[[ind2]],
				s = seqStart
			},
			Module[
				{tempNeg, tempPos}
				,
				tempNeg[i_, j_] = Table[{T, uncondCov[v1[t, i], v2[t + T, j], model]}, {T, -maxLag - 1, -seqStart}];
				tempPos[i_, j_] = Table[{T, uncondCov[v1[t, i], v2[t + T, j], model]}, {T, seqStart, maxLag + 1}];
				covLong[v1, v2, q_ /; q <= (-s), i_, j_] = seqfun[tempNeg[i, j], q, v1, v2];
				covLong[v1, v2, 0, i_, j_] = uncondCov[v1[t, i], v2[t, j], model];
				covLong[v1, v2, q_ /; q >= s, i_, j_] = seqfun[tempPos[i, j], q, v1, v2];
				Do[
					covLong[v1, v2, -qInd, i_, j_] = uncondCov[v1[t, i], v2[t - qInd, j], model];
					covLong[v1, v2, qInd, i_, j_] = uncondCov[v1[t, i], v2[t + qInd, j], model];
					,
					{qInd, s - 1}
				];
				covLong[v2, v1, q_Integer, i_, j_] = covLong[v1, v2, -q, j, i];
			];(*Module*)
		];(*With*)
		,
		{ind1, Length[exoStocks]}
		,
		{ind2, ind1}
		,
		DistributedContexts -> All
	];
	(*moments of the form uncondCov[v1[t] v2[t], v3[t]] without stocks*)
	ParallelMap[
		(
			covLong[OrderlessPatternSequence[#[[1]], #[[2]]], 0, 0] = 
				uncondCov[#[[1]][t], #[[2, 1]][t] * #[[2, 2]][t], model]
		)&
		,
		Tuples[exo, {2}] /. {a_ ? (!ListQ[#]&), b_ ? (!ListQ[#]&)} :> {a, {b, b}}
		,
		DistributedContexts -> All
	];
	ParallelMap[
		(
			covLong[OrderlessPatternSequence[#[[1]], {OrderlessPatternSequence[#[[2, 1]], #[[2, 2]]]}], 0, 0] =
				uncondCov[#[[1]][t], #[[2, 1]][t] * #[[2, 2]][t], model]
		)&
		,
		Tuples[{exo, Subsets[exo, {2}]}]
		,
		DistributedContexts -> All
	];
	(*moments of the form uncondCov[v1[t] v2[t], v3[t] v4[t]] without stocks*)
	ParallelMap[
		(
			covLong[OrderlessPatternSequence[#[[1]], #[[2]]], 0, 0, 0] =
				uncondCov[#[[1, 1]][t] * #[[1, 2]][t], #[[2, 1]][t] * #[[2, 2]][t], model]
		)&
		,
		Tuples[exo, {2}] /. {a_ ? (!ListQ[#]&), b_ ? (!ListQ[#]&)} :> {{a, a}, {b, b}}
		,
		DistributedContexts -> All
	];
	ParallelMap[
		(
			covLong[OrderlessPatternSequence[#[[1]], {OrderlessPatternSequence[#[[2, 1]], #[[2, 2]]]}], 0, 0, 0] =
				uncondCov[#[[1, 1]][t] * #[[1, 2]][t], #[[2, 1]][t] * #[[2, 2]][t], model]
		)&
		,
		Tuples[{exo, Subsets[exo, {2}]}] /. {a_ ? (!ListQ[#]&), {b_ ? (!ListQ[#]&), c_ ? (!ListQ[#]&)}} :>{{a, a}, {b, c}}
		,
		DistributedContexts -> All
	];
	ParallelMap[
		(
			covLong[OrderlessPatternSequence[{OrderlessPatternSequence[#[[1, 1]], #[[1, 2]]]}, {OrderlessPatternSequence[#[[2, 1]], #[[2, 2]]]}], 0, 0, 0] =
				uncondCov[#[[1, 1]][t] * #[[1, 2]][t], #[[2, 1]][t] * #[[2, 2]][t], model]
		)&
		,
		Tuples[{Subsets[exo, {2}], Subsets[exo, {2}]}]
		,
		DistributedContexts-> All
	];
	(*moments of the form uncondCov[v1[t] v2[t], v3[t]] with only stocks*)
	ParallelMap[
		(
			covLong[
				OrderlessPatternSequence[#[[1]], #[[2]]],
				0, 0, i_, j_, k_
			] = uncondCov[#[[1]][t, i], #[[2, 1]][t, j] * #[[2, 2]][t, k],model]
		)&
		,
		Tuples[exoStocks, {2}] /. {
			a_ ? (!ListQ[#]&),
			b_ ? (!ListQ[#]&)
		} :> {a, {b, b}}
		,
		DistributedContexts -> All
	];
	ParallelMap[
		(
			covLong[
				OrderlessPatternSequence[
					#[[1]],
					{OrderlessPatternSequence[#[[2, 1]], #[[2, 2]]]}
				],
				0, 0, i_, j_, k_
			] = uncondCov[#[[1]][t, i], #[[2, 1]][t, j] * #[[2, 2]][t, k], model]
		)&
		,
		Tuples[{exoStocks, Subsets[exoStocks, {2}]}]
		,
		DistributedContexts -> All
	];
	(*moments of the form uncondCov[v1[t] v2[t], v3[t] v4[t]] with only stocks*)
	ParallelMap[
		(
			covLong[
				OrderlessPatternSequence[#[[1]], #[[2]]],
				0, 0, 0, i_, j_, k_, m_
			] = uncondCov[#[[1, 1]][t, i] * #[[1, 2]][t, j], #[[2, 1]][t, k] * #[[2, 2]][t, m], model]
		)&
		,
		Tuples[exoStocks, {2}] /. {
			a_ ? (!ListQ[#]&),
			b_ ? (!ListQ[#]&)
		} :> {{a, a}, {b, b}}
		,
		DistributedContexts -> All
	];
	ParallelMap[
		(
			covLong[
				OrderlessPatternSequence[
					#[[1]],
					{OrderlessPatternSequence[#[[2, 1]], #[[2, 2]]]}
				],
				0, 0, 0, i_, j_, k_, m_
			] = uncondCov[#[[1, 1]][t, i] * #[[1, 2]][t, j], #[[2, 1]][t, k] * #[[2, 2]][t, m], model]
		)&
		,
		Tuples[
			{exoStocks, Subsets[exoStocks, {2}]}
		] /. {
				a_ ? (!ListQ[#]&), 
				{
					b_ ? (!ListQ[#]&),
					c_ ? (!ListQ[#]&)
				}
			} :> {{a, a}, {b, c}}
		,
		DistributedContexts -> All
	];
	ParallelMap[
		(
			covLong[
				OrderlessPatternSequence[
					{OrderlessPatternSequence[#[[1, 1]], #[[1, 2]]]},
					{OrderlessPatternSequence[#[[2, 1]], #[[2, 2]]]}
				],
				0, 0, 0, i_, j_, k_, m_
			] = uncondCov[#[[1, 1]][t, i] * #[[1, 2]][t, j], #[[2, 1]][t, k] * #[[2, 2]][t, m], model]
		)&
		,
		Tuples[{Subsets[exoStocks,{2}], Subsets[exoStocks, {2}]}]
		,
		DistributedContexts -> All
	];
	(*retrieve DownValues from parallel kernels*)
	DownValues[Evaluate @ covLong] = DeleteDuplicates[Flatten[ParallelEvaluate[DownValues[Evaluate @ covLong]]]];
	(*rule to compute moments not previously in database with memoization*)
	covLong[expr1_,expr2_,ind__] /; validArgsQ[{expr1, expr2, {ind}}] := HoldForm[(*HoldForm to allow Simplify without evaluating*)
		covLong[expr1,expr2,ind] = 
		(totCovLong[##, model, covLong, uncondCovLongExoOpts] &) @@ Join @@ covLongToUncondCov[{expr1, expr2, {ind}}]
	]; 
	(*DownValues[Evaluate@covLong]=Replace[#,(RuleDelayed[HoldPattern[Verbatim[HoldPattern][Verbatim[Condition][a__,b__]]],c__])/;(!FreeQ[HoldPattern[b],countStockVars] && FreeQ[HoldPattern[c],Module]):>(RuleDelayed[HoldPattern[a],c]),{0,Infinity}]&/@DownValues[Evaluate@covLong];*)
	(*simplify downvalues if "simplifyDownValues"->True*)
	If[
		OptionValue["simplifyDownValues"]
		,
		(*simplify downvalues, then ReleaseHold*)
		With[{dv=DownValues[Evaluate@covLong]},
			With[
				{
					vals=Values@dv,
					keys=Keys@dv
				},	
				With[
					{
						dvValuesSimplify=ParallelMap[
							Simplify[#,model["modelAssumptions"]]&,
							vals,
							DistributedContexts -> All
						]
					},
					DownValues[Evaluate@covLong] = With[{keysLocal=keys,valuesLocal=dvValuesSimplify}, Thread[keysLocal -> valuesLocal]];
				];(*With*)
			];(*With*)
		];(*With*)
	];(*If*)
	DownValues[Evaluate@covLong]=DeleteCases[DownValues[Evaluate@covLong],HoldForm,{3},Heads->True];
	
	(*save to file*)
	With[{dataCovLong=ResourceFunction["DefinitionData"][covLong]},
		Put[dataCovLong,covLongFilename];
	];
	
	(*user message*)
	Message[createDatabase::done, covLong];
];(*With*)


(* ::Subsubsection:: *)
(*uncondCovLong*)


uncondCovLong[
	(*toExogenous_,*)
	model_,
	expr1_,
	expr2_,
	covfun_,
	opts : OptionsPattern[{uncondCovLongExo}]
] := FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`uncondCovLongExo[(*toExogenous*)model, expr1, expr2, covfun, opts];


(* ::Subsubsection:: *)
(*uncondVarLong*)


uncondVarLong[
	(*toExogenous_,*)
	model_,
	expr_,
	covfun_,
	opts : OptionsPattern[{uncondCovLongExo}]
] := FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`uncondVarLongExo[(*toExogenous*)model, expr, covfun, opts];


(* ::Subsubsection:: *)
(*totCovLong*)


(*law of total covariance*)
totCovLong[
	x_,
	y_,
	s_,
	model_Association,
	fun_,
	opts : OptionsPattern[{uncondCovLongExo}]
]:=FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[
	FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`cov[x, y, s, model],
	model
]+uncondCovLong[
	(*Normal@model["endogenousEq"],*)
	model,
	FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[x, s, model],
	FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[y, s, model],
	fun,
	opts
];


(* ::Subsubsection:: *)
(*covLongToUncondCov*)


covLongToUncondCov::nind = "The number of indices provided in `1` must be equal to the number of variables in `2` plus the number of stock-related variables in `2` that require a stock identifier";


covLongToUncondCov[components_]:=With[
	{
		vars=Most@components,
		ind=Last@components,
		alt=Alternatives@@exoStocks
	},
	With[
		{
			v1=Flatten@{First@vars}, (*first set of variables, converted to list if they are not*)
			v2=Flatten@{Last@vars}, (*second set of variables, converted to list if they are not*)
			ns=Count[vars,alt,{1,2}],(*number of stock-related variables*)
			ps=Position[vars,alt](*positions of stock-related variables*)
		},
		(*check components is well formed, otherwise abort with message*)
		If[Length@Flatten@vars-1+ns =!=Length[ind], Message[covLongToUncondCov::nind,ind,vars];Abort[];];
		(*arrange components*)
		With[
			{
				indSplit=TakeList[ind,{-ns,All}],(*split ind into a component that denotes stock indices and a component for time shifts*)
				l1=Length[v1],
				l2 =Length[v2]
			},
			With[
				{
				lv=TakeList[Last@indSplit,{l1-1,l2 }](*split time shifts for v1 and v2*)
				},
				With[
					(*insert time shifts*)
					{
						vap1=Fold[ap,If[l1===1,Inactive[Identity],Inactive[Times]]@@(#[t]&/@v1),{Table[{i},{i,2,l1}],First@lv}\[Transpose]],
						vap2=Fold[ap,If[l2===1,Inactive[Identity],Inactive[Times]]@@(#[t]&/@v2),{Table[{i},{i,1,l2 }],Last@lv}\[Transpose]]
					},
					{
						Activate[Fold[rp,Activate[{vap1,vap2},Identity],{ps,First@indSplit }\[Transpose]]],(*insert stock identifier*)
						{t-1+(Min@@{Append[Last@indSplit,0]})} (*smallest time index minus 1*)
					}
				](*With*)
			](*With*)
		](*With*)
	](*With*)
](*With*)


(* ::Subsubsection:: *)
(*ap*)


ap[expr_,{pos_,q_}]:=ReplaceAt[expr,vv_[t]:>vv[t+q],pos];


(* ::Subsubsection:: *)
(*rp*)


rp[expr_,{pos_,i_}]:=ReplaceAt[expr,vv_[t+q_.]:>vv[t+q,i],pos];


(* ::Subsubsection:: *)
(*partitionBy*)


(*split expr by presence/absence of certain parameters*)
partitionBy[expr_] := {
	{Not @ Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`phix] && Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`phipbarx] && Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`phipbarx] && Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhoxpbar]},
	{Not @ Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`phix] && Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`phipbarx^2] && Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhox]},
	{Not @ Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`phix] && Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`phipbarx^2] },
	{Not @ Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhox] && Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhopbar]},
	{Not @ Inactive @ FreeQ[expr,  FernandoDuarte`LongRunRisk`Model`Parameters`rhodx] && Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhox]},
	{Not @ Inactive @ FreeQ[expr,  FernandoDuarte`LongRunRisk`Model`Parameters`rhox]},
	
	{Not @ Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhopbar] && Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`vp] && Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`phispw]},
	{Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhopbar] && Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`phipbarpb]},
	{Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhopbar] && Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`phispw]},
	{Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhopbar] && Inactive @ Not @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`vp]},
	{Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhopbar] && Inactive @ Not @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`phispw]},
	{Not @ Inactive@ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhopbar] && Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`Esp]},
	{Not @ Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhopbar] && Inactive @ Not @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`Esp]},
	{Inactive@ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`vppbar]},
	
	{Not @ Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`phipbarx] && Not @ Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`phipbarxb]},
	{Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhox] && Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhopbar]},
	{Inactive @ FreeQ[expr, FernandoDuarte`LongRunRisk`Model`Parameters`rhox]}
};
(*number of cases in partitionBy*)
numCond = (Dimensions @ Values @ DownValues @ partitionBy)[[2]];
(*create function with different value for each case*)
dvPartitionBy= DownValues @ partitionBy;
partitionWithValue = Values @ First @ Fold[Insert[#1, #2[[3]], #2]&, dvPartitionBy, Table[{1, 2, n, 1}, {n, 1, numCond}]];
categorize[expr_] := Evaluate @ Piecewise[partitionWithValue, -99];(*-99 for cases not in partitionBy*)
DownValues[categorize] = Activate @ DownValues @ categorize;


(* ::Subsubsection:: *)
(*splitAndFindSequenceFunction*)


(*split additive terms of expr based on categorize, use FindSequenceFunction for each category, combine terms*)
(*splitAndFindSequenceFunction can be used like FindSequenceFunction*)
splitAndFindSequenceFunction[expr_, q_] :=
	Module[
		{denTempPos, numTempPos, categorizedTempPos, tempPosSeqFun, pos}
		,
		denTempPos = MapAt[Denominator, Together @ expr, {;;, 2}]; (*denominator*)
		numTempPos = Numerator @ Together @ expr; (*numerator*)
		categorizedTempPos = Table[
			GroupBy[
				List @@ numTempPos[[kk, 2]],
				categorize,
				{2 + kk, Simplify[Plus @@ #]}&
			], 
			{kk, 1, Length[numTempPos]}
		];
		tempPosSeqFun = Table[
			FindSequenceFunction[#[n]& /@ categorizedTempPos,q],
			{n, Join[Range[numCond], {-99}]}
		];
		tempPosSeqFun = DeleteCases[tempPosSeqFun, Missing[__], {0, Infinity}]; (*remove categories that are empty*)
		denTempPos = FindSequenceFunction[denTempPos, q]; 
		pos = PositionIndex[expr[[;;, 1]]]; (*q is number of lags, not index in expr*)
		(Plus @@ tempPosSeqFun) / denTempPos
	]


(* ::Subsubsection:: *)
(*seqfun*)


seqfun::seqfun="Sequence function not found for uncondCov[`1`[t], `2`[t+`3`]].";


(*seqfun tries FindSequenceFunction, then splitAndFindSequenceFunction, then fails with a message*)
seqfun[list_, q_, v1_:v1, v2_:v2] :=
	With[{sf = FindSequenceFunction[list, q]},
		If[
			FreeQ[sf, FindSequenceFunction],
			sf,
			With[{ssf = splitAndFindSequenceFunction[list, q]},
				If[
					FreeQ[ssf, FindSequenceFunction],
					ssf,
					Message[seqfun::seqfun, ToString @ v1, ToString @ v2, ToString @ q];
					Echo[list,"list"];
					Echo[q,"q"];
					Echo[v1,"v1"];
					Echo[v2,"v2"];
					Echo[ssf,"ssf"];
					Abort[];
				]
			]
		]
	]


(* ::Section::Closed:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
