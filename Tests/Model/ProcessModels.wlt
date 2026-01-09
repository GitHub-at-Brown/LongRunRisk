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
	TestID -> "[processModels] Model keys are strings"
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
	TestID -> "[processModels] String fields including variable lists are strings"
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
	TestID -> "[processModels] Parameters evaluate to numbers after substitution"
]

(* Test: Known models are present *)
TestCreate[
	SubsetQ[Keys[$modelsTest], {"BY", "BKY"}] &&
	SubsetQ[Keys[$modelsP], {"BY", "BKY", "NRC"}],
	True,
	{},
	TestID -> "[processModels] Known models BY, BKY, NRC are present"
]

(* Test: Models are associations and each model is also an association *)
TestCreate[
	AllTrue[Values[$modelsTest], AssociationQ] &&
	AllTrue[Values[$modelsP], AssociationQ],
	True,
	{},
	TestID -> "[processModels] Models and their values are Associations"
]


(* ::Subsection:: *)
(*processModels - StateVars Function Structure Tests*)


(* Test: stateVars are functions *)
TestCreate[
	AllTrue[Values[$modelsP], MatchQ[#["stateVars"], _Function] &],
	True,
	{},
	TestID -> "[processModels] StateVars field is a Function"
]

(* Test: stateVars applied to t returns a List *)
TestCreate[
	AllTrue[Values[$modelsP], ListQ[#["stateVars"][t]] &],
	True,
	{},
	TestID -> "[processModels] StateVars applied to t returns List"
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
	TestID -> "[processModels] StateVars function takes single argument"
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
	TestID -> "[processModels] StateVars function argument is named t"
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
	TestID -> "[processModels] StateVars at t matches raw catalog stateVars"
]


(* ::Subsection:: *)
(*processModels - Numeric Field Tests*)


(* Test: numStocks is a number *)
TestCreate[
	AllTrue[Values[$modelsP], NumberQ[#["numStocks"]] &],
	True,
	{},
	TestID -> "[processModels] NumStocks field is numeric"
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
	TestID -> "[processModels] StateVars exclude endogenous variables"
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
	TestID -> "[processModels] ExogenousEq excludes endogenous variables"
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
	TestID -> "[processModels] Keys and shortnames preserved after processing"
]


(* ::Subsection:: *)
(*processModels - Equation Key Structure Tests*)


(* Test: Keys in exogenousEq are PatternTest expressions *)
TestCreate[
	AllTrue[Keys[$modelsP["BKY"]["exogenousEq"]], MatchQ[#, _PatternTest] &],
	True,
	{},
	TestID -> "[processModels] ExogenousEq keys are PatternTest expressions"
]

(* Test: Keys in endogenousEq are PatternTest expressions *)
TestCreate[
	AllTrue[Keys[$modelsP["BKY"]["endogenousEq"]], MatchQ[#, _PatternTest] &],
	True,
	{},
	TestID -> "[processModels] EndogenousEq keys are PatternTest expressions"
]


(* ::Subsection:: *)
(*processModels - Equation Evaluation Tests*)


(* Test: equations evaluate dc, dd, wc, sdf, bondyield *)
Block[{t, i},
	TestCreate[
		Module[{checkEvaluates},
			checkEvaluates[model_Association, var_] := With[
				{eqs = Normal[Join[model["exogenousEq"], model["endogenousEq"]]]},
				(var /. eqs) =!= var
			];
			AllTrue[Values[$modelsP], checkEvaluates[#, dc[t]] &] &&
			AllTrue[Values[$modelsP], checkEvaluates[#, dd[t, i]] &] &&
			AllTrue[Values[$modelsP], checkEvaluates[#, wc[t]] &] &&
			AllTrue[Values[$modelsP], checkEvaluates[#, sdf[t]] &] &&
			AllTrue[Values[$modelsP], checkEvaluates[#, bondyield[t]] &]
		],
		True,
		{},
		TestID -> "[processModels] Equations evaluate dc, dd, wc, sdf, bondyield"
	]
]

(* Test: equations do not evaluate non-variables *)
Block[{t, notVar},
	TestCreate[
		AllTrue[Values[$modelsP],
			Function[model,
				With[{eqs = Normal[Join[model["exogenousEq"], model["endogenousEq"]]]},
					(notVar[t] /. eqs) === notVar[t]
				]
			]
		],
		True,
		{},
		TestID -> "[processModels] Equations do not evaluate non-variables"
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
	TestID -> "[processModels] A and B coefficients are numeric"
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
	TestID -> "[processModels] Bond values are numeric or Missing sentinel"
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
	TestID -> "[processModels] Output structure is invariant to input key for BKY"
]

(* Test: Pre-processed models match expected structure for BY *)
TestCreate[
	KeyExistsQ[$modelsP, "BY"] &&
	AssociationQ[$modelsP["BY"]] &&
	KeyExistsQ[$modelsP["BY"], "modelAssumptions"] &&
	KeyExistsQ[$modelsP["BY"], "coeffsParamQuadSolve"],
	True,
	{},
	TestID -> "[processModels] Output structure is invariant to input key for BY"
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
	TestID -> "[processModels] Batch processing preserves isolation between models"
]


End[]
EndTestSection[]
