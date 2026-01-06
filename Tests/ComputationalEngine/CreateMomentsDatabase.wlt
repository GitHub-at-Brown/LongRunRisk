(* ::Package:: *)

(* ::Section:: *)
(*Kernel/ComputationalEngine/CreateMomentsDatabase.wl Tests*)


BeginTestSection["Kernel/ComputationalEngine/CreateMomentsDatabase.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
Needs["PacletizedResourceFunctions`"];

(* ::Subsection:: *)
(*Load Test Helpers*)


Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]];


(* ::Subsection:: *)
(*Test Configuration*)


(* Fast mode: Tests only BKY and NRC models *)
(* Full mode (longTest = True): Tests all models including DES and NRCStochVol *)
$longTest = False;


(* ::Subsection:: *)
(*Test Helpers*)


(* Private symbols for testing *)
exo = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`exo;
exoStocks = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`exoStocks;

(* Load processed models from the Models.wl resource file *)
(* This file contains DefinitionData that needs to be Get twice - first to get the path, second to load the data *)
$modelsData = Get[Get[FileNameJoin[{"FernandoDuarte/LongRunRisk", "Models.wl"}]]];

$covLongLookupTables = <|
	"BKY" -> FileNameJoin[{"FernandoDuarte/LongRunRisk/MomentsLookupTables", "covLongBKY.mx"}],
	"DES" -> FileNameJoin[{"FernandoDuarte/LongRunRisk/MomentsLookupTables", "covLongDES.mx"}],
	"NRC" -> FileNameJoin[{"FernandoDuarte/LongRunRisk/MomentsLookupTables", "covLongNRC.mx"}],
	"NRCStochVol" -> FileNameJoin[{"FernandoDuarte/LongRunRisk/MomentsLookupTables", "covLongNRCStochVol.mx"}]
|>;

(* Load lookup tables - use Scan for side effects *)
Scan[Get, Values[$covLongLookupTables]];

(* Select models based on test mode *)
$testModels = If[$longTest,
	{$modelsData["BKY"], $modelsData["NRC"], $modelsData["DES"], $modelsData["NRCStochVol"]},
	{$modelsData["BKY"], $modelsData["NRC"]}
];

(* Helper to get covLong symbol for a model *)
getCovLongSymbol[model_] := Symbol["FernandoDuarte`LongRunRisk`covLong" <> model["shortname"]];

(* Helper to check if all elements are numeric *)
allNumericQ[list_] := AllTrue[Flatten[list], NumericQ];

(* Helper to check if a symbol is properly exported (has usage, values, or definitions) *)
exportedSymbolQ[s_Symbol] := AnyTrue[
	{
		ValueQ[s],
		OwnValues[s] =!= {},
		DownValues[s] =!= {},
		StringQ[MessageName[s, "usage"]]
	},
	TrueQ
];

(* Compute moments without stocks for a model *)
computeMomentsNoStocks[model_] := Module[{covLong, testMoments},
	covLong = getCovLongSymbol[model];
	testMoments = Apply[covLong, Outer[Append, Tuples[exo, {2}], Range[-8, 8], 1], {2}];
	testMoments //. model["params"]
];

(* Compute moments with one stock for a model *)
computeMomentsOneStock[model_] := Module[{covLong, testMoments},
	covLong = getCovLongSymbol[model];
	testMoments = Append[#, 1] & /@ Flatten[Apply[Inactive[covLong],
		Outer[Append, Tuples[{exo, exoStocks}], Range[-8, 8], 1], {2}]];
	Activate[testMoments] //. model["params"]
];

