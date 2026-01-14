(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];


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
			   "toNum[..., parameters] uses the parameters provided in the list of rules parameters.";
toEquation::usage = "toEquation[model] gives a pure (or \"anonymous\") function that re-writes its argument in terms of lagged exogenous variables and shocks of model."<>"\n"<>
					"toEquation[expr, model] re-writes expr in terms of lagged exogenous variables and shocks of model.";
toExogenousVars::usage = "toExogenousVars[model] gives a pure (or \"anonymous\") function that re-writes its argument in terms of the exogenous variables of model."<>"\n"<>
						 "toExogenousVars[expr, model] re-writes its first argument in terms of the exogenous variables of model.";
toStateVars::usage = "toStateVars[model] gives a pure (or \"anonymous\") function that re-writes its argument in terms of the state variables of model."<>"\n"<>
					 "toStateVars[expr, model] re-writes expr in terms of the state variables of model.";
processNewParameters::usage = "processNewParameters[newParameters,parameters] returns a validated list of rules to substitute newParameters into parameters, handling dependencies between gamma, psi, and theta."

(* ::Subsubsection:: *)
(*Messages*)


toNum::badselector = "SolutionSelector `1` is invalid. Expected Automatic, All, Integer, {aIdx, bIdx}, or Association with SignsA/SignsB/SolutionIndexA keys.";
toNum::nosolution = "No solution matching SolutionSelector `1` was found.";
toNum::badidx = "Solution index `1` is out of range [1, `2`].";
toNum::badbidx = "B solution index `1` for stock `2` is out of range [1, `3`].";
toNum::badreturnall = "ReturnAllSolutions must be True or False, not `1`.";
toNum::selectorallrequiresreturnall = "SolutionSelector -> All requires ReturnAllSolutions -> True.";
toNum::emptysigns = "SignsA -> {} is empty. Omit SignsA to match any solution, or specify sign patterns like {1}, {-1}, or {1, -1, 1}.";
toNum::nobsolutions = "No valid B solutions found for one or more stocks. The model may be unsolvable with the given parameters.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];


(* ::Subsection:: *)
(*Helper Functions*)


