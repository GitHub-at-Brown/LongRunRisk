(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Model/Catalog.wl Tests*)


BeginTestSection["Kernel/Model/Catalog.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Catalog`"]

Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];

(* ::Subsection:: *)
(*Load Test Helpers*)


Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]];


(* ::Subsection:: *)
(*Test Helpers*)

(* Extract BibTeX keys from references.bib file *)
$bibFile = FileNameJoin[{$pacletDir, "Resources", "BibTeX", "references.bib"}];

$bibKeys = Module[{content, matches},
	If[!FileExistsQ[$bibFile], Return[{}]];
	content = Import[$bibFile, "Text"];
	matches = StringCases[content, RegularExpression["@\\w+\\{([^,]+),"] :> "$1"];
	matches
];

(* Helper for checking initialGuess fields *)
initialGuessQ[model_, key_, pred_] := Module[{ig = Lookup[model, "initialGuess", <||>]},
	!KeyExistsQ[ig, key] || pred[ig[key]]
]


(* ::Subsection:: *)
(*models - Structure Tests*)


(* Test: models is an Association *)
TestCreate[
	AssociationQ[models],
	True,
	{},
	TestID -> "models-Structure-IsAssociation"
]

(* Test: models keys are strings *)
TestCreate[
	AllTrue[Keys[models], StringQ],
	True,
	{},
	TestID -> "models-Keys-AreStrings"
]

(* Test: Each model entry is an Association *)
TestCreate[
	AllTrue[Values[models], AssociationQ],
	True,
	{},
	TestID -> "models-Values-AreAssociations"
]

