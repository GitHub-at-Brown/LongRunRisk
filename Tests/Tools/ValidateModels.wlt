(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Tools/ValidateModels.wl Tests*)


BeginTestSection["Kernel/Tools/ValidateModels.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`ValidateModels`"]

Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];


(* ::Subsection:: *)
(*Load Test Helpers*)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "ToolsTestHelpers.wl"}];


(* ::Subsection:: *)
(*Private Symbol Aliases*)


$containsTimeDep = FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency;
$numericValueQ = FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ;
$validParamNameQ = FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ;
$stripParamIndex = FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex;


(* ::Subsection:: *)
(*containsTimeDependency - Basic Tests*)


(* Test: containsTimeDependency returns True for simple x[t] *)
TestCreate[
	$containsTimeDep[x[t]],
	True,
	{},
	TestID -> "[containsTimeDependency] Simple x[t] returns True"
]

(* Test: containsTimeDependency returns True for lagged expression *)
TestCreate[
	$containsTimeDep[sx[-1 + t]],
	True,
	{},
	TestID -> "[containsTimeDependency] Lagged sx[-1+t] returns True"
]

(* Test: containsTimeDependency returns True for expression with t *)
TestCreate[
	$containsTimeDep[-mup + pi[t]],
	True,
	{},
	TestID -> "[containsTimeDependency] Expression -mup+pi[t] returns True"
]

(* Test: containsTimeDependency returns False for symbol without t *)
TestCreate[
	$containsTimeDep[x],
	False,
	{},
	TestID -> "[containsTimeDependency] Symbol without t returns False"
]

(* Test: containsTimeDependency returns False for number *)
TestCreate[
	$containsTimeDep[42],
	False,
	{},
	TestID -> "[containsTimeDependency] Number returns False"
]


(* ::Subsection:: *)
(*numericValueQ - Basic Tests*)


(* Test: numericValueQ returns True for decimal number *)
TestCreate[
	$numericValueQ[0.998],
	True,
	{},
	TestID -> "[numericValueQ] Decimal number returns True"
]

(* Test: numericValueQ returns True for integer *)
TestCreate[
	$numericValueQ[10],
	True,
	{},
	TestID -> "[numericValueQ] Integer returns True"
]

(* Test: numericValueQ returns True for symbolic expression with known params *)
TestCreate[
	$numericValueQ[(1 - gamma)/(1 - psi^(-1))],
	True,
	{},
	TestID -> "[numericValueQ] Symbolic expression with known params returns True"
]

(* Test: numericValueQ returns False for string *)
TestCreate[
	$numericValueQ["not a number"],
	False,
	{},
	TestID -> "[numericValueQ] String returns False"
]


(* ::Subsection:: *)
(*validParamNameQ - Basic Tests*)


(* Test: validParamNameQ returns True for symbol *)
TestCreate[
	$validParamNameQ[delta],
	True,
	{},
	TestID -> "[validParamNameQ] Symbol returns True"
]

(* Test: validParamNameQ returns True for indexed symbol *)
TestCreate[
	$validParamNameQ[mud[1]],
	True,
	{},
	TestID -> "[validParamNameQ] Indexed symbol returns True"
]

(* Test: validParamNameQ returns False for string *)
TestCreate[
	$validParamNameQ["delta"],
	False,
	{},
	TestID -> "[validParamNameQ] String returns False"
]


(* ::Subsection:: *)
(*stripParamIndex - Basic Tests*)


(* Test: stripParamIndex returns symbol name for plain symbol *)
TestCreate[
	$stripParamIndex[delta],
	"delta",
	{},
	TestID -> "[stripParamIndex] Plain symbol returns symbol name"
]

(* Test: stripParamIndex returns symbol name for indexed symbol *)
TestCreate[
	$stripParamIndex[mud[1]],
	"mud",
	{},
	TestID -> "[stripParamIndex] Indexed symbol returns base name"
]


(* ::Subsection:: *)
(*validateModel - Valid Model Tests*)


(* Test: validateModel returns Valid True for BY model *)
TestCreate[
	validateModel[models["BY"]]["Valid"],
	True,
	{},
	TestID -> "[validateModel] BY model passes validation"
]

