(* ::Package:: *)

(* ::Section:: *)
(*Model Pipeline Integration Tests*)


BeginTestSection["Model Pipeline Integration Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`PipelineIntegration`"]

Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"];
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];


(* ::Subsection:: *)
(*Load Test Helpers*)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "ModelTestHelpers.wl"}];


(* ::Subsection:: *)
(*Package Loading Tests*)


(* Test: Catalog package is loaded *)
TestCreate[
	MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Model`Catalog`"],
	True,
	{},
	TestID -> "[Pipeline] Catalog package is loaded"
]

(* Test: ProcessModels package is loaded *)
TestCreate[
	MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"],
	True,
	{},
	TestID -> "[Pipeline] ProcessModels package is loaded"
]

(* Test: ManageResources package is loaded *)
TestCreate[
	MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Tools`ManageResources`"],
	True,
	{},
	TestID -> "[Pipeline] ManageResources package is loaded"
]


(* ::Subsection:: *)
(*Symbol Existence Tests*)


(* Test: processModels symbol exists *)
TestCreate[
	Head[FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels] === Symbol,
	True,
	{},
	TestID -> "[Pipeline] processModels symbol exists"
]

(* Test: buildModels symbol exists *)
TestCreate[
	Head[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels] === Symbol,
	True,
	{},
	TestID -> "[Pipeline] buildModels symbol exists"
]


(* ::Subsection:: *)
(*Usage Message Tests*)


(* Test: processModels has usage message *)
TestCreate[
	StringQ[FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels::usage],
	True,
	{},
	TestID -> "[Pipeline] processModels has usage message"
]

(* Test: buildModels has usage message *)
TestCreate[
	StringQ[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels::usage],
	True,
	{},
	TestID -> "[Pipeline] buildModels has usage message"
]


(* ::Subsection:: *)
(*Catalog Integration Tests*)


(* Test: Catalog models is an Association *)
TestCreate[
	AssociationQ[FernandoDuarte`LongRunRisk`Model`Catalog`models],
	True,
	{},
	TestID -> "[Pipeline] Catalog models is Association"
]

(* Test: Catalog contains at least one model *)
TestCreate[
	Length[FernandoDuarte`LongRunRisk`Model`Catalog`models] > 0,
	True,
	{},
	TestID -> "[Pipeline] Catalog contains at least one model"
]

(* Test: Catalog keys are strings *)
TestCreate[
	AllTrue[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], StringQ],
	True,
	{},
	TestID -> "[Pipeline] Catalog keys are strings"
]

(* Test: Catalog values are Associations *)
TestCreate[
	AllTrue[Values[FernandoDuarte`LongRunRisk`Model`Catalog`models], AssociationQ],
	True,
	{},
	TestID -> "[Pipeline] Catalog values are Associations"
]


(* ::Subsection:: *)
(*Model Structure Tests*)


(* Test: BKY model has required keys *)
TestCreate[
	Module[{model},
		model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BKY"];
		AllTrue[{"name", "shortname", "parameters", "stateVars"}, KeyExistsQ[model, #] &]
	],
	True,
	{},
	TestID -> "[Pipeline] BKY model has required keys"
]

(* Test: BY model has enabled field with Boolean value *)
TestCreate[
	Module[{model},
		model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"];
		KeyExistsQ[model, "enabled"] && BooleanQ[model["enabled"]]
	],
	True,
	{},
	TestID -> "[Pipeline] BY model has enabled Boolean field"
]

(* Test: BKY model has enabled field with Boolean value *)
TestCreate[
	Module[{model},
		model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BKY"];
		KeyExistsQ[model, "enabled"] && BooleanQ[model["enabled"]]
	],
	True,
	{},
	TestID -> "[Pipeline] BKY model has enabled Boolean field"
]


End[]
EndTestSection[]
