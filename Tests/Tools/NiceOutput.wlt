(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Tools/NiceOutput.wl Tests*)


BeginTestSection["Kernel/Tools/NiceOutput.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`"]

Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];


(* ::Subsection:: *)
(*Load Test Helpers*)


Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]];


(* ::Subsection:: *)
(*Setup*)


(* Install PacletizedResourceFunctions for tests *)
$prf = Module[{distributedPaclet},
	distributedPaclet = FileNameJoin[{$pacletDir, "Resources", "PacletizedResourceFunctions.paclet"}];
	If[FileExistsQ[distributedPaclet],
		PacletInstall[distributedPaclet, "IgnoreVersion" -> True];
	];
	Length[PacletFind["PacletizedResourceFunctions"]] > 0
];

(* Load PacletizedResourceFunctions once for all tests *)
Needs["PacletizedResourceFunctions`"];

(* Load preprocessed models from Resources/Models.wl - these have all required keys *)
(* Using the paclet specification pattern that works in both local and CI environments *)
$processedModels = Get @ Get[FileNameJoin[{"FernandoDuarte/LongRunRisk", "Models.wl"}]];

(* Use a small subset for faster tests *)
$testModels = KeyTake[$processedModels, {"BY", "BKY", "NRC"}];
$modBY = $testModels["BY"];

(* Alias for private context to improve readability *)
$nft = FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate;
$sft = FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stringFormattingTemplate;


(* ::Subsection:: *)
(*info - Structure Tests*)