(* Test: validateModel returns Valid True and zero errors for BKY model *)
TestCreate[
	Module[{result},
		result = validateModel[models["BKY"]];
		result["Valid"] && result["ErrorCount"] === 0
	],
	True,
	{},
	TestID -> "[validateModel] BKY model passes with zero errors"
]


(* ::Subsection:: *)
(*validateCatalog - Valid Catalog Tests*)


(* Test: validateCatalog returns Valid True for all catalog models *)
TestCreate[
	validateCatalog[models]["Valid"],
	True,
	{},
	TestID -> "[validateCatalog] All catalog models pass validation"
]

(* Test: validateCatalog returns Valid True for subset of real models *)
TestCreate[
	Module[{catalog},
		catalog = <|"ModelA" -> models["BY"], "ModelB" -> models["BKY"]|>;
		validateCatalog[catalog]["Valid"]
	],
	True,
	{},
	TestID -> "[validateCatalog] Subset of catalog models passes validation"
]


(* ::Subsection:: *)
(*validateModel - Missing Key Tests*)


(* Test: validateModel detects missing name key *)
TestCreate[
	Module[{model, result},
		model = <|
			"shortname" -> "TM",
			"bibRef" -> "Test2025",
			"desc" -> "Missing name",
			"stateVars" -> {x[t]},
			"parameters" -> {delta -> 0.998}
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "MissingKey"]
	],
	True,
	{},
	TestID -> "[validateModel] Missing name key detected"
]

(* Test: validateModel accumulates multiple missing keys *)
TestCreate[
	Module[{model, result, missingKeyCount},
		model = <|
			"name" -> "Test",
			"stateVars" -> {x[t]},
			"parameters" -> {delta -> 0.998}
		|>;
		result = Quiet[validateModel[model]];
		missingKeyCount = Count[result["Errors"][[All, "Type"]], "MissingKey"];
		missingKeyCount >= 3
	],
	True,
	{},
	TestID -> "[validateModel] Multiple missing keys accumulated"
]


(* ::Subsection:: *)
(*validateModel - Wrong Type Tests*)


(* Test: validateModel detects wrong type for name (integer instead of string) *)
TestCreate[
	Module[{model, result},
		model = <|
			"name" -> 42,
			"shortname" -> "TM",
			"bibRef" -> "Test2025",
			"desc" -> "Test",
			"stateVars" -> {x[t]},
			"parameters" -> {delta -> 0.998}
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "WrongType"]
	],
	True,
	{},
	TestID -> "[validateModel] Wrong type for name key detected"
]

(* Test: validateModel detects wrong type for stateVars (string instead of list) *)
TestCreate[
	Module[{model, result},
		model = <|
			"name" -> "Test",
			"shortname" -> "TM",
			"bibRef" -> "Test2025",
			"desc" -> "Test",
			"stateVars" -> "not a list",
			"parameters" -> {delta -> 0.998}
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "WrongType"]
	],
	True,
	{},
	TestID -> "[validateModel] Wrong type for stateVars key detected"
]


(* ::Subsection:: *)
(*validateModel - StateVar Validation Tests*)


(* Test: validateModel detects state variables missing t dependency *)
TestCreate[
	Module[{model, result},
		model = <|
			"name" -> "Test",
			"shortname" -> "TM",
			"bibRef" -> "Test2025",
			"desc" -> "Test",
			"stateVars" -> {x, y},
			"parameters" -> {delta -> 0.998}
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "BadStateVar"]
	],
	True,
	{},
	TestID -> "[validateModel] State variables missing t dependency detected"
]

(* Test: validateModel detects empty stateVars list *)
TestCreate[
	Module[{model, result},
		model = <|
			"name" -> "Test",
			"shortname" -> "TM",
			"bibRef" -> "Test2025",
			"desc" -> "Test",
			"stateVars" -> {},
			"parameters" -> {delta -> 0.998}
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "WrongType"]
	],
	True,
	{},
	TestID -> "[validateModel] Empty stateVars list detected as wrong type"
]

