(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]


(* ::Subsection:: *)
(*Public symbols*)


processModels


(* ::Subsubsection:: *)
(*Usage*)


processModels::usage = "processModels[modelsCatalog] adds convenience tools to solve and work with each model in modelsCatalog."<>"\n"<>
					   "processModels[modelsCatalog, modelsExtraInfo] uses modelsExtraInfo to pre-solve parts of the model and to provide bounds or initial estimates for parts of the model that are not pre-solved.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];

$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];


(* ::Subsection:: *)
(*processModels*)


(*processModels//Options = {};*)


processModels[
	modelsCatalog_Association,
	modelsExtraInfo_Association:<||>,
	opts:OptionsPattern[{(*processModels,*) updateCoeffs, getStartingValues, FindRoot, RecurrenceTable}]
]:=
	Module[
	{
		keys=Keys[modelsCatalog],
		models = KeyMap[Replace[#, Thread[Keys[modelsCatalog]->Values@(#["shortname"]&/@modelsCatalog) ] ]&,modelsCatalog],(*rename Keys to shortname*)		
		contextPath=$ContextPath,
		i,
		modelAssumptions,
		(*optsSol,*)
		maxMomentOrder,
		maxSolveTime
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
	
	(*parameters that can be changed for each model*)
	models = Append[
			#,
			"params" -> Complement[#["parameters"], #["assignParam"]]
	]& /@ models;
	
	(*add assumptions*)
	modelAssumptions = FernandoDuarte`LongRunRisk`Model`Parameters`Private`paramAssumptions && 
		FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`endogEqAssumptions;
	models=(Append[#, "modelAssumptions"->(modelAssumptions//.#["assignParam"]//.#["assignParamStocks"]) ]&) /@models;

	(*add "exogenousVars","exogenousEq" to each model*)
	models = createExogenous[models];
	
	(*add "exogenousVarsNonZero","exogenousEqNonZero" to each model*)
	models = createExogenousNonZero[models];
	
	(*add "endogenousVars","endogenousEq" to each model*)
	models = createEndogenous[models];
	
	(*add lists of endogenous and exogenous variables that do not end in "eq" for convenience of end user*)
	models = Append[
		#,
		"exogenousVarsNames" -> Map[(StringDrop[#,-2]&),#["exogenousVars"]]
	]& /@ models;
	
	models = Append[
		#,
		"exogenousVarsNonZeroNames" -> Map[(StringDrop[#,-2]&),#["exogenousVarsNonZero"]]
	]& /@ models;
	
	models = Append[
		#,
		"endogenousVarsNames" -> Map[(StringDrop[#,-2]&),#["endogenousVars"]]
	]& /@ models;
	
	(*add mapping to make expressions only a function of state variables*)
	models = Append[
		#,
		"toStateVars" -> addToStateVars[#]
	]& /@ models;

	(*add unconditional moments of state variables*)
	maxMomentOrder=4;
	maxSolveTime = 20; (*try Solve for maxSolveTime seconds before switching to solveSystemRecursively*)
	models = Append[#,
		"uncondMomOfStateVars"-> 
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`solveSystem[maxMomentOrder, #, maxSolveTime]
	]&/@models; (*leaks global t*)
Echo["uncondMomOfStateVars","Done"];

	(*add expressions for some unconditional moments*)
	models = Append[
		#,
		"ratioUncondE" -> <| 
			"wc"->Simplify@uncondE[wc[t],#],
			"pd"->Simplify@uncondE[pd[t,j],#],
			"bond"->Simplify@uncondE[bond[t,m],#],
			"nombond"->Simplify@uncondE[nombond[t,m],#]
		|>
	]& /@ models;
Echo["uncondE","Done"];

	(*add Euler equations*)
	models=Append[
		#,
		addCoeffsSystem[#]
	]&/@models;
Echo["addCoeffsSystem","Done"];

	(*add from FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo*)
	models = Append[
		#,
		"extraInfo" -> If[KeyExistsQ[modelsExtraInfo,#["shortname"]],modelsExtraInfo[#["shortname"]],<||>]
	]& /@ models;
Echo["extraInfo","Done"];

	models = Append[
		#,
		"coeffsSolution" -> <| 
			"wc" -> addCoeffsSolution[#,"wc",opts],
			"pd" -> addCoeffsSolution[#,"pd", opts],
			"bond" -> addCoeffsSolution[#,"bond", opts],
			"nombond" -> addCoeffsSolution[#,"nombond", opts]
		|>
	]& /@ models;
Echo["addCoeffsSolution","Done"];

	(*add numerical solution to coeffsSolution when using model["params"]*)
	models = Append[
		#,
		"coeffsSolutionN" -> addCoeffsSolutionN[#]
	]& /@ models;
Echo["addCoeffsSolutionN","Done"];
		
	(*add a list of existing Keys called Properties*)
	models=Append[
		#,
		"Properties" -> Keys[#]
	]&/@models;	
	
	(*restore $ContextPath to initial state*)
	$ContextPath=contextPath;

	(*restore original keys and output models*)
	models = KeyMap[Replace[#,Thread[Keys[models]->keys]]&,models]
]


(* ::Subsection:: *)
(*createExogenous*)


createExogenous[m_]:=Module[
	(*adds exogenous variables and equations to each model in m*)
	{
		models=m,
		exoExprAssignParam,
		funTemplate,
		matchSymbol,
		exoExprMatchSymbol,
		exo
	},
	Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
	With[
		{
			argsPattern = Cases[DownValues[#][[;;,1]],Verbatim[HoldPattern][Verbatim[Symbol@#][vars__]]:>vars]&/@$exogenousVars,
			funs = DownValues[#][[;;,2]][[1]]&/@$exogenousVars
		}
		,
		(*plug in parameters that are assumed fixed (most are fixed to 0 or 1)*)
		exoExprAssignParam=(funs//.#["assignParam"]//.#["assignParamStocks"])& /@models;
		
		(*arrange as anonymous function with the right arguments*)
		funTemplate[fun_,argPatt_] := ( {##} /. (argPatt :> fun) )&;
		Attributes[matchSymbol]={Listable};
		matchSymbol[var_String]:= (_Symbol?((SymbolName[#]===var)&)); (*pattern to match symbols in any Context*)
		exoExprMatchSymbol = matchSymbol/@FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`$exogenousVarsPrivate;
		exo[shortname_String]:=Association@MapThread[#1->funTemplate[##2]&,{exoExprMatchSymbol,exoExprAssignParam[shortname],argsPattern}];

		(*append to models*)
		models=Append[
			#,
			"exogenousVars"->$exogenousVars
		]& /@ models;
		
		models=Append[
			#,
			"exogenousEq"->exo[#["shortname"]]
		]& /@models
	]
]	


(* ::Subsection:: *)
(*createExogenousNonZero*)


createExogenousNonZero[m_]:=Module[
	(*adds exogenous variables and equations to each model in m after removing those that are always 0*)
	{
		models=m,
		exoExprAssignParam,
		indicesKeep,
		argsPatternKeep,
		funsKeepList,
		funsKeep,
		exoExprKeep,
		exoVarKeep,
		funTemplate,
		exo,
		matchSymbol,
		exoExprMatchSymbol
	},
	Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
	With[
		{
			argsPattern = Cases[DownValues[#][[;;,1]],Verbatim[HoldPattern][Verbatim[Symbol@#][vars__]]:>vars]&/@$exogenousVars,
			funs = DownValues[#][[;;,2]][[1]]&/@$exogenousVars(*,
			posPi=Position[$exogenousVars,"pieq"]*)
		}
		,
	
		(*plug in parameters that are assumed fixed (most are fixed to 0 or 1)*)
		exoExprAssignParam=(funs//.#["assignParam"]//.#["assignParamStocks"])& /@models;
		
		(*find indices of exogenous variables that are not identically 0, except for inflation, which is needed to compute nominal variables even if always zero*)
		(*indicesKeep=Union[posPi,
			Complement[
				Thread[{Range @ Length @ #}],
				Position[#,0]
			]
		]& /@exoExprAssignParam;*)
		
		indicesKeep=Complement[
			Thread[{Range @ Length @ #}],
			Position[#,0]
		]& /@exoExprAssignParam;
		
		(*keep args, funs for variables with position indicesKeep*)
		argsPatternKeep=Extract[argsPattern,#]&/@indicesKeep;
		funsKeepList=MapApply[Extract,{Values@exoExprAssignParam,Values@indicesKeep}\[Transpose]];
		funsKeep=Association@Thread[Keys@exoExprAssignParam->funsKeepList];
		
		(*get names of all exogenous variables and keep those not identically 0*)
		exoExprKeep=Extract[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`$exogenousVarsPrivate,#]&/@indicesKeep;
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
			"exogenousVarsNonZero"->exoVarKeep[#["shortname"]]
		]& /@ models;
		models=Append[
			#,
			"exogenousEqNonZero"->exo[#["shortname"]]
		]& /@models
	]
]	


(* ::Subsection:: *)
(*createEndogenous*)


createEndogenous[mod_]:=Module[
	(*adds $endogenous variables and equations to each model in m*)
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
				(matchSymbol/@endogUpValuesVar) -> ((funTemplate[#]&/@endog[#["stateVars"]])//.#["assignParam"]//.#["assignParamStocks"])
			],
			Thread[
				(matchSymbol/@endogRestVar) -> MapApply[funTemplate,{funs,argsPattern}\[Transpose]]
			]
		]
	]& /@models
	
]	


(* ::Subsection:: *)
(*addToStateVars*)


addToStateVars[model_]:=With[
	{
		stateVars = DeleteDuplicates[DeleteCases[Cases[Variables[model["stateVars"][t] ],x_[_]:>x],0]],
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]]
	},
	With[
		{
			stateVarsNoEps = Complement[stateVars,Cases[stateVars,x_Symbol?(MatchQ[SymbolName[#],"eps"]&)[y___]:>x[y],Infinity,Heads->True]]
		},
		(*Cases[mapAll,Rule[a_,b_]/;FreeQ[a,Alternatives@@SymbolName/@(Head/@(Flatten@stateVarsNoEps))]]*)
		Cases[mapAll,Rule[a_,b_]/;FreeQ[a,Alternatives@@(SymbolName/@stateVarsNoEps)]]
	]
]


(* ::Subsection:: *)
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
		ratiosUncondERulePd
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


(* ::Subsection:: *)
(*addCoeffsSolution*)


addCoeffsSolution[
	model_,
	ratio_String,
	opts : OptionsPattern[{updateCoeffs, getStartingValues, FindRoot, RecurrenceTable}]]:=With[
	{
		cs = model["coeffsSystem"][ratio],
		shortname = model["shortname"],
		numStocks = model["numStocks"],
		ratioUncondE=model["ratioUncondE"][ratio],
		infoModel = model["extraInfo"]
	},
	With[
		{
			getStartingValuesOpts=FilterRules[Flatten[{opts}],Options[getStartingValues]],
			findRootOpts=Sequence@@Flatten[{
				Evaluate[
					FilterRules[
						Flatten@{opts},
						Options[FindRoot]
					]
				],
				Evaluate[
					First@OptionValue[updateCoeffs,Flatten@{opts}, {"FindRootOptions"}]
				],
				Evaluate[
					First@OptionValue[updateCoeffs, {"FindRootOptions"}]
				]
			}],
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
				coeffInfoSol
			},
			If[
				(*infoModel has coefficients in closed form*)
				KeyExistsQ[infoModel,"coeffs"] && KeyExistsQ[infoModel["coeffs"],ratio]
				,
				(*use the closed form to make the system of equations smaller*)
				coeffInfo=infoModel["coeffs"][ratio];(*Join[infoModel["coeffs"][ratio],If[ratio==="wc",{},infoModel["coeffs"]["wc"]]];*)
				solvedQ=Quiet[Simplify[#,Assumptions->n>=1 && Element[n,Integers],TimeConstraint->{5,15}]&/@(system[[2;;-1]]//.coeffInfo/.dependentParameters),Simplify::gtime];
				notSolvedQ=Not/@(BooleanQ/@solvedQ);
				If[
					(*if not all equations are solved*)
					Not@(And@@(TrueQ/@solvedQ))
					,
					(*try again for unsolved equations by substituting out gamma*)
					solvedQ=With[
						{
							solvedQgamma=Quiet[Simplify[#,Assumptions->n>=1 && Element[n,Integers],TimeConstraint->{5,15}]&/@(Pick[system[[2;;-1]],notSolvedQ]//.coeffInfo//.FernandoDuarte`LongRunRisk`Model`Parameters`gamma->(1+(-1+1/FernandoDuarte`LongRunRisk`Model`Parameters`psi) FernandoDuarte`LongRunRisk`Model`Parameters`theta)),Simplify::gtime]
						},
						ReplacePart[solvedQ,Thread[Position[notSolvedQ,True]->solvedQgamma]]
					];
					notSolvedQ=Not/@(BooleanQ/@solvedQ);
				];
				
				If[
					(*if the closed form coefficients from infoModel make some equation not hold*)
					AnyTrue[Not/@solvedQ,TrueQ]
					,
					(*don't use the closed form and solve entire system numerically*)
					coeff::badextrainfo;
					solveNumericQ = True;
					,
					(*incorporate closed form into system of equations*)
					{eq,coefficientNames,coeffInfo}=With[
						{
							(*remove equations that are already solved when plugging in closed form coefficients*)
							eqLocal=Flatten@{(First@system)//.coeffInfo,Pick[solvedQ,notSolvedQ]}
						}
						,
						With[
							{
								(*find coefficients without a closed form solution that still need to be solved for*)
								coefficientNamesLocal=DeleteDuplicates@Cases[eqLocal,unknowns[[1]][[0]][_Integer],{-2}],
								unknownsNotSolved=Pick[Rest@unknowns,notSolvedQ]
							},
							 With[
								{
									coeffInfoLocal=Normal@KeyDrop[coeffInfo,unknownsNotSolved]
								},
								If[
									(*number of eq and number of remaining unknowns not equal*)
									Length[eqLocal]==Length[coefficientNamesLocal]
									,
									(*use closed form*)
									{
										eqLocal,
										coefficientNamesLocal,
										coeffInfoLocal
									}
									,
									(*don't use the closed form for equations that cannot be symbollically verified to be solved*)
									{
										Flatten@{(First@system)//.coeffInfo,Pick[Rest@system,notSolvedQ]//.coeffInfoLocal},
										Prepend[unknownsNotSolved, First@unknowns],
										coeffInfoLocal
									}
								](*If*)
							](*With*)
						](*With*)
					](*With*)
				](*If*)
				,
				(*solve entire system numerically*)
				solveNumericQ = True;
			](*If*);
			x = If[
				solveNumericQ,
				(*solve entire system numerically*)
				eq=system;
				coefficientNames=unknowns;
				coeffInfo = {};			
				If[
					StringMatchQ[ratio,"wc"|"pd"],
					createStartingPoint[
						coefficientNames,
						ratioUncondE,
						False,(*stocksSolvedQ*)
						numStocks,
						KeyDrop[infoModel,"coeffs"],
						getStartingValuesOpts
					],
					cs[[3]]
				]
				,
				(*solve a subset of the system numerically, use closed form solution for the rest*)
				If[
					StringMatchQ[ratio,"wc"|"pd"],
					createStartingPoint[
						coefficientNames,
						ratioUncondE,
						False,(*stocksSolvedQ*)
						numStocks,
						infoModel,
						getStartingValuesOpts
					],
					Flatten@{(First@(cs[[3]]))//.coeffInfo,Pick[Rest@(cs[[3]]),notSolvedQ]}
				]
			];
			coeffInfoSol = Normal@ReplaceRepeated[Association@coeffInfo,coeffInfo];
			Switch[
				ratio
				,
				"wc"
				,
				{
					Inactive[MapThread][
						Inactive[FindRoot][
							Inactive[N][#1],
							Inactive[N][#2],
							Evaluate@findRootOpts
						]&,
						{{eq}, x}
					],
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
							checkFindRoot,
							mapFindRoot,
							dropTrue
						},
						checkFindRoot[x___]:= Quiet[Check[FindRoot[x],Nothing, {FindRoot::reged}],{FindRoot::reged}];
						mapFindRoot[x1_,x2_,x3___]:=checkFindRoot[x1,#,x3]&/@x2;
						dropTrue[expr_]:=Select[expr,Not[TrueQ[#]]&];
						{
							Inactive[MapThread][
								Inactive[mapFindRoot][
									Inactive[dropTrue][Inactive[N][#1]],
									Inactive[N][#2],
									Evaluate@findRootOpts
								]&,
								{eq  /. ({j->#}&/@Range[numStocks]), x}
							],
							coeffInfoSol /. ({j->#}&/@Range[numStocks])
						}
					]
				](*With*)
				,
				"nombond"|"bond"
				,
				With[
					{						
(*						P =(First@unknowns)[[0,0]],*)
						remainingUnknowns=Complement[unknowns,coefficientNames]
					},
					With[
						{
							recurrenceTableOpts=Flatten[{
								Evaluate[FilterRules[Flatten@{opts}, Options[RecurrenceTable]]],
								Evaluate[First@OptionValue[addCoeffsSolution,{"RecurrenceTableOptions"}]]
							}],
							bondCoefficientRules=unknowns /. (x_[n][j_Integer] :> RuleDelayed[x[m_][j], Symbol["`Private`"<>(SymbolName@x)<>IntegerString[j]][m]])
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
							solBondNum[maxMaturity_]:=Inactive[RecurrenceTable][
								Flatten[
									{
										bondRecursionPerturbation,
										x
									}
								]/.bondCoefficientRules,
								coefficientNames/.bondCoefficientRules,
								{n,0,maxMaturity},
								recurrenceTableOpts
							];					
							solNum[maxMaturity_]:=With[{coefficientNamesLocal=coefficientNames},Inactive[MapIndexed][Inactive[Thread][(coefficientNamesLocal/.n->(First@#2-1))->#1]&,solBondNum[maxMaturity]]];
							solInfo[maxMaturity_]:= If[remainingUnknowns==={},Inactive[ConstantArray][{},maxMaturity+1],Inactive[Prepend][Inactive[Table][Inactive[Thread][remainingUnknowns->(remainingUnknowns/.coeffInfoSol)]/.n->m,{m,1,maxMaturity}],Complement[cs[[3]],x]/.Equal->Rule]];
							{
								maxMaturity|->Evaluate@solNum[maxMaturity],
								maxMaturity|->Evaluate@solInfo[maxMaturity]
							}
						](*Module*)
					](*With*)
				](*With*)
			](*Switch*)
		](*Module*)
	](*Which*)
](*Which*)


(* ::Subsubsection:: *)
(*createStartingPoint*)


createStartingPoint::coeffswc = "infoModel[\"modelAssumptions\"] requires values of the wealth-consumption ratio
coefficients to be provided as an association with key \"coeffsSolution\" in opts, e.g., 
opts={ \"coeffsSolution\"-> <|\"wc\"-> {A[0]\[Rule]4.59,A[1],...}|>}";


createStartingPoint[
	coefficientNames_,
	ratioUncondE_,
	stocksSolvedQ:_?BooleanQ:False,
	numStocks_Integer:1,
	infoModel_Association:<||>,
	opts : OptionsPattern[{getStartingValues}]
]:=With[
	{
		ratio = If[FreeQ[coefficientNames,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc],"pd","wc"]
	},
	With[
		{
			iEv = "E"<>ratio,
			startValues=formatStartingValues[
				coefficientNames,
				ratioUncondE,
				stocksSolvedQ,
				numStocks,
				infoModel,
				FilterRules[Flatten@{opts},Options[getStartingValues]]
			]
		},		
		Module[{out},
			Catch[
				With[
					{
						dimStartValues=Dimensions@startValues
					},
					If[
						StringMatchQ[ratio,"pd"] && (*createStartingPoints for stocks*)
						Not[stocksSolvedQ] &&  (*"stocksSolvedQ" is used as an internal state that indicates createStartingPoint has already been run for stocks*)
						MatchQ[ First@dimStartValues, numStocks] && MatchQ[Length@coefficientNames, dimStartValues[[2]]] (*dimensions of startValues are correct*)
						,
						out=With[
							{
								j=Last@Head@First@coefficientNames
							},
							MapIndexed[
								createStartingPoint[
									coefficientNames /. j -> (First@#2),
									ratioUncondE /. j -> (First@#2),
									True,(*stocksSolvedQ=True*)
									numStocks,
									infoModel /. j -> (First@#2),
									{"initialGuess" -> <|"Epd" -> Take[#1,1,-1] |>, "stocksSolvedQ" -> True}
								]&,
								startValues
							](*MapIndexed*)
						];(*With*)
						Throw[out];
					];(*If*)
				];(*With*)		
				With[
					{
						guessFirst = (Flatten@First@startValues)/.x_Symbol?(MatchQ[SymbolName[#],"Epd0"]&):>x[Last@Head@First@coefficientNames],
						restStartValues=Rest@startValues
					},
					With[
						{
							guessFirstValues = Rest@guessFirst,
							coeff0 = First@coefficientNames
						},
						Module[
							{
								boundsGuess0,
								boundsInfo0,
								bounds0,
								guess0,
								lb,
								ub,
								intervals0
							},
							boundsGuess0=Switch[
								Length[guessFirstValues],
								1, True,
								2, Inequality[guessFirstValues[[1]],LessEqual,coeff0,LessEqual,guessFirstValues[[2]]],
								3, Inequality[guessFirstValues[[2]],LessEqual,coeff0,LessEqual,guessFirstValues[[3]]]
							];		
							(*combine with assumptions*)	
							boundsInfo0=If[
								KeyExistsQ[infoModel,"modelAssumptions"] && KeyExistsQ[infoModel["modelAssumptions"],iEv]
								,
								infoModel["modelAssumptions"][iEv]
								,
								True
							];
							bounds0= Inactive[Reduce][Inactive[Simplify][boundsGuess0 && boundsInfo0 && 0 < coeff0 < 15], coeff0, Reals];
							intervals0= With[
								{
									coeff0Local=coeff0,
									fv=First@guessFirstValues,
									intervalPattern=Alternatives@@((Inequality[lb_?NumberQ,#[[1]],coeff0,#[[2]], ub_?NumberQ])&/@Tuples[{Less,LessEqual},2])
								},
								Inactive[Cases][bounds0,intervalPattern :> {coeff0Local,Inactive[If][Inactive[TrueQ][lb<=fv<=ub],fv,(lb+ub)/2],lb,ub},{0,1}]
							];
							guess0=Inactive[If][
								Inactive[SameQ][{}, intervals0],
								(*if assumptions do not give an interval, use provided initial guess*)
								{guessFirst},
								(*if assumptions do give an interval, use it*)
								intervals0
							];
							With[{restStartValuesLocal=restStartValues},Inactive[Map][Join[{#},restStartValues]&, guess0]]
						](*Module*)
					](*With*)
				](*With*)
			](*Catch*)
		](*Module for stocks*)
	](*With*)
](*With*)


(* ::Subsubsection:: *)
(*formatStartingValues*)


formatStartingValues::badformat = "The format of `1` for starting points is incorrect. Try setting starting points using the optional argument {\"initialGuess\" -> \[LeftAssociation]\"Ewc\"\[Rule]{4.5},\"Epd\"\[Rule]{{4.5}}\[RightAssociation]}.";


formatStartingValues[
	coefficientNames_List,
	ratioUncondE_,
	stocksSolvedQ:_?BooleanQ:False,
	numStocks_Integer:1,
	Longest[infoModel_Association:<||>],
	opts : OptionsPattern[{getStartingValues}]
]:=With[
	{
		ratio = If[FreeQ[coefficientNames,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc],"pd","wc"],
		pattern1 = (VectorQ[#(*,NumberQ*)] && 1<=Length[#]<=3)&,
		pattern2 = { {_?(Not@NumberQ[#]&),Repeated[_(*?NumberQ*),{1,3}]}..}
	},
	With[
		{
			pattern3 = (ListQ[#] && pattern1[First@#] && MatchQ[Rest@#, {} | pattern2])&
		},
		Module[
			{
				ig = getStartingValues[ratio,infoModel,opts]
			},
			(*if user provided a single set of starting values but there are more stocks, use the same starting value for all stocks*)
			ig = If[
					(ratio==="pd") && (numStocks>(First@(Dimensions@ig))) && (Not@stocksSolvedQ),
					ConstantArray[First@ig,numStocks],
					ig
				];
			Module[{out},
				Catch[
					If[
						StringMatchQ[ratio,"pd"] && 
						Not[stocksSolvedQ] && (*"stocksSolvedQ" is used as an internal state that indicates formatStartingValues has already been run for stocks*)
						And@@((pattern1[#] || (ListQ[#] && MatchQ[#, pattern2]) || pattern3[#])& /@ig) (*dimensions are correct*)
						,
						out=With[
							{
								j=Last@Head@First@coefficientNames
							},
							MapIndexed[
								formatStartingValues[
									coefficientNames /. (j -> (First@#2)), 
									ratioUncondE /. (j -> (First@#2)),
									True,(*stocksSolvedQ*)
									numStocks,
									infoModel/. (j -> (First@#2)),
									{"initialGuess" -> <|"Epd" -> {#1}|>}
								]&,ig
							]
						];
						Throw[out];
					];
					With[
						{
							firstIg = First@ig,
							restIg = Rest@ig
						},
						With[
							{
								firstNames = First@coefficientNames,
								restNames = Rest@coefficientNames
							},
							Which[
								(*a number or a vector of up to three elements*)
								(*NumberQ[ig] || (VectorQ[ig,NumberQ] && 1<=Length[ig]<=3)*)
								NumberQ[ig] || pattern1[ig]
								,
								(*wrap ig in list, add zeros for all other variables*)
								If[
									Length[ig]===2,
									Join[{Flatten@{firstNames,Mean@ig,ig}},Thread[{#,0}]&/@restNames],
									Join[{Flatten@{firstNames,ig}},Thread[{#,0}]&/@restNames]
								]
								,
								(*a list of lists, with sublists having 1 to 3 numbers as their last entries*)
								(*ListQ[ig] && MatchQ[ig, { {_?(Not@NumberQ[#]&),Repeated[_?NumberQ,{1,3}]}..}]*)
								ListQ[ig] && MatchQ[ig, pattern2]
								,
								(*reformat to only include coefficients that are being solved for and fix the context of the coefficients if needed*)
								Join[{Flatten@{firstNames,Rest@(firstIg)}},formatStartingValuesRest[restIg,restNames]]
								,
								(*ListQ[ig] && (NumberQ[firstIg]||(VectorQ[firstIg,NumberQ]&&1<=Length[firstIg]<=3))  &&  MatchQ[restIg, {} | { {_?(Not@NumberQ[#]&),Repeated[_?NumberQ,{1,3}]}..}]*)
								pattern3[ig]
								,
								Module[
									{
										guessRest,
										guessRules,
										guessFirst,
										keys,
										values,
										uncondERatio
									},
									guessRest=formatStartingValuesRest[restIg,restNames];
									guessRules = MapThread[#1 -> If[Length[#2]==2,Mean[#2],#2[[1]]]&,{First/@guessRest,Rest/@guessRest}];
									guessFirst=Solve[(ratioUncondE/.guessRules)==uncondERatio,firstNames,Reals];
									keys = Keys[guessFirst];
									values = Switch[
										Length[firstIg],
										1,
											Values@(guessFirst/.uncondERatio->First@firstIg),
										2,
											Join[Values@(guessFirst/.uncondERatio->Mean@firstIg),Sort@@@(Values@(guessFirst/.(uncondERatio->(firstIg)))),2],
										3,
											Join[Values@(guessFirst/.uncondERatio->First@firstIg),Sort@@@(Values@(guessFirst/.(uncondERatio->(Rest@firstIg)))),2]
									];
									Join[Join[keys,values,2],guessRest]
								](*Module*)
								,
								(*all other cases*)
								True
								,
								(Message[formatStartingValues::badformat,ig]; Abort[])
							](*Which*)
						](*With*)
					](*With*)
				](*Catch for stocks*)
			](*Module for stocks*)
		](*Module*)
	](*With*)
](*With*)



(* ::Subsubsection:: *)
(*formatStartingValuesRest*)


formatStartingValuesRest[startingValuesRest_,coefficientNamesRest_List]:=Module[
	{
		all,
		guess,
		inter,
		overlapAll,
		overlapGuess,
		overlapNames,
		noOverlapNames,
		noOverlapNamesGuess,
		overlapNamesGuess
	},
	all=ReplaceAll[coefficientNamesRest, ( a_[j__] | a_)[ind_] :> {SymbolName@a,If[j===Sequence ,Nothing,Switch[ Head[j],Symbol,SymbolName@j,Integer,IntegerString@j,_,ToString@j]],ind}];
	guess=Replace[First/@startingValuesRest, ( a_[j__] | a_)[ind_] :> {SymbolName@a,If[j===Sequence ,Nothing,Switch[ Head[j],Symbol,SymbolName@j,Integer,IntegerString@j,_,ToString@j]],ind},{1}];
	inter=Intersection[all,guess];
	overlapAll=PositionIndex[all][#]&/@(Keys@PositionIndex[inter]);
	overlapGuess=PositionIndex[guess][#]&/@(Keys@PositionIndex[inter]);
	overlapNames=Extract[coefficientNamesRest,overlapAll];
	noOverlapNames = Complement[coefficientNamesRest,overlapNames];
	noOverlapNamesGuess=Thread[{#,0}]&/@noOverlapNames;
	overlapNamesGuess=MapIndexed[Join[overlapNames[[#2]],Rest@#1]&,Extract[startingValuesRest,overlapGuess]];
	SortBy[Join[overlapNamesGuess,noOverlapNamesGuess],First]
]


(* ::Subsubsection:: *)
(*getStartingValues*)


getStartingValues//Options={
	"initialGuess" -> <|"Ewc"->{4},"Epd"->{{4}}|>
};


getStartingValues[
	ratio_String,
	infoModel_Association:<||>,
	opts : OptionsPattern[{getStartingValues}]
]:=With[
	{
		iEv = "E"<>ratio,
		ig = First@OptionValue[getStartingValues,Flatten@{opts},{"initialGuess"}]
	},
	(*get initial guess from the places where it can be provided*)
	Which[
		(*optional argument in function call or default option, but only if non-empty*)
		And[
				KeyExistsQ[ig,iEv],
				Not[SameQ[ig,{}]] || Not[SameQ[ig[iEv],{}]
			]
		]
		,
		ig[iEv],
		(*modelsExtraInfo[modKey]["initialGuess"] in Catalog.wl*)
		KeyExistsQ[infoModel,"initialGuess"] && KeyExistsQ[infoModel["initialGuess"],iEv]
		,
		infoModel["initialGuess"][iEv],
		(*a number*)
		True
		,
		Switch[ratio,"wc",{4},"pd",{{4}}]
	]
]


(* ::Subsection:: *)
(*addCoeffsSolutionN*)


addCoeffsSolutionN[model_]:=With[
	{
		modelInfo=model["extraInfo"],
		params=model["params"],
		maxMaturity = 120,
		numStocks = model["numStocks"]
	},
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
	Ewc0 = getStartingValues["wc",modelInfo,"initialGuess" -> {}];
	Epd0 = getStartingValues["pd",modelInfo,"initialGuess" -> {}];
	Epd0j=Table["Epd0["<>IntegerString[j]<>"]"->First@(Epd0[[j]]),{j,1,numStocks}]/.Table->Sequence;
	solWc=FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsWc[model["coeffsSolution"]["wc"],params,{},"Ewc0"->Sequence[First@Ewc0],MaxIterations->1000];
	solPd=FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsPd[model["coeffsSolution"]["pd"],params,{},solWc,Epd0j,MaxIterations->1000];
	solBond=FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[model["coeffsSolution"]["bond"],params,{},maxMaturity,solWc];
	solNomBond=FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[model["coeffsSolution"]["nombond"],params,{},maxMaturity,solWc];
	Flatten@Join[solWc,solPd,solBond,solNomBond]
]


(* ::Section::Closed:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
