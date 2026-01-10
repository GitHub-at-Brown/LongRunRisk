(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`ToNumber`"]


(* ::Subsection:: *)
(*Public symbols*)


toNum
toEquation
toExogenousVars
toStateVars
processNewParameters

(* ::Subsubsection:: *)
(*Usage*)


toNum::usage = "toNum[model] gives a pure (or \"anonymous\") function that evaluates its argument numerically using the solution to model."<>"\n"<>
			   "toNum[expr, model] evaluates expr numerically using the solution to model."<>"\n"<>
			   "toNum[\"Rules\", model] gives substitution rules that can be used to evaluate expressions numerically."<>"\n"<>
			   "toNum[..., parameters] uses the parameters provided in the list of rules parameters."<>"\n"<>
			   "toNum[..., parameters, initialGuess] provides an initial estimate for the solution of the model.";
toEquation::usage = "toEquation[model] gives a pure (or \"anonymous\") function that re-writes its argument in terms of lagged exogenous variables and shocks of model."<>"\n"<>
					"toEquation[expr, model] re-writes expr in terms of lagged exogenous variables and shocks of model.";
toExogenousVars::usage = "toExogenousVars[model] gives a pure (or \"anonymous\") function that re-writes its argument in terms of the exogenous variables of model."<>"\n"<>
						 "toExogenousVars[expr, model] re-writes its first argument in terms of the exogenous variables of model.";
toStateVars::usage = "toStateVars[model] gives a pure (or \"anonymous\") function that re-writes its argument in terms of the state variables of model."<>"\n"<>
					 "toStateVars[expr, model] re-writes expr in terms of the state variables of model.";
processNewParameters::usage = "processNewParameters[newParameters,parameters] returns a validated list of rules to substitute  ";


(* ::Subsubsection:: *)
(*Messages*)


toNum::badselector = "SolutionSelector `1` is invalid. Expected Automatic, All, Integer, {aIdx, bIdx}, or Association with SignsA/SignsB/SolutionIndexA keys.";
toNum::nosolution = "No solution matching SolutionSelector `1` was found.";
toNum::badidx = "Solution index `1` is out of range [1, `2`].";
toNum::badbidx = "B solution index `1` for stock `2` is out of range [1, `3`].";
toNum::badreturnall = "ReturnAllSolutions must be True or False, not `1`.";
toNum::selectorallrequiresreturnall = "SolutionSelector -> All requires ReturnAllSolutions -> True.";


(*Get["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Get["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
$ContextPath=AppendTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
$ContextPath=AppendTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];*)


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];


(* ::Subsection:: *)
(*toNum*)


(* Handler for options-only calls - ensures model["params"] is used as default *)
(* toNum["Rules", model_Association, opts:OptionsPattern[{toNumRules, updateCoeffs}]] /; Length[{opts}] > 0 :=
	(Echo[{opts},"opts"];toNum["Rules", model, model["params"], (*{},*) opts]); *)

(*uses starting point from modelsExtraInfo in Catalog.wl if available and initial guess is passed by user*)
toNum["Rules",model_Association,rest__]:= toNumRules[model,rest]; 

 (* ,ReleaseHold@If[KeyExistsQ[model["extraInfo"],"initialGuess"],"initialGuess"->model["extraInfo"]["initialGuess"],Hold@Sequence[] ]*) 