(* Test: validateModel detects invalid symbol in state variable *)
TestCreate[
	Module[{model, result},
		model = <|
			"name" -> "Test",
			"shortname" -> "TM",
			"bibRef" -> "Test2025",
			"desc" -> "Test",
			"stateVars" -> {invalidSymbol[t]},
			"parameters" -> models["BY"]["parameters"]
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "BadStateVarSymbol"]
	],
	True,
	{},
	TestID -> "[validateModel] Invalid symbol in state variable detected"
]

(* Test: validateModel passes valid state variables with exo vars, params, shocks *)
TestCreate[
	Module[{model, result},
		model = <|
			"name" -> "Test",
			"shortname" -> "TM",
			"bibRef" -> "Test2025",
			"desc" -> "Test",
			"stateVars" -> {x[t], -mup + pi[t]},
			"parameters" -> models["BY"]["parameters"]
		|>;
		result = Quiet[validateModel[model]];
		!MemberQ[result["Errors"][[All, "Type"]], "BadStateVarSymbol"]
	],
	True,
	{},
	TestID -> "[validateModel] Valid state variables pass symbol check"
]


(* ::Subsection:: *)
(*validateModel - Parameter Validation Tests*)


(* Test: validateModel detects duplicate parameter *)
TestCreate[
	Module[{model, result},
		model = <|
			"name" -> "Test",
			"shortname" -> "TM",
			"bibRef" -> "Test2025",
			"desc" -> "Test",
			"stateVars" -> {x[t]},
			"parameters" -> {delta -> 0.998, delta -> 0.99}
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "DuplicateParam"]
	],
	True,
	{},
	TestID -> "[validateModel] Duplicate parameter detected"
]

(* Test: validateModel detects non-numeric parameter value *)
TestCreate[
	Module[{model, result},
		model = <|
			"name" -> "Test",
			"shortname" -> "TM",
			"bibRef" -> "Test2025",
			"desc" -> "Test",
			"stateVars" -> {x[t]},
			"parameters" -> {delta -> "not numeric"}
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "BadParam"]
	],
	True,
	{},
	TestID -> "[validateModel] Non-numeric parameter value detected"
]

(* Test: validateModel detects non-Rule parameter entry *)
TestCreate[
	Module[{model, result},
		model = <|
			"name" -> "Test",
			"shortname" -> "TM",
			"bibRef" -> "Test2025",
			"desc" -> "Test",
			"stateVars" -> {x[t]},
			"parameters" -> {delta -> 0.998, 42}
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "NotRule"]
	],
	True,
	{},
	TestID -> "[validateModel] Non-Rule parameter entry detected"
]

(* Test: validateModel detects extra parameter not in $parameters *)
TestCreate[
	Module[{model, result, byParams},
		byParams = models["BY"]["parameters"];
		model = <|
			"name" -> "Test",
			"shortname" -> "TM",
			"bibRef" -> "Test2025",
			"desc" -> "Test",
			"stateVars" -> models["BY"]["stateVars"],
			"parameters" -> Append[byParams, notAValidParam -> 123]
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "ExtraParam"]
	],
	True,
	{},
	TestID -> "[validateModel] Extra parameter detected"
]

(* Test: validateModel detects missing parameter from $parameters *)
TestCreate[
	Module[{model, result, byParams},
		byParams = DeleteCases[models["BY"]["parameters"],
			Rule[s_Symbol, _] /; SymbolName[s] === "delta"];
		model = <|
			"name" -> "Test",
			"shortname" -> "TM",
			"bibRef" -> "Test2025",
			"desc" -> "Test",
			"stateVars" -> models["BY"]["stateVars"],
			"parameters" -> byParams
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "MissingParam"]
	],
	True,
	{},
	TestID -> "[validateModel] Missing parameter detected"
]


(* ::Subsection:: *)
(*validateModel - Indexed Parameter Tests*)


(* Test: validateModel detects incomplete stock parameters *)
TestCreate[
	Module[{model, result, byParams, incompleteStock2Params},
		byParams = models["BY"]["parameters"];
		incompleteStock2Params = {mud[2] -> 0.002, rhodx[2] -> 2.5};
		model = <|
			"name" -> "Multi Stock",
			"shortname" -> "MS",
			"bibRef" -> "Test2025",
			"desc" -> "Multi stock model",
			"stateVars" -> models["BY"]["stateVars"],
			"parameters" -> Join[byParams, incompleteStock2Params]
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "MissingStockParam"]
	],
	True,
	{},
	TestID -> "[validateModel] Incomplete stock parameters detected"
]

