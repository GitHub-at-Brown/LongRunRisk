(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]


(* ::Subsection:: *)
(*Public symbols*)


processModels


(* ::Subsubsection:: *)
(*Usage*)


processModels::usage = ""


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Load packages*)


<<FernandoDuarte`LongRunRisk`Model`Parameters`;
<<FernandoDuarte`LongRunRisk`Model`Shocks`;
<<FernandoDuarte`LongRunRisk`Model`ExogenousEq`;
<<FernandoDuarte`LongRunRisk`Model`EndogenousEq`;
<<PacletizedResourceFunctions`;


(* ::Subsection:: *)
(*Helper functions*)


(*resource functions*)


(* ::Subsubsection:: *)
(*Usage*)


(* ::Subsection:: *)
(*processModels*)


(*adds useful key-value pairs to models*)
(*SetSymbolsContext=ResourceFunction["SetSymbolsContext"];
FullSymbolName=ResourceObject["FullSymbolName"];*)

processModels[m_]:=Module[
	{
		keys=Keys[m],
		models=keyRename[m, Thread[Keys[m]->Values@(#["shortname"]&/@m)] ], (*rename Keys to shortname*)
		z,
		i(*,
		ContextPath=$ContextPath*)
	},
	    
	(*add number of stocks as a new key-value pair in each model*)
	models = Append[
		#,
		"numStocks" -> Count[#["parameters"], SetSymbolsContext[mud][_Integer], Infinity]
	]& /@ models;
	
	(*find parameters that are zero or one in parameters and add to models*)
	models = Append[
		#,
		"assignParam" -> Select[#["parameters"], #[[2]] == 0 || #[[2]] == 1&]
	]& /@ models;
	
	(*find parameters of stocks that are zero for all stocks and add to models*)
	models = Append[
			#,
			"stockZeroParam" -> DeleteDuplicates[Cases[#["parameters"], Rule[z_[i_], 0] :> {z, i}, Infinity]]
	]& /@ models;
	
	models = Append[#,
		"assignParamStocks" -> DeleteDuplicates[
			Table[
				If[
					And @@ Table[
						MemberQ[#["stockZeroParam"], {#["stockZeroParam"][[q, 1]], j}],
						{j, 1, #["numStocks"]}
					],
					#["stockZeroParam"][[q, 1]][SetSymbolsContext[i_]] -> 0,
					Nothing
				], 
				{q, 1, Length[#["stockZeroParam"]]}
			]
		 ]
	]& /@ models;
	
	models = KeyDrop[#, "stockZeroParam"]& /@ models;
	
	(*add "exogenousVars","exogenousEq" to each model*)
	models = createExogenous[models];
	
	(*add "endogenousVars","endogenousEq" to each model*)
	models = createEndogenous[models];
	
	(*add assumptions*)
	modelAssumptions = FernandoDuarte`LongRunRisk`Model`Parameters`Private`paramAssumptions && FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`endogEqAssumptions;
	models=(Append[#, "modelAssumptions"->(SetSymbolsContext[modelAssumptions]//.#["assignParam"]//.#["assignParamStocks"]) ]&) /@models;

	(*restore $ContextPath to initial state*)
	(*$ContextPath=ContextPath;*)

	(*restore original keys and output models*)
	keyRename[models, Thread[Keys[models]->keys] ]

];


(* ::Subsubsection:: *)
(*createExogenous*)


createExogenous[m_]:=Module[
	(*adds exogenous variables and equations to each model in m after removing those that are always 0*)
	{
		models=m,
		argsPattern,
		funs,
		exoExprAssignParam,
		indicesKeep,
		argsPatternKeep,
		funsKeepList,
		funsKeep,
		exoExpr,
		exoExprKeep,
		exoVarKeep,
		funTemplate,
		exo
		(*,vars,fun,argPatt*)
	},
	Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];

	(*separate the equations into arguments `argsPattern` and expressions that define the functions `fun`*)
	argsPattern = SetSymbolsContext[Cases[DownValues[#][[;;,1]],Verbatim[HoldPattern][Verbatim[ToExpression@#][vars__]]->vars]&/@$exogenousVars];
	(*args = argsPattern /. Optional->First /. (x_Pattern :> First@x);*)
	funs = SetSymbolsContext[DownValues[#][[;;,2]][[1]]&/@(ToExpression/@$exogenousVars)];
	
	(*plug in parameters that are assumed fixed (most are fixed to 0 or 1)*)
	exoExprAssignParam=(funs//.#["assignParam"]//.#["assignParamStocks"])& /@models;
	(*find indices of exogenous variables that are not identically 0*)
	indicesKeep=Complement[
		Thread[{Range @ Length @ #}],
		Position[#,0]
	]& /@exoExprAssignParam;
	(*keep args, funs for variables that are not identically 0 *)
	argsPatternKeep=Extract[argsPattern,#]&/@indicesKeep;
	funsKeepList=MapApply[Extract,{Values@exoExprAssignParam,Values@indicesKeep}\[Transpose]];
	funsKeep=Association@Thread[Keys@exoExprAssignParam->funsKeepList];
	
	(*get names of all exogenous variables and keep those not identically 0*)
	exoExpr=ToExpression@(StringDrop[#,-2]&/@$exogenousVars);
	exoExprKeep=Extract[exoExpr,#]&/@indicesKeep;
	exoVarKeep=Extract[$exogenousVars,#]&/@indicesKeep;
	
	(*arrange as anonymous function with the right arguments*)
	funTemplate[fun_,argPatt_] := ( {##} /. (argPatt :> fun) )&;
	exo=MapThread[Association@Thread[#1->MapThread[funTemplate,{##2}]]&,{exoExprKeep,funsKeep,argsPatternKeep}];
	
	(*append to models*)
	models=Append[
		#,
		"exogenousVars"->exoVarKeep[#["shortname"]]
	]& /@ models;
	models=Append[
		#,
		"exogenousEq"->exo[#["shortname"]]
	]& /@models
]	


(* ::Subsubsection:: *)
(*createEndogenous*)


createEndogenous[m_]:=Module[
	(*adds exogenous variables and equations to each model in m after removing those that are always 0*)
	{
		models=m,
		endogenousVarsExpr,
		endogUpValuesEq,
		endogUpValuesVar,
		endogRestEq,
		endogRestVar,
		endog,
		argsPattern,
		args,
		funs,
		funTemplate
	},
	Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
	
	endogenousVarsExpr=ToExpression/@$endogenousVars;
	(*separate endogenous equations and variables with and without UpValues*)
	
		endogUpValuesEq = Pick[$endogenousVars,UnsameQ[{},#]&/@(UpValues/@endogenousVarsExpr)];
		endogUpValuesVar = ToExpression@(StringDrop[#,-2]&/@endogUpValuesEq);
		
		endogRestEq=Complement[$endogenousVars,endogUpValuesEq];
		endogRestVar= ToExpression@(StringDrop[#,-2]&/@endogRestEq);

	(*with UpValues*)
		(*equations are linear functions of state variables*)		
		endog[stateVars_] := (stateVars[#]&) /@ (ToExpression/@endogUpValuesEq);

	(*without UpValues*)
		(*equations are given functions of other variables*)
		argsPattern = SetSymbolsContext[Cases[DownValues[#][[;;,1]],Verbatim[HoldPattern][Verbatim[ToExpression@#][vars__]]->vars]&/@endogRestEq];
		args = argsPattern /. Optional->First /. (x_Pattern :> First@x);
		(*funs = ToExpression/@endogRestEq;
		funTemplate[fun_,argPatt_,arg_] := ( {##} /. (argPatt :> (fun@@arg )) )&;*)
		funs = SetSymbolsContext[DownValues[#][[;;,2]][[1]]&/@(ToExpression/@endogRestEq)];
		
		funTemplate[argPattFun_] := ( {##} /. (argPattFun) )&;
		funTemplate[fun_,argPatt_,arg_] := ( {##} /. (argPatt :> fun) )&;
	
	(*append to models*)
	models=Append[
		#,
		"endogenousVars"->Join[endogUpValuesEq,endogRestEq]
	]& /@models;
	
	models=Append[
		#,
		"endogenousEq"->Association@Join[
			Thread[
				endogUpValuesVar -> SetSymbolsContext[funTemplate[#]&/@endog[#["stateVars"]]]
			],
			Thread[
				endogRestVar -> MapApply[funTemplate,{funs,argsPattern,args}\[Transpose]]
			]
		]
	]& /@models
	
]	


(* ::Subsubsection:: *)
(*createStateVarEq*)


createStateVarEq[m_]:=Module[
	(*adds exogenous variables and equations to each model in m after removing those that are always 0*)
	{
		models=m
		
	},
(*	indicesKeep=Complement[
				Thread[{Range @ Length @ exoExpr}],
				Position[#,0]
			]& /@exoExprAssignParam;
	#["exogenousEq"]*)
	m
]	


(* ::Subsubsection:: *)
(*keyRename*)


(*rename keys in an association using a list of rules {oldkey1->newkey1,oldkey2->newkey2,..}*)
keyRename[a_Association, key_ -> key_] := a
keyRename[a_Association, old_ -> new_] /; KeyExistsQ[a, old] := KeyDrop[old]@Insert[a, new -> a[old], Key[old]]
keyRename[a:Association[Rule[_,Association[Rule[_,_]..]]..], replaceRules : {Rule[_, _] ..}]:=Fold[keyRename, a , replaceRules]



(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
