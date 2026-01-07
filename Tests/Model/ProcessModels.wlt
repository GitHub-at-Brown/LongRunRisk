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
	TestID -> "processModels-Keys-AreStrings"
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
	TestID -> "processModels-StringFields-AreStrings"
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
	TestID -> "processModels-Parameters-EvaluateToNumbers"
]

(* Test: Known models are present *)
TestCreate[
	SubsetQ[Keys[$modelsTest], {"BY", "BKY"}] &&
	SubsetQ[Keys[$modelsP], {"BY", "BKY", "NRC"}],
	True,
	{},
	TestID -> "processModels-KnownModels-ArePresent"
]

(* Test: Models are associations and each model is also an association *)
TestCreate[
	AllTrue[Values[$modelsTest], AssociationQ] &&
	AllTrue[Values[$modelsP], AssociationQ],
	True,
	{},
	TestID -> "processModels-Structure-AreAssociations"
]


(* ::Subsection:: *)
(*processModels - StateVars Function Structure Tests*)


(* Test: stateVars are functions *)
TestCreate[
	AllTrue[Values[$modelsP], MatchQ[#["stateVars"], _Function] &],
	True,
	{},
	TestID -> "processModels-StateVars-AreFunction"
]

(* Test: stateVars applied to t returns a List *)
TestCreate[
	AllTrue[Values[$modelsP], ListQ[#["stateVars"][t]] &],
	True,
	{},
	TestID -> "processModels-StateVars-AppliedToT-ReturnsList"
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
	TestID -> "processModels-StateVars-SingleArgument"
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
	TestID -> "processModels-StateVars-ArgumentNamedT"
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
	TestID -> "processModels-StateVars-EvaluationMatchesCatalog"
]


(* ::Subsection:: *)
(*processModels - Numeric Field Tests*)


(* Test: numStocks is a number *)
TestCreate[
	AllTrue[Values[$modelsP], NumberQ[#["numStocks"]] &],
	True,
	{},
	TestID -> "processModels-NumStocks-IsNumber"
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
	TestID -> "processModels-StateVars-NoEndogenousVars"
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
	TestID -> "processModels-ExogenousEq-NoEndogenousVars"
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
	TestID -> "processModels-KeysAndShortnames-ArePreserved"
]


(* ::Subsection:: *)
(*processModels - Equation Key Structure Tests*)


(* Test: Keys in exogenousEq are PatternTest expressions *)
TestCreate[
	AllTrue[Keys[$modelsP["BKY"]["exogenousEq"]], MatchQ[#, _PatternTest] &],
	True,
	{},
	TestID -> "processModels-ExogenousEqKeys-ArePatternTest"
]

(* Test: Keys in endogenousEq are PatternTest expressions *)
TestCreate[
	AllTrue[Keys[$modelsP["BKY"]["endogenousEq"]], MatchQ[#, _PatternTest] &],
	True,
	{},
	TestID -> "processModels-EndogenousEqKeys-ArePatternTest"
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
		TestID -> "processModels-Equations-EvaluateVariables"
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
		TestID -> "processModels-Equations-DoNotEvaluateNonVariables"
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
	TestID -> "processModels-Coefficients-AB-AreNumeric"
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
	TestID -> "processModels-Coefficients-Bonds-AreNumericOrMissing"
]


End[]
EndTestSection[]