(* Test: validateModel detects invalid indexed parameter name *)
TestCreate[
	Module[{model, result, byParams, badIndexedParams},
		byParams = models["BY"]["parameters"];
		badIndexedParams = {notADividendParam[1] -> 0.5};
		model = <|
			"name" -> "Bad Indexed",
			"shortname" -> "BI",
			"bibRef" -> "Test2025",
			"desc" -> "Model with invalid indexed param",
			"stateVars" -> models["BY"]["stateVars"],
			"parameters" -> Join[byParams, badIndexedParams]
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "BadIndexedParam"]
	],
	True,
	{},
	TestID -> "[validateModel] Invalid indexed parameter name detected"
]

(* Test: validateModel detects non-positive index *)
TestCreate[
	Module[{model, result, byParams, nonPositiveIndexParams},
		byParams = models["BY"]["parameters"];
		nonPositiveIndexParams = {mud[0] -> 0.001};
		model = <|
			"name" -> "Non-Positive Index",
			"shortname" -> "NPI",
			"bibRef" -> "Test2025",
			"desc" -> "Model with non-positive index",
			"stateVars" -> models["BY"]["stateVars"],
			"parameters" -> Join[byParams, nonPositiveIndexParams]
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "IndexNotPositive"]
	],
	True,
	{},
	TestID -> "[validateModel] Non-positive index detected"
]

(* Test: validateModel detects index gap *)
TestCreate[
	Module[{model, result, byParams, stock3Params},
		byParams = models["BY"]["parameters"];
		stock3Params = {
			mud[3] -> 0.001, rhodx[3] -> 2, rhodp[3] -> 0, phidc[3] -> 0,
			phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> 0, phids[3] -> 0,
			phidxc[3] -> 0, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0,
			phidxd[3] -> 4, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
		};
		model = <|
			"name" -> "Index Gap",
			"shortname" -> "IG",
			"bibRef" -> "Test2025",
			"desc" -> "Model with index gap",
			"stateVars" -> models["BY"]["stateVars"],
			"parameters" -> Join[byParams, stock3Params]
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "IndexGap"]
	],
	True,
	{},
	TestID -> "[validateModel] Index gap detected"
]

(* Test: validateModel passes valid multi-stock model *)
TestCreate[
	Module[{model, result, byParams, stock2Params},
		byParams = models["BY"]["parameters"];
		stock2Params = {
			mud[2] -> 0.001, rhodx[2] -> 2, rhodp[2] -> 0, phidc[2] -> 0,
			phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0,
			phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0,
			phidxd[2] -> 4, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
		};
		model = <|
			"name" -> "Multi Stock Valid",
			"shortname" -> "MSV",
			"bibRef" -> "Test2025",
			"desc" -> "Valid multi-stock model",
			"enabled" -> True,
			"stateVars" -> models["BY"]["stateVars"],
			"parameters" -> Join[byParams, stock2Params]
		|>;
		result = Quiet[validateModel[model]];
		result["Valid"]
	],
	True,
	{},
	TestID -> "[validateModel] Valid multi-stock model passes"
]


(* ::Subsection:: *)
(*validateModel - Parameter Assumption Tests*)


(* Test: validateModel detects delta negative - violates delta > 0 *)
TestCreate[
	Module[{model, result, byParams, modifiedParams},
		byParams = models["BY"]["parameters"];
		modifiedParams = byParams /. (Rule[s_Symbol, _] /; SymbolName[s] === "delta" :> (s -> -0.5));
		model = <|
			"name" -> "Bad Delta",
			"shortname" -> "BD",
			"bibRef" -> "Test2025",
			"desc" -> "Model with invalid delta",
			"stateVars" -> models["BY"]["stateVars"],
			"parameters" -> modifiedParams
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "BadAssumption"]
	],
	True,
	{},
	TestID -> "[validateModel] Negative delta violates assumption"
]