(* Compute moments with two stocks for a model *)
computeMomentsTwoStocks[model_] := Module[{covLong, testMoments, stockIndices},
	covLong = getCovLongSymbol[model];
	testMoments = Map[
		covLong @@ Join[#, {Global`i, Global`j}] &,
		Outer[Append, Tuples[{exoStocks, exoStocks}], Range[-8, 8], 1],
		{2}
	];
	stockIndices = Tuples[Range[model["numStocks"]], {2}];
	testMoments /. Map[(Thread[Rule[{Global`i, Global`j}, #]]) &, stockIndices] //. model["params"]
];

(* Compute 3-variable moments without stocks *)
computeMoments3Vars[model_] := Module[{covLong, testMoments},
	covLong = getCovLongSymbol[model];
	testMoments = MapApply[covLong[##, 0, 0] &, Groupings[Tuples[exo, {3}], 2]];
	testMoments //. model["params"]
];

(* Compute 4-variable moments without stocks *)
computeMoments4Vars[model_] := Module[{covLong, testMoments},
	covLong = getCovLongSymbol[model];
	testMoments = MapApply[covLong[##, 0, 0, 0] &, Partition[#, 2] & /@ Tuples[exo, {4}]];
	testMoments //. model["params"]
];

(* Compute 3-variable moments with stocks *)
computeMomentsStocks3Vars[model_] := Module[{covLong, testMoments, stockIndices},
	covLong = getCovLongSymbol[model];
	testMoments = Map[
		covLong @@ Join[#, {0, 0, Global`i, Global`j, Global`k}] &,
		Groupings[Tuples[exoStocks, {3}], 2],
		{1}
	];
	stockIndices = Tuples[Range[Min[model["numStocks"], 2]], {3}];
	testMoments /. Map[(Thread[Rule[{Global`i, Global`j, Global`k}, #]]) &, stockIndices] //. model["params"]
];

(* Compute 4-variable moments with stocks *)
computeMomentsStocks4Vars[model_] := Module[{covLong, testMoments, stockIndices},
	covLong = getCovLongSymbol[model];
	testMoments = Map[
		covLong @@ Join[#, {0, 0, 0, Global`i, Global`j, Global`k, Global`m}] &,
		Partition[#, 2] & /@ Tuples[exoStocks, {4}],
		{1}
	];
	stockIndices = Tuples[Range[Min[model["numStocks"], 2]], {4}];
	testMoments /. Map[(Thread[Rule[{Global`i, Global`j, Global`k, Global`m}, #]]) &, stockIndices] //. model["params"]
];


(* ::Subsection:: *)
(*covLong - Lookup Table Tests*)


(* Test: Lookup tables exist for expected models *)
TestCreate[
	AllTrue[Values[$covLongLookupTables], FileExistsQ[FindFile[#]] &],
	True,
	{},
	TestID -> "covLong-LookupTables-FilesExist"
]

(* Test: covLong symbols are defined after loading lookup tables *)
TestCreate[
	AllTrue[$testModels, Length[DownValues[Evaluate[getCovLongSymbol[#]]]] > 0 &],
	True,
	{},
	TestID -> "covLong-LookupTables-SymbolsDefined"
]


(* ::Subsection:: *)
(*covLong - Moments Without Stocks Tests*)


(* Test: All moments without stocks evaluate to numbers for BKY model *)
TestCreate[
	allNumericQ[computeMomentsNoStocks[$modelsData["BKY"]]],
	True,
	{},
	TestID -> "covLong-BKY-MomentsNoStocksAreNumeric"
]

(* Test: All moments without stocks evaluate to numbers for NRC model *)
TestCreate[
	allNumericQ[computeMomentsNoStocks[$modelsData["NRC"]]],
	True,
	{},
	TestID -> "covLong-NRC-MomentsNoStocksAreNumeric"
]


(* ::Subsection:: *)
(*covLong - Moments With One Stock Tests*)


(* Test: All moments with one stock evaluate to numbers for BKY model *)
TestCreate[
	allNumericQ[computeMomentsOneStock[$modelsData["BKY"]]],
	True,
	{},
	TestID -> "covLong-BKY-MomentsOneStockAreNumeric"
]

(* Test: All moments with one stock evaluate to numbers for NRC model *)
TestCreate[
	allNumericQ[computeMomentsOneStock[$modelsData["NRC"]]],
	True,
	{},
	TestID -> "covLong-NRC-MomentsOneStockAreNumeric"
]


(* ::Subsection:: *)
(*covLong - Moments With Two Stocks Tests*)


(* Test: All moments with two stocks evaluate to numbers for BKY model *)
TestCreate[
	allNumericQ[computeMomentsTwoStocks[$modelsData["BKY"]]],
	True,
	{},
	TestID -> "covLong-BKY-MomentsTwoStocksAreNumeric"
]

(* Test: All moments with two stocks evaluate to numbers for NRC model *)
TestCreate[
	allNumericQ[computeMomentsTwoStocks[$modelsData["NRC"]]],
	True,
	{},
	TestID -> "covLong-NRC-MomentsTwoStocksAreNumeric"
]


(* ::Subsection:: *)
(*covLong - Three Variable Moment Tests*)


(* Test: All 3-variable moments without stocks evaluate to numbers for BKY model *)
TestCreate[
	allNumericQ[computeMoments3Vars[$modelsData["BKY"]]],
	True,
	{},
	TestID -> "covLong-BKY-MomentsThreeVarsAreNumeric"
]

(* Test: All 3-variable moments without stocks evaluate to numbers for NRC model *)
TestCreate[
	allNumericQ[computeMoments3Vars[$modelsData["NRC"]]],
	True,
	{},
	TestID -> "covLong-NRC-MomentsThreeVarsAreNumeric"
]


(* ::Subsection:: *)
(*covLong - Four Variable Moment Tests*)


(* Test: All 4-variable moments without stocks evaluate to numbers for BKY model *)
TestCreate[
	allNumericQ[computeMoments4Vars[$modelsData["BKY"]]],
	True,
	{},
	TestID -> "covLong-BKY-MomentsFourVarsAreNumeric"
]

(* Test: All 4-variable moments without stocks evaluate to numbers for NRC model *)
TestCreate[
	allNumericQ[computeMoments4Vars[$modelsData["NRC"]]],
	True,
	{},
	TestID -> "covLong-NRC-MomentsFourVarsAreNumeric"
]


(* ::Subsection:: *)
(*covLong - Stock Variable Moment Tests*)


(* Test: All 3-variable moments with stocks evaluate to numbers for BKY model *)
TestCreate[
	allNumericQ[computeMomentsStocks3Vars[$modelsData["BKY"]]],
	True,
	{},
	TestID -> "covLong-BKY-MomentsStocksThreeVarsAreNumeric"
]

(* Test: All 3-variable moments with stocks evaluate to numbers for NRC model *)
TestCreate[
	allNumericQ[computeMomentsStocks3Vars[$modelsData["NRC"]]],
	True,
	{},
	TestID -> "covLong-NRC-MomentsStocksThreeVarsAreNumeric"
]

(* Test: All 4-variable moments with stocks evaluate to numbers for BKY model *)
TestCreate[
	allNumericQ[computeMomentsStocks4Vars[$modelsData["BKY"]]],
	True,
	{},
	TestID -> "covLong-BKY-MomentsStocksFourVarsAreNumeric"
]

(* Test: All 4-variable moments with stocks evaluate to numbers for NRC model *)
TestCreate[
	allNumericQ[computeMomentsStocks4Vars[$modelsData["NRC"]]],
	True,
	{},
	TestID -> "covLong-NRC-MomentsStocksFourVarsAreNumeric"
]


(* ::Subsection:: *)
(*Public Symbol Export Tests*)


(* Test: uncondCovLongExo is exported *)
TestCreate[
	exportedSymbolQ[uncondCovLongExo],
	True,
	{},
	TestID -> "uncondCovLongExo-Export-IsPublic"
]

(* Test: uncondVarLongExo is exported *)
TestCreate[
	exportedSymbolQ[uncondVarLongExo],
	True,
	{},
	TestID -> "uncondVarLongExo-Export-IsPublic"
]

(* Test: createDatabase is exported *)
TestCreate[
	exportedSymbolQ[createDatabase],
	True,
	{},
	TestID -> "createDatabase-Export-IsPublic"
]


(* ::Subsection:: *)
(*createDatabase - Options Tests*)


(* Test: createDatabase has expected options *)
TestCreate[
	Sort[Keys[Options[createDatabase]]],
	Sort[{"maxMomentsLagsToCreate", "startSequenceAtLag", "simplifyDownValues"}],
	{},
	TestID -> "createDatabase-Options-ExpectedKeys"
]


End[]
EndTestSection[]