(* Test: info returns Column with OpenerView structure *)
TestCreate[
	Module[{result},
		result = PacletizedResourceFunctions`SetSymbolsContext @ info[$testModels];
		AllTrue[{
			Head[result] === Column,
			Head[result[[1]]] === List,
			Head[result[[1, 1]]] === OpenerView
		}, TrueQ]
	],
	True,
	{},
	TestID -> "info-MultipleModels-ReturnsColumnWithOpenerViews"
]

(* Test: info output has Grid elements inside OpenerViews *)
TestCreate[
	Module[{result},
		result = PacletizedResourceFunctions`SetSymbolsContext @ info[$testModels];
		AllTrue[Head /@ result[[1, ;; , 1, 2]], MatchQ[#, Grid] &]
	],
	True,
	{},
	TestID -> "info-MultipleModels-OpenerViewsContainGrids"
]


(* ::Subsection:: *)
(*info - Key Mismatch Tests*)


(* Test: info displays shortname when model key differs from shortname *)
TestCreate[
	Module[{justBY, infoBY, newBY, infoNewBY},
		justBY = <|"BY" -> $modBY|>;
		infoBY = PacletizedResourceFunctions`SetSymbolsContext @ info[justBY];
		newBY = <|"myModel" -> $modBY|>;
		infoNewBY = PacletizedResourceFunctions`SetSymbolsContext @ info[newBY];
		AllTrue[{
			(* Original key "BY" shows shortname "BY" *)
			infoBY[[1, 1, 1, 1]] == "BY",
			(* New key "myModel" still shows shortname "BY" *)
			infoNewBY[[1, 1, 1, 1]] == "BY"
		}, TrueQ]
	],
	True,
	{},
	TestID -> "info-KeyMismatch-DisplaysShortname"
]

(* Test: info output structure is consistent regardless of key name *)
TestCreate[
	Module[{justBY, infoBY, newBY, infoNewBY},
		justBY = <|"BY" -> $modBY|>;
		infoBY = PacletizedResourceFunctions`SetSymbolsContext @ info[justBY];
		newBY = <|"myModel" -> $modBY|>;
		infoNewBY = PacletizedResourceFunctions`SetSymbolsContext @ info[newBY];
		AllTrue[{
			Head[infoBY] === Column,
			Head[infoBY[[1]]] === List,
			Head[infoBY[[1, 1]]] === OpenerView,
			AllTrue[Head /@ infoBY[[1, ;; , 1, 2]], MatchQ[#, Grid] &],
			Head[infoNewBY] === Column,
			Head[infoNewBY[[1]]] === List,
			Head[infoNewBY[[1, 1]]] === OpenerView,
			AllTrue[Head /@ infoNewBY[[1, ;; , 1, 2]], MatchQ[#, Grid] &]
		}, TrueQ]
	],
	True,
	{},
	TestID -> "info-KeyMismatch-StructureConsistent"
]


(* ::Subsection:: *)
(*numberFormattingTemplate - Formatting Tests*)


(* Test: numberFormattingTemplate formats numeric literals correctly *)
TestCreate[
	$nft[3.14],
	"3.14",
	{},
	TestID -> "numberFormattingTemplate-NumericLiteral-FormatsCorrectly"
]

(* Test: numberFormattingTemplate formats integers as reals (due to N@ in implementation) *)
TestCreate[
	$nft[42],
	"42.",
	{},
	TestID -> "numberFormattingTemplate-Integer-FormatsAsReal"
]

(* Test: numberFormattingTemplate with NumberMarks -> True includes backtick *)
TestCreate[
	$nft[3.14, NumberMarks -> True],
	"3.14`",
	{},
	TestID -> "numberFormattingTemplate-NumberMarksTrue-IncludesBacktick"
]

(* Test: numberFormattingTemplate with NumberMarks -> False excludes backtick *)
TestCreate[
	$nft[3.14, NumberMarks -> False],
	"3.14",
	{},
	TestID -> "numberFormattingTemplate-NumberMarksFalse-ExcludesBacktick"
]

(* Test: numberFormattingTemplate handles symbolic input by evaluating N *)
TestCreate[
	$nft[Pi],
	"3.141592653589793",
	{},
	TestID -> "numberFormattingTemplate-SymbolicPi-EvaluatesToNumeric"
]

(* Test: numberFormattingTemplate handles scientific notation *)
TestCreate[
	$nft[3.14*10^(-7)],
	"3.14*^-7",
	{},
	TestID -> "numberFormattingTemplate-ScientificNotation-FormatsCorrectly"
]

(* Test: numberFormattingTemplate handles CapitalPi symbol - pass symbol directly to avoid context issues *)
TestCreate[
	Module[{sym = Symbol["\[CapitalPi]"]},
		$nft[sym]
	],
	"\[CapitalPi]",
	{},
	TestID -> "numberFormattingTemplate-UnicodeSymbol-PreservesSymbol"
]

(* Test: numberFormattingTemplate with CharacterEncoding -> ASCII escapes unicode *)
TestCreate[
	Module[{sym = Symbol["\[CapitalPi]"]},
		$nft[sym, CharacterEncoding -> "ASCII"]
	],
	"\\[CapitalPi]",
	{},
	TestID -> "numberFormattingTemplate-ASCIIEncoding-EscapesUnicode"
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
	TestID -> "stringFormattingTemplate-LongString-AddsLinebreaks"
]

(* Test: stringFormattingTemplate short strings remain unchanged structure *)
TestCreate[
	StringFreeQ[$sft["Short string"], "\n"],
	True,
	{},
	TestID -> "stringFormattingTemplate-ShortString-NoLinebreaks"
]


(* ::Subsection:: *)
(*Context and Symbol Tests*)


(* Test: NiceOutput context is in $ContextPath after loading *)
TestCreate[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"],
	True,
	{},
	TestID -> "NiceOutput-Load-ContextInPath"
]

(* Test: info symbol is accessible - use specific NameQ for precision *)
TestCreate[
	NameQ["FernandoDuarte`LongRunRisk`Tools`NiceOutput`info"],
	True,
	{},
	TestID -> "info-Symbol-IsAccessible"
]


(* ::Subsection:: *)
(*PacletizedResourceFunctions Tests*)


(* Test: PacletizedResourceFunctions is installed *)
TestCreate[
	$prf,
	True,
	{},
	TestID -> "PacletizedResourceFunctions-Installation-Succeeds"
]


End[]
EndTestSection[]