(* Test: validateModel detects delta > 1 - violates delta < 1 *)
TestCreate[
	Module[{model, result, byParams, modifiedParams},
		byParams = models["BY"]["parameters"];
		modifiedParams = byParams /. (Rule[s_Symbol, _] /; SymbolName[s] === "delta" :> (s -> 1.5));
		model = <|
			"name" -> "Bad Delta High",
			"shortname" -> "BDH",
			"bibRef" -> "Test2025",
			"desc" -> "Model with delta too high",
			"stateVars" -> models["BY"]["stateVars"],
			"parameters" -> modifiedParams
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "BadAssumption"]
	],
	True,
	{},
	TestID -> "[validateModel] Delta greater than 1 violates assumption"
]

(* Test: validateModel detects psi <= 0 - violates psi > 0 *)
TestCreate[
	Module[{model, result, byParams, modifiedParams},
		byParams = models["BY"]["parameters"];
		modifiedParams = byParams /. (Rule[s_Symbol, _] /; SymbolName[s] === "psi" :> (s -> -1));
		model = <|
			"name" -> "Bad Psi",
			"shortname" -> "BP",
			"bibRef" -> "Test2025",
			"desc" -> "Model with invalid psi",
			"stateVars" -> models["BY"]["stateVars"],
			"parameters" -> modifiedParams
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "BadAssumption"]
	],
	True,
	{},
	TestID -> "[validateModel] Negative psi violates assumption"
]

(* Test: validateModel detects theta = 0 - violates theta != 0 *)
TestCreate[
	Module[{model, result, byParams, modifiedParams},
		byParams = models["BY"]["parameters"];
		modifiedParams = byParams /. (Rule[s_Symbol, _] /; SymbolName[s] === "theta" :> (s -> 0));
		model = <|
			"name" -> "Bad Theta",
			"shortname" -> "BT",
			"bibRef" -> "Test2025",
			"desc" -> "Model with theta = 0",
			"stateVars" -> models["BY"]["stateVars"],
			"parameters" -> modifiedParams
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "BadAssumption"]
	],
	True,
	{},
	TestID -> "[validateModel] Theta zero violates assumption"
]

(* Test: validateModel detects rhox outside (-1, 1) *)
TestCreate[
	Module[{model, result, byParams, modifiedParams},
		byParams = models["BY"]["parameters"];
		modifiedParams = byParams /. (Rule[s_Symbol, _] /; SymbolName[s] === "rhox" :> (s -> 1.5));
		model = <|
			"name" -> "Bad Rhox",
			"shortname" -> "BR",
			"bibRef" -> "Test2025",
			"desc" -> "Model with rhox out of range",
			"stateVars" -> models["BY"]["stateVars"],
			"parameters" -> modifiedParams
		|>;
		result = Quiet[validateModel[model]];
		MemberQ[result["Errors"][[All, "Type"]], "BadAssumption"]
	],
	True,
	{},
	TestID -> "[validateModel] Rhox outside valid range violates assumption"
]


(* ::Subsection:: *)
(*validateCatalog - Invalid Model Detection Tests*)


(* Test: validateCatalog identifies invalid models in catalog *)
TestCreate[
	Module[{catalog, result},
		catalog = <|
			"ModelA" -> models["BY"],
			"ModelB" -> <|
				"name" -> 42,
				"shortname" -> "B",
				"bibRef" -> "B2025",
				"desc" -> "Second model",
				"stateVars" -> {y[t]},
				"parameters" -> {gamma -> 10}
			|>
		|>;
		result = Quiet[validateCatalog[catalog]];
		MemberQ[result["InvalidModels"], "ModelB"] && result["TotalErrors"] >= 1
	],
	True,
	{},
	TestID -> "[validateCatalog] Invalid model identified in catalog"
]


(* ::Subsection:: *)
(*validateModel - Error Accumulation Tests*)


(* Test: validateModel accumulates multiple different error types *)
TestCreate[
	Module[{model, result},
		model = <|
			"name" -> 42,
			"shortname" -> "TM",
			"stateVars" -> {x},
			"parameters" -> {delta -> "bad", delta -> 0.99}
		|>;
		result = Quiet[validateModel[model]];
		result["ErrorCount"] >= 4
	],
	True,
	{},
	TestID -> "[validateModel] Multiple error types accumulated"
]


End[]
EndTestSection[]
