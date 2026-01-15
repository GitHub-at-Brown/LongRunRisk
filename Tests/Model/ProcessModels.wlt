(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Model/ProcessModels.wl Tests*)


BeginTestSection["Kernel/Model/ProcessModels.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`"]

Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"];
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["PacletizedResourceFunctions`"];


(* ::Subsection:: *)
(*Load Test Helpers*)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "ModelTestHelpers.wl"}];


(* ::Subsection:: *)
(*Test Setup*)


(* Load pre-processed models from Models.wl resource *)
FernandoDuarte`LongRunRisk`Models = Get[Get[FileNameJoin[{"FernandoDuarte/LongRunRisk", "Models.wl"}]]];

(* Raw catalog models for comparison *)
$modelsTest = KeyTake[models, {"BY", "BKY", "NRC"}];

(* Pre-processed models subset for testing *)
$modelsP = KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC"}];

(* Common test predicates *)
$endoVarBaseNames = StringDrop[#, -2] & /@ $endogenousVars;


(* ::Subsection:: *)
(*processModels - Basic Structure Tests*)


(* Test: Model keys are strings *)
TestCreate[
	AllTrue[Keys[$modelsP], StringQ],
	True,
	{},
	TestID -> "[processModels] Model keys are strings",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: String fields have correct type including exogenousVars and endogenousVars *)
TestCreate[
	AllTrue[Values[$modelsP],
		Function[model,
			AllTrue[
				Flatten[Lookup[model, {"name", "shortname", "bibRef", "desc", "exogenousVars", "endogenousVars"}]],
				StringQ
			]
		]
	],
	True,
	{},
	TestID -> "[processModels] String fields including variable lists are strings",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Parameters evaluate to numbers after substitution *)
TestCreate[
	Module[{checkModel},
		checkModel[model_Association] := With[
			{params = model["parameters"]},
			AllTrue[Flatten[Values[Association@params //. params // N]], NumericQ]
		];
		AllTrue[Values[$modelsP], checkModel] &&
		AllTrue[Values[$modelsTest], checkModel]
	],
	True,
	{},
	TestID -> "[processModels] Parameters evaluate to numbers after substitution",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Known models are present *)
TestCreate[
	SubsetQ[Keys[$modelsTest], {"BY", "BKY"}] &&
	SubsetQ[Keys[$modelsP], {"BY", "BKY", "NRC"}],
	True,
	{},
	TestID -> "[processModels] Known models BY, BKY, NRC are present",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Models are associations and each model is also an association *)
TestCreate[
	AllTrue[Values[$modelsTest], AssociationQ] &&
	AllTrue[Values[$modelsP], AssociationQ],
	True,
	{},
	TestID -> "[processModels] Models and their values are Associations",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*processModels - StateVars Function Structure Tests*)


(* Test: stateVars are functions *)
TestCreate[
	AllTrue[Values[$modelsP], MatchQ[#["stateVars"], _Function] &],
	True,
	{},
	TestID -> "[processModels] StateVars field is a Function",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: stateVars applied to t returns a List *)
TestCreate[
	AllTrue[Values[$modelsP], ListQ[#["stateVars"][t]] &],
	True,
	{},
	TestID -> "[processModels] StateVars applied to t returns List",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: stateVars function takes one argument *)
TestCreate[
	AllTrue[Values[$modelsP],
		Function[model,
			With[{f = model["stateVars"]},
				(* Function has form Function[{args}, body] where args is a single symbol *)
				MatchQ[f, _Function] && Length[f[[1]]] === 1
			]
		]
	],
	True,
	{},
	TestID -> "[processModels] StateVars function takes single argument",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: stateVars function argument is named t *)
TestCreate[
	AllTrue[Values[$modelsP],
		Function[model,
			With[{f = model["stateVars"]},
				(* The single argument should be a symbol named "t" *)
				Head[f[[1, 1]]] === Symbol && SymbolName[f[[1, 1]]] === "t"
			]
		]
	],
	True,
	{},
	TestID -> "[processModels] StateVars function argument is named t",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: stateVars evaluated at t matches raw catalog stateVars *)
TestCreate[
	AllTrue[Keys[$modelsP],
		Function[key,
			$modelsP[key]["stateVars"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] ===
			$modelsTest[key]["stateVars"]
		]
	],
	True,
	{},
	TestID -> "[processModels] StateVars at t matches raw catalog stateVars",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*processModels - Numeric Field Tests*)


(* Test: numStocks is a number *)
TestCreate[
	AllTrue[Values[$modelsP], NumberQ[#["numStocks"]] &],
	True,
	{},
	TestID -> "[processModels] NumStocks field is numeric",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*processModels - Variable Exclusion Tests*)


(* Test: stateVars do not contain endogenous variables *)
TestCreate[
	AllTrue[Values[$modelsP],
		Function[model,
			FreeQ[
				model["stateVars"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t],
				var_Symbol?(MemberQ[$endoVarBaseNames, SymbolName[#]] &)[__]
			]
		]
	],
	True,
	{},
	TestID -> "[processModels] StateVars exclude endogenous variables",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: exogenousEq does not contain endogenous variables *)
TestCreate[
	AllTrue[Values[$modelsP],
		Function[model,
			FreeQ[
				Values[model["exogenousEq"]],
				var_Symbol?(MemberQ[$endoVarBaseNames, SymbolName[#]] &)[__]
			]
		]
	],
	True,
	{},
	TestID -> "[processModels] ExogenousEq excludes endogenous variables",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*processModels - Model Key and Shortname Preservation Tests*)


(* Test: Keys and shortnames are preserved after processing *)
TestCreate[
	SubsetQ[Keys[$modelsTest], Keys[$modelsP]] &&
	SubsetQ[
		#["shortname"] & /@ Values[$modelsTest],
		#["shortname"] & /@ Values[$modelsP]
	],
	True,
	{},
	TestID -> "[processModels] Keys and shortnames preserved after processing",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*processModels - Equation Key Structure Tests*)


(* Test: Keys in exogenousEq are PatternTest expressions *)
TestCreate[
	AllTrue[Keys[$modelsP["BKY"]["exogenousEq"]], MatchQ[#, _PatternTest] &],
	True,
	{},
	TestID -> "[processModels] ExogenousEq keys are PatternTest expressions",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Keys in endogenousEq are PatternTest expressions *)
TestCreate[
	AllTrue[Keys[$modelsP["BKY"]["endogenousEq"]], MatchQ[#, _PatternTest] &],
	True,
	{},
	TestID -> "[processModels] EndogenousEq keys are PatternTest expressions",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*processModels - Equation Evaluation Tests*)


(* Test: equations evaluate dc, dd, wc, sdf, bondyield *)
Block[{tVar, i},
	TestCreate[
		Module[{checkEvaluates},
			checkEvaluates[model_Association, var_] := With[
				{eqs = Normal[Join[model["exogenousEq"], model["endogenousEq"]]]},
				(var /. eqs) =!= var
			];
			AllTrue[Values[$modelsP], checkEvaluates[#, dc[tVar]] &] &&
			AllTrue[Values[$modelsP], checkEvaluates[#, dd[tVar, i]] &] &&
			AllTrue[Values[$modelsP], checkEvaluates[#, wc[tVar]] &] &&
			AllTrue[Values[$modelsP], checkEvaluates[#, sdf[tVar]] &] &&
			AllTrue[Values[$modelsP], checkEvaluates[#, bondyield[tVar]] &]
		],
		True,
		{},
		TestID -> "[processModels] Equations evaluate dc, dd, wc, sdf, bondyield",
	MetaInformation -> <|"Category" -> "extended"|>
	]
]

(* Test: equations do not evaluate non-variables *)
Block[{tVar, notVar},
	TestCreate[
		AllTrue[Values[$modelsP],
			Function[model,
				With[{eqs = Normal[Join[model["exogenousEq"], model["endogenousEq"]]]},
					(notVar[tVar] /. eqs) === notVar[tVar]
				]
			]
		],
		True,
		{},
		TestID -> "[processModels] Equations do not evaluate non-variables",
	MetaInformation -> <|"Category" -> "extended"|>
	]
]


(* ::Subsection:: *)
(*processModels - Coefficient Solution Tests*)


(* Test: A and B coefficients are numeric *)
TestCreate[
	AllTrue[Values[$modelsP],
		Function[model,
			AllTrue[
				Flatten[Values /@ {
					model["coeffsSolutionN"][[1, "A"]],
					model["coeffsSolutionN"][[1, "Stocks", 1, 1, "B"]]
				}],
				NumberQ
			]
		]
	],
	True,
	{},
	TestID -> "[processModels] A and B coefficients are numeric",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Bond values are numeric or Missing sentinel *)
TestCreate[
	AllTrue[Values[$modelsP],
		Function[model,
			AllTrue[
				Flatten[Values /@ {
					model["coeffsSolutionN"][[1, "Bond"]],
					model["coeffsSolutionN"][[1, "NomBond"]]
				}],
				(NumberQ[#] || MatchQ[#, _Missing]) &
			]
		]
	],
	True,
	{},
	TestID -> "[processModels] Bond values are numeric or Missing sentinel",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*processModels - Model Renaming Tests*)


(* Helper: Normalize logical expressions by sorting their arguments canonically.
   This handles non-deterministic term ordering from parallel evaluation.
   And/Or are Flat but not Orderless, so their argument order is not canonical.
   Uses Replace[..., All] to handle nested expressions. *)
normalizeLogicalExpr[expr_] := Replace[
	expr,
	{e_And :> And @@ Sort[List @@ e], e_Or :> Or @@ Sort[List @@ e]},
	All
];

(* Helper: Normalize coeffsParamQuadSolve subassociation by dropping
   non-deterministic fields and sorting logical expressions.
   We apply normalizeLogicalExpr to the entire sub-association after dropping
   non-deterministic keys to catch And/Or expressions anywhere in the structure
   (including in eqA0, eqB0, Solution rules, etc.). *)
normalizeCoeffsParamQuadSolve[assoc_Association] := Map[
	KeyDrop[{"Maps", "Diagnostics"}] /* normalizeLogicalExpr,
	assoc
];

(* Helper: Compare processed models by normalizing fields that may have
   non-deterministic content (unique symbols, timing, expression ordering).
   - coeffsSolution: Contains functions with potential numeric precision differences
   - coeffsSystem: Contains simplified expressions from ParallelMap/LocalEvaluate
     which may have different term orderings from parallel execution
   - coeffsParamQuadSolve["Maps"]: Contains CoeffMap with Unique symbols
   - coeffsParamQuadSolve["Diagnostics"]: Contains TimingSeconds and metadata
   - coeffsParamQuadSolve[*]["Assumptions"/"Conditions"]: And/Or expressions with
     potentially different term ordering from parallel/LocalEvaluate execution
   - modelAssumptions: And expression with potentially different term ordering *)
normalizeProcessedModel[m_Association] := m //
	KeyDrop[{"coeffsSolution", "coeffsSystem"}] //
	MapAt[normalizeCoeffsParamQuadSolve, Key["coeffsParamQuadSolve"]] //
	MapAt[normalizeLogicalExpr, Key["modelAssumptions"]];

(* Test: Pre-processed models match expected structure for BKY *)
TestCreate[
	KeyExistsQ[$modelsP, "BKY"] &&
	AssociationQ[$modelsP["BKY"]] &&
	KeyExistsQ[$modelsP["BKY"], "modelAssumptions"] &&
	KeyExistsQ[$modelsP["BKY"], "coeffsParamQuadSolve"],
	True,
	{},
	TestID -> "[processModels] Output structure is invariant to input key for BKY",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Pre-processed models match expected structure for BY *)
TestCreate[
	KeyExistsQ[$modelsP, "BY"] &&
	AssociationQ[$modelsP["BY"]] &&
	KeyExistsQ[$modelsP["BY"], "modelAssumptions"] &&
	KeyExistsQ[$modelsP["BY"], "coeffsParamQuadSolve"],
	True,
	{},
	TestID -> "[processModels] Output structure is invariant to input key for BY",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Batch processing preserves isolation - check BY has independent structure *)
TestCreate[
	Module[{byKeys, bkyKeys},
		byKeys = Keys[$modelsP["BY"]["coeffsParamQuadSolve"]];
		bkyKeys = Keys[$modelsP["BKY"]["coeffsParamQuadSolve"]];
		AssociationQ[$modelsP["BY"]] &&
		AssociationQ[$modelsP["BKY"]] &&
		Length[byKeys] > 0 &&
		Length[bkyKeys] > 0
	],
	True,
	{},
	TestID -> "[processModels] Batch processing preserves isolation between models",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*processModels - Context Isolation Tests*)


(* Test: Context isolation for exogenousEq/endogenousEq symbols *)
TestCreate[
	Module[{exoNames, paramNames},
		exoNames = StringDrop[#, -2] & /@ FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars;
		paramNames = FernandoDuarte`LongRunRisk`Model`Parameters`$parameters;
		And[
			checkModelsFieldContext[$modelsP, "exogenousEq", "functionHead", exoNames,
				"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
			checkModelsFieldContext[$modelsP, "endogenousEq", "functionHead", exoNames,
				"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
			checkModelsFieldContext[$modelsP, "exogenousEq", "curriedHead", {"eps"},
				"FernandoDuarte`LongRunRisk`Model`Shocks`"],
			checkModelsFieldContext[$modelsP, "endogenousEq", "curriedHead", {"eps"},
				"FernandoDuarte`LongRunRisk`Model`Shocks`"],
			checkModelsFieldContext[$modelsP, "exogenousEq", "bareSymbol", paramNames,
				"FernandoDuarte`LongRunRisk`Model`Parameters`"],
			checkModelsFieldContext[$modelsP, "endogenousEq", "bareSymbol", paramNames,
				"FernandoDuarte`LongRunRisk`Model`Parameters`"]
		]
	],
	True,
	{},
	TestID -> "[processModels] Context isolation for all equation symbols",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*processModels - Equation Structural Integrity Tests*)


(* Test: NRC pi[t] structural equation is preserved *)
TestCreate[
	Module[{modelPNRC, piExpanded, expected},
		modelPNRC = $modelsP["NRC"];
		piExpanded = FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[myT] /.
			Normal[modelPNRC["exogenousEq"]];
		expected = FernandoDuarte`LongRunRisk`Model`Parameters`mup +
			FernandoDuarte`LongRunRisk`Model`Parameters`rhop *
				(FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[myT - 1] -
				 FernandoDuarte`LongRunRisk`Model`Parameters`mup) +
			FernandoDuarte`LongRunRisk`Model`Parameters`xip *
				FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][myT - 1] +
			FernandoDuarte`LongRunRisk`Model`Parameters`phip *
				FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][myT];
		piExpanded === expected
	],
	True,
	{},
	TestID -> "[processModels] NRC pi[t] structural equation is preserved",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*processModels - Model Renaming Tests*)


(* Test: processModels respects model renaming - key name doesn't leak into computed values *)
(* Verifies that computed mathematical values don't contain the model key name as a symbol *)
(* Excludes descriptive fields (name, shortname, bibRef, desc) which legitimately contain model identifiers *)
TestCreate[
	Module[{modelData, keyNames, values, valuesStr},
		(* Get the BY model from pre-processed models *)
		modelData = $modelsP["BY"];
		keyNames = {"BY", "BKY", "NRC"};
		(* Get string representation of computed values only (excluding descriptive fields) *)
		values = Values[KeyDrop[modelData, {"name", "shortname", "bibRef", "desc", "coeffsSolution", "coeffsSolutionN"}]];
		valuesStr = ToString[values, InputForm];
		(* Verify none of the test model key names appear in computed values *)
		NoneTrue[keyNames, StringContainsQ[valuesStr, #] &]
	],
	True,
	{},
	TestID -> "[processModels] Respects model renaming",
	MetaInformation -> <|"Category" -> "extended"|>
]


End[]
EndTestSection[]
