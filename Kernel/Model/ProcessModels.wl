(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Model`ProcessModels`"];


(* ::Subsection:: *)
(*Public symbols*)


processModels


(* ::Subsubsection:: *)
(*Usage*)


processModels::usage = "processModels[modelsCatalog] performs symbolic processing on models, adding coefficient systems and solutions.\nAdds keys: exogenousEq, endogenousEq, coeffsSystem, coeffsSolution, toStateVars, and more.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Tools`Common`"];
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

$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];


(* ::Subsection:: *)
(*Helper functions*)



(* safeRest - safely extract all but first element, returns {} for invalid input *)
safeRest[list_List] := If[Length[list] >= 1, Rest[list], {}];
safeRest[_] := {};

(* safeVerification - safely convert Verification result to list of booleans.
   If verification returned $Failed/Missing/etc, return list of all False
   (meaning all vars are unverified and should be kept in the system).
   Takes the raw Verification value, expected length, and optional label, model name, and vars for warnings. *)
safeVerification[verif_List, len_Integer, _String : "", _String : "", _List : {}] := TrueQ /@ verif;
safeVerification[other_, len_Integer, label_String : "", modelName_String : "", vars_List : {}] := ConstantArray[False, len]


(* ::Subsection:: *)
(*processModels*)


(*processModels//Options = {};*)


processModels[
	modelsCatalog_Association,
	opts:OptionsPattern[{solveCoeffsSystem, updateCoeffs, FindRoot, RecurrenceTable}]
]:= Module[{
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
	models = EchoTiming[
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
	models = EchoTiming[
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
	models = EchoTiming[
		Append[
			#,
			addCoeffsSystem[#]
		]&/@models,
		"addCoeffsSystem"
	];

	(* simplify Euler equations *)
	models = EchoTiming[
	  (
	    Module[
	    {
		    m = #, simpl = simplifyCoeffsSystem[
			    #
			    (*,
			    TimeConstraint -> {1,5}*)
		    ]
	    },
	      m[["coeffsSystem", "wc", 1, 2 ;; -1]] = simpl[[1]];
	      m[["coeffsSystem", "pd", 1, 2 ;; -1]] = simpl[[2]];
	      m
	    ]
	  ) & /@ models,
	  "simplifyCoeffsSystem"
	];

	(*solve, simplify solution, create nonlinear equations for mean of wc and pd*)
	models = EchoTiming[
		Append[
			#,
			solveCoeffsSystem[#,
				"PdEquations" -> OptionValue[solveCoeffsSystem, Flatten@{opts}, "PdEquations"]
				(*,
				TimeConstraint->{1,5}*)
			]
		]&/@models,
		"solveCoeffsSystem"
	];

	(*add from FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo*)
	models = EchoTiming[
		Append[
			#,
			"extraInfo" -> If[KeyExistsQ[modelsExtraInfo,#["shortname"]],modelsExtraInfo[#["shortname"]],<||>]
		]& /@ models,
		"extraInfo"
	];

	(*create recursions for bonds*)
models = EchoTiming[
	With[{addCoeffsOpts = FilterRules[Flatten@{opts}, Join[Options[updateCoeffs], Options[RecurrenceTable]]]},
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
			sysA = safeRest[modelCoeffsSys["wc"][[1]]],
			sysB = safeRest[modelCoeffsSys["pd"][[1]]],
			modelAssumptions=model["modelAssumptions"]
		},
		With[
		{
			assumeA=expandPatternAssumptions[sysA,modelAssumptions],
			assumeB=expandPatternAssumptions[sysB,modelAssumptions]
		},
				With[
					{
						maxLen = Max[Length[sysA], Length[sysB]],
						fA = Function[e,
							Assuming[
								assumeA,
								Quiet[
									FullSimplify[e,Sequence @@ simplifyOpts],
									{FullSimplify::time,FullSimplify::gtime}
								]
							]
						],
						fB = Function[e,
							Assuming[
								assumeB,
								Quiet[
									FullSimplify[e,Sequence @@ simplifyOpts],
									{FullSimplify::time,FullSimplify::gtime}
								]
							]
						]
					},
					Module[{nKernels, kernelsOK = False, res},
						nKernels = Min[maxLen, $ProcessorCount];
						If[nKernels > 1,
							Quiet[CloseKernels[]];
							Quiet[
								Check[
									LaunchKernels[nKernels];
									kernelsOK = Length[ParallelKernels[]] > 0,
									kernelsOK = False
								]
							];
						];
						res = If[kernelsOK,
							{
								ParallelMap[fA, sysA/. (1-gamma)/(1-1/psi)->theta],
								ParallelMap[fB, sysB/. (1-gamma)/(1-1/psi)->theta]
							},
							With[{
								localSysA = sysA /. (1-gamma)/(1-1/psi) -> theta,
								localSysB = sysB /. (1-gamma)/(1-1/psi) -> theta,
								localAssumeA = assumeA,
								localAssumeB = assumeB,
								localSimplifyOpts = simplifyOpts
							},
							{
								isolatedEvaluate[
									Map[FullSimplify[#, Sequence @@ localSimplifyOpts] &, localSysA],
									"Assumptions" -> localAssumeA
								],
								isolatedEvaluate[
									Map[FullSimplify[#, Sequence @@ localSimplifyOpts] &, localSysB],
									"Assumptions" -> localAssumeB
								]
							}
							]
						];
						If[kernelsOK, CloseKernels[]];
						res
					]
				]
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
        modelCoeffsSys=model["coeffsSystem"],
        shortname = model["shortname"]
	},
	With[
		{
			modelCoeffsSysWc = modelCoeffsSys["wc"],
			modelCoeffsSysPd = modelCoeffsSys["pd"]
		},
		With[
			{
				sysA = safeRest[modelCoeffsSysWc[[1]]],
				sysB = safeRest[modelCoeffsSysPd[[1]]],
				modelAssumptions=model["modelAssumptions"]
			},
			With[
				{
					assumeA=expandPatternAssumptions[sysA,modelAssumptions],
					assumeB=expandPatternAssumptions[sysB,modelAssumptions]
				},
				With[
					{
						varsA = safeRest[modelCoeffsSysWc[[2]]],
						varsB = safeRest[modelCoeffsSysPd[[2]]]
					},
					Module[
						{
							solA,
							solB,
							conditionsA,
							conditionsB
						},

						print["[" <> shortname <> "] solveCoeffsSystem START"];

						(*solve system of linear-quadratic equations for wc and pd coefficients*)
						(*Echo[sysA[[1]],"sysA1"];*)
						solA=paramQuadSolve[
							sysA,
							varsA,
							"SymbolicSignSymbol" -> Symbol[
								"sign"<>SymbolName[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc]
							],
							Assumptions->assumeA,
							Sequence @@ Normal[paramQuadSolveOpts]
						];
						print["[" <> shortname <> "] paramQuadSolve wc done"];
						(*Echo[solA[[1]],"solA1"];*)
						solB=paramQuadSolve[
							sysB,
							varsB,
							"SymbolicSignSymbol" -> Symbol[
								"sign"<>SymbolName[Head@FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd]
							],
							Assumptions->assumeB,
							Sequence @@ Normal[paramQuadSolveOpts]
						];
						print["[" <> shortname <> "] paramQuadSolve pd done"];
						If[FailureQ[solA] || FailureQ[solB],
							Return["coeffsParamQuadSolve" -> $Failed, Module]
						];
						(*Echo[solB[[1]],"solB1"];*)
						(*simplify conditions that guarantee real solutions*)
						conditionsA=Assuming[assumeA,
							simplifyWithDummySubstitution[solA["Conditions"],
								"Assumptions" -> True,
								"SimplifyFunction" -> FullSimplify,
								Sequence @@ simplifyOpts
							]
						];
						print["[" <> shortname <> "] simplify conditionsA done"];
						conditionsB=Assuming[assumeB,
							simplifyWithDummySubstitution[solB["Conditions"],
								"Assumptions" -> True,
								"SimplifyFunction" -> FullSimplify,
								Sequence @@ simplifyOpts
							]
						];
						print["[" <> shortname <> "] simplify conditionsB done"];
						solA["Conditions"]=assumeA && (And@@conditionsA);
						solB["Conditions"]=assumeB && (And@@conditionsB);

						(*Echo[solA["Conditions"][[1]],"solAConditions"];*)
						(*Echo[solB["Conditions"][[1]],"solBConditions"];*)
						(*simplify using assumptions*)
						solA["Solution"]=With[
							{localSol = solA["Solution"], localOpts = simplifyOpts},
							isolatedEvaluate[
								Simplify[localSol, Sequence @@ localOpts],
								"Assumptions" -> solA["Conditions"]
							]
						];
						print["[" <> shortname <> "] simplify solA Solution done"];
					    solB["Solution"]=With[
							{localSol = solB["Solution"], localOpts = simplifyOpts},
							isolatedEvaluate[
								Simplify[localSol, Sequence @@ localOpts],
								"Assumptions" -> solB["Conditions"]
							]
						];
						print["[" <> shortname <> "] simplify solB Solution done"];
						(*Echo[solA["Solution"][[1]],"solASolution"];*)
						(*Echo[solB["Solution"][[1]],"solBSolution"];*)
						(*try eliminating one of gamma, theta, psi and keep shortest expressions*)
						solA["Solution"]=tryTransforms[#,assumeA,Sequence @@ simplifyOpts]&/@solA["Solution"];
						print["[" <> shortname <> "] tryTransforms solA done"];
						solB["Solution"]=tryTransforms[#,assumeB,Sequence @@ simplifyOpts]&/@solB["Solution"];
						print["[" <> shortname <> "] tryTransforms solB done"];

						(*create non-linear equation for unconditional mean of wc and pd and unsolved coeffs*)
						With[
							{
								wcCoeffEq = modelCoeffsSysWc[[1,1]],
								pdCoeffEq = modelCoeffsSysPd[[1,1]],
								verifA = safeVerification[solA["Verification"], Length[varsA], "wc", model["shortname"], varsA],
								verifB = safeVerification[solB["Verification"], Length[varsB], "pd", model["shortname"], varsB]
							},
							With[
								{
									newSysA= Pick[sysA,verifA,False],
									newVarsA = Pick[varsA,verifA,False]
								},
								(*wc*)
								solA["varsA0"] = Prepend[newVarsA,modelCoeffsSysWc[[2,1]]];
								With[
									{
										eqA0Unsimplified = Prepend[newSysA,wcCoeffEq]/.solA["Solution"],
										localSimplifyOpts = simplifyOpts
									},
									solA["eqA0"] = isolatedEvaluate[
										FullSimplify[eqA0Unsimplified, Sequence @@ localSimplifyOpts],
										"Assumptions" -> assumeA
									];
									print["[" <> shortname <> "] isolatedEvaluate eqA0 done"];
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
										eqB0=Prepend[newSysB,pdCoeffEq]/.solB["Solution"],
										localAssumeB = assumeB,
										localSimplifyOpts = simplifyOpts,
										localSolASolution = solA["Solution"]
									},
									solB["pdMode"] = pdMode;
									solB["varsB0"] = Prepend[newVarsB,modelCoeffsSysPd[[2,1]]];
									(*pd without plugging in wc coeffs - only if needed*)
									If[MatchQ[pdMode, "B" | "Both"],
										solB["eqB0"] = isolatedEvaluate[
											FullSimplify[eqB0, Sequence @@ localSimplifyOpts],
											"Assumptions" -> localAssumeB
										];
										print["[" <> shortname <> "] LocalEvaluate eqB0 done"];
									];
									(*pd plugging in wc coeffs - only if needed*)
									If[MatchQ[pdMode, "AB" | "Both"],
										solB["eqAB0"] = isolatedEvaluate[
											FullSimplify[eqB0 /. localSolASolution, Sequence @@ localSimplifyOpts],
											"Assumptions" -> localAssumeB
										];
										print["[" <> shortname <> "] LocalEvaluate eqAB0 done"];
									];
								]; (*With*)
							]; (*With*)
						]; (*With*)
						(*Echo[solA["eqA0"],"eqA0"];*)
						(*Echo[solB["eqB0"],"eqB0"];*)
						(*Echo[solB["eqAB0"],"eqAB0"];*)
						(*Echo[model["shortname"],"finishedcoeffsParamQuadSolve"]; *)
						print["[" <> shortname <> "] solveCoeffsSystem END"];
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


(* ::Subsubsection:: *)
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
	        }],
			transformsList = actualTransforms
		},
		(*Echo[{opts},"tryTransformsopts"];
		Echo[simplifyOpts,"tryTransformssimplifyOpts"];
		Echo[transformsList,"tryTransformsactualTransforms"];
		Echo[expr,"tryTransformsexpr"];
		Echo[ass[[1]],"tryTransformsass"];*)
		With[
			{
				simplifyOne = Function[{tr},
					Assuming[
						ass,
						Quiet[Simplify[expr /. tr, Sequence @@ simplifyOpts], {Simplify::time, Simplify::gtime}]
					]
				],
				nKernels = Min[Length[transformsList], $ProcessorCount]
			},
			If[nKernels > 0,
				CloseKernels[];
				LaunchKernels[nKernels];
				results =
					ParallelTable[
						simplifyOne[transform],
						{transform, transformsList}
					];
				CloseKernels[],
				(* Sequential fallback with memory isolation *)
				results = isolatedEvaluate[
					Table[
						Simplify[localExpr /. transform, Sequence @@ localOpts],
						{transform, localTransforms}
					],
					"Bindings" -> {localExpr -> expr, localOpts -> simplifyOpts, localTransforms -> transformsList},
					"Assumptions" -> ass
				]
			]
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
				solvedQ=(Quiet[Simplify[#,Assumptions->n>=1 && Element[n,Integers],TimeConstraint->{5,15}],{Simplify::time,Simplify::gtime}]&)/@(system[[2;;-1]]//.coeffInfo/.dependentParameters);
				notSolvedQ=Not/@(BooleanQ/@solvedQ);
				If[
					(*if not all equations are solved*)
					Not@(And@@(TrueQ/@solvedQ))
					,
					(*try again for unsolved equations by substituting out gamma*)
					solvedQ=With[
						{
							solvedQgamma=(Quiet[Simplify[#,Assumptions->n>=1 && Element[n,Integers],TimeConstraint->{5,15}],{Simplify::time,Simplify::gtime}]&)/@(Pick[system[[2;;-1]],notSolvedQ]//.coeffInfo//.FernandoDuarte`LongRunRisk`Model`Parameters`gamma->(1+(-1+1/FernandoDuarte`LongRunRisk`Model`Parameters`psi) FernandoDuarte`LongRunRisk`Model`Parameters`theta))
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
								Evaluate[OptionValue[updateCoeffs, {opts}, "RecurrenceTableOptions"]]
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


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
