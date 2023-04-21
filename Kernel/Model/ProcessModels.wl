(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]


(* ::Subsection:: *)
(*Public symbols*)


processModels
createExogenous


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
		models=m,
		z,
		i,
		ContextPath=$ContextPath
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
	


	$ContextPath=ContextPath;
	
	
	models

];


(* ::Subsubsection:: *)
(*createExogenous*)


createExogenous[m_]:=Module[
	(*adds exogenous variables and equations to each model in m after removing those that are always 0*)
	{
		models=m,
		exoNoStocks,
		exoString,
		exoExprPrivate,
		exoExpr,
		exoExprAssignParam,
		indicesKeep,
		exoVar,
		exoVarString,
		exoVarExpr,
		exoEqAll,
		exoEq,
		exoStocks,
		exoStocksString,
		(*dd,t,i,j*)
		exoExprStocksPrivate,
		exoExprStocks,
		exoExprStocksAssignParam,
		indicesNumStocks,
		indicesZeroStocks,
		indicesKeepStocks,
		exoEqStocks,	
		exoVars,
		exoEqs
	},
	(*add list of exogenous variables and equations to models*)
	Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"->None];
	
	(*non-stock specific*)
		exoNoStocks=FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVarsNoStocks;
		(*find exogenous variables that are not identically equal to zero*)
		exoString=("FernandoDuarte`LongRunRisk`Model`ExogenousEq`"<>#<>"[t]")&/@exoNoStocks;
		exoExprPrivate=ToExpression/@exoString;
		exoExpr := Block[{$ContextPath = {}}, SetSymbolsContext[exoExprPrivate]];
		exoExprAssignParam=(exoExpr//.#["assignParam"])& /@models;
		indicesKeep=Complement[
				Thread[{Range @ Length @ exoExpr}],
				Position[#,0]
			]& /@exoExprAssignParam;
		(*variables*)
		exoVar= Extract[exoNoStocks, #]&/@indicesKeep;	
		(*equations*)
		exoVarString=(StringDrop[#,-2]<>"[t]")&/@exoNoStocks;
		exoVarExpr=ToExpression/@exoVarString;
		(*funTemplate[fun_,argPatt_,arg_] := ( {##} /. (argPatt :> fun) )&;
		exoEqAll=Thread[exoVarExpr->funTemplate[exoExpr,{t}]];*)
		exoEqAll=Thread[exoVarExpr->exoExpr];
		exoEq=Extract[exoEqAll, #]&/@indicesKeep;
	
	(*stock specific*)
		exoStocks=FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVarsStocks;
		(*find exogenous variables that are not identically equal to zero*)
		exoStocksString=("FernandoDuarte`LongRunRisk`Model`ExogenousEq`"<>#)&/@exoStocks;
		exoExprStocksPrivate=Table[dd[t,j]->(ToExpression/@exoStocksString)[[1]][t,j],{j,Prepend[Range[#["numStocks"]],i] }] &/@models;
		(*exoExprStocksPrivate=Table[dd-> ({t,j}:>(ToExpression/@exoStocksString)[[1]][t,j]),{j,Prepend[Range[#["numStocks"]],i] }] &/@models;*)
		exoExprStocks = Block[{$ContextPath = {}}, SetSymbolsContext[exoExprStocksPrivate]];
		exoExprStocksAssignParam=(exoExprStocks[#["shortname"]]//.#["assignParam"]//.#["assignParamStocks"])&/@models;
		indicesNumStocks=(Range @ Length @ exoExprStocks[#["shortname"]])& /@models;
		indicesZeroStocks=First/@Position[#,0]&/@exoExprStocksAssignParam;
		indicesKeepStocks=Complement[
			indicesNumStocks[#["shortname"]],
			indicesZeroStocks[#["shortname"]]
		]& /@models;
		(*equations*)
		exoEqStocks = Extract[exoExprStocksAssignParam[#["shortname"]], Thread[{indicesKeepStocks[#["shortname"]]}]]&/@models;
		
	(*combine*)
		exoVars=Append[Extract[exoNoStocks, #],"ddeq"]&/@indicesKeep;(*we assume at least one stock has dividends not identically 0*)
		exoEqs=Join[exoEq,exoEqStocks,2];

	(*append to models*)
	models=(Append[#, "exogenousVars"->exoVars[#["shortname"]] ]&) /@models;
	models=(Append[#, "exogenousEq"->Association@exoEqs[#["shortname"]] ]&) /@models
	

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


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