(*convenience forms that apply rules to expr or allow for postfix notation expr//toNum*)
toNum[
	expr_ /; Not@AssociationQ[expr],
	model_Association,
	Longest[newParameters : {(_Rule) ...} : {}, 1],
	opts : OptionsPattern[{toNumRules, updateCoeffs}]
] := With[
	{
		(* Get rules or hierarchical structure based on options *)
		rulesOrSol = toNum["Rules", model, newParameters, opts],
		(* Compute effective parameters to ensure consistency with toNumRules *)
		params = model["params"]
	},
	(* Echo[rulesOrSol, "rulesOrSol in toNum expr"]; *)

	If[FailureQ[rulesOrSol],
		rulesOrSol,

		With[{
			(* Process parameters exactly as toNumRules does to ensure correct evaluation context *)
			allParams = Normal@Join[
				Association@params,
				Association@processNewParameters[newParameters, params]
			]
		},
			(* Check if we have a hierarchical structure (List of Associations with "A", "Stocks" etc) *)
			If[MatchQ[rulesOrSol, {__Association} /; KeyExistsQ[First[rulesOrSol], "A"]],
				(* Hierarchical Evaluation *)
				evaluateExprHierarchical[toEquation[expr, model], model, rulesOrSol, allParams],
				
				(* Standard Flat Evaluation *)
				ReplaceRepeated[toEquation[expr, model], rulesOrSol]
			]
		]
	]
]

(* ... existing toNum definitions ... *)

(* ::Subsection:: *)
(*Hierarchical Evaluation Helpers*)

(* Detect dependencies: Returns <|"Type" -> "A"|"Stock"|"Mixed", "Stocks" -> {indices}|> *)
detectExpressionType[expr_, model_] := Module[
	{
		stockIndices = {}
	},
	(* Detect B[i][...] patterns where i is a stock index *)
	(* B is the specific symbol used for price-dividend coefficients in EndogenousEq *)

	(* Matches B[i][j] or B[i][t] etc. where i is integer stock index *)
	stockIndices = Cases[expr,
		B[i_Integer][___] :> i,
		Infinity
	] // Union;

	If[Length[stockIndices] > 0,
		If[Length[stockIndices] == 1,
			<|"Type" -> "Stock", "Stocks" -> stockIndices|>,
			<|"Type" -> "Mixed", "Stocks" -> stockIndices|>
		],
		<|"Type" -> "A", "Stocks" -> {}|>
	]
];

(* Main hierarchical evaluator *)
evaluateExprHierarchical[expr_, model_, solHierarchical_, allParams_] := Map[
	Function[aSol,
		Module[{exprA, typeInfo, res, baseMeta},
			(* 1. Evaluate A-level (Macro) dependencies *)
			(* Substitute A, Bonds, and global Params using the CORRECT allParams *)
			exprA = expr /. aSol["A"] /. allParams;
			
			(* Robust Bond handling: Check existence AND MissingQ *)
			If[KeyExistsQ[aSol, "Bond"] && !MissingQ[aSol["Bond"]], 
				exprA = exprA /. aSol["Bond"]
			];
			If[KeyExistsQ[aSol, "NomBond"] && !MissingQ[aSol["NomBond"]], 
				exprA = exprA /. aSol["NomBond"]
			];
			
			(* Preserve all metadata from aSol except the heavy solution payloads *)
			baseMeta = KeyDrop[aSol, {"A", "Stocks", "Bond", "NomBond"}];
			
			(* 2. Detect remaining dependencies (Stocks) *)
			typeInfo = detectExpressionType[exprA, model];
			
			Switch[typeInfo["Type"],
				"A",
					(* No stock dependencies left *)
					Join[
						baseMeta,
						Association["Value" -> exprA]
					],
				
				"Stock",
					(* Single stock dependency *)
					With[{i = First[typeInfo["Stocks"]]},
						Join[
							baseMeta,
							Association[
								"Stocks" -> Association[
									i -> Map[
										Function[bSol,
											Association[
												"IntervalB" -> bSol["IntervalB"], 
												"SignsB" -> bSol["SignsB"],
												"Value" -> (exprA /. bSol["B"])
											]
										],
										aSol["Stocks"][i]
									]
								]
							]
						]
					],
					
				"Mixed",
					(* Multiple stocks: Cartesian Product *)
					Module[{stocks = typeInfo["Stocks"], bCombinations, stockKeys},
						(* Get list of B-solutions for each involved stock *)
						(* Structure: { { {B->..}, {B->..} }_stock1, { {B->..} }_stock2 } *)
						bCombinations = Tuples[
							Table[
								(* Tag each B-sol with its stock index for identification if needed *)
								Map[{stockIdx, #} &, aSol["Stocks"][stockIdx]], 
								{stockIdx, stocks}
							]
						];
						
						Join[
							baseMeta,
							Association[
								"Combinations" -> Map[
									Function[combo, (* combo is list of {stockIdx, bSol} *)
										Module[{mergedRules, meta},
											mergedRules = Flatten[combo[[All, 2, "B"]]];
											meta = Association @ Map[
												#[[1]] -> DeleteCases[#[[2]], "B"] &, 
												combo
											];
											
											Association[
												"StockSolutions" -> meta,
												"Value" -> (exprA /. mergedRules)
											]
										]
									],
									bCombinations
								]
							]
						]
					]
			]
		]
	],
	solHierarchical
];
toNum[model_Association,rest__]:=Function[{expr}, toNum[expr,model,rest]]

(*if rest not provided, use model["params"]*)
toNum["Rules",model_Association]:= toNum["Rules", model (*,model["params"]*), {}];
toNum[expr_/;Not@AssociationQ[expr],model_Association]:= With[
	{rules = toNum["Rules", model]},
	If[FailureQ[rules], rules, ReplaceRepeated[toEquation[expr,model], rules]]
]
toNum[model_Association]:=toNum[model (*,model["params"]*), {}]


(* Options for toNumRules *)
Options[toNumRules] = {
	"SolutionSelector" -> Automatic,
	"ReturnAllSolutions" -> False
};

toNumRules[
	model_Association,
	Longest[newParameters : {(_Rule)...} : {}, 1],
	(* Longest[guessCoeffsSolution_List : {}, 2], *)
	opts : OptionsPattern[{toNumRules, updateCoeffs}]
] := With[
	{
		params = model["params"],
		numStocks = model["numStocks"],
		uncondEwc = model["ratioUncondE"]["wc"],
		uncondEpd = model["ratioUncondE"]["pd"],
		optsUpdateCoeffs = Sequence @@ Flatten @ {FilterRules[Flatten @ {opts}, Flatten[Options /@ {updateCoeffs}]]},
		selectorOpt = OptionValue["SolutionSelector"],
		returnAllOpt = OptionValue["ReturnAllSolutions"],
		guessCoeffsSolution = {}
	},
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];

	
	Echo[newParameters,"newParameters"];
	Echo[guessCoeffsSolution,"guessCoeffsSolution"];
	Echo[{opts},"optstoNumRules"];
	
	(* Validate ReturnAllSolutions option *)
	If[!MatchQ[returnAllOpt, True | False],
		Message[toNum::badreturnall, returnAllOpt];
		Return[Failure["InvalidOption", <|"MessageTemplate" -> toNum::badreturnall, "MessageParameters" -> {returnAllOpt}|>]]
	];

	(* Determine effective selector: when ReturnAllSolutions->True and selector is Automatic, use All *)
	With[{effectiveSelector = If[returnAllOpt && selectorOpt === Automatic, All, selectorOpt]},

		(* Validate SolutionSelector -> All requires ReturnAllSolutions -> True *)
		If[effectiveSelector === All && !returnAllOpt,
			Message[toNum::selectorallrequiresreturnall];
			Return[Failure["InvalidOption", <|"MessageTemplate" -> toNum::selectorallrequiresreturnall|>]]
		];

		With[{newParams = processNewParameters[newParameters, params]},
			With[{allParams = Normal @ Join[Association @ params, Association @ newParams]},
			Echo[allParams,"allParams"];
				With[{solHierarchical = updateCoeffs[model, {}, newParameters, guessCoeffsSolution, "UpdatePd" -> True, "UpdateBonds" -> True, optsUpdateCoeffs]},
				Echo[solHierarchical,"solHierarchical"];
					(* Propagate Failure from updateCoeffs *)
					If[FailureQ[solHierarchical],
						solHierarchical,
						(* Apply solution selection *)
						selectAndFormatSolutions[solHierarchical, effectiveSelector, returnAllOpt, allParams, uncondEwc, uncondEpd, numStocks]
					]
				]
			]
		]
	]
];

(* Helper: Select and format solutions based on selector and returnAll options *)
selectAndFormatSolutions[solHierarchical_List, selector_, returnAll_, allParams_, uncondEwc_, uncondEpd_, numStocks_] := Module[
	{selectedSolutions, result},

	(* Select solutions based on selector *)
	selectedSolutions = selectSolutions[solHierarchical, selector, numStocks];

	(* Check for Failure from selection *)
	If[FailureQ[selectedSolutions],
		Return[selectedSolutions]
	];

	(* Format output based on returnAll *)
	If[returnAll,
		(* Return hierarchical structure *)
		selectedSolutions,
		(* Return flat rules from first selected solution *)
		With[{sol = flattenCoeffsFromSelected[selectedSolutions, selector, numStocks]},
			If[FailureQ[sol],
				sol,
				Join[
					sol
					,
					allParams
					(*,
					{
						FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc -> (uncondEwc /. sol //. allParams),
						FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[ind_] :> (uncondEpd /. (FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j -> ind) /. sol //. allParams)
					}*)
				]
			]
		]
	]
];

(* Helper: Select solutions from hierarchical structure based on selector *)
selectSolutions[solHierarchical_List, selector_, numStocks_] := Module[{numASolutions = Length[solHierarchical]},
	Switch[selector,
		(* All: return all solutions *)
		All,
			solHierarchical,

		(* Automatic or integer 1: return first A solution *)
		Automatic,
			{First[solHierarchical]},

		(* Positive integer: select n-th A solution *)
		_Integer?Positive,
			If[selector > numASolutions,
				Message[toNum::badidx, selector, numASolutions];
				Failure["IndexOutOfRange", <|"MessageTemplate" -> toNum::badidx, "MessageParameters" -> {selector, numASolutions}|>],
				{solHierarchical[[selector]]}
			],

		(* Invalid integer (zero, negative) *)
		_Integer,
			Message[toNum::badidx, selector, numASolutions];
			Failure["IndexOutOfRange", <|"MessageTemplate" -> toNum::badidx, "MessageParameters" -> {selector, numASolutions}|>],

		(* Non-integer Real (like 1.5) *)
		_Real,
			Message[toNum::badselector, selector];
			Failure["InvalidSelector", <|"MessageTemplate" -> toNum::badselector, "MessageParameters" -> {selector}|>],

		(* Tuple {aIdx, bIdx} *)
		{_Integer, _Integer},
			selectByTupleIndex[solHierarchical, selector, numStocks],

		(* Association selector (SignsA, SignsB, SolutionIndexA) *)
		_Association,
			selectByAssociation[solHierarchical, selector, numStocks],

		(* Invalid list (wrong length, non-integers, nested, empty) *)
		_List,
			Message[toNum::badselector, selector];
			Failure["InvalidSelector", <|"MessageTemplate" -> toNum::badselector, "MessageParameters" -> {selector}|>],

		(* Any other invalid selector *)
		_,
			Message[toNum::badselector, selector];
			Failure["InvalidSelector", <|"MessageTemplate" -> toNum::badselector, "MessageParameters" -> {selector}|>]
	]
];

(* Helper: Select by tuple index {aIdx, bIdx} *)
selectByTupleIndex[solHierarchical_List, {aIdx_Integer, bIdx_Integer}, numStocks_] := Module[
	{numASolutions = Length[solHierarchical], aSol, stockKeys, invalidStock},

	(* Validate A index *)
	Which[
		aIdx < 1 || aIdx > numASolutions,
			Message[toNum::badidx, aIdx, numASolutions];
			Failure["IndexOutOfRange", <|"MessageTemplate" -> toNum::badidx, "MessageParameters" -> {aIdx, numASolutions}|>],

		bIdx < 1,
			Message[toNum::badbidx, bIdx, 1, "varies"];
			Failure["IndexOutOfRange", <|"MessageTemplate" -> toNum::badbidx, "MessageParameters" -> {bIdx, 1, "varies"}|>],

		True,
			aSol = solHierarchical[[aIdx]];
			stockKeys = Keys[aSol["Stocks"]];

			(* Find first stock where bIdx is out of range *)
			invalidStock = SelectFirst[stockKeys, Length[aSol["Stocks"][#]] < bIdx &, None];

			If[invalidStock =!= None,
				With[{numBSols = Length[aSol["Stocks"][invalidStock]]},
					Message[toNum::badbidx, bIdx, invalidStock, numBSols];
					Failure["IndexOutOfRange", <|"MessageTemplate" -> toNum::badbidx, "MessageParameters" -> {bIdx, invalidStock, numBSols}|>]
				],
				(* All validations passed - return modified A solution *)
				{Association[
					"IntervalA" -> aSol["IntervalA"],
					"SignsA" -> aSol["SignsA"],
					"SolutionIndexA" -> aSol["SolutionIndexA"],
					"IntervalIndexA" -> aSol["IntervalIndexA"],
					"A" -> aSol["A"],
					"Stocks" -> Association @ Table[
						stockKey -> {aSol["Stocks"][stockKey][[bIdx]]},
						{stockKey, stockKeys}
					],
					If[!MissingQ[aSol["Bond"]], "Bond" -> aSol["Bond"], Nothing],
					If[!MissingQ[aSol["NomBond"]], "NomBond" -> aSol["NomBond"], Nothing]
				]}
			]
	]
];

(* Helper: Select by association (SignsA, SignsB, SolutionIndexA) *)
selectByAssociation[solHierarchical_List, selector_Association, numStocks_] := Module[
	{validKeys, selectorKeys, matchingASols, result},

	validKeys = {"SignsA", "SignsB", "SolutionIndexA", "SolutionIndexB"};
	selectorKeys = Keys[selector];

	(* Check for invalid keys *)
	If[!SubsetQ[validKeys, selectorKeys],
		Message[toNum::badselector, selector];
		Return[Failure["InvalidSelector", <|"MessageTemplate" -> toNum::badselector, "MessageParameters" -> {selector}|>]]
	];

	(* Empty association is invalid *)
	If[Length[selector] == 0,
		Message[toNum::badselector, selector];
		Return[Failure["InvalidSelector", <|"MessageTemplate" -> toNum::badselector, "MessageParameters" -> {selector}|>]]
	];

	(* Validate SignsA if present *)
	If[KeyExistsQ[selector, "SignsA"],
		With[{signsA = selector["SignsA"]},
			If[!ListQ[signsA] || Length[signsA] == 0,
				Message[toNum::badselector, selector];
				Return[Failure["InvalidSelector", <|"MessageTemplate" -> toNum::badselector, "MessageParameters" -> {selector}|>]]
			]
		]
	];

	(* Validate SolutionIndexA if present *)
	If[KeyExistsQ[selector, "SolutionIndexA"],
		With[{idxA = selector["SolutionIndexA"]},
			If[!IntegerQ[idxA],
				Message[toNum::badselector, selector];
				Return[Failure["InvalidSelector", <|"MessageTemplate" -> toNum::badselector, "MessageParameters" -> {selector}|>]]
			]
		]
	];

	(* Filter A solutions by SignsA and/or SolutionIndexA *)
	matchingASols = Select[solHierarchical, Function[aSol,
		And[
			If[KeyExistsQ[selector, "SignsA"], aSol["SignsA"] === selector["SignsA"], True],
			If[KeyExistsQ[selector, "SolutionIndexA"], aSol["SolutionIndexA"] === selector["SolutionIndexA"], True]
		]
	]];

	If[Length[matchingASols] == 0,
		Message[toNum::nosolution, selector];
		Return[Failure["NoSolution", <|"MessageTemplate" -> toNum::nosolution, "MessageParameters" -> {selector}|>]]
	];

	(* If SignsB is specified, filter B solutions within each A solution *)
	If[KeyExistsQ[selector, "SignsB"],
		matchingASols = Map[Function[aSol,
			With[{filteredStocks = Association @ KeyValueMap[
				Function[{stockKey, bSolList},
					stockKey -> Select[bSolList, #["SignsB"] === selector["SignsB"] &]
				],
				aSol["Stocks"]
			]},
				(* Check that at least one B solution matches for each stock that has solutions *)
				If[AnyTrue[Values[filteredStocks], Length[#] == 0 &],
					Nothing,
					Association[
						"IntervalA" -> aSol["IntervalA"],
						"SignsA" -> aSol["SignsA"],
						"SolutionIndexA" -> aSol["SolutionIndexA"],
						"IntervalIndexA" -> aSol["IntervalIndexA"],
						"A" -> aSol["A"],
						"Stocks" -> filteredStocks,
						If[!MissingQ[aSol["Bond"]], "Bond" -> aSol["Bond"], Nothing],
						If[!MissingQ[aSol["NomBond"]], "NomBond" -> aSol["NomBond"], Nothing]
					]
				]
			]
		], matchingASols];

		(* Remove Nothing entries *)
		matchingASols = DeleteCases[matchingASols, Nothing];

		If[Length[matchingASols] == 0,
			Message[toNum::nosolution, selector];
			Return[Failure["NoSolution", <|"MessageTemplate" -> toNum::nosolution, "MessageParameters" -> {selector}|>]]
		]
	];

	(* Return first matching solution (for determinism) *)
	{First[matchingASols]}
];

(* Helper: Check if an A solution has valid (non-empty) B solutions for all stocks *)
hasValidBSolutions[aSol_Association] := AllTrue[
	Values[aSol["Stocks"]],
	Length[#] > 0 &
];

(* Helper: Flatten coefficients from selected solutions based on selector type *)
flattenCoeffsFromSelected[selectedSolutions_List, selector_, numStocks_] := Module[{aSol, stockKeys},
	(* Always take the first selected A solution *)
	aSol = First[selectedSolutions];
	stockKeys = Keys[aSol["Stocks"]];

	(* Check for empty B solutions - use If/Else to ensure proper control flow *)
	If[!hasValidBSolutions[aSol],
		(* Empty B solutions - return Failure *)
		Message[toNum::nosolution, selector];
		Failure["NoSolution", <|"MessageTemplate" -> toNum::nosolution, "MessageParameters" -> {selector}|>],
		(* Valid B solutions - build flat rules: A coeffs + first B for each stock + bonds *)
		Join[
			Normal[aSol["A"]],
			Flatten @ Table[
				Normal[aSol["Stocks"][stockKey][[1]]["B"]],
				{stockKey, stockKeys}
			],
			If[!MissingQ[aSol["Bond"]], Normal[aSol["Bond"]], {}],
			If[!MissingQ[aSol["NomBond"]], Normal[aSol["NomBond"]], {}]
		]
	]
]


(* ::Subsection:: *)
(*toEquation*)


toEquation[
	expr_,
	model_Association
]:=ReplaceAll[
		ReplaceRepeated[
			modelEval[expr, model],
			Normal@model["endogenousEq"]
		],
		Normal@model["exogenousEq"]
	]

toEquation[model_Association]:=Function[{expr}, toEquation[expr,model]]

(*ToEquation[expr_,model_Association, n_Integer?Positive]:= Nest[ToEquation[#,model]&,expr,n];
ToEquation[model_Association, n_Integer?Positive]:=Function[{expr}, Nest[ToEquation[#,model]&,expr,n]];*)
(*ReplaceAll[expr_,ToEquation[model_]]^:=ToEquation[expr,model]*)


(* ::Subsection:: *)
(*toExogenousVars*)


toExogenousVars[
	expr_,
	model_Association
]:= ReplaceRepeated[
			modelEval[expr, model],
			Normal@model["endogenousEq"]
		];

toExogenousVars[model_Association]:=Function[{expr}, toExogenousVars[expr,model]]


(* ::Subsection:: *)
(*toStateVars*)


toStateVars[
	expr_,
	model_Association
]:= ReplaceAll[
		modelEval[expr, model],
		Normal@model["toStateVars"]
	]

toStateVars[model_Association]:=Function[{expr}, toStateVars[expr,model]]


(* ::Subsubsection:: *)
(*GlobalProperties*)


GlobalProperties[] :={
    OwnValues, DownValues, SubValues, UpValues, NValues, FormatValues,
    Options, DefaultValues, Attributes
};


(* ::Subsubsection:: *)
(*clone*)


Attributes[clone] = {HoldAll};


clone[s_Symbol, new_Symbol] := With[
    {
	    clone = new, sopts = Options[Unevaluated[s]]
	    },
        With[{setProp = (#[clone] = (#[s] /. HoldPattern[s] :> clone)
            )&},
            Map[setProp, DeleteCases[GlobalProperties[], Options]];
            If[sopts =!= {},
                Options[clone] = (sopts /. HoldPattern[s] :> clone)
            ];
            HoldPattern[s] :> clone
        ]
    ]


(* ::Subsubsection:: *)
(*withUserDefs*)


SetAttributes[withUserDefs, HoldAll];


withUserDefs[sym_Symbol, {defs__}, code_] := Module[
    {s, inSym},
        clone[sym, s];
        With[{evalSym = sym},
            Block[{evalSym},
                defs;
                evalSym[args___] /; !TrueQ[inSym] := Block[
                    {evalSym, inSym = True},
                        clone[s, evalSym];
                        With[{result = evalSym[args]},
                            result /; result =!= Unevaluated[evalSym[args]]
                        ]
                    ];
                code
            ]
        ]
    ];


(* ::Subsubsection:: *)
(*moms*)


moms[fun_, expr_, model_] := withUserDefs[fun, {fun[x___] := fun[x, model]}, expr]


(* ::Subsubsection:: *)
(*modelEval*)


modelEval::usage = "modelEval[expr, model] evaluates moments in expr using model.
	For exmaple,
		modelEval[\[IndentingNewLine]			uncondE[dc[t]]+uncondCov[x[t],x[t+1]]+cov[dc[t+1],dc[t+2],t],\[IndentingNewLine]			model\[IndentingNewLine]		]\[IndentingNewLine]	gives the same as\[IndentingNewLine]		uncondE[dc[t],model]+uncondCov[x[t],x[t+1],model]+cov[dc[t+1],dc[t+2],t,model]
"


modelEval[expr_, model_] := Fold[
	ReverseApplied[moms[#1, #2, model]&]
	,
	expr(*/.{
		FernandoDuarte`LongRunRisk`UncondE -> uncondE,
		FernandoDuarte`LongRunRisk`UncondVar -> uncondVar,
		FernandoDuarte`LongRunRisk`UncondCov -> uncondCov,
		FernandoDuarte`LongRunRisk`UncondCorr -> uncondCorr,
		FernandoDuarte`LongRunRisk`Ev -> ev,
		FernandoDuarte`LongRunRisk`Var -> var,
		FernandoDuarte`LongRunRisk`Cov -> cov,
		FernandoDuarte`LongRunRisk`Corr -> corr
	}*)
	,
	{
		uncondE, uncondVar, uncondCov, uncondCorr,
		ev, var, cov, corr,
		FernandoDuarte`LongRunRisk`UncondE,
		FernandoDuarte`LongRunRisk`UncondVar,
		FernandoDuarte`LongRunRisk`UncondCov,
		FernandoDuarte`LongRunRisk`UncondCorr,
		FernandoDuarte`LongRunRisk`Ev,
		FernandoDuarte`LongRunRisk`Var,
		FernandoDuarte`LongRunRisk`Cov,
		FernandoDuarte`LongRunRisk`Corr
	}
];


(* ::Subsection:: *)
(*processNewParameters*)


processNewParameters::psi="psi=1 implies a constant wealth-consumption ratio, please choose a different psi.";
processNewParameters::param="theta must equal (1-gamma)/(1-1/psi), replacing theta by (1-gamma)/(1-1/psi)=`1`.";
processNewParameters::theta="Please provide psi or gamma with theta.";
processNewParameters::subsetparam="Parameters `1` in newParameters are not a subset of parameters.";


processNewParameters[newParameters : {___Rule} | _Association, parameters : {___Rule} | _Association]:=If[
	newParameters==={},
	Return[{}],
	With[
		{
			newParametersA=(Association@newParameters)//.newParameters//.parameters,
			parametersA=(Association@parameters)//.parameters
		},
		(*Echo[newParametersA,"newParametersA"];
		Echo[parametersA,"parametersA"];*)
		Module[
			{
				newParametersSplit,
				parametersSplit,
				newParametersString,
				processedParameters,
				thetaNew,
				system,
				processedParametersA,
				posNew
			},
			(*newParameters and parameters may have symbols in different contexts, split keys into context, symbol name and index*)
			newParametersSplit=KeyMap[Replace[{x_Symbol[j_Integer]:>{Context@x,SymbolName@x,j},x_Symbol:>{Context@x,SymbolName@x}}],newParametersA];
			parametersSplit=KeyMap[Replace[{x_Symbol[j_Integer]:>{Context@x,SymbolName@x,j},x_Symbol:>{Context@x,SymbolName@x}}],parametersA];
			If[
				Not@SubsetQ[Map[Rest,Keys@parametersSplit],Map[Rest,Keys@newParametersSplit]],
				(*abort with message if newParameters has a parameter not in parameters*)
				Message[processNewParameters::subsetparam,Pick[newParameters,MemberQ[Map[Rest,Keys@parametersSplit],#]&/@Map[Rest,Keys@newParametersSplit],False]];
				Abort[];
			];
			(*process gamma, psi, theta*)
			newParametersString = Normal@KeyMap[#[[2]]&,newParametersSplit];
			If[1.===N@("psi"/.newParametersString), Message[processNewParameters::psi]; Abort[]; ]; (*psi=1 aborts*)
			processedParameters = Switch[
				Count[MemberQ[Keys@newParametersString,#]&/@{"gamma","psi","theta"},True],
					3,
						(*when gamma, psi, theta all provided, ignore theta and issue message unless theta is exactly (1-gamma)/(1-1/psi)*)	
						thetaNew=(1-("gamma"/.newParametersString))/(1-1/("psi"/.newParametersString));
						If[
							RealAbs[("theta"/.newParametersString)-thetaNew]>=$MachineEpsilon,
							Message[processNewParameters::param,thetaNew]
						];
						Prepend[
							(*remove old theta*)
							KeySelect[newParametersSplit,Not@StringMatchQ["theta",#[[2]]]&],
							(*insert new theta with context Global*)
							{"Global`","theta"}->thetaNew
						],		
					2,
						(*when 2 of {gamma, psi, theta} are provided, solve for the third and add to newParameters*)
						system = ( (1-ToExpression@("gamma"/.newParametersString))/(1-1/ToExpression@("psi"/.newParametersString)) == (ToExpression@("theta"/.newParametersString)) );
						Prepend[newParametersSplit,KeyMap[{"Context`",SymbolName@#}&,Association@SolveAlways[system,Reals]]],
					1,
						(*if theta provided without gamma or psi, abort*)
						If[
							MemberQ[Keys[newParametersSplit][[;;,2]],"theta"],
							Message[processNewParameters::theta];Abort[];,
							newParametersSplit
						],
					(*otherwise, return newParametersSplit unchanged*)
					_,
					newParametersSplit
			];
			(*make keys of newParameters match context of keys of parameters that have the same SymbolName*)
			processedParametersA=Association@processedParameters;
			posNew=Position[Rest/@Keys@parametersSplit,#]&/@Rest/@Keys@processedParametersA;
			Thread[Extract[Keys@parametersA,Flatten[posNew,1]]->(Values@processedParametersA)]
		](*Module*)
	](*With*)
](*If*)


(* ::Section::Closed:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
