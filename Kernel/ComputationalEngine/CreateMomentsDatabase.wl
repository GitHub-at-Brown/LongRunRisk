(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`"];


(* ::Subsection:: *)
(*Public symbols*)


uncondVarLongExo::usage = "uncondVarLong[toExogenous, expression ] computes the unconditional variance of expression using toExogenous to map endogenous variables to exogenous variables, and the default covariance function covLong to compute covariances of exogenous variables."<>"\n"<>
					      "uncondVarLong[toExogenous, expression, covfun] uses the covariance function covfun."
uncondCovLongExo::usage = "uncondCovLong[toExogenous, expression1, expression2] computes the unconditional covariance of expression1 and expression2 using toExogenous to map endogenous variables to exogenous variables, and the default covariance function covLong to compute covariances of exogenous variables."<>"\n"<>
					      "uncondCovLong[toExogenous, expression1, expression2, covfun] computes the unconditional covariance of expression1 and expression2 using the covariance function covfun.";
createDatabase::usage = "createDatabase[model_Association,covLongFilename_String]"


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


(*Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];*)
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];


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


(* ::Subsection:: *)
(*uncondCovLong*)


SetAttributes[uncondVarLongExo,HoldRest]


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
		If[
			p1=={} || p2=={},
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
				Cases[1+ExpandAll[exprSingleTimeIndex],Plus[z_^n_./;(!FreeQ[z,timeIndex] && Element[n,PositiveIntegers])]:>powerToProduct[z^n,timeIndex],{1}]
			]
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
(*split[expr_,t_]:= Cases[expr, vv_[(b_.)+t, i___] :> {{b, vv, {i}}, vv[b+t, i]}, Infinity]*)


(* ::Subsection:: *)
(*createDatabase*)


createDatabase//Options ={
	(*"numParallelProcessors" -> 4,*)
	"maxMomentsLagsToCreate" -> 4
}


createDatabase[
	model_Association,
	covLongFilename_String,
	opts : OptionsPattern[{createDatabase}]
]:= With[
	{
		modelShortName=model["shortname"],
		toExogenous = Normal@model["endogenousEq"],
		(*nproc=OptionValue["numParallelProcessors"],*)
		maxLag=OptionValue["maxMomentsLagsToCreate"],
		stateVars=DeleteDuplicates[DeleteCases[Cases[Variables[model["stateVars"][t] ],x_[_]:>x],0]],
		(* dd *)
		varListdd={FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd},
		(* equations that do not depend on stocks or bonds *)
		expandList={
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc,
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`sdf,
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomsdf
		},
		(* stocks *)
		expandListStocks={
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`pd,
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`ret
		},
		(* bonds *)
		expandListBond={
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond,
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombond,
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondret,
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombondret,
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield,
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombondyield
		},
		(*shocks*)
		shocksList = {
			FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"](*,
			FernandoDuarte`LongRunRisk`Model`Shocks`eps["x"],
			FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"],
			FernandoDuarte`LongRunRisk`Model`Shocks`eps["pibar"],
			FernandoDuarte`LongRunRisk`Model`Shocks`eps["sg"],
			FernandoDuarte`LongRunRisk`Model`Shocks`eps["sx"],
			FernandoDuarte`LongRunRisk`Model`Shocks`eps["sc"],
			FernandoDuarte`LongRunRisk`Model`Shocks`eps["sp"]*)
		},
		(*covariance with pd12lag*)
		vars1={"dc","dd"(*,"pd","rf","excret","pdpd","dcdc","dddd","excretexcret","rfrf","dcpd","ddpd","excretpd","rfpd"*)},
		vars2={"pd12lag"}
	},
	

	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
	
	Module[
		{
			i,j,q,n1,n2,n,rf,
			kk,qq,zz,pp,rr,vv,mm,v,v1,v2,v3,v4,v5,v6,v7,
			totCovLong,notAllZero,rp,
			countStockVars,positionStockVars,
			tup1,tup2,tup3,tup4,tup5,
			varlistWithEps
		},
		
		Block[
		{
			dataCovLong,uncondCovLong,uncondVarLong
		},
		
		With[
		{
			stateVarsNoEps = Complement[stateVars,Cases[stateVars,x_Symbol?(MatchQ[SymbolName[#],"eps"]&)[y___]:>x[y],Infinity,Heads->True]]
		},
		
		With[
		{
			(*state vars, dc and pi*)
			varList=Union[stateVarsNoEps,{FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc,FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi}],
			covLong=Symbol["FernandoDuarte`LongRunRisk`covLong"<>modelShortName]
		},
		
		uncondCovLong[expr1_, expr2_, covfun_:covLong]:= FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`uncondCovLongExo[toExogenous, expr1, expr2,  covfun];
		uncondVarLong[expr_, covfun_:covLong]:= FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`uncondVarLongExo[toExogenous, expr,  covfun];

		(*law of total variance*)
		totCovLong[x_,y_,s_,fun_:covLong]:=uncondE[cov[x,y,s, model], model]+uncondCovLong[ev[x,s, model],ev[y,s, model],fun];
		notAllZero[q___]:=Or@@(\!\(\*
TagBox[
StyleBox[
RowBox[{"Unequal", "[", 
RowBox[{"#", ",", "0"}], "]"}],
ShowSpecialCharacters->False,
ShowStringCharacters->True,
NumberMarks->True],
FullForm]\)&/@{q}) ;(*at least one input argument is non-zero*)
		
		(*moments of the form uncondCov[v1 v2, v3]*)
		varlistWithEps = Join[varList,shocksList];
		tup1=Tuples[varlistWithEps,{2}]/.{a_,b_}:>{a,{b,b}};
		tup2=Tuples[{varlistWithEps,Subsets[varlistWithEps,{2}]}];
		(covLong[OrderlessPatternSequence[#[[1]],#[[2]]],0,0]=uncondCov[#[[1]][t],#[[2,1]][t]*#[[2,2]][t], model ])&/@tup1;
		(covLong[OrderlessPatternSequence[#[[1]],{OrderlessPatternSequence[#[[2,1]] ,#[[2,2]]]}],0,0]=uncondCov[#[[1]][t],#[[2,1]][t]*#[[2,2]][t] , model])&/@tup2;
		
		covLong[v1_,{v2_ ,v3_},q1_Integer,q2_Integer]/;(notAllZero[q1,q2]):=covLong[v1,{v2 ,v3},q1,q2]=totCovLong[v1[t],v2[t+q1]*v3[t+q2],t+Min[{0,q1,q2}]-1];
		covLong[{v1_,v2_},v3_,q1_Integer,q2_Integer]/;(notAllZero[q1,q2]):= covLong[{v1,v2},v3,q1,q2]=totCovLong[v1[t]*v2[t+q1], v3[t+q2],t+Min[{0,q1,q2}]-1];
		
		rp[expr_,{pos_,i_}]:=ReplaceAt[expr,vv_[t+q_.]:>vv[t+q,i],pos];
		
		countStockVars[vars_List,patt_]:=Count[If[ResourceFunction["SymbolQ"][#],SymbolName[#], Nothing]&/@vars,patt];
		positionStockVars[vars_List,patt_]:=Position[vars,_Symbol?(MatchQ[SymbolName[#],patt]&),Heads->False];
		
		covLong[v1_,{v2_ ,v3_},q1_Integer,q2_Integer,i__]/;(countStockVars[{v1, v2, v3},"dd"|"pd"|"ret"]===Length[List[i]]):=covLong[v1,{v2,v3},q1,q2,i]=Module[
			{pos,vdd,tc},
			pos=positionStockVars[{v1,{v2,v3}},"dd"|"pd"|"ret"];
			vdd=Activate[Fold[rp,{v1[t],Inactive[Times][v2[t+q1],v3[t+q2]] },Transpose[{pos,List[i]}]]];
			tc=(totCovLong[##,t+Min[{0,q1,q2}]-1]&)@@vdd
		];
		
		covLong[{v1_ ,v2_},v3_,q1_Integer,q2_Integer,i__]/;(countStockVars[{v1, v2, v3},"dd"|"pd"|"ret"]===Length[List[i]]):=covLong[{v1,v2},v3,q1,q2,i]/;(countStockVars[{v1, v2, v3},"dd"|"pd"|"ret"]===Length[List[i]])=Module[
			{pos,vdd,tc},
			pos=positionStockVars[{{v1 ,v2},v3},"dd"|"pd"|"ret"];
			vdd=Activate[Fold[rp,{Inactive[Times][v1[t],v2[t+q1]],v3[t+q2] },Transpose[{pos,List[i]}]]];
			tc=(totCovLong[##,t+Min[{0,q1,q2}]-1]&)@@vdd
		];
		
		(*moments of the form uncondCov[v1 v2, v3 v4]*)
		tup3=Tuples[varlistWithEps,{2}]/.{a_,b_}:>{{a,a},{b,b}};
		tup4=tup2/.{a_,{b_,c_}}:>{{a,a},{b,c}};
		tup5=Tuples[{Subsets[varlistWithEps,{2}],Subsets[varlistWithEps,{2}]}];
		
		(covLong[OrderlessPatternSequence[#[[1]],#[[2]]],0,0,0]=uncondCov[#[[1,1]][t]*#[[1,2]][t],#[[2,1]][t]*#[[2,2]][t] , model])&/@tup3;
		(covLong[OrderlessPatternSequence[#[[1]],{OrderlessPatternSequence[#[[2,1]] ,#[[2,2]]]}],0,0,0]=uncondCov[#[[1,1]][t]*#[[1,2]][t],#[[2,1]][t]*#[[2,2]][t] , model])&/@tup4;
		(covLong[OrderlessPatternSequence[{OrderlessPatternSequence[#[[1,1]] ,#[[1,2]]]},{OrderlessPatternSequence[#[[2,1]] ,#[[2,2]]]}],0,0,0]=uncondCov[#[[1,1]][t]*#[[1,2]][t],#[[2,1]][t]*#[[2,2]][t] , model])&/@tup5;
		
		covLong[{v1_,v2_},{v3_ ,v4_},q1_Integer,q2_Integer,q3_Integer]/;(notAllZero[q1,q2,q3]):=covLong[{v1,v2},{v3,v4},q1,q2,q3]=totCovLong[v1[t]*v2[t+q1], v3[t+q2]* v4[t+q3],t+Min[{0,q1,q2,q3}]-1];
		
		covLong[{v1_,v2_},{v3_ ,v4_},q1_Integer,q2_Integer,q3_Integer,i__]/;(countStockVars[{v1, v2, v3, v4},"dd"|"pd"|"ret"]===Length[List[i]]):=covLong[{v1,v2},{v3,v4},q1,q2,q3,i]=Module[
			{pos,vdd,tc},
			pos=positionStockVars[{{v1,v2},{v3,v4}},"dd"|"pd"|"ret"];
			vdd=Activate[Fold[rp,{Inactive[Times][v1[t],v2[t+q1]],Inactive[Times][v3[t+q2],v4[t+q3]] },Transpose[{pos,List[i]}]]];
			tc=(totCovLong[##,t+Min[{0,q1,q2,q3}]-1]&)@@vdd
		];

		(*remove function evaluation condition in memoized DownValues of covLong*)
		DownValues[Evaluate@covLong]=Replace[#,(RuleDelayed[HoldPattern[Verbatim[HoldPattern][Verbatim[Condition][a__,b__]]],c__])/;(!FreeQ[HoldPattern[b],countStockVars] && FreeQ[HoldPattern[c],Module]):>(RuleDelayed[HoldPattern[a],c]),{0,Infinity}]&/@DownValues[Evaluate@covLong];
		(*shocks*)
		Do[
			v=shocksList[[mm]];
				covLong[v,0]=1;
				covLong[v, q_/;(q!=0)]=0;
				covLong[v,v,q_]=covLong[v,q];
				covLong[v,_,q_/;q<0]=0;
				covLong[v,x_,q_/;q>=0]:=uncondCov[v[t],x[t+q], model];
				covLong[x_,v,q_]:=covLong[v,x,-q];
			,
			{mm,1,Length[shocksList]}
		];	
		(*state vars, dc and pi*)
		ParallelDo[
			v1=varList[[kk]];
			With[
				{
					tempNeg=Table[{T,uncondCov[v1[t],v1[t+T], model  ]},{T,-maxLag-1,-2}],
					tempPos=Table[{T,uncondCov[v1[t],v1[t+T]  , model ]},{T,2,maxLag+1}]
				},
				covLong[v1,q_/;q < -1]=FindSequenceFunction[tempNeg,q];
				covLong[v1,-1]=uncondCov[v1[t],v1[t-1], model];
				covLong[v1,0]=uncondVar[v1[t], model];
				covLong[v1,1]=uncondCov[v1[t],v1[t+1], model];
				covLong[v1,q_/;q > 1]=FindSequenceFunction[tempPos,q];
				covLong[v1,v1,q_]=covLong[v1,q];
			];
			Do[
				v2=varList[[qq]];
				With[
					{
						tempNeg=Table[{T,uncondCov[v1[t],v2[t+T], model]},{T,-maxLag-1,-2}],
						tempPos=Table[{T,uncondCov[v1[t],v2[t+T], model]},{T,2,maxLag+1}]
					},
					covLong[v1,v2,q_/;q < -1]=FindSequenceFunction[tempNeg,q];
					covLong[v1,v2,-1]=uncondCov[v1[t],v2[t-1], model];
					covLong[v1,v2,0]=uncondCov[v1[t],v2[t], model];
					covLong[v1,v2,1]=uncondCov[v1[t],v2[t+1], model];
					covLong[v1,v2,q_/;q > 1]=FindSequenceFunction[tempPos,q];
					covLong[v2,v1,q_]=covLong[v1,v2,-q];
				];
				(*shocks*)
				Do[
					v3=shocksList[[mm]];
					With[
						{
							tempPos=Table[{T,uncondCov[v1[t],v3[t+T], model]},{T,3,maxLag+2}]
						},
						covLong[v1,v3,q_/;q < 0]=0;
						covLong[v1,v3,0]=uncondCov[v1[t],v3[t], model];
						covLong[v1,v3,1]=uncondCov[v1[t],v3[t+1], model];
						covLong[v1,v3,2]=uncondCov[v1[t],v3[t+2], model];
						covLong[v1,v3,q_/;q > 2]=FindSequenceFunction[tempPos,q];
						(*covLong[v3,v1,q_]=covLong[v1,v3,-q];*)
					];
					,
					{mm,1,Length[shocksList]}
				];
				,
				{qq,kk+1,Length[varList]}
			];
			,
			{kk,1,Length[varList]}
			,
			DistributedContexts->All
		];
		DownValues[Evaluate@covLong]=DeleteDuplicates[Flatten[ParallelEvaluate[DownValues[Evaluate@covLong]]]];
		(* dd *)
		Do[
			(* one stock *)
			v1=varListdd[[jj]];
			Module[
				{
					tempNeg,
					tempPos
				},
				tempNeg[i_]=Table[{T,uncondCov[v1[t,i],v1[t+T,i] , model ]},{T,-maxLag-2,-3}];
				tempPos[i_]=Table[{T,uncondCov[v1[t,i],v1[t+T,i], model]},{T,3,maxLag+2}];
				covLong[v1,q_/;q < -1,i_]=FindSequenceFunction[tempNeg[i],q];
				covLong[v1,-2,i_]=uncondCov[v1[t,i],v1[t-2,i], model];
				covLong[v1,-1,i_]=uncondCov[v1[t,i],v1[t-1,i], model];
				covLong[v1,0,i_]=uncondVar[v1[t,i], model];
				covLong[v1,1,i_]=uncondCov[v1[t,i],v1[t+1,i], model];
				covLong[v1,2,i_]=uncondCov[v1[t,i],v1[t+2,i], model];
				covLong[v1,q_/;q > 1,i_]=FindSequenceFunction[tempPos[i],q];
				
				covLong[v1,q_,i_,i_]=covLong[v1,q,i];
				covLong[v1,v1,q_,i_]=covLong[v1,q,i];
				covLong[v1,v1,q_,i_,i_]=covLong[v1,q,i];
			];
			(* two stocks *)
			Module[
				{
					tempNeg,
					tempPos
				},
				tempNeg[i_,j_]=Table[{T,uncondCov[v1[t,i],v1[t+T,j], model   ]},{T,-maxLag-1,-2}];
				tempPos[i_,j_]=Table[{T,uncondCov[v1[t,i],v1[t+T,j], model  ]},{T,2,maxLag+1}];
				covLong[v1,q_/;q < -1,i_,j_]/;Not[MatchQ[i,j]]=FindSequenceFunction[tempNeg[i,j],q];
				covLong[v1,-1,i_,j_]/;Not[MatchQ[i,j]]=uncondCov[v1[t,i],v1[t-1,j], model];
				covLong[v1,0,i_,j_]/;Not[MatchQ[i,j]]=uncondCov[v1[t,i],v1[t,j], model];
				covLong[v1,1,i_,j_]/;Not[MatchQ[i,j]]=uncondCov[v1[t,i],v1[t+1,j], model];
				covLong[v1,q_/;q > 1,i_,j_]/;Not[MatchQ[i,j]]=FindSequenceFunction[tempPos[i,j],q];
				covLong[v1,v1,q_,i_,j_]/;Not[MatchQ[i,j]]=covLong[v1,q,i,j];
			];
			(*shocks*)
			Do[
				v3=shocksList[[mm]];
				With[
					{
						tempPos=Table[{T,uncondCov[v1[t],v3[t+T], model]},{T,3,maxLag+2}]
					},
					covLong[v1,v3,q_/;q < 0]=0;
					covLong[v1,v3,0,i_]=uncondCov[v1[t,i],v3[t], model];
					covLong[v1,v3,1,i_]=uncondCov[v1[t,i],v3[t+1], model];
					covLong[v1,v3,2,i_]=uncondCov[v1[t,i],v3[t+2], model];
					covLong[v1,v3,q_/;q > 2,i_]=FindSequenceFunction[tempPos,q];
					(*covLong[v3,v1,q_]=covLong[v1,v3,-q];*)
				];
				,
				{mm,1,Length[shocksList]}
			];
			ParallelDo[
				v2=varList[[kk]];
				Module[
					{
						tempNeg,
						tempPos
					},
					tempNeg[i_]=Table[{T,uncondCov[v1[t,i],v2[t+T], model]},{T,-maxLag-1,-2}];
					tempPos[i_]=Table[{T,uncondCov[v1[t,i],v2[t+T], model]},{T,2,maxLag+1}];
					covLong[v1,v2,q_/;q < -1,i_]=FindSequenceFunction[tempNeg[i],q];
					covLong[v1,v2,-1,i_]=uncondCov[v1[t,i],v2[t-1], model];
					covLong[v1,v2,0,i_]=uncondCov[v1[t,i],v2[t], model];
					covLong[v1,v2,1,i_]=uncondCov[v1[t,i],v2[t+1], model];
					covLong[v1,v2,q_/;q > 1,i_]=FindSequenceFunction[tempPos[i],q];
					covLong[v2,v1,q_,i_]=covLong[v1,v2,-q,i];
				]
				,
				{kk,1,Length[varList]}
				,
				DistributedContexts->All
			];
			DownValues[Evaluate@covLong]=DeleteDuplicates[Flatten[ParallelEvaluate[DownValues[Evaluate@covLong]]]];
			,
			{jj,1,Length[varListdd]}
		];
			
		(* equations that do not depend on stocks or bonds *)
		Parallelize[
			Do[
				v1=expandList[[kk]];
				covLong[v1,q_Integer]=uncondCovLong[v1[t],v1[t+q],covLong];
				covLong[v1,v1,q_]=covLong[v1,q];
				
				Do[
					v2=varList[[qq]];
					covLong[v1,v2,q_Integer]=uncondCovLong[v1[t],v2[t+q],covLong];
					covLong[v2,v1,q_]=covLong[v1,v2,-q];
					,
					{qq,1,Length[varList]}
				];
				
				Do[
					v3=varListdd[[zz]];
					covLong[v1,v3,q_Integer,i_]=uncondCovLong[v1[t],v3[t+q,i],covLong];
					covLong[v3,v1,q_,i_]=covLong[v1,v3,-q,i];
					,
					{zz,1,Length[varListdd]}
				];
				
				Do[
					v4=expandList[[pp]];
					covLong[v1,v4,q_Integer]=uncondCovLong[v1[t],v4[t+q],covLong];
					covLong[v4,v1,q_]=covLong[v1,v4,-q];
					,
					{pp,kk+1,Length[expandList]}
				];
				
				Do[
					v5=shocksList[[mm]];
					covLong[v5,v1,q_/;q < 0]=0;
					covLong[v5,v1,q_/;q > 0]=uncondCov[v5[t],v1[t+q], model];
					(*covLong[v1,v5,q_]=covLong[v5,v1,-q];*)
					,
					{mm,1,Length[shocksList]}
				];
				,
				{kk,1,Length[expandList]}
			];
			,
			DistributedContexts->All
		];
		DownValues[Evaluate@covLong]=DeleteDuplicates[Flatten[ParallelEvaluate[DownValues[Evaluate@covLong]]]];
			
		(* stocks *)
		Parallelize[
			Do[
				v1=expandListStocks[[kk]];
				covLong[v1,q_Integer,i_]=uncondCovLong[v1[t,i],v1[t+q,i],covLong];
				covLong[v1,q_Integer,i_,i_]=covLong[v1,q,i];
				covLong[v1,v1,q_,i_]=covLong[v1,q,i];
				covLong[v1,v1,q_,i_,i_]=covLong[v1,q,i];	
				Do[
					v2=varList[[qq]];
					covLong[v1,v2,q_Integer,i_]=uncondCovLong[v1[t,i],v2[t+q],covLong];
					covLong[v2,v1,q_,i_]=covLong[v1,v2,-q,i];
					,
					{qq,1,Length[varList]}
				];
				Do[
					v3=varListdd[[zz]];
					covLong[v1,v3,q_Integer,i_,j_]=uncondCovLong[v1[t,i],v3[t+q,j],covLong];
					covLong[v3,v1,q_,i_,j_]=covLong[v1,v3,-q,j,i];
					covLong[v1,v3,q_,i_]=covLong[v1,v3,q,i,i];
					covLong[v3,v1,q_,i_]=covLong[v1,v3,-q,i,i];
					,
					{zz,1,Length[varListdd]}
				];
				Do[
					v4=expandList[[pp]];
					covLong[v1,v4,q_Integer,i_]=uncondCovLong[v1[t,i],v4[t+q],covLong];
					covLong[v4,v1,q_,i_]=covLong[v1,v4,-q,i];
					,
					{pp,1,Length[expandList]}
				];
				Do[
					v5=expandListStocks[[rr]];
					covLong[v1,v5,q_Integer,i_,j_]=uncondCovLong[v1[t,i],v5[t+q,j],covLong];
					covLong[v5,v1,q_,i_,j_]=covLong[v1,v5,-q,j,i];
					covLong[v1,v5,q_,i_]=covLong[v1,v5,q,i,i];
					covLong[v5,v1,q_,i_]=covLong[v1,v5,-q,i,i];
					,
					{rr,kk+1,Length[expandListStocks]}
				];
				Do[
					v6=shocksList[[mm]];
					covLong[v1,v6,q_Integer,i_]=uncondCovLong[v1[t,i],v6[t+q],covLong];
					covLong[v6,v1,q_,i_]=covLong[v1,v6,-q,i];
					,
					{mm,1,Length[shocksList]}
				];
				,
				{kk,1,Length[expandListStocks]}
			];
			
			(* bonds *)
			Do[
				v1=expandListBond[[kk]];
				covLong[v1,q_Integer,n_]=uncondCovLong[v1[t,n],v1[t+q,n],covLong];
				covLong[v1,q_Integer,n_,n_]=covLong[v1,q,n];
				covLong[v1,v1,q_Integer,n_]=covLong[v1,q,n];
				covLong[v1,v1,q_Integer,n_,n_]=covLong[v1,q,n];
				
				Do[
					v2=varList[[qq]];
					covLong[v1,v2,q_Integer,n_]=uncondCovLong[v1[t,n],v2[t+q],covLong];
					covLong[v2,v1,q_Integer,n_]=covLong[v1,v2,-q,n];
					,
					{qq,1,Length[varList]}
				];
				Do[
					v3=varListdd[[zz]];
					covLong[v1,v3,q_Integer,n_,i_]=uncondCovLong[v1[t,n],v3[t+q,i],covLong];
					covLong[v3,v1,q_,i_,n_]=covLong[v1,v3,-q,n,i];
					,
					{zz,1,Length[varListdd]}
				];
				Do[
					v4=expandList[[pp]];
					covLong[v1,v4,q_Integer,n_]=uncondCovLong[v1[t,n],v4[t+q],covLong];
					covLong[v4,v1,q_,n_]=covLong[v1,v4,-q,n];
					,
					{pp,1,Length[expandList]}
				];
				Do[
					v5=expandListStocks[[rr]];
					covLong[v1,v5,q_Integer,n_,i_]=uncondCovLong[v1[t,n],v5[t+q,i],covLong];
					covLong[v5,v1,q_,i_,n_]=covLong[v1,v5,-q,n,i];
					,
					{rr,1,Length[expandListStocks]}
				];
				Do[
					v6=expandListBond[[vv]];
					covLong[v1,v6,q_Integer,n1_Integer,n2_Integer]=uncondCovLong[ v1[t,n1],v6[t+q,n2],covLong];
					covLong[v6,v1,q_Integer,n1_Integer,n2_Integer]=covLong[v1,v6,-q,n2,n1];
					,
					{vv,kk+1,Length[expandListBond]}
				];
				Do[
					v7=shocksList[[mm]];
					covLong[v1,v7,q_Integer,n_]=uncondCovLong[v1[t,n],v7[t+q],covLong];
					covLong[v7,v1,q_Integer,n_]=covLong[v1,v7,-q,n];
					,
					{mm,1,Length[shocksList]}
				];
				,
				{kk,1,Length[expandListBond]}
			];
			,
			DistributedContexts->All
		];
		DownValues[Evaluate@covLong]=DeleteDuplicates[Flatten[ParallelEvaluate[DownValues[Evaluate@covLong]]]];
			
		(* risk free rates are yields on one-period bonds *)
		Parallelize[
			covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,q_Integer]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield,q,1];
			covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,q_]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,q];
			covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,q_Integer]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombondyield,q,1];
			covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,q_]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,q];
			Do[
				v2=varList[[qq]];
				covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,v2,q_Integer]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield,v2,q,1];
				covLong[v2,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,q_]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,v2,-q];
				covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,v2,q_Integer]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombondyield,v2,q,1];
				covLong[v2,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,q_]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,v2,-q];
				,
				{qq,1,Length[varList]}
			];
			
			Do[
				v3=varListdd[[zz]];
				covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,v3,q_Integer,i_]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield,v3,q,1,i];
				covLong[v3,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,q_,i_]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,v3,-q,i];
				
				covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,v3,q_Integer,i_]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombondyield,v3,q,1,i];
				covLong[v3,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,q_,i_]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,v3,-q,i];
				,
				{zz,1,Length[varListdd]}
			];
			
			Do[
				v4=expandList[[pp]];
				covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,v4,q_Integer]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield,v4,q,1];
				covLong[v4,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,q_]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,v4,-q];
				
				covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,v4,q_Integer]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombondyield,v4,q,1];
				covLong[v4,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,q_]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,v4,-q];
				,
				{pp,1,Length[expandList]}
			];
			
			Do[
				v5=expandListStocks[[rr]];
				covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,v5,q_Integer,i_]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield,v5,q,1,i];
				covLong[v5,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,q_,i_]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,v5,-q];
				
				covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,v5,q_Integer,i_]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombondyield,v5,q,1,i];
				covLong[v5,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,q_,i_]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,v5,-q];
				,
				{rr,1,Length[expandListStocks]}
			];
			
			Do[
				v6=expandListBond[[vv]];
				covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,v6,q_Integer,n_Integer]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield,v6,q,1,n];
				covLong[v6,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,q_Integer,n_Integer]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,v6,-q,n];
				
				covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,v6,q_Integer,n_Integer]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombondyield,v6,q,1,n];
				covLong[v6,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,q_Integer,n_Integer]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,v6,-q,n];
				,
				{vv,1,Length[expandListBond]}
			];
			Do[
				v7=shocksList[[mm]];
				covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,v7,q_Integer,n_Integer]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield,v7,q,1,n];
				covLong[v7,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,q_Integer,n_Integer]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`rf,v7,-q,n];
				
				covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,v7,q_Integer,n_Integer]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombondyield,v7,q,1,n];
				covLong[v7,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,q_Integer,n_Integer]=covLong[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nomrf,v7,-q,n];
				,
				{mm,1,Length[shocksList]}
			];
			,
			DistributedContexts->All
		];
		DownValues[Evaluate@covLong]=DeleteDuplicates[Flatten[ParallelEvaluate[DownValues[Evaluate@covLong]]]];
		
		(*covariance with pd12lag*)
		(*
		hor=ToString/@{12,24(*,36,48,60,72*)};
		vars1cov=Flatten[Outer[{StringJoin[#1,#2],StringJoin[#1,#1,#2],StringJoin[#1,"pd",#2]}&,vars1,hor],1];
		vars1cov=Flatten@LexicographicSort@Transpose[vars1cov];
		Do[
			Do[
				memo=uncondCovLong[Symbol[vars1cov[[jj]]],Symbol[vars2[[qq]]],Inactive[covLong]];
				memovec=DeleteDuplicates[Cases[Expand[memo],a_. Inactive[covLong][x__]->Inactive[covLong][x],{1}]];
				ParallelMap[Activate,memovec];
				(*retrieve from parallel kernels*)
				DownValues[Evaluate@covLong]=DeleteDuplicates[Flatten[ParallelEvaluate[DownValues[Evaluate@covLong]]]];
				(*remove function evaluation condition in memoized DownValues of covLong*)
				DownValues[Evaluate@covLong]=Replace[#,(RuleDelayed[HoldPattern[Verbatim[HoldPattern][Verbatim[Condition][a__,b__]]],c__])/;(!FreeQ[HoldPattern[b],countStockVars] && FreeQ[HoldPattern[c],Module])->HoldPattern[a]:>c,{0,Infinity}]&/@DownValues[Evaluate@covLong];
				,
				{jj,1,Length[vars1cov]}
			];
			,
			{qq,1,Length[vars2]}
		];
		(*retrieve from parallel kernels*)
		DownValues[Evaluate@covLong]=DeleteDuplicates[Flatten[ParallelEvaluate[DownValues[Evaluate@covLong]]]];*)
		
		(*remove function evaluation condition in memoized DownValues of covLong*)
		DownValues[Evaluate@covLong]=Replace[#,(\!\(\*
TagBox[
StyleBox[
RowBox[{"RuleDelayed", "[", 
RowBox[{
RowBox[{"HoldPattern", "[", 
RowBox[{
RowBox[{"Verbatim", "[", "HoldPattern", "]"}], "[", 
RowBox[{
RowBox[{"Verbatim", "[", "Condition", "]"}], "[", 
RowBox[{"a__", ",", "b__"}], "]"}], "]"}], "]"}], ",", "c__"}], "]"}],
ShowSpecialCharacters->False,
ShowStringCharacters->True,
NumberMarks->True],
FullForm]\))/;(!FreeQ[HoldPattern[b],countStockVars] && FreeQ[HoldPattern[c],Module]):>(RuleDelayed[HoldPattern[a],c]),{0,Infinity}]&/@DownValues[Evaluate@covLong];
		dataCovLong=ResourceFunction["DefinitionData"][covLong];
		Put[dataCovLong,covLongFilename];
		ToString[covLong] (*full name with context*)
		](*With*)
		](*With*)
		](*Block*)
	](*Module*)
](*With*)


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
