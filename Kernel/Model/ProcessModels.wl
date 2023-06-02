(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]


(* ::Subsection:: *)
(*Public symbols*)


processModels
addCoeffsSystem
addCoeffsSolution


(* ::Subsubsection:: *)
(*Usage*)


processModels::usage = "";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Load packages*)


(*<<PacletizedResourceFunctions`;*)
(*<<FernandoDuarte`LongRunRisk`Model`Parameters`;
<<FernandoDuarte`LongRunRisk`Model`Shocks`;*)
(*<<FernandoDuarte`LongRunRisk`Model`ExogenousEq`;*)
(*<<FernandoDuarte`LongRunRisk`Model`EndogenousEq`;*)


(*Needs["PacletizedResourceFunctions`"];*)
Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];



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

processModels[modelsCatalog_]:=
	Module[
	{
		keys=Keys[modelsCatalog],
		models = KeyMap[Replace[#, Thread[Keys[modelsCatalog]->Values@(#["shortname"]&/@modelsCatalog) ] ]&,modelsCatalog],(*rename Keys to shortname*)		
		ContextPath=$ContextPath,
		z,
		i,
		modelAssumptions
	},
	(*replace stateVars by a function t |-> stateVars[t] *)
	models = Append[
		#,
		"stateVars" -> Function[Evaluate@DeleteDuplicates@Cases[#["stateVars"],e_Symbol?(MatchQ[SymbolName[#],"t"]&),Infinity],Evaluate@#["stateVars"]]
	]& /@ models;
	
	(*add number of stocks as a new key-value pair in each model*)
	models = Append[
		#,
		"numStocks" -> Count[#["parameters"], mud[_Integer], Infinity]
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
					#["stockZeroParam"][[q, 1]][i_] -> 0,
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
	modelAssumptions = FernandoDuarte`LongRunRisk`Model`Parameters`Private`paramAssumptions 
		&& FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`endogEqAssumptions;
	models=(Append[#, "modelAssumptions"->(modelAssumptions//.#["assignParam"]//.#["assignParamStocks"]) ]&) /@models;

	(*add unconditional moments of state variables*)
	maxMomentOrder=2;
	(**activated version**)
	models = Append[#,
		"uncondMomOfStateVars"-> 
				Join[
					First@#,
					Flatten@(Solve@@(Rest@#))
				]&@FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`createSystem[maxMomentOrder,#]
	]&/@models;
	
	(**inactivated version**)
	(*models = Append[#,
		"uncondMomOfStateVars"-> 
		Activate[
			Inactivate[
				Join[
					First@#,
					Flatten@(Solve@@(Rest@#))
				]
			],
			First|Rest
		]&@FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`createSystem[maxMomentOrder,#]
	]&/@models;*)
	
	(*add expressions for some unconditional moments*)
	models = Append[
		#,
		"ratioUncondE" -> <| 
			"wc"->uncondE[wc[t],#],
			"pd"->uncondE[pd[t,j],#],
			"bond"->uncondE[bond[t,m],#],
			"nombond"->uncondE[nombond[t,m],#]
		|>
	]& /@ models;
	
	(*add Euler equations*)
	(**activated version**)
	models=Append[
		#,
		addCoeffsSystem[#]
	]&/@models;
		
	(**inactivated version**)
	(*models=Append[
		#,
		Inactive[addCoeffsSystem][#]
	]&/@models;*)
	
	(*add from FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo*)

	(*add addCoeffsSolution with fields "coeffsSolution" and subfields "wc" "pd"*)
	
	(*restore $ContextPath to initial state*)
	$ContextPath=ContextPath;

	(*restore original keys and output models*)
	KeyMap[Replace[#,Thread[Keys[models]->keys]]&,models]

]



(* ::Subsubsection:: *)
(*createExogenous*)


createExogenous[m_]:=Module[
	(*adds exogenous variables and equations to each model in m after removing those that are always 0*)
	{
		models=m,
		ContextPath=$ContextPath,
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
		exo,
		matchSymbol,
		exoExprMatchSymbol
		(*,vars,fun,argPatt*)
	},
	Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
	(*$ContextPath = PrependTo[ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];*)
	(*DeclareKnownSymbols[{"pi","x"}];*)
	
	(*separate the equations into arguments `argsPattern` and expressions that define the functions `fun`*)
(*	argsPattern = SetSymbolsContext[Cases[DownValues[#][[;;,1]],Verbatim[HoldPattern][Verbatim[ToExpression@#][vars__]]:>vars]&/@$exogenousVars];*)
(*	funs = SetSymbolsContext[DownValues[#][[;;,2]][[1]]&/@(ToExpression/@$exogenousVars)];*)
	
	argsPattern = Cases[DownValues[#][[;;,1]],Verbatim[HoldPattern][Verbatim[ToExpression@#][vars__]]:>vars]&/@$exogenousVars;
	funs = DownValues[#][[;;,2]][[1]]&/@(ToExpression/@$exogenousVars);
	
	
	(*plug in parameters that are assumed fixed (most are fixed to 0 or 1)*)
	(*exoExprAssignParam=(funs//.SetSymbolsContext[#["assignParam"]]//.SetSymbolsContext[#["assignParamStocks"]])& /@models;*)
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
(*	exoExpr=ToExpression@(StringDrop[#,-2]&/@$exogenousVars);
	exoExprKeep=Extract[exoExpr,#]&/@indicesKeep;*)
	exoExpr=StringDrop[#,-2]&/@$exogenousVars;
	exoExprKeep=Extract[exoExpr,#]&/@indicesKeep;
	
	exoVarKeep=Extract[$exogenousVars,#]&/@indicesKeep;
	
	(*arrange as anonymous function with the right arguments*)
	funTemplate[fun_,argPatt_] := ( {##} /. (argPatt :> fun) )&;
	Attributes[matchSymbol]={Listable};
	matchSymbol[var_String]:= (_Symbol?((SymbolName[#]===var)&)); (*pattern to match symbols in any Context*)
	exoExprMatchSymbol = matchSymbol/@exoExprKeep;
	exo=MapThread[Association@Thread[#1->MapThread[funTemplate,{##2}]]&,{exoExprMatchSymbol,funsKeep,argsPatternKeep}];

	(*append to models*)
	models=Append[
		#,
		"exogenousVars"->exoVarKeep[#["shortname"]]
	]& /@ models;
	models=Append[
		#,
		"exogenousEq"->exo[#["shortname"]]
	]& /@models;

	(*restore $ContextPath to initial state*)
	(*$ContextPath=ContextPath;*)
		
	models
]	


(*
to not pollute workspace idea
something[] := 
  (
  Block[{$ContextPath}, Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];];
   FernandoDuarte`LongRunRisk`Model`EndogenousEq`fun[] 
   )
*)


(* ::Subsubsection:: *)
(*createEndogenous*)


createEndogenous[mod_]:=Module[
	(*adds exogenous variables and equations to each model in m after removing those that are always 0*)
	{
		models=mod,
		endogenousVarsExpr,
		endogUpValuesEq,
		endogUpValuesVar,
		endogRestEq,
		endogRestVar,
		endog,
		argsPattern,
		funs,
		funTemplate
	},
	Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
	
	endogenousVarsExpr=ToExpression/@$endogenousVars;
	(*separate endogenous equations and variables with and without UpValues*)
	
		endogUpValuesEq = Pick[$endogenousVars,UnsameQ[{},#]&/@(UpValues/@endogenousVarsExpr)];
		(*endogUpValuesVar = ToExpression@(StringDrop[#,-2]&/@endogUpValuesEq);*)
		endogUpValuesVar = StringDrop[#,-2]&/@endogUpValuesEq;
		
		endogRestEq=Complement[$endogenousVars,endogUpValuesEq];
		(*endogRestVar= ToExpression@(StringDrop[#,-2]&/@endogRestEq);*)
		endogRestVar= StringDrop[#,-2]&/@endogRestEq;

	(*with UpValues*)
		(*equations are linear functions of state variables*)		
		endog[stateVars_] := (stateVars[#]&) /@ (ToExpression/@endogUpValuesEq);

	(*without UpValues*)
		(*equations are given functions of other variables*)
(*		argsPattern = SetSymbolsContext[Cases[DownValues[#][[;;,1]],Verbatim[HoldPattern][Verbatim[ToExpression@#][vars__]]:>vars]&/@endogRestEq];*)
(*		funs = SetSymbolsContext[DownValues[#][[;;,2]][[1]]&/@(ToExpression/@endogRestEq)];*)
		argsPattern = Cases[DownValues[#][[;;,1]],Verbatim[HoldPattern][Verbatim[ToExpression@#][vars__]]:>vars]&/@endogRestEq;
		funs = DownValues[#][[;;,2]][[1]]&/@(ToExpression/@endogRestEq);

		funTemplate[argPattFun_] := ( {##} /. (argPattFun) )&;
		funTemplate[fun_,argPatt_] := ( {##} /. (argPatt :> fun) )&;
	
		Attributes[matchSymbol]={Listable};
		matchSymbol[var_String]:= (_Symbol?((SymbolName[#]===var)&)); (*pattern to match symbols in any Context*)
	
	(*append to models*)
	models=Append[
		#,
		"endogenousVars"->Join[endogUpValuesEq,endogRestEq]
	]& /@models;

	models=Append[
		#,
		"endogenousEq"->Association@Join[
			Thread[
				(*endogUpValuesVar -> SetSymbolsContext[funTemplate[#]&/@endog[#["stateVars"]]]*)
				(matchSymbol/@endogUpValuesVar) -> (funTemplate[#]&/@endog[#["stateVars"]])
			],
			Thread[
				(matchSymbol/@endogRestVar) -> MapApply[funTemplate,{funs,argsPattern}\[Transpose]]
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
(*addCoeffsSystem*)


addCoeffsSystem[model_]:=Module[
	{
		systemWc,
		unknownsWc,
		systemPd,
		unknownsPd,
		nameBond,
		systemBond,
		initialCondBond,
		unknownsBond,
		nBond,
		nameNomBond,
		systemNomBond,
		initialCondNomBond,
		unknownsNomBond,
		nNomBond,
		ratiosUncondERuleWc,
		ratiosUncondERulePd,
		out
	},
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`"];
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
	
	(*rules that re-write Ewc, Epd in terms of the coefficients of wc[t] or pd[t,j]*)
	ratiosUncondERuleWc={FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc :>
		Simplify@FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[wc[t],model]};
		
	ratiosUncondERulePd={FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[j_] :>
			Simplify@FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[pd[t,j],model]};
			
	(* create system of equations for coefficients of wc ratio *)
	{systemWc,unknownsWc}=findEulerEqConstants[retc[t+1],model]/.ratiosUncondERuleWc;
		
	(* create system of equations for coefficients of pd ratios *)
	{systemPd,unknownsPd}=findEulerEqConstants[ret[t+1,j],model]/.ratiosUncondERuleWc/.ratiosUncondERulePd;
	
	(* create recursion for price of bonds *)
	{{nameBond,systemBond,initialCondBond,unknownsBond,nBond},
	{nameNomBond,systemNomBond,initialCondNomBond,unknownsNomBond,nNomBond}} = findBondRecursion[t+1,n,model] /.ratiosUncondERuleWc;
	
	"coeffsSystem" -> <| 
		"wc" -> {systemWc,unknownsWc},
		"pd"-> {systemPd,unknownsPd},
		"bond" -> {systemBond,unknownsBond,initialCondBond,nBond,nameBond},
		"nombond" -> {systemNomBond,unknownsNomBond,initialCondNomBond,nNomBond,nameNomBond}
	|>
]



(* ::Subsubsection:: *)
(*addCoeffsSolution*)


addCoeffsSolution[model_, ratio_String, opts_List:{}, infoModel_Association:<||>]:=With[
	{
		cs = model["coeffsSystem"][ratio],
		shortname = model["shortname"],
		numStocks = model["numStocks"],
		ratioUncondE=model["ratioUncondE"][ratio]
	},
	With[
		{
			system=cs[[1]],
			unknowns=cs[[2]],
			n=If[StringMatchQ[ratio,"bond"|"nombond"],cs[[4]],Sequence[]],
			dependentParameters=Pick[model["parameters"],NumericQ/@Values@model["parameters"],False]
		},
		Module[
			{
				solveNumericQ = False,
				coeffInfo,
				solvedQ,
				notSolvedQ,
				eq,
				coefficientNames,
				x,
				sol,
				replaceCoeffInfo,
				coeffInfoSol
			},
			Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
			Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
			If[
				(*infoModel has coefficients in closed form*)
				KeyExistsQ[infoModel,"coeffs"]&&KeyExistsQ[infoModel["coeffs"],ratio]
				,
				(*use the closed form to make the system of equations smaller*)
				coeffInfo=infoModel["coeffs"][ratio];
				solvedQ=Quiet[Simplify[#,Assumptions->n>=1&&Element[n,Integers],TimeConstraint->{1,2}]&/@(system[[2;;-1]]//.coeffInfo/.dependentParameters),Simplify::gtime];
				If[
					(*if the closed form coefficients from infoModel make some equation not hold*)
					AnyTrue[Not/@solvedQ,TrueQ]
					,
					(*don't use the closed form and solve entire system numerically*)
					coeff::badextrainfo;
					solveNumericQ = True;
					,
					(*incorporate closed form into system of equations*)
					(*remove equations that are already solved when plugging in closed form coefficients*)
					notSolvedQ=Not/@(BooleanQ/@solvedQ);
					eq=Flatten@{(First@system)//.coeffInfo,Pick[solvedQ,notSolvedQ]};
					(*find coefficients without a closed form solution that still need to be solved for*)
					coefficientNames=DeleteDuplicates@Cases[eq,unknowns[[1]][[0]][_Integer],{-2}];
				] 
				,
				(*solve entire system numerically*)
				solveNumericQ = True;
			];
			x = If[
				solveNumericQ,
				(*solve entire system numerically*)
				eq=system;
				coefficientNames=unknowns;
				coeffInfo = {};			
				If[StringMatchQ[ratio,"wc"|"pd"],createStartingPoint[coefficientNames, ratioUncondE, numStocks, opts, KeyDrop[infoModel,"coeffs"]],cs[[3]]]
				,
				If[StringMatchQ[ratio,"wc"|"pd"],createStartingPoint[coefficientNames, ratioUncondE, numStocks, opts, infoModel],Flatten@{(First@(cs[[3]]))//.coeffInfo,Pick[Rest@(cs[[3]]),notSolvedQ]}]
			];
			coeffInfoSol = Normal@ReplaceRepeated[Association@coeffInfo,coeffInfo];
			Switch[
				ratio
				,
				"wc"
				,
				{
					Inactive[MapThread][Inactive[FindRoot][#1, #2]&,{{eq}, x}],
					coeffInfoSol
				}
				,
				"pd"
				,
				With[
					{
						j=Last@Head@First@coefficientNames
					},
					Module[
						{
							CheckFindRoot,
							MapFindRoot
						},
						CheckFindRoot[x___]:=Check[FindRoot[x],Nothing,FindRoot::reged];
						MapFindRoot[x1_,x2_,x3___]:=CheckFindRoot[x1,#,x3]&/@x2;
						{
							Inactive[MapThread][Inactive[MapFindRoot][#1,#2(*,FindRootOptions*) ]&,
								{eq  /. ({j->#}&/@Range[numStocks]), x}],
							coeffInfoSol /. ({j->#}&/@Range[numStocks])
						}
					]
				](*With*)
				,
				"nombond"|"bond"
				,
				With[
					{						
						P =(First@unknowns)[[0,0]],
						remainingUnknowns=Complement[unknowns,coefficientNames]
					},
					With[
						{
							bondCoefficientRules=unknowns /. (x_[n][j_Integer] :> RuleDelayed[x[m_][j], Symbol[(SymbolName@x)<>IntegerString[j]][m]])
							(*ic=Flatten@{(First@initialConditions)//.coeffInfo,Pick[Rest@initialConditions,notSolvedQ]}*)
							(*solInfo=Table[Thread[remainingUnknowns->(remainingUnknowns/.coeffInfoSol)]/.n->m,{m,1,maxMaturity}]*)
						},
						Module[
							{
								posConstantCoeff,
								perturbation,
								bondRecursionPerturbation,
								solBondNum,
								solNum,
								solInfo
							},
							posConstantCoeff=Position[eq,_?(FreeQ[#,n-1]&),1,Heads->False];
							perturbation=If[posConstantCoeff==={},0,10^(-18)*(First@Extract[coefficientNames,posConstantCoeff]/.(n->n-1))];
							bondRecursionPerturbation=MapAt[(#/.(Equal[a_,b_]:>Equal[a,b+perturbation])&),eq,posConstantCoeff];
							solBondNum[maxMaturity:_Integer?Positive]:=Inactive[RecurrenceTable][
								Flatten[
									{
										bondRecursionPerturbation,
										x
									}
								]/.bondCoefficientRules,
								coefficientNames/.bondCoefficientRules,
								{n,0,maxMaturity}(*,
								Evaluate[FilterRules[{opts}, Options[RecurrenceTable]]],
								Evaluate@OptionValue["RecurrenceTableOptions"]*)
							];							
							solNum[maxMaturity:_Integer?Positive]:=Inactive[MapIndexed][Inactive[Thread][(coefficientNames/.n->(First@#2-1))->#1]&,solBondNum[maxMaturity]];
							solInfo[maxMaturity:_Integer?Positive]:= If[remainingUnknowns==={},ConstantArray[{},maxMaturity+1],Inactive[Prepend][Inactive[Table][Inactive[Thread][remainingUnknowns->(remainingUnknowns/.coeffInfoSol)]/.n->m,{m,1,maxMaturity}],Complement[cs[[3]],x]/.Equal->Rule]];
							{
								(*Inactive[Prepend][Inactive[Join][solNum,solInfo,2],initialConditions/.Equal->Rule]*)
								solNum,
								solInfo
							}
						](*Module*)
					](*With*)
				](*With*)
			](*Switch*)
			(*Inactive[Join][sol, Inactive[ReplaceAll][coeffInfoSol, sol]]*)
			(*{sol, coeffInfoSol}*)
		](*Module*)
	](*Which*)
](*Which*)


(* ::Subsubsection:: *)
(*addExtraInfo*)


(*createEndogenous[m_]:=Module[
	(*processes information from FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo and adds it to m*)
	{
		models=mod,
		endogenousVarsExpr,
		endogUpValuesEq,
		endogUpValuesVar,
		endogRestEq,
		endogRestVar,
		endog,
		argsPattern,
		funs,
		funTemplate
	},
modKey="NRC";
model=Map[Activate,modelsP[modKey]];
modelAssumptions=model["modelAssumptions"];
parameters=model["parameters"];
newParameters={};
newParameters = processNewParameters[newParameters,parameters];
Get["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]
ratiosUncondERuleWc={
	FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc:>
		Simplify@FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[wc[t],model]
};
{systemWc,unknownsWc}=findEulerEqConstants[retc[t+1],model]/.ratiosUncondERuleWc;
If[KeyExistsQ[modelsExtraInfo,modKey]&&KeyExistsQ[modelsExtraInfo[modKey],"coeffs"]&&KeyExistsQ[modelsExtraInfo[modKey]["coeffs"],"wc"],"use rules","numerical"]

info=modelsExtraInfo[modKey];
coeffswc=modelsExtraInfo[modKey]["coeffs"]["wc"];
solvedQ=systemWc[[2;;-1]]//.coeffswc//Simplify
If[AnyTrue[Not/@solvedQ,TrueQ],coeff::badextrainfo;"numerical","use rules"] 
(*use rules*)
notSolvedQ=Not/@(BooleanQ/@solvedQ)
Pick[solvedQ,notSolvedQ]
systemWcNotSolvedN=Flatten@{First@systemWc//.coeffswc,Pick[solvedQ,notSolvedQ]}//.parameters;

*)





(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