(* Single source of truth for rule application *)
applyRules[expr_, rules_, maxIter_:10] :=
	FixedPoint[ReplaceAll[#, rules] &, expr, maxIter]

(* Standardized failure creation *)
makeFailure[tag_String, msgTemplate_, params_List:{}] :=
	Failure[tag, <|"MessageTemplate" -> msgTemplate, "MessageParameters" -> params|>]

(* Single source for A solution association structure *)
buildASolutionAssoc[aSol_, stocks_] := Association[
	"IntervalA" -> aSol["IntervalA"],
	"SignsA" -> aSol["SignsA"],
	"SolutionIndexA" -> aSol["SolutionIndexA"],
	"IntervalIndexA" -> aSol["IntervalIndexA"],
	"A" -> aSol["A"],
	"Stocks" -> stocks,
	If[!MissingQ[aSol["Bond"]], "Bond" -> aSol["Bond"], Nothing],
	If[!MissingQ[aSol["NomBond"]], "NomBond" -> aSol["NomBond"], Nothing]
]

(* Clear predicate for result type *)
isHierarchicalResult[result_] :=
	MatchQ[result, {__Association}] && Length[result] > 0 && KeyExistsQ[First[result], "A"]


(* ::Subsection:: *)
(*toNum*)


(* ::Subsection:: *)
(*Internal Dispatcher and Evaluator*)


(* Internal dispatcher: Routes to Rules extraction or expression evaluation *)
iToNumDispatch["Rules", model_, rest___] := toNumRules[model, rest];

iToNumDispatch[expr_, model_, Longest[newParams : ({(_Rule)...} | _Association) : {}, 1], opts:OptionsPattern[{toNumRules, updateCoeffs}]] :=
	toNumEvaluate[expr, model, newParams, opts];


(* Internal evaluator: Handles expression evaluation with rules *)
toNumEvaluate[expr_, model_, Longest[newParams : ({(_Rule)...} | _Association) : {}, 1], opts:OptionsPattern[{toNumRules, updateCoeffs}]] :=
Module[{rulesOrSol, allParams, transformed},
	(* Get rules or hierarchical structure *)
	rulesOrSol = toNumRules[model, newParams, opts];
	If[FailureQ[rulesOrSol], Return[rulesOrSol]];

	(* Compute all parameters *)
	allParams = Normal@Join[
		Association@model["params"],
		Association@processNewParameters[newParams, model["params"]]
	];

	(* Transform expression to equation form *)
	transformed = toEquation[expr, model];

	(* Evaluate: hierarchical or flat *)
	If[isHierarchicalResult[rulesOrSol],
		evaluateExprHierarchical[transformed, model, rulesOrSol, allParams],
		applyRules[transformed, rulesOrSol]
	]
]


(* ::Subsection:: *)
(*Public toNum Interface*)


(* ::Text:: *)
(* Fix for infinite recursion issue: *)
(* The problem was that toNum["Rules", model] would match the generic expr_ pattern,*)
(* which then called toNum["Rules", model, newParameters, opts], matching again,*)
(* creating an infinite loop: toNum["Rules", m] -> toNum["Rules", m, {}] -> ... *)
(* *)
(* Solution: Add explicit "Rules" patterns that prevent fallthrough to generic expr pattern *)

(* Explicit patterns for toNum["Rules", ...] to prevent matching generic expr_ pattern *)
(* Pattern 1: toNum["Rules", model] with no additional arguments *)
toNum["Rules", model_Association] := iToNumDispatch["Rules", model];

(* Pattern 2: toNum["Rules", model, rest...] with additional arguments *)
toNum["Rules", model_Association, rest__] := iToNumDispatch["Rules", model, rest];

(* Pattern 3: Expression evaluation with full arguments *)
toNum[
	expr_ /; Not@AssociationQ[expr] && expr =!= "Rules",
	model_Association,
	Longest[newParameters : ({(_Rule) ...} | _Association) : {}, 1],
	opts : OptionsPattern[{toNumRules, updateCoeffs}]
] := iToNumDispatch[expr, model, newParameters, opts];

(* Pattern 4: Curried form - returns function *)
toNum[model_Association, rest__] := Function[{expr}, toNum[expr, model, rest]]

(* Pattern 5: Simple expression evaluation without parameters *)
toNum[expr_ /; Not@AssociationQ[expr] && expr =!= "Rules", model_Association] :=
	iToNumDispatch[expr, model];

(* Pattern 6: Curried form with no parameters *)
toNum[model_Association] := toNum[model, {}]


(* ::Subsection:: *)
(*Hierarchical Evaluation Helpers*)


(* Simplified evaluator: always evaluate all coefficients via Cartesian product *)
evaluateExprHierarchical[expr_, model_, solHierarchical_, allParams_] := Flatten[
	Map[
		Function[aSol,
			With[{baseMeta = KeyDrop[aSol, {"A", "Stocks", "Bond", "NomBond"}]},
				Map[
					Function[bIndices,
						With[{rules = Join[flattenCoeffsForIndices[aSol, bIndices], allParams]},
							Join[
								baseMeta,
								If[Length[bIndices] > 0, <|"BIndices" -> bIndices|>, <||>],
								<|"Value" -> applyRules[expr, rules]|>
							]
						]
					],
					allBIndexCombinations[aSol]
				]
			]
		],
		solHierarchical
	],
	1
];


(* Options for toNumRules *)
Options[toNumRules] = {
	"SolutionSelector" -> Automatic,
	"ReturnAllSolutions" -> False
};

toNumRules[
	model_Association,
	Longest[newParameters : ({(_Rule)...} | _Association) : {}, 1],
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

	(* Debug output disabled to prevent output bloat *)
	(* Echo[newParameters,"newParameters"];
	Echo[guessCoeffsSolution,"guessCoeffsSolution"];
	Echo[{opts},"optstoNumRules"]; *)

	(* Validate ReturnAllSolutions option *)
	If[!MatchQ[returnAllOpt, True | False],
		Message[toNum::badreturnall, returnAllOpt];
		Return[makeFailure["InvalidOption", toNum::badreturnall, {returnAllOpt}]]
	];

	(* Determine effective selector: when ReturnAllSolutions->True and selector is Automatic, use All *)
	With[{effectiveSelector = If[returnAllOpt && selectorOpt === Automatic, All, selectorOpt]},

		(* Validate SolutionSelector -> All requires ReturnAllSolutions -> True *)
		If[effectiveSelector === All && !returnAllOpt,
			Message[toNum::selectorallrequiresreturnall];
			Return[makeFailure["InvalidOption", toNum::selectorallrequiresreturnall]]
		];

		With[{newParams = processNewParameters[newParameters, params]},
			(* Propagate Failure from processNewParameters *)
			If[FailureQ[newParams],
				newParams,
				With[{allParams = Normal @ Join[Association @ params, Association @ newParams]},
				(* Echo[allParams,"allParams"]; *)
					With[{solHierarchical = updateCoeffs[model, {}, newParameters, guessCoeffsSolution, "UpdatePd" -> True, "UpdateBonds" -> True, optsUpdateCoeffs]},
					(* Echo[solHierarchical,"solHierarchical"]; *)
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
	]
];

(* Helper: Select and format solutions based on selector and returnAll options *)
selectAndFormatSolutions[solHierarchical_List, selector_, returnAll_, allParams_, uncondEwc_, uncondEpd_, numStocks_] := Module[
	{selectedSolutions},

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
	(* Safety check: if no solutions found, return Failure *)
	If[numASolutions == 0,
		Message[toNum::nosolution, selector];
		Return[makeFailure["NoSolution", toNum::nosolution, {selector}]]
	];

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
				makeFailure["IndexOutOfRange", toNum::badidx, {selector, numASolutions}],
				{solHierarchical[[selector]]}
			],

		(* Invalid integer (zero, negative) *)
		_Integer,
			Message[toNum::badidx, selector, numASolutions];
			makeFailure["IndexOutOfRange", toNum::badidx, {selector, numASolutions}],

		(* Non-integer Real (like 1.5) *)
		_Real,
			Message[toNum::badselector, selector];
			makeFailure["InvalidSelector", toNum::badselector, {selector}],

		(* Tuple {aIdx, bIdx} *)
		{_Integer, _Integer},
			selectByTupleIndex[solHierarchical, selector, numStocks],

		(* Association selector (SignsA, SignsB, SolutionIndexA) *)
		_Association,
			selectByAssociation[solHierarchical, selector, numStocks],

		(* Invalid list (wrong length, non-integers, nested, empty) *)
		_List,
			Message[toNum::badselector, selector];
			makeFailure["InvalidSelector", toNum::badselector, {selector}],

		(* Any other invalid selector *)
		_,
			Message[toNum::badselector, selector];
			makeFailure["InvalidSelector", toNum::badselector, {selector}]
	]
];

(* Helper: Select by tuple index {aIdx, bIdx} *)
selectByTupleIndex[solHierarchical_List, {aIdx_Integer, bIdx_Integer}, numStocks_] := Module[
	{numASolutions = Length[solHierarchical], aSol, stockKeys, invalidStock},

	(* Validate A index *)
	Which[
		aIdx < 1 || aIdx > numASolutions,
			Message[toNum::badidx, aIdx, numASolutions];
			makeFailure["IndexOutOfRange", toNum::badidx, {aIdx, numASolutions}],

		bIdx < 1,
			Message[toNum::badbidx, bIdx, 1, "varies"];
			makeFailure["IndexOutOfRange", toNum::badbidx, {bIdx, 1, "varies"}],

		True,
			aSol = solHierarchical[[aIdx]];
			stockKeys = Keys[aSol["Stocks"]];

			(* Find first stock where bIdx is out of range *)
			invalidStock = SelectFirst[stockKeys, Length[aSol["Stocks"][#]] < bIdx &, None];

			If[invalidStock =!= None,
				With[{numBSols = Length[aSol["Stocks"][invalidStock]]},
					Message[toNum::badbidx, bIdx, invalidStock, numBSols];
					makeFailure["IndexOutOfRange", toNum::badbidx, {bIdx, invalidStock, numBSols}]
				],
				(* All validations passed - return modified A solution *)
				{buildASolutionAssoc[
					aSol,
					Association @ Table[
						stockKey -> {aSol["Stocks"][stockKey][[bIdx]]},
						{stockKey, stockKeys}
					]
				]}
			]
	]
];

(* Helper: Select by association (SignsA, SignsB, SolutionIndexA) *)
selectByAssociation[solHierarchical_List, selector_Association, numStocks_] := Module[
	{validKeys, selectorKeys, matchingASols},

	validKeys = {"SignsA", "SignsB", "SolutionIndexA"};
	selectorKeys = Keys[selector];

	(* Check for invalid keys *)
	If[!SubsetQ[validKeys, selectorKeys],
		Message[toNum::badselector, selector];
		Return[makeFailure["InvalidSelector", toNum::badselector, {selector}]]
	];

	(* Empty association is invalid *)
	If[Length[selector] == 0,
		Message[toNum::badselector, selector];
		Return[makeFailure["InvalidSelector", toNum::badselector, {selector}]]
	];

	(* Validate SignsA if present *)
	If[KeyExistsQ[selector, "SignsA"],
		With[{signsA = selector["SignsA"]},
			Which[
				!ListQ[signsA],
					Message[toNum::badselector, selector];
					Return[makeFailure["InvalidSelector", toNum::badselector, {selector}]],
				signsA === {},
					Message[toNum::emptysigns];
					Return[makeFailure["EmptySigns", toNum::emptysigns]]
			]
		]
	];

	(* Validate SolutionIndexA if present *)
	If[KeyExistsQ[selector, "SolutionIndexA"],
		With[{idxA = selector["SolutionIndexA"]},
			If[!IntegerQ[idxA],
				Message[toNum::badselector, selector];
				Return[makeFailure["InvalidSelector", toNum::badselector, {selector}]]
			]
		]
	];

	(* Filter A solutions by SignsA and/or SolutionIndexA *)
	matchingASols = Select[solHierarchical, Function[aSol,
		And[
			If[KeyExistsQ[selector, "SignsA"], aSol["SignsA"] == selector["SignsA"], True],
			If[KeyExistsQ[selector, "SolutionIndexA"], aSol["SolutionIndexA"] == selector["SolutionIndexA"], True]
		]
	]];

	If[Length[matchingASols] == 0,
		Message[toNum::nosolution, selector];
		Return[makeFailure["NoSolution", toNum::nosolution, {selector}]]
	];

	(* If SignsB is specified, filter B solutions within each A solution *)
	If[KeyExistsQ[selector, "SignsB"],
		matchingASols = Map[Function[aSol,
			With[{filteredStocks = Association @ KeyValueMap[
				Function[{stockKey, bSolList},
					stockKey -> Select[bSolList, #["SignsB"] == selector["SignsB"] &]
				],
				aSol["Stocks"]
			]},
				(* Check that at least one B solution matches for each stock that has solutions *)
				If[AnyTrue[Values[filteredStocks], Length[#] == 0 &],
					Nothing,
					buildASolutionAssoc[aSol, filteredStocks]
				]
			]
		], matchingASols];

		(* Remove Nothing entries *)
		matchingASols = DeleteCases[matchingASols, Nothing];

		If[Length[matchingASols] == 0,
			Message[toNum::nosolution, selector];
			Return[makeFailure["NoSolution", toNum::nosolution, {selector}]]
		]
	];

	(* Final safety check before returning *)
	If[Length[matchingASols] == 0,
		Message[toNum::nosolution, selector];
		Return[makeFailure["NoSolution", toNum::nosolution, {selector}]]
	];

	(* Return first matching solution (for determinism) *)
	{First[matchingASols]}
];

(* Helper: Check if an A solution has valid (non-empty) B solutions for all stocks *)
hasValidBSolutions[aSol_Association] := AllTrue[
	Values[aSol["Stocks"]],
	Length[#] > 0 &
];

(* Helper: Flatten all rules for one A solution with specific B indices *)
flattenCoeffsForIndices[aSol_Association, bIndices_Association] := Join[
	Normal[aSol["A"]],
	Flatten @ KeyValueMap[
		Normal[aSol["Stocks"][#1][[#2]]["B"]] &,
		bIndices
	],
	If[!MissingQ[aSol["Bond"]], Normal[aSol["Bond"]], {}],
	If[!MissingQ[aSol["NomBond"]], Normal[aSol["NomBond"]], {}]
]

(* Helper: Generate all B index combinations for an A solution *)
allBIndexCombinations[aSol_Association] := With[
	{stockKeys = Keys[aSol["Stocks"]]},
	If[Length[stockKeys] == 0,
		{<||>},
		Map[
			AssociationThread[stockKeys, #] &,
			Tuples[Table[Range[Length[aSol["Stocks"][sk]]], {sk, stockKeys}]]
		]
	]
]

(* Helper: Flatten coefficients from selected solutions based on selector type *)
flattenCoeffsFromSelected[selectedSolutions_List, selector_, numStocks_] := Module[
	{aSol, stockKeys},

	(* Safety check: ensure we have at least one solution *)
	If[Length[selectedSolutions] == 0,
		Message[toNum::nosolution, selector];
		Return[makeFailure["NoSolution", toNum::nosolution, {selector}]]
	];

	aSol = First[selectedSolutions];
	stockKeys = Keys[aSol["Stocks"]];
	If[!hasValidBSolutions[aSol],
		Message[toNum::nobsolutions];
		makeFailure["NoBSolutions", toNum::nobsolutions],
		(* Use helper with all indices = 1 *)
		flattenCoeffsForIndices[aSol, AssociationThread[stockKeys, ConstantArray[1, Length[stockKeys]]]]
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
(*modelEval*)


(* Moment symbols that need model injection *)
$MomentSymbols = {
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
};


modelEval::usage = "modelEval[expr, model] evaluates moments in expr using model.
	For example,
		modelEval[uncondE[dc[t]]+uncondCov[x[t],x[t+1]]+cov[dc[t+1],dc[t+2],t], model]
	gives the same as
		uncondE[dc[t],model]+uncondCov[x[t],x[t+1],model]+cov[dc[t+1],dc[t+2],t,model]
";


(* Simple pattern-based model injection *)
modelEval[expr_, model_] := expr /.
	(f_ /; MemberQ[$MomentSymbols, f])[args___] :> f[args, model];


(* ::Subsection:: *)
(*processNewParameters*)


processNewParameters::psi="psi=1 implies a constant wealth-consumption ratio, please choose a different psi.";
processNewParameters::param="theta must equal (1-gamma)/(1-1/psi), replacing theta by (1-gamma)/(1-1/psi)=`1`.";
processNewParameters::theta="Please provide psi or gamma with theta.";
processNewParameters::subsetparam="Parameters `1` in newParameters are not a subset of parameters.";


(* Helper: Parse symbol into {context, name} or {context, name, index} *)
splitParamKey[sym_Symbol] := {Context[sym], SymbolName[sym]}
splitParamKey[sym_Symbol[idx_Integer]] := {Context[sym], SymbolName[sym], idx}


(* Helper: Apply key splitting to association *)
normalizeParamKeys[params_] := KeyMap[splitParamKey, Association[params]]


(* Helper: Validate new params are subset of base params *)
validateParamSubset[newNorm_, baseNorm_] := Module[{newKeys, baseKeys, invalid},
	newKeys = Rest /@ Keys[newNorm];  (* Drop context *)
	baseKeys = Rest /@ Keys[baseNorm];
	invalid = Pick[Keys[newNorm], MemberQ[baseKeys, #]& /@ newKeys, False];
	If[invalid =!= {},
		Message[processNewParameters::subsetparam, invalid];
		makeFailure["InvalidParameters", processNewParameters::subsetparam, {invalid}],
		Success["Validation", <|"ValidatedParams" -> newNorm|>]
	]
]


(* Helper: Handle gamma/psi/theta constraints *)
enforceGammaPsiTheta[paramsNorm_] := Module[
	{paramsStr, gamma, psi, theta, count, thetaNew, paramContext},

	(* Early return if no parameters *)
	If[Length[paramsNorm] == 0, Return[paramsNorm]];

	(* Extract context from first parameter (all should have same context) *)
	paramContext = First[Keys[paramsNorm]][[1]];

	(* Convert to string-keyed lookup *)
	paramsStr = Normal@KeyMap[#[[2]]&, paramsNorm];

	(* Extract values *)
	gamma = Lookup[paramsStr, "gamma", Missing[]];
	psi = Lookup[paramsStr, "psi", Missing[]];
	theta = Lookup[paramsStr, "theta", Missing[]];

	(* Check psi=1 *)
	If[!MissingQ[psi] && N[psi] === 1.,
		Message[processNewParameters::psi];
		Return[makeFailure["InvalidPsi", processNewParameters::psi, {}]]
	];

	(* Count how many of {gamma, psi, theta} are provided *)
	count = Count[{gamma, psi, theta}, _?(!MissingQ[#]&)];

	Switch[count,
		3, (* All provided - validate theta *)
			thetaNew = (1 - gamma)/(1 - 1/psi);
			If[RealAbs[theta - thetaNew] >= $MachineEpsilon,
				Message[processNewParameters::param, thetaNew]
			];
			(* Remove old theta and insert computed one *)
			Prepend[
				KeySelect[paramsNorm, #[[2]] =!= "theta" &],
				{paramContext, "theta"} -> thetaNew
			],
		2, (* Two provided - solve for third *)
			Which[
				MissingQ[gamma],
					(* Solve: gamma = 1 - theta*(1 - 1/psi) *)
					Prepend[paramsNorm, {paramContext, "gamma"} -> (1 - theta*(1 - 1/psi))],
				MissingQ[psi],
					(* Solve: psi = 1/(1 - (1-gamma)/theta) *)
					Prepend[paramsNorm, {paramContext, "psi"} -> (1/(1 - (1 - gamma)/theta))],
				MissingQ[theta],
					(* Solve: theta = (1-gamma)/(1-1/psi) *)
					Prepend[paramsNorm, {paramContext, "theta"} -> ((1 - gamma)/(1 - 1/psi))]
			],
		1, (* One provided *)
			If[!MissingQ[theta],
				Message[processNewParameters::theta];
				makeFailure["MissingParams", processNewParameters::theta, {}],
				paramsNorm
			],
		_, (* Zero or other *)
			paramsNorm
	]
]


(* Helper: Map normalized keys back to original contexts *)
reconcileContexts[processedNorm_, baseParams_] := Module[{baseSplit, positions},
	baseSplit = normalizeParamKeys[baseParams];
	positions = Position[Rest /@ Keys[baseSplit], #]& /@ (Rest /@ Keys[processedNorm]);
	Thread[Extract[Keys[Association[baseParams]], Flatten[positions, 1]] -> Values[processedNorm]]
]


processNewParameters[newParameters : {___Rule} | _Association, parameters : {___Rule} | _Association] :=
Module[{newNorm, baseNorm, validated, constrained},
	(* Empty parameters - return empty *)
	If[newParameters === {}, Return[{}]];

	(* Normalize parameters with repeated substitution *)
	newNorm = normalizeParamKeys[(Association@newParameters) //. newParameters //. parameters];
	baseNorm = normalizeParamKeys[(Association@parameters) //. parameters];

	(* Validate subset *)
	validated = validateParamSubset[newNorm, baseNorm];
	If[FailureQ[validated], Return[validated]];

	(* Enforce gamma/psi/theta constraints *)
	constrained = enforceGammaPsiTheta[newNorm];
	If[FailureQ[constrained], Return[constrained]];

	(* Reconcile contexts and return *)
	reconcileContexts[constrained, parameters]
]


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
