(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Model/Catalog.wl Tests*)


BeginTestSection["Kernel/Model/Catalog.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Catalog`"]

Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];

(* ::Subsection:: *)
(*Load Test Helpers*)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "ModelTestHelpers.wl"}];


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

(* ::Subsection:: *)
(*models - Structure Tests*)


(* Test: models is an Association *)
TestCreate[
	AssociationQ[models],
	True,
	{},
	TestID -> "[models] Structure is Association"
]

(* Test: models keys are strings *)
TestCreate[
	AllTrue[Keys[models], StringQ],
	True,
	{},
	TestID -> "[models] All keys are strings"
]

(* Test: Each model entry is an Association *)
TestCreate[
	AllTrue[Values[models], AssociationQ],
	True,
	{},
	TestID -> "[models] Each model entry is Association"
]

(* Test: Each model's keys are strings *)
TestCreate[
	AllTrue[Values[models], AllTrue[Keys[#], StringQ] &],
	True,
	{},
	TestID -> "[models] Each model has string keys"
]

(* Test: Each model has exactly the required keys *)
TestCreate[
	Module[{requiredKeys},
		requiredKeys = Sort[{"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"}];
		AllTrue[Values[models], Sort[Keys[#]] === requiredKeys &]
	],
	True,
	{},
	TestID -> "[models] Required keys present in each model entry"
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
	TestID -> "[models] Name shortname bibRef desc are strings"
]

(* Test: bibRef is "None", "none", "n/a", or a valid BibTeX key *)
TestCreate[
	Module[{validBibRef},
		validBibRef[ref_] := MemberQ[{"None", "none", "n/a"}, ref] || MemberQ[$bibKeys, ref];
		AllTrue[Values[models], validBibRef[#["bibRef"]] &]
	],
	True,
	{},
	TestID -> "[models] BibRef is none or valid BibTeX key"
]

(* Test: enabled is Boolean *)
TestCreate[
	AllTrue[Values[models], BooleanQ[#["enabled"]] &],
	True,
	{},
	TestID -> "[models] Enabled field is Boolean"
]

(* Test: stateVars is a list *)
TestCreate[
	AllTrue[Values[models], ListQ[#["stateVars"]] &],
	True,
	{},
	TestID -> "[models] StateVars field is list"
]

(* Test: parameters is a list of rules *)
TestCreate[
	AllTrue[Values[models], MatchQ[#["parameters"], {___Rule}] &],
	True,
	{},
	TestID -> "[models] Parameters field is list of rules"
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
	TestID -> "[models] Parameters evaluate to numbers after substitution"
]


(* ::Subsection:: *)
(*models - Context Tests*)


(* Test: Symbols in model fields are in correct contexts *)
Module[{ctx, specs},
	ctx = "FernandoDuarte`LongRunRisk`Model`";
	specs = {
		(* Exogenous variables in stateVars should be in ExogenousEq`Private` *)
		<|"field" -> "stateVars", "type" -> "functionHead",
		  "names" -> StringDrop[$exogenousVars, -2],
		  "context" -> "ExogenousEq`Private`", "id" -> "Exogenous vars in ExogenousEq Private context"|>,

		(* Shocks (eps) in stateVars should be in Shocks` *)
		<|"field" -> "stateVars", "type" -> "curriedHead",
		  "names" -> {"eps"},
		  "context" -> "Shocks`", "id" -> "Shocks in Shocks context"|>,

		(* Parameters should be in Parameters` *)
		<|"field" -> "parameters", "type" -> "bareSymbol",
		  "names" -> $parameters,
		  "context" -> "Parameters`", "id" -> "Parameters in Parameters context"|>,

		(* Endogenous variables should NOT be in stateVars (use None for absence check) *)
		<|"field" -> "stateVars", "type" -> "functionHead",
		  "names" -> StringDrop[$endogenousVars, -2],
		  "context" -> None, "id" -> "StateVars excludes endogenous variables"|>
	};
	Map[
		Function[spec,
			TestCreate[
				checkModelsFieldContext[
					models,
					spec["field"],
					spec["type"],
					spec["names"],
					Replace[spec["context"], s_String :> ctx <> s]
				],
				True,
				{},
				TestID -> "[models] " <> spec["id"]
			]
		],
		specs
	]
]


(* ::Subsection:: *)
(*modelsExtraInfo - Structure Tests*)


(* Test: modelsExtraInfo is an Association *)
TestCreate[
	AssociationQ[modelsExtraInfo],
	True,
	{},
	TestID -> "[modelsExtraInfo] Structure is Association"
]

(* Test: All values in modelsExtraInfo are Associations *)
TestCreate[
	AllTrue[Values[modelsExtraInfo], AssociationQ],
	True,
	{},
	TestID -> "[modelsExtraInfo] All values are Associations"
]

(* Test: Models in modelsExtraInfo are a subset of those in models *)
TestCreate[
	SubsetQ[Keys[models], Keys[modelsExtraInfo]],
	True,
	{},
	TestID -> "[modelsExtraInfo] Keys are subset of models keys"
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
	TestID -> "[validateCatalog] Returns Valid True for models"
]


End[]
EndTestSection[]
