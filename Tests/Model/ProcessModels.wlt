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
(*Tests Needing Refactoring*)
(*TODO: The following test was copied from docs/test-files/ProcessModels.wlt and needs refactoring to use TestCreate and semantic TestIDs*)


(* Test: processModels preserves model content when renaming *)
(* Original TestID: ProcessModels_20260103-HIY034 *)
(* This test verifies that processModels output is identical regardless of the model key name used *)
VerificationTest[
	Module[{modelBY, modelBKY, modelBKYP, modelBYP, newModels, newModelsSameName, newModelsRename,
	        newModelsP, newModelsSameNameP, newModelsRenameP},
		modelBY = $modelsTest["BY"];
		modelBKY = $modelsTest["BKY"];
		modelBKYP = processModels[<|"BKY" -> modelBKY|>];
		modelBYP = processModels[<|"BY" -> modelBY|>];
		newModels = <|"myModel" -> modelBKY, "BY" -> modelBY|>;
		newModelsSameName = <|"BY" -> modelBY|>;
		newModelsRename = <|"myModel" -> modelBY|>;
		newModelsP = processModels[newModels];
		newModelsSameNameP = processModels[newModelsSameName];
		newModelsRenameP = processModels[newModelsRename];
		And[
			(* BKY model under different name produces same result *)
			KeyDrop[newModelsP["myModel"], "coeffsSolution"] === KeyDrop[modelBKYP["BKY"], "coeffsSolution"],
			(* BY model produces same result *)
			KeyDrop[newModelsP["BY"], "coeffsSolution"] === KeyDrop[modelBYP["BY"], "coeffsSolution"],
			(* BY model with same name produces same result *)
			KeyDrop[newModelsSameNameP["BY"], "coeffsSolution"] === KeyDrop[modelBYP["BY"], "coeffsSolution"],
			(* BY model renamed produces same result *)
			KeyDrop[newModelsRenameP["myModel"], "coeffsSolution"] === KeyDrop[modelBYP["BY"], "coeffsSolution"]
		]
	],
	True,
	{},
	TestID -> "[processModels] Renaming model key preserves content"
]


End[]
EndTestSection[]
