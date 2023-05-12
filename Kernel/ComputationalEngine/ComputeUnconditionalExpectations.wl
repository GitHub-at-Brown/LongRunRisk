(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];


(* ::Subsection:: *)
(*Public symbols*)


uncondE::usage = "uncondE[x] gives the unconditional mean of x."; 
uncondVar::usage = "uncondVar[x] gives the unconditional variance of x."; 
uncondCov::usage = "uncondCov[x,y] gives the unconditional covariance of x and y."; 
createSystem


Begin["`Private`"];


(* ::Subsection:: *)
(*Package Dependencies*)


Get["PacletizedResourceFunctions`"]
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"->"cond`"]


(* ::Subsection:: *)
(*Unconditional moments of state variables*)


evNoEps[model_,variablesToLag_]:= Module[
	{e,i,r,M,q,x,t,p},
	(e_Symbol?(MatchQ[SymbolName[#],"eps"]&)[i_][r_,M___]^q_. x_Symbol?(MemberQ[Alternatives@@(SymbolName/@variablesToLag),SymbolName[#]]&)[t_]^p_.) :> e[i][r,M]^q If[FullSimplify[r<=t,r>=0&&t>=0],cond`Private`lagStateVarst[x[t]^p,r-1,model],x[t]^p](*/;MemberQ[stateVarsNoEps,x]*)
]

lagStateVarsProduct[model_,variablesToLag_]:= Module[
	{x1,x2,t1,t2,i1,i2,q1,q2},
	((x1_Symbol?(MemberQ[Alternatives@@(SymbolName/@variablesToLag),SymbolName[#]]&)[t1_,i1___]^q1_.)(x2_Symbol?(MemberQ[Alternatives@@(SymbolName/@variablesToLag),SymbolName[#]]&)[t2_,i2___]^q2_.)) :>  If[FullSimplify[t1<=t2,t1>=0&&t2>=0],x1[t1,i1]^q1 cond`Private`lagStateVarst[x2[t2,i2]^q2,t1,model],cond`Private`lagStateVarst[x1[t1,i1]^q1,t2,model]x2[t2,i2]^q2](*/;MemberQ[stateVarsNoEps,x]*)
]

evNoEpsStateVarsProduct[expr_,model_,variablesToLag_]:= Module[
	{
		assignParam=model["assignParam"],
		assignParamStocks=model["assignParamStocks"],
		rulesEfun = t |-> FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t],
		rulesE,
		exprLagStateVarsProduct,
		exprEvNoEps
	},
	rulesE[t_]:=rulesEfun[t]//.assignParam//.assignParamStocks;
	exprLagStateVarsProduct=ExpandAll[expr]//.lagStateVarsProduct[model,variablesToLag];
	exprEvNoEps=ExpandAll[exprLagStateVarsProduct]//.evNoEps[model,variablesToLag];
	ExpandAll[exprEvNoEps](*/.rulesE[_]*)
]

(*evNoEps[expr_,model_,statevarsnoeps_]:= Module[
	{
		lagTimes,k,g,p,e,i,r,M,q,t
	},
	lagTimes=Cases[{expr},Times[(k_Symbol?(MemberQ[Alternatives@@(SymbolName/@statevarsnoeps),SymbolName[#]]&)[g_]^p_.),(e_Symbol?(MatchQ[SymbolName[#],"eps"]&)[i_][r_,M___]^q_. )]:>If[FullSimplify[r<=t,r>=0&&t>=0],r-1,t],Infinity];
	cond`Private`lagStateVarst[expr,FullSimplify[Min@@lagTimes,t>=0],model]
]*)

(*evNoEps:= Subscript[\[CurlyEpsilon],i_][r_,M___]^q_. x_[t_]^p_.:> Subscript[\[CurlyEpsilon],i][r,M]^q If[FullSimplify[r<=t],lagStateVarst[x[t]^p,r-1],x[t]^p]/;MemberQ[stateVarsNoEps,x];*)


(*lagsUntilEpsInFuture[expr_,model_,variablesToLag_]:= Module[
	{
		lagTimes,
		vLocal=Alternatives@@(SymbolName/@variablesToLag),
		exprLocal=ReplaceAll[expr,x_Symbol:>Symbol@SymbolName@x]
	},
	lagTimes=Cases[
		{ExpandAll@exprLocal},
		_. Times[
			(k_Symbol?(MemberQ[vLocal,SymbolName[#]]&)[t_]^p_.),(e_Symbol?(MatchQ[SymbolName[#],"eps"]&)[i_][r_,M___]^q_. )
		] :> If[
				FullSimplify[r<=t,r>=0&&t>=0],
				r-1,
				t
			],
		Infinity
	];
	FullSimplify[Min@@lagTimes,Thread[lagTimes >= 0]]
]
evNoEps[expr_,lagTime_,model_]:=cond`Private`lagStateVarst[expr,lagTime,model]*)


createSystem::nomom = "Unconditional moments cannot be computed for state variables. "<>
"The term `1` in the equation for the moment `2` contains `3`, which is a product of state "<>
"variables at different time periods and is not currently handled. "<>
"Consider adding an equation for `3` as an additional moment in the system of equations"<>
"that computes uncoditional moments of state variables in ComputationalEngine.wl";

addt[x_] := x[Symbol["t"]];


(*minTfun[x_] := Module[
	{
		timeIndices = Cases[Variables[x], y_[s__, i___] :> s]
	}
	,	
	Refine[Min[timeIndices], Thread[timeIndices >= 0]]
]*)	

	
createSystem[n_,model_]:=With[
	{
		stateVars=DeleteDuplicates[DeleteCases[Cases[Variables[model["stateVars"] ],x_[_]:>x],0]],
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]],
		assignParam=model["assignParam"],
		assignParamStocks=model["assignParamStocks"],
		rulesEfun = t |-> FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t]
	},
	

	With[
		{
			stateVarsNoEps = Complement[stateVars,Cases[stateVars,x_Symbol?(MatchQ[SymbolName[#],"eps"]&)[y___]:>x[y],Infinity,Heads->True]]
		},
		With[
		{
			stateVarsNoEpst=Symbol/@SymbolName/@stateVarsNoEps
		},		
			Module[
			{				
				stateVarsTuples,
				stateVarsSets,
				stateVarsProducts,
				stateVarsMapAll,
				minEpsT,
				(*minStateVarsT,*)
				minT,
				stateVarsEqs,
				times0,
				times,
				powers,
				powersString,
				stateVarsNoEpsString,
				stateVarsPowers,
				unknowns,
				stateVarsProductsLocal,
				nameRules,
				stateVarsEqsLocal,
				system,
				pos,
				term,
				prod,
				posEqs,
				eq,
				rulesE
			},
			rulesE[t_]:=rulesEfun[t]//.assignParam//.assignParamStocks;
				(*
					(*create products of powers of state variables of order n*)
					stateVarsTuples=Tuples[stateVarsNoEpst,n];
				*)		
				(*create products of powers of state variables up to order n*)
				stateVarsTuples=Flatten[Table[Tuples[stateVarsNoEpst,i],{i,n}],1];
				stateVarsSets=DeleteDuplicatesBy[Sort]@stateVarsTuples;
				stateVarsProducts=Replace[Map[addt,stateVarsSets,{2}],List->Times,{2},Heads->True];
				
				(*evaluate products of powers using equations for exogenous processes*)
				stateVarsMapAll=stateVarsProducts/.mapAll;

				(*lag state variables until shocks are in the future (using lagsUntilEpsInFuture), then
				apply rulesE to compute unconditional expectations*)
				(*minEpsT = lagsUntilEpsInFuture[ExpandAll[#], model, stateVarsNoEps]& /@stateVarsMapAll;*)
				(*minStateVarsT=minTfun[stateVarsMapAll];	*)
				(*stateVarsEqs = cond`ev[ExpandAll[stateVarsMapAll]//.evNoEps[model],minStateVarsT,model]/.rulesE[_] ;*)
				
				(*stateVarsEqs = ExpandAll[ExpandAll[stateVarsMapAll]//.evNoEps[model,stateVarsNoEps]]/.rulesE[_] ;*)
				stateVarsEqs = FixedPoint[evNoEpsStateVarsProduct[#,model,stateVarsNoEps]&,stateVarsMapAll];
			
				(*find time indices of state variables for each summand of each equation*)
				times0=Cases[#,k_Symbol?(MemberQ[Alternatives@@(SymbolName/@stateVarsNoEps),SymbolName[#]]&)[g_]:>g,Infinity]&/@(Flatten@(List@@@stateVarsEqs));
				times=times0/.{}->Sequence[];
				
				If[
					(*if all state variables have the same time index within each summand*)
					And@@(SameQ@@@times)
					,
	
					(*create names for each moment, which are the unknowns we solve for*)
					powers =CoefficientRules[stateVarsProducts,addt/@stateVarsNoEpst][[;;,1,1]];
					powersString=IntegerString@powers;
					stateVarsNoEpsString=ToString/@stateVarsNoEps;
					stateVarsPowers=Riffle[stateVarsNoEpsString,#]&/@powersString;
					unknowns =Module[
						{z}
						,
						ToExpression /@ Map[StringJoin, Map[ToString, (Tally /@ stateVarsSets), {3}], {1}]
					];
					(*stateVarsProductsLocal=ReplaceAll[stateVarsProducts,k_Symbol?(MemberQ[Alternatives@@(SymbolName/@stateVarsNoEps),SymbolName[#]]&)[g_]:>Symbol[SymbolName[k]][g]];
					nameRules=Thread[(stateVarsProductsLocal/. t_Symbol?(MatchQ[SymbolName[#],"t"]&)->_ )->unknowns];(*/.x_Symbol:>Symbol[SymbolName[x]]*)
					
					(*create system of equations to solve for moments*)
					stateVarsEqsLocal=ReplaceAll[stateVarsEqs,k_Symbol?(MemberQ[Alternatives@@(SymbolName/@stateVarsNoEps),SymbolName[#]]&)[g_]:>Symbol[SymbolName[k]][g]];
					
					system=Thread[stateVarsProducts==stateVarsEqsLocal]/.nameRules;*)
										
					nameRules=Thread[(stateVarsProducts/. x_Symbol?(MatchQ[SymbolName[#],"t"]&) ->_ )->unknowns];(*/.x_Symbol:>Symbol[SymbolName[x]]*)
					system=Thread[stateVarsProducts==stateVarsEqs]/.nameRules;
					
					(*return system, unknowns, and naming rules*)
					{nameRules,system,unknowns,stateVars,stateVarsNoEpst}
					,		
					(*find the problematic term, issue message, return unsolved stateVarsEqs*)
					pos=Position[SameQ@@@times0,False,1,1];
					term=Extract[Flatten@(List@@@stateVarsEqs),pos];
					prod=Times@@Cases[term,k_Symbol?(MemberQ[Alternatives@@(SymbolName/@stateVarsNoEps),SymbolName[#]]&)[g_]:>Symbol[SymbolName[k]][g],Infinity];
					posEqs=Position[stateVarsEqs,term[[1]]];
					eq=Inactive[uncondE][stateVarsProducts[[posEqs[[1,1]]]]];
					Message[createSystem::nomom,term,eq,prod];
					(*{stateVarsEqs,stateVarsProducts}*)
					{$Failed,$Failed,$Failed}
				]
			]
		]
	]
]


(*solveSystem[n_Integer/;n>0,model_]:=
	With
	{
		m=model
	}
	Module[
	{
		system,
		unknowns,
		nameRules,
		lastSol,
		newSystem,
		newUnknowns
	},
		{system,unknowns,nameRules}=createSystem[n,model];
		lastSol=solveStage[n-1];
		newSystem=Cases[system/.lastSol,Except[True]];
		newUnknowns=Complement[unknowns,lastSol[[;;,1]]];
		Join[Flatten@Solve[system,unknowns],lastSol]
	]
]
solveStage[0]={};
solveSystem[4]
Solve[system,unknowns]
uncondMomStateVars=Solve[##]&@@(createSystem[n,modNRC])
*)


(*maxMoment=2;
{system,unknowns,nameRules}=createSystem[maxMoment];
uncondMomStateVars=Flatten@Solve[system,unknowns];*)


minTfun[expr_,variablesToLag_]:= With[
	{
		vLocal=Alternatives@@(SymbolName/@variablesToLag),
		exprLocal=ReplaceAll[expr,x_Symbol:>Symbol@SymbolName@x]
	},
	With[
		{
			lagTimes=Cases[
				Variables[exprLocal],
				(k_Symbol?(MemberQ[vLocal,SymbolName[#]]&)[t__][i___]) :> t,
				Infinity
			]
		},
		FullSimplify[Min@@lagTimes,Thread[lagTimes >= 0]]
		]
]
(*minTfun[expr_] := minTfun[expr,Variables[expr]]*)


uncondEStep[expr_,model_]:=With[
	{
		stateVars=DeleteDuplicates[DeleteCases[Cases[Variables[model["stateVars"] ],x_[_]:>x],0]],
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]](*,
		varNames = StringDrop[#,-2]&/@Join[model["exogenousVars"],model["endogenousVars"]],
		assignParam=model["assignParam"],
		assignParamStocks=model["assignParamStocks"],
		rulesEfun = t |-> FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[t]		*)
	},
	
	With[
		{
			stateVarsNoEps = Complement[stateVars,Cases[stateVars,x_Symbol?(MatchQ[SymbolName[#],"eps"]&)[y___]:>x[y],Infinity,Heads->True]]
		},
		With[
			{
				mapToStateVars = Cases[mapAll,Rule[a_,b_]/;FreeQ[a,Alternatives@@(SymbolName/@stateVarsNoEps)]]
			},
			With[
				{
					minT=minTfun[expr/.mapToStateVars,varNames]
				},
				Module[
				{
					rulesE
				},
					(*rulesE[t_]:=rulesEfun[t]//.assignParam//.assignParamStocks;*)
					(*ExpandAll[cond`ev[expr//.evNoEps[model],minT,model]]/.rulesE[_]*)
					
					(*ExpandAll[ExpandAll[expr/.mapToStateVars]//.evNoEps[model]]/.rulesE[_]*)
					FixedPoint[evNoEpsStateVarsProduct[#,model,stateVarsNoEps]&,expr/.mapToStateVars]
					(*minTstep=Min[Cases[Variables[expr/.mapToStateVars] ,y_[s_,i___]/;MemberQ[ToExpression[varNames],y]:>s]];*)
					(*timeIndices=Cases[Variables[expr/.mapToStateVars],y_Symbol?(MemberQ[Alternatives@@(SymbolName/@varNames),SymbolName[#]]&)[s_,i___]:>s,Infinity];*)
					(*minTstep=Refine[Min[timeIndices], Thread[timeIndices >= 0]];*)
					(*xStateVars = evNoEps[ Expand[cond`Private`lagStateVarst[expr,minTstep,model]],model,stateVarsNoEps];*)(*Expand[cond`Private`lagStateVarst[expr,minTstep,model]]/.evNoEps[model]*)
					(*xEshocks = Expand[xStateVars]/.rulesE[_]*)
				]
			]
		]
	]
]


(* unconditional moments of any expression *)
uncondE::nmom="Moment(s) `1` not computed. Try increasing maxMoment or maxCrossMoment in llr.wl";
uncondE[x_,model_]:= With[
	{
	uncondMomOfStateVars = model["uncondMomOfStateVars"]
	},
	(*FixedPoint[uncondEStep[#,model]&,x] //. uncondMomOfStateVars*)
	uncondEStep[x,model] //. uncondMomOfStateVars
]

(* unconditional variances and covariances *)
uncondVar[x_]:=uncondE[(x-uncondE[x])^2]
uncondCov[x_,y_]:=uncondE[(x-uncondE[x])(y-uncondE[y])]
uncondCorr[x_,y_]:=uncondCov[x,y]/(Sqrt[uncondVar[x]]Sqrt[uncondVar[y]])


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