(* Test: Each model's keys are strings *)
TestCreate[
	AllTrue[Values[models], AllTrue[Keys[#], StringQ] &],
	True,
	{},
	TestID -> "models-ModelKeys-AreStrings"
]

(* Test: Each model has exactly the required keys *)
TestCreate[
	Module[{requiredKeys},
		requiredKeys = Sort[{"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"}];
		AllTrue[Values[models], Sort[Keys[#]] === requiredKeys &]
	],
	True,
	{},
	TestID -> "models-RequiredKeys-AllPresent"
]


(* ::Subsection:: *)
(*models - Field Type Tests*)


(* Test: name, shortname, bibRef, desc are strings *)
TestCreate[
	AllTrue[Values[models],
		MatchQ[Lookup[#, {"name", "shortname", "bibRef", "desc"}], {__String}] &
	],
	True,
	{},
	TestID -> "models-StringFields-AreStrings"
]

(* Test: bibRef is "None", "none", "n/a", or a valid BibTeX key *)
TestCreate[
	Module[{validBibRef},
		validBibRef[ref_] := MemberQ[{"None", "none", "n/a"}, ref] || MemberQ[$bibKeys, ref];
		AllTrue[Values[models], validBibRef[#["bibRef"]] &]
	],
	True,
	{},
	TestID -> "models-BibRef-IsValid"
]

(* Test: enabled is Boolean *)
TestCreate[
	AllTrue[Values[models], BooleanQ[#["enabled"]] &],
	True,
	{},
	TestID -> "models-Enabled-IsBoolean"
]

(* Test: stateVars is a list *)
TestCreate[
	AllTrue[Values[models], ListQ[#["stateVars"]] &],
	True,
	{},
	TestID -> "models-StateVars-IsList"
]

(* Test: parameters is a list of rules *)
TestCreate[
	AllTrue[Values[models], MatchQ[#["parameters"], {___Rule}] &],
	True,
	{},
	TestID -> "models-Parameters-IsListOfRules"
]


(* ::Subsection:: *)
(*models - Parameter Value Tests*)


(* Test: parameters evaluate to numbers after repeated substitution *)
(* Uses FixedPoint with iteration cap to avoid infinite loops *)
TestCreate[
	AllTrue[Values[models],
		Function[model,
			With[{rules = model["parameters"], maxIter = 20},
				With[{resolved = FixedPoint[ReplaceAll[rules], rules[[All, 2]], maxIter]},
					AllTrue[resolved, NumericQ]
				]
			]
		]
	],
	True,
	{},
	TestID -> "models-Parameters-EvaluateToNumbers"
]


(* ::Subsection:: *)
(*models - Context Tests*)


(* Test: Exogenous variables are in the correct context *)
TestCreate[
	Module[{exoVarBaseNames, checkModel},
		(* Get base names of exogenous variables (e.g., "xeq" -> "x") *)
		exoVarBaseNames = StringDrop[#, -2] & /@
			$exogenousVars;

		checkModel[model_] := Module[{stateVars, exoSymbols},
			stateVars = model["stateVars"];
			(* Find symbols in stateVars whose names match exogenous variable base names *)
			exoSymbols = Cases[
				stateVars,
				var_Symbol?(MemberQ[exoVarBaseNames, SymbolName[#]] &)[__] :> var,
				Infinity
			];
			(* All such symbols should be in ExogenousEq`Private` context *)
			AllTrue[exoSymbols, Context[#] === "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`" &]
		];
		AllTrue[Values[models], checkModel]
	],
	True,
	{},
	TestID -> "models-ExogenousVars-InCorrectContext"
]

(* Test: Shocks are in the correct context *)
TestCreate[
	Module[{checkModel},
		checkModel[model_] := Module[{stateVars, shockSymbols},
			stateVars = model["stateVars"];
			(* Find symbols named "eps" with arguments like eps["pi"][t] *)
			shockSymbols = Cases[
				stateVars,
				var_Symbol?(SymbolName[#] === "eps" &)[__][__] :> var,
				Infinity
			];
			(* All such symbols should be in Shocks` context *)
			AllTrue[shockSymbols, Context[#] === "FernandoDuarte`LongRunRisk`Model`Shocks`" &]
		];
		AllTrue[Values[models], checkModel]
	],
	True,
	{},
	TestID -> "models-Shocks-InCorrectContext"
]

(* Test: All parameters are in the Parameters context *)
TestCreate[
	Module[{paramNames, checkModel},
		paramNames = $parameters;

		checkModel[model_] := Module[{params, paramSymbols},
			params = model["parameters"];
			(* Find symbols whose names match known parameter names *)
			paramSymbols = Cases[
				params,
				var_Symbol?(MemberQ[paramNames, SymbolName[#]] &) :> var,
				Infinity
			];
			(* All such symbols should be in Parameters` context *)
			AllTrue[paramSymbols, Context[#] === "FernandoDuarte`LongRunRisk`Model`Parameters`" &]
		];
		AllTrue[Values[models], checkModel]
	],
	True,
	{},
	TestID -> "models-Parameters-InCorrectContext"
]

(* Test: State variables do not contain endogenous variables *)
TestCreate[
	Module[{endoVarBaseNames, checkModel},
		(* Get base names of endogenous variables *)
		endoVarBaseNames = StringDrop[#, -2] & /@
			$endogenousVars;

		checkModel[model_] := Module[{stateVars, endoSymbols},
			stateVars = model["stateVars"];
			(* Find any symbols whose names match endogenous variable base names *)
			endoSymbols = Cases[
				stateVars,
				var_Symbol?(MemberQ[endoVarBaseNames, SymbolName[#]] &)[__] :> var,
				Infinity
			];
			(* Should be empty - no endogenous variables in state vars *)
			endoSymbols === {}
		];
		AllTrue[Values[models], checkModel]
	],
	True,
	{},
	TestID -> "models-StateVars-NoEndogenousVars"
]


(* ::Subsection:: *)
(*modelsExtraInfo - Structure Tests*)


(* Test: modelsExtraInfo is an Association *)
TestCreate[
	AssociationQ[modelsExtraInfo],
	True,
	{},
	TestID -> "modelsExtraInfo-Structure-IsAssociation"
]

(* Test: All values in modelsExtraInfo are Associations *)
TestCreate[
	AllTrue[modelsExtraInfo, AssociationQ],
	True,
	{},
	TestID -> "modelsExtraInfo-Values-AreAssociations"
]

(* Test: Models in modelsExtraInfo are a subset of those in models *)
TestCreate[
	SubsetQ[Keys[models], Keys[modelsExtraInfo]],
	True,
	{},
	TestID -> "modelsExtraInfo-Keys-SubsetOfModels"
]


(* ::Subsection:: *)
(*modelsExtraInfo - Initial Guess Tests*)


(* Test: If initialGuess is provided, Ewc is a vector *)
TestCreate[
	AllTrue[Values[modelsExtraInfo], initialGuessQ[#, "Ewc", VectorQ] &],
	True,
	{},
	TestID -> "modelsExtraInfo-Ewc-IsVector"
]

(* Test: If initialGuess is provided, Epd is a 2-dimensional array *)
TestCreate[
	AllTrue[Values[modelsExtraInfo], Function[model, initialGuessQ[model, "Epd", ArrayQ[#, 2] &]]],
	True,
	{},
	TestID -> "modelsExtraInfo-Epd-Is2DArray"
]


(* ::Subsection:: *)
(*Validation Tests*)


(* Test: validateCatalog returns Valid = True for models *)
TestCreate[
	Module[{result},
		result = validateCatalog[models];
		result["Valid"]
	],
	True,
	{},
	TestID -> "validateCatalog-Models-ReturnsValid"
]


End[]
EndTestSection[]
