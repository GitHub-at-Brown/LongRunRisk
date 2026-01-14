(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Tools/NiceOutput.wl Tests*)


BeginTestSection["Kernel/Tools/NiceOutput.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`"]

Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];


(* ::Subsection:: *)
(*Load Test Helpers*)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "ToolsTestHelpers.wl"}];


(* ::Subsection:: *)
(*info - Structure Tests*)


(* Test: info returns Column with OpenerView structure *)
TestCreate[
	Module[{result},
		result = PacletizedResourceFunctions`SetSymbolsContext @ info[$testModelsCore];
		AllTrue[{
			Head[result] === Column,
			Head[result[[1]]] === List,
			Head[result[[1, 1]]] === OpenerView
		}, TrueQ]
	],
	True,
	{},
	TestID -> "[info] Multiple models returns Column with OpenerViews"
]

(* Test: info output has Grid elements inside OpenerViews *)
TestCreate[
	Module[{result},
		result = PacletizedResourceFunctions`SetSymbolsContext @ info[$testModelsCore];
		AllTrue[Head /@ result[[1, ;; , 1, 2]], MatchQ[#, Grid] &]
	],
	True,
	{},
	TestID -> "[info] Multiple models OpenerViews contain Grids"
]


(* ::Subsection:: *)
(*info - Key Mismatch Tests*)


(* Test: info displays shortname when model key differs from shortname *)
TestCreate[
	Module[{justBKY, infoBKY, newBKY, infoNewBKY},
		justBKY = <|"BKY" -> $modBKY|>;
		infoBKY = PacletizedResourceFunctions`SetSymbolsContext @ info[justBKY];
		newBKY = <|"myModel" -> $modBKY|>;
		infoNewBKY = PacletizedResourceFunctions`SetSymbolsContext @ info[newBKY];
		AllTrue[{
			(* Original key "BKY" shows shortname "BKY" *)
			infoBKY[[1, 1, 1, 1]] == "BKY",
			(* New key "myModel" still shows shortname "BKY" *)
			infoNewBKY[[1, 1, 1, 1]] == "BKY"
		}, TrueQ]
	],
	True,
	{},
	TestID -> "[info] Key mismatch displays shortname"
]

(* Test: info output structure is consistent regardless of key name *)
TestCreate[
	Module[{justBKY, infoBKY, newBKY, infoNewBKY},
		justBKY = <|"BKY" -> $modBKY|>;
		infoBKY = PacletizedResourceFunctions`SetSymbolsContext @ info[justBKY];
		newBKY = <|"myModel" -> $modBKY|>;
		infoNewBKY = PacletizedResourceFunctions`SetSymbolsContext @ info[newBKY];
		AllTrue[{
			Head[infoBKY] === Column,
			Head[infoBKY[[1]]] === List,
			Head[infoBKY[[1, 1]]] === OpenerView,
			AllTrue[Head /@ infoBKY[[1, ;; , 1, 2]], MatchQ[#, Grid] &],
			Head[infoNewBKY] === Column,
			Head[infoNewBKY[[1]]] === List,
			Head[infoNewBKY[[1, 1]]] === OpenerView,
			AllTrue[Head /@ infoNewBKY[[1, ;; , 1, 2]], MatchQ[#, Grid] &]
		}, TrueQ]
	],
	True,
	{},
	TestID -> "[info] Key mismatch structure is consistent"
]


(* ::Subsection:: *)
(*numberFormattingTemplate - Formatting Tests*)


(* Test: numberFormattingTemplate formats numeric literals correctly *)
TestCreate[
	$nft[3.14],
	"3.14",
	{},
	TestID -> "[numberFormattingTemplate] Numeric literal formats correctly"
]

(* Test: numberFormattingTemplate formats integers as reals (due to N@ in implementation) *)
TestCreate[
	$nft[42],
	"42.",
	{},
	TestID -> "[numberFormattingTemplate] Integer formats as real"
]

(* Test: numberFormattingTemplate with NumberMarks -> True includes backtick *)
TestCreate[
	$nft[3.14, NumberMarks -> True],
	"3.14`",
	{},
	TestID -> "[numberFormattingTemplate] NumberMarks True includes backtick"
]

(* Test: numberFormattingTemplate with NumberMarks -> False excludes backtick *)
TestCreate[
	$nft[3.14, NumberMarks -> False],
	"3.14",
	{},
	TestID -> "[numberFormattingTemplate] NumberMarks False excludes backtick"
]

(* Test: numberFormattingTemplate handles symbolic input by evaluating N *)
TestCreate[
	$nft[Pi],
	"3.141592653589793",
	{},
	TestID -> "[numberFormattingTemplate] Symbolic Pi evaluates to numeric"
]

(* Test: numberFormattingTemplate handles scientific notation *)
TestCreate[
	$nft[3.14*10^(-7)],
	"3.14*^-7",
	{},
	TestID -> "[numberFormattingTemplate] Scientific notation formats correctly"
]

(* Test: numberFormattingTemplate handles CapitalPi symbol - pass symbol directly to avoid context issues *)
TestCreate[
	Module[{sym = Symbol["\[CapitalPi]"]},
		$nft[sym]
	],
	"\[CapitalPi]",
	{},
	TestID -> "[numberFormattingTemplate] Unicode symbol is preserved"
]

(* Test: numberFormattingTemplate with CharacterEncoding -> ASCII escapes unicode *)
TestCreate[
	Module[{sym = Symbol["\[CapitalPi]"]},
		$nft[sym, CharacterEncoding -> "ASCII"]
	],
	"\\[CapitalPi]",
	{},
	TestID -> "[numberFormattingTemplate] ASCII encoding escapes unicode"
]


(* ::Subsection:: *)
(*stringFormattingTemplate - Line Breaking Tests*)


(* Test: stringFormattingTemplate adds linebreaks and tabs for long strings *)
TestCreate[
	StringContainsQ[
		$sft["Long-run risk model with stochastic volatility in the original 2004 paper by Bansal and Yaron"],
		"\t" | "\n"
	],
	True,
	{},
	TestID -> "[stringFormattingTemplate] Long string adds linebreaks"
]

(* Test: stringFormattingTemplate short strings remain unchanged structure *)
TestCreate[
	StringFreeQ[$sft["Short string"], "\n"],
	True,
	{},
	TestID -> "[stringFormattingTemplate] Short string has no linebreaks"
]


(* ::Subsection:: *)
(*Context and Symbol Tests*)


(* Test: NiceOutput context is in $ContextPath after loading *)
TestCreate[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"],
	True,
	{},
	TestID -> "[NiceOutput] Context is in ContextPath after loading"
]

(* Test: info symbol is accessible - use specific NameQ for precision *)
TestCreate[
	NameQ["FernandoDuarte`LongRunRisk`Tools`NiceOutput`info"],
	True,
	{},
	TestID -> "[info] Symbol is accessible"
]


(* ::Subsection:: *)
(*toCatalog - Empty Catalog Tests*)


(* Test: toCatalog returns empty association for empty input *)
TestCreate[
	toCatalog[<||>, {"name", "shortname"}],
	<||>,
	{},
	TestID -> "[toCatalog] Returns empty association for empty catalog"
]

(* Test: toCatalog returns association type for empty input *)
TestCreate[
	AssociationQ[toCatalog[<||>, {"name"}]],
	True,
	{},
	TestID -> "[toCatalog] Empty catalog result is an association"
]


(* ::Subsection:: *)
(*toCatalog - Real Models Tests*)


(* Test: toCatalog returns associations for all model values *)
TestCreate[
	Module[{result},
		result = toCatalog[$testModels, {"name", "shortname"}];
		AllTrue[Values[result], AssociationQ]
	],
	True,
	{},
	TestID -> "[toCatalog] Returns associations for all model values"
]

(* Test: toCatalog preserves model keys *)
TestCreate[
	Module[{result},
		result = toCatalog[$testModels, {"name"}];
		Keys[result] === Keys[$testModels]
	],
	True,
	{},
	TestID -> "[toCatalog] Preserves model keys from input"
]

(* Test: toCatalog filters to specified keys *)
TestCreate[
	Module[{result, keysToKeep},
		keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
		result = toCatalog[$testModels, keysToKeep];
		AllTrue[Values[result], Length[#] >= 6 &]
	],
	True,
	{},
	TestID -> "[toCatalog] Filters to specified keys"
]

(* Test: toCatalog preserves enabled field as Boolean *)
TestCreate[
	Module[{result},
		result = toCatalog[$testModels, {"enabled"}];
		AllTrue[Values[result], BooleanQ[#["enabled"]] &]
	],
	True,
	{},
	TestID -> "[toCatalog] Preserves enabled field as Boolean"
]

(* Test: toCatalog preserves parameters as list *)
TestCreate[
	Module[{result},
		result = toCatalog[$testModels, {"parameters"}];
		AllTrue[Values[result], ListQ[#["parameters"]] &]
	],
	True,
	{},
	TestID -> "[toCatalog] Preserves parameters field as list"
]

(* Test: toCatalog preserves all models *)
TestCreate[
	Module[{result, keysToKeep},
		keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
		result = toCatalog[$testModels, keysToKeep];
		Length[result] === Length[$testModels]
	],
	True,
	{},
	TestID -> "[toCatalog] Preserves all models in result"
]

(* Test: toCatalog roundtrip preserves structure *)
TestCreate[
	Module[{keysToKeep, result},
		keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
		result = toCatalog[$testModels, keysToKeep];
		AssociationQ[result] &&
		AllTrue[Keys[$testModels], KeyExistsQ[result, #] &] &&
		AllTrue[Values[result], AssociationQ]
	],
	True,
	{},
	TestID -> "[toCatalog] Full catalog roundtrip preserves structure"
]


(* ::Subsection:: *)
(*toCatalog - stateVars Handling Tests*)


(* Test: toCatalog evaluates stateVars when it is a Function *)
TestCreate[
	Module[{testModel, result},
		testModel = <|
			"test" -> <|
				"name" -> "Test",
				"stateVars" -> Function[t, {x[t], sc[t]}],
				"parameters" -> {delta -> 0.999}
			|>
		|>;
		result = toCatalog[testModel, {"stateVars"}];
		Head[result["test"]["stateVars"]] === List
	],
	True,
	{},
	TestID -> "[toCatalog] Evaluates stateVars Function to List"
]

(* Test: toCatalog preserves stateVars when it is already a List *)
TestCreate[
	Module[{testModel, result},
		testModel = <|
			"test" -> <|
				"name" -> "Test",
				"stateVars" -> {x[t], sc[t]},
				"parameters" -> {delta -> 0.999}
			|>
		|>;
		result = toCatalog[testModel, {"stateVars"}];
		Head[result["test"]["stateVars"]] === List
	],
	True,
	{},
	TestID -> "[toCatalog] Preserves stateVars List unchanged"
]


(* ::Subsection:: *)
(*toCatalog - Field Filtering Tests*)


(* Test: toCatalog filters out extra fields not in keysToKeep *)
TestCreate[
	Module[{testModel, result},
		testModel = <|
			"test" -> <|
				"name" -> "Test Model",
				"shortname" -> "TM",
				"bibRef" -> "test2024",
				"desc" -> "A test model",
				"enabled" -> True,
				"stateVars" -> {x[t]},
				"parameters" -> {delta -> 0.999},
				"extraField" -> "should be filtered"
			|>
		|>;
		result = toCatalog[testModel, {"name", "shortname"}];
		!KeyExistsQ[result["test"], "extraField"]
	],
	True,
	{},
	TestID -> "[toCatalog] Filters out extra fields not in keysToKeep"
]

(* Test: toCatalog handles single model correctly *)
TestCreate[
	Module[{singleModel, result},
		singleModel = <|"BKY" -> $modBKY|>;
		result = toCatalog[singleModel, {"name"}];
		Length[result] === 1 && KeyExistsQ[result, "BKY"]
	],
	True,
	{},
	TestID -> "[toCatalog] Handles single model correctly"
]


End[]
EndTestSection[]
