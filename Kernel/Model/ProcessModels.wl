(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]


(* ::Subsection:: *)
(*Public symbols*)


processModels


(* ::Subsubsection:: *)
(*Usage*)


processModels::usage = "processModels[modelsCatalog] performs symbolic processing on models, adding coefficient systems and solutions.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
Needs["FernandoDuarte`LongRunRisk`Tools`Logging`"];

$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];


(* ::Subsection:: *)
(*processModels*)


(*processModels//Options = {};*)


processModels[
	modelsCatalog_Association,
	opts:OptionsPattern[{solveCoeffsSystem, updateCoeffs, getStartingValues, FindRoot, RecurrenceTable}]
]:=
	Module[
	{
		keys=Keys[modelsCatalog],
		models = KeyMap[Replace[#, Thread[Keys[modelsCatalog]->Values@(#["shortname"]&/@modelsCatalog) ] ]&,modelsCatalog],(*rename Keys to shortname*)
		contextPath=$ContextPath,
		modelAssumptions,
		maxMomentOrder,
		maxSolveTime
	},
	(* add default empty extraInfo if not present *)
	models = If[KeyExistsQ[#, "extraInfo"], #, Append[#, "extraInfo" -> <||>]]& /@ models;

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
	modelAssumptions = Module[{divParam, restParam, param},
	divParam=FernandoDuarte`LongRunRisk`Model`Parameters`Private`paramList["Real dividend growth"]/.x_[1]:>x[_];
	restParam=Values[KeyDrop[FernandoDuarte`LongRunRisk`Model`Parameters`Private`paramList,"Real dividend growth"]];
	param=Flatten@{divParam,restParam};
	(And @@ (Element[#, Reals] & /@param)) && 
		FernandoDuarte`LongRunRisk`Model`Parameters`Private`paramAssumptions &&
		FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`endogEqAssumptions &&
		psi!=1 && theta!=1 && gamma!=1
	];
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
	maxMomentOrder=4;(*4;*)
	maxSolveTime = 2;(*20;*) (*try Solve for maxSolveTime seconds before switching to solveSystemRecursively*)
	models = LRRTimed[
		Append[#,
			"uncondMomOfStateVars"->
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`solveSystem[
					maxMomentOrder,
					#,
					maxSolveTime
				]
		]&/@models,
		"uncondMomOfStateVars"
	]; (*leaks global t*)

	(*add expressions for some unconditional moments*)
	models = LRRTimed[
		Append[
			#,
			"ratioUncondE" -> <|
				"wc"->Simplify@uncondE[wc[t],#],
				"pd"->Simplify@uncondE[pd[t,j],#],
				"bond"->Simplify@uncondE[bond[t,m],#],
				"nombond"->Simplify@uncondE[nombond[t,m],#]
			|>
		]& /@ models,
		"uncondE"
	];

	(*add Euler equations*)
	models = LRRTimed[
		Append[
			#,
			addCoeffsSystem[#]
		]&/@models,
		"addCoeffsSystem"
	];

	(* simplify Euler equations *)
	models = LRRTimed[
	  (
	    Module[{m = #, simpl = simplifyCoeffsSystem[# , TimeConstraint -> {1,5}]},
	      m[["coeffsSystem", "wc", 1, 2 ;; -1]] = simpl[[1]];
	      m[["coeffsSystem", "pd", 1, 2 ;; -1]] = simpl[[2]];
	      m
	    ]
	  ) & /@ models,
	  "simplifyCoeffsSystem"
	];

	(*solve, simplify solution, create nonlinear equations for mean of wc and pd*)
	models = LRRTimed[
		Append[
			#,
			solveCoeffsSystem[#,
				"PdEquations" -> OptionValue[solveCoeffsSystem, Flatten@{opts}, "PdEquations"]
				,
				TimeConstraint->{1,5}
			]
		]&/@models,
		"solveCoeffsSystem"
	];

	(*add from FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo*)
	models = LRRTimed[
		Append[
			#,
			"extraInfo" -> If[KeyExistsQ[modelsExtraInfo,#["shortname"]],modelsExtraInfo[#["shortname"]],<||>]
		]& /@ models,
		"extraInfo"
	];

	(*create recursions for bonds*)
	models = LRRTimed[
		With[{addCoeffsOpts = FilterRules[Flatten@{opts}, Options[addCoeffsSolution]]},
			Append[
				#,
				"coeffsSolution" -> <|
					"bond" -> addCoeffsSolution[#,"bond", Sequence @@ addCoeffsOpts],
					"nombond" -> addCoeffsSolution[#,"nombond", Sequence @@ addCoeffsOpts]
				|>
			]& /@ models
		],
		"addCoeffsSolution"
	];

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


(* ::Subsection::Closed:: *)
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


(* ::Subsection::Closed:: *)
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


(* ::Subsection::Closed:: *)
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


(* ::Subsection::Closed:: *)
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
(*simplifyCoeffsSystem*)


simplifyCoeffsSystem // Options = {
	"SimplifyOptions" -> {TimeConstraint -> {5, 300}}
};


simplifyCoeffsSystem[model_, opts : OptionsPattern[{solveCoeffsSystem, Simplify}]]:=With[
	{
		simplifyOpts = Flatten[{
          Evaluate @ FilterRules[Flatten@{opts}, Options[Simplify]],
          Evaluate @ OptionValue["SimplifyOptions"]
        }],
		modelCoeffsSys=model["coeffsSystem"]
	},
		With[
		{
			sysA = modelCoeffsSys["wc"][[1]][[2;;-1]],
			sysB = modelCoeffsSys["pd"][[1]][[2;;-1]],
			modelAssumptions=model["modelAssumptions"]
		},
		With[
		{
			assumeA=expandPatternAssumptions[sysA,modelAssumptions],
			assumeB=expandPatternAssumptions[sysB,modelAssumptions]
		},
				{
					Quiet[Assuming[assumeA, FullSimplify[sysA/. (1-gamma)/(1-1/psi)->theta, Sequence @@ simplifyOpts]],{FullSimplify::time}],
					Quiet[Assuming[assumeB, FullSimplify[sysB/. (1-gamma)/(1-1/psi)->theta, Sequence @@ simplifyOpts]],{FullSimplify::time}]
				}
		](*With*)
	] (*With*)
] (*With*)


(* ::Subsection:: *)
(*solveCoeffsSystem*)


solveCoeffsSystem // Options = {
	"SimplifyOptions" -> {TimeConstraint -> {5, 300}},
	"paramQuadSolveOptions" -> {},
	"PdEquations" -> "B"  (* "B" | "AB" | "Both" - controls which pd equations to compute *)
};


solveCoeffsSystem[model_, opts : OptionsPattern[{solveCoeffsSystem, Simplify}]]:=With[
	{
		simplifyOpts = Flatten[{
          Evaluate @ FilterRules[Flatten@{opts}, Options[Simplify]],
          Evaluate @ OptionValue["SimplifyOptions"]
        }],
        paramQuadSolveOpts=OptionValue["paramQuadSolveOptions"],
        modelCoeffsSys=model["coeffsSystem"]
	},
	With[
		{
			modelCoeffsSysWc = modelCoeffsSys["wc"],
			modelCoeffsSysPd = modelCoeffsSys["pd"]
		},
		With[
			{
				sysA = modelCoeffsSysWc[[1]][[2;;-1]],
				sysB = modelCoeffsSysPd[[1]][[2;;-1]],
				modelAssumptions=model["modelAssumptions"]
			},
			With[
				{
					assumeA=expandPatternAssumptions[sysA,modelAssumptions],
					assumeB=expandPatternAssumptions[sysB,modelAssumptions]
				},
				With[
					{
						varsA = modelCoeffsSysWc[[2]][[2;;-1]],
						varsB = modelCoeffsSysPd[[2]][[2;;-1]]
					},
					Module[
						{
							solA,
							solB,
							conditionsA,
							conditionsB
						},
						(*solve system of linear-quadratic equations for wc and pd coefficients*)
						(*Echo[sysA[[1]],"sysA1"];*)
						solA=paramQuadSolve[
							sysA,
							varsA,
							"SignSymbol" -> Symbol[
								"sign"<>SymbolName[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc]
							],
							Assumptions->assumeA,
							Sequence @@ paramQuadSolveOpts
						];
						(*Echo[solA[[1]],"solA1"];*)
						solB=paramQuadSolve[
							sysB,
							varsB,
							"SignSymbol" -> Symbol[
								"sign"<>SymbolName[Head@FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd]
							],
							Assumptions->assumeB,
							Sequence @@ paramQuadSolveOpts
						];
						If[FailureQ[solA] || FailureQ[solB],
							Return["coeffsParamQuadSolve" -> $Failed, Module]
						];
						(*Echo[solB[[1]],"solB1"];*)
						(*simplify conditions that guarantee real solutions*)
						conditionsA=Assuming[assumeA,FullSimplify[solA["Conditions"],Sequence @@ simplifyOpts]];
						conditionsB=Assuming[assumeB,FullSimplify[solB["Conditions"],Sequence @@ simplifyOpts]];
						solA["Conditions"]=assumeA && (And@@conditionsA);
						solB["Conditions"]=assumeB && (And@@conditionsB);

						(*Echo[solA["Conditions"][[1]],"solAConditions"];*)
						(*Echo[solB["Conditions"][[1]],"solBConditions"];*)
						(*simplify using assumptions*)
						solA["Solution"]=Quiet[Assuming[solA["Conditions"],Simplify[solA["Solution"],Sequence @@ simplifyOpts]],{Simplify::time}];
					    solB["Solution"]=Quiet[Assuming[solB["Conditions"],Simplify[solB["Solution"],Sequence @@ simplifyOpts]],{Simplify::time}];
						(*Echo[solA["Solution"][[1]],"solASolution"];*)
						(*Echo[solB["Solution"][[1]],"solBSolution"];*)
						(*try eliminating one of gamma, theta, psi and keep shortest expressions*)
						solA["Solution"]=tryTransforms[#,assumeA,Sequence @@ simplifyOpts]&/@solA["Solution"];
						solB["Solution"]=tryTransforms[#,assumeB,Sequence @@ simplifyOpts]&/@solB["Solution"];
						
						(*create non-linear equation for unconditional mean of wc and pd and unsolved coeffs*)
						With[
							{
								wcCoeffEq = modelCoeffsSysWc[[1,1]],
								pdCoeffEq = modelCoeffsSysPd[[1,1]],
								verifA = TrueQ/@ solA["Verification"],
								verifB = TrueQ/@ solB["Verification"]
							},
							With[
								{
									newSysA= Pick[sysA,verifA,False],
									newVarsA = Pick[varsA,verifA,False]
								},
								(*wc*)
								solA["varsA0"] = Prepend[newVarsA,modelCoeffsSysWc[[2,1]]];
								solA["eqA0"] = Assuming[
									assumeA,
									Quiet[FullSimplify[Prepend[newSysA,wcCoeffEq]/.solA["Solution"],Sequence @@ simplifyOpts],{FullSimplify::time}]
								];
							];
							With[
								{
									newSysB= Pick[sysB,verifB,False],
									newVarsB = Pick[varsB,verifB,False],
									pdMode = OptionValue["PdEquations"]
								},
								With[
									{
										eqB0=Prepend[newSysB,pdCoeffEq]/.solB["Solution"]
									},
									solB["pdMode"] = pdMode;
									solB["varsB0"] = Prepend[newVarsB,modelCoeffsSysPd[[2,1]]];
									(*pd without plugging in wc coeffs - only if needed*)
									If[MatchQ[pdMode, "B" | "Both"],
										solB["eqB0"] = Assuming[
											assumeB,
											Quiet[FullSimplify[eqB0,Sequence @@ simplifyOpts],{FullSimplify::time}]
										];
									];
									(*pd plugging in wc coeffs - only if needed*)
									If[MatchQ[pdMode, "AB" | "Both"],
										solB["eqAB0"] = Assuming[
											assumeB,
											Quiet[FullSimplify[eqB0/.solA["Solution"],Sequence @@ simplifyOpts],{FullSimplify::time}]
										];
									];
								]; (*With*)
							]; (*With*)
						]; (*With*)
						(*Echo[solA["eqA0"],"eqA0"];*)
						(*Echo[solB["eqB0"],"eqB0"];*)
						(*Echo[solB["eqAB0"],"eqAB0"];*)
						(*Echo[model["shortname"],"finishedcoeffsParamQuadSolve"]; *)
						"coeffsParamQuadSolve" -> <| 
							"wc" -> solA,
							"pd" -> solB
						|>
					](*Module*)
				](*With*)
			](*With*)
		] (*With*)
	] (*With*)
] (*With*)


(* ::Subsubsection::Closed:: *)
(*tryTransforms*)


tryTransforms // Options = {
	"SimplifyOptions" -> {TimeConstraint -> {5,300}}
};


tryTransforms[
	expr_,
	ass : Except[_List] : True,
	transforms : _List | Automatic : Automatic,
	opts : OptionsPattern[{tryTransforms, Simplify}]
] := Module[
	{
		actualTransforms,
		results
	},
	actualTransforms = If[
		transforms === Automatic,
		Flatten[Solve[(1-gamma)/(1-1/psi)==theta, #] & /@ {psi, gamma, theta}, 1],
		transforms
	];
	With[
		{
			simplifyOpts = Flatten[{
	          Evaluate @ FilterRules[Flatten@{opts}, Options[Simplify]],
	          Evaluate @ OptionValue["SimplifyOptions"]
	        }]
		},
		(*Echo[{opts},"tryTransformsopts"];
		Echo[simplifyOpts,"tryTransformssimplifyOpts"];
		Echo[actualTransforms,"tryTransformsactualTransforms"];
		Echo[expr,"tryTransformsexpr"];
		Echo[ass[[1]],"tryTransformsass"];*)
		results = Quiet[
			Table[
				Assuming[ass,Simplify[expr /. transform, Sequence @@ simplifyOpts]],
				{transform, actualTransforms}
			]
			,
			{Simplify::time}
		];
	];(*With*)
	(*Echo[results,"tryTransformsresults"];*)
	First[MinimalBy[results, LeafCount, 1]]
](*Module*)




(* ::Subsection:: *)
(*addCoeffsSolution*)


addCoeffsSolution::badextrainfo = "Closed-form coefficients from extra info did not validate; falling back to all-numerical solve.";


addCoeffsSolution[
	model_,
	ratio: "bond" | "nombond", 
	opts : OptionsPattern[{updateCoeffs, RecurrenceTable}]]:=With[
	{
		cs = model["coeffsSystem"][ratio],
		ratioUncondE=model["ratioUncondE"][ratio],
		infoModel = model["extraInfo"]
	},
	With[
		{
			system=cs[[1]],
			unknowns=cs[[2]],
			ic = cs[[3]],
			n=cs[[4]],
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
				coeffInfoSol,
				x
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
					Message[addCoeffsSolution::badextrainfo];
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
			{eq, coefficientNames, x, coeffInfo} = If[
		      solveNumericQ,
		      (* solve entire system numerically *)
		      {system, unknowns, ic, {}},
		      (* solve subset numerically, use closed form for rest *)
		      {eq, coefficientNames, Flatten@{(First@ic) //. coeffInfo, Pick[Rest@ic, notSolvedQ]}, coeffInfo}
		    ];
			coeffInfoSol = Normal@ReplaceRepeated[Association@coeffInfo,coeffInfo];
			With[
					{						
						(*P =(First@unknowns)[[0,0]],*)
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
							perturbation=If[posConstantCoeff==={},0,$MachineEpsilon*(First@Extract[coefficientNames,posConstantCoeff]/.(n->n-1))];
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
							solInfo[maxMaturity_]:= If[remainingUnknowns==={},Inactive[ConstantArray][{},maxMaturity+1],Inactive[Prepend][Inactive[Table][Inactive[Thread][remainingUnknowns->(remainingUnknowns/.coeffInfoSol)]/.n->m,{m,1,maxMaturity}],Complement[ic,x]/.Equal->Rule]];
							{
								maxMaturity|->Evaluate@solNum[maxMaturity],
								maxMaturity|->Evaluate@solInfo[maxMaturity]
							}
						](*Module*)
					](*With*)
				](*With*)
		](*Module*)
	](*With*)
](*With*)


(* ::Section::Closed:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
