(* ::Package:: *)

(* ::Section:: *)
(* Kernel/Tools/ManageResources.wl Tests *)

BeginTestSection["Kernel/Tools/ManageResources.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`ManageResources`"]

Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];


(* ::Subsection:: *)
(* Load Test Helpers *)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "ToolsTestHelpers.wl"}];


(* ::Subsection:: *)
(* Private Symbol Aliases *)


$getCanonicalHash = FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash;
$canonicalize = FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`canonicalize;
$findPacletRoot = FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot;
$getVersion = FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getVersion;
$getMomentsHash = FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash;
$momentsUpToDate = FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate;
$setupParallelKernels = FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels;
$warmupParallelKernels = FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels;
$normalizeWhitespace = FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`normalizeWhitespace;
$stringFormattingTemplate = FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stringFormattingTemplate;


(* ::Section:: *)
(* buildModels Tests *)


(* ::Subsection:: *)
(* buildModels - Options Tests *)


(* Test: buildModels has CreateMoments option *)
TestCreate[
	MemberQ[Keys[Options[buildModels]], "CreateMoments"],
	True,
	{},
	TestID -> "[buildModels] Has CreateMoments option"
]

(* Test: buildModels has NumKernels option *)
TestCreate[
	MemberQ[Keys[Options[buildModels]], "NumKernels"],
	True,
	{},
	TestID -> "[buildModels] Has NumKernels option"
]

(* Test: buildModels CreateMoments default is True *)
TestCreate[
	OptionValue[buildModels, "CreateMoments"],
	True,
	{},
	TestID -> "[buildModels] CreateMoments default is True"
]

(* Test: buildModels NumKernels default is Automatic *)
TestCreate[
	OptionValue[buildModels, "NumKernels"],
	Automatic,
	{},
	TestID -> "[buildModels] NumKernels default is Automatic"
]


(* ::Subsection:: *)
(* buildModels - Message Tests *)


(* Test: buildModels has noroot message *)
TestCreate[
	StringQ[buildModels::noroot],
	True,
	{},
	TestID -> "[buildModels] Has noroot message defined"
]

(* Test: buildModels has nocat message *)
TestCreate[
	StringQ[buildModels::nocat],
	True,
	{},
	TestID -> "[buildModels] Has nocat message defined"
]


(* ::Subsection:: *)
(* buildModels - getMomentsHash Tests *)


(* Test: getMomentsHash returns 64 character hex string *)
TestCreate[
	Module[{catalog, model, hash},
		catalog = <|"name" -> "Test", "shortname" -> "T"|>;
		model = <|"exogenousEq" -> {x -> y}, "endogenousEq" -> {a -> b}|>;
		hash = $getMomentsHash[catalog, model];
		StringMatchQ[hash, Repeated[HexadecimalCharacter, {64}]]
	],
	True,
	{},
	TestID -> "[getMomentsHash] Returns 64 character hex string"
]

(* Test: getMomentsHash is deterministic *)
TestCreate[
	Module[{catalog, model, hash1, hash2},
		catalog = <|"name" -> "Test", "shortname" -> "T"|>;
		model = <|"exogenousEq" -> {x -> y}, "endogenousEq" -> {a -> b}|>;
		hash1 = $getMomentsHash[catalog, model];
		hash2 = $getMomentsHash[catalog, model];
		hash1 === hash2
	],
	True,
	{},
	TestID -> "[getMomentsHash] Same inputs produce identical hash"
]

(* Test: getMomentsHash differs for different catalog *)
TestCreate[
	Module[{catalog1, catalog2, model, hash1, hash2},
		catalog1 = <|"name" -> "Test1", "shortname" -> "T1"|>;
		catalog2 = <|"name" -> "Test2", "shortname" -> "T2"|>;
		model = <|"exogenousEq" -> {x -> y}, "endogenousEq" -> {a -> b}|>;
		hash1 = $getMomentsHash[catalog1, model];
		hash2 = $getMomentsHash[catalog2, model];
		hash1 =!= hash2
	],
	True,
	{},
	TestID -> "[getMomentsHash] Different catalog produces different hash"
]

(* Test: getMomentsHash differs for different exogenousEq *)
TestCreate[
	Module[{catalog, model1, model2, hash1, hash2},
		catalog = <|"name" -> "Test", "shortname" -> "T"|>;
		model1 = <|"exogenousEq" -> {x -> y}, "endogenousEq" -> {a -> b}|>;
		model2 = <|"exogenousEq" -> {x -> z}, "endogenousEq" -> {a -> b}|>;
		hash1 = $getMomentsHash[catalog, model1];
		hash2 = $getMomentsHash[catalog, model2];
		hash1 =!= hash2
	],
	True,
	{},
	TestID -> "[getMomentsHash] Different exogenousEq produces different hash"
]


(* ::Subsection:: *)
(* buildModels - momentsUpToDate Tests *)


(* Test: momentsUpToDate returns False for nonexistent files *)
TestCreate[
	$momentsUpToDate["/nonexistent/file.wl", "/nonexistent/meta.wl", "somehash"],
	False,
	{},
	TestID -> "[momentsUpToDate] Returns False for nonexistent files"
]

(* Test: momentsUpToDate returns False when meta file missing *)
TestCreate[
	Module[{tmpDir, momentsFile, metaFile, result},
		tmpDir = CreateDirectory[];
		momentsFile = FileNameJoin[{tmpDir, "covLongTest.wl"}];
		metaFile = FileNameJoin[{tmpDir, "covLongTest_meta.wl"}];
		Put[{1, 2, 3}, momentsFile];
		result = $momentsUpToDate[momentsFile, metaFile, "somehash"];
		DeleteDirectory[tmpDir, DeleteContents -> True];
		result
	],
	False,
	{},
	TestID -> "[momentsUpToDate] Returns False when meta file missing"
]

(* Test: momentsUpToDate returns True when hash matches *)
TestCreate[
	Module[{tmpDir, momentsFile, metaFile, result},
		tmpDir = CreateDirectory[];
		momentsFile = FileNameJoin[{tmpDir, "covLongTest.wl"}];
		metaFile = FileNameJoin[{tmpDir, "covLongTest_meta.wl"}];
		Put[{1, 2, 3}, momentsFile];
		Put[<|"Hash" -> "expectedhash", "Date" -> "2024-01-01"|>, metaFile];
		result = $momentsUpToDate[momentsFile, metaFile, "expectedhash"];
		DeleteDirectory[tmpDir, DeleteContents -> True];
		result
	],
	True,
	{},
	TestID -> "[momentsUpToDate] Returns True when hash matches"
]

(* Test: momentsUpToDate returns False when hash differs *)
TestCreate[
	Module[{tmpDir, momentsFile, metaFile, result},
		tmpDir = CreateDirectory[];
		momentsFile = FileNameJoin[{tmpDir, "covLongTest.wl"}];
		metaFile = FileNameJoin[{tmpDir, "covLongTest_meta.wl"}];
		Put[{1, 2, 3}, momentsFile];
		Put[<|"Hash" -> "oldhash", "Date" -> "2024-01-01"|>, metaFile];
		result = $momentsUpToDate[momentsFile, metaFile, "newhash"];
		DeleteDirectory[tmpDir, DeleteContents -> True];
		result
	],
	False,
	{},
	TestID -> "[momentsUpToDate] Returns False when hash differs"
]


(* ::Subsection:: *)
(* buildModels - setupParallelKernels Tests *)


(* Test: setupParallelKernels with None returns zero *)
TestCreate[
	$setupParallelKernels[None],
	0,
	{},
	TestID -> "[setupParallelKernels] None returns zero"
]

(* Test: setupParallelKernels with zero returns zero *)
TestCreate[
	$setupParallelKernels[0],
	0,
	{},
	TestID -> "[setupParallelKernels] Zero returns zero"
]

(* Test: setupParallelKernels with negative returns zero *)
TestCreate[
	$setupParallelKernels[-1],
	0,
	{},
	TestID -> "[setupParallelKernels] Negative returns zero"
]


(* ::Section:: *)
(* checkCatalogChanges Tests *)


(* ::Subsection:: *)
(* checkCatalogChanges - Structure Tests *)


(* Test: checkCatalogChanges with association input returns expected structure *)
TestCreate[
	Module[{tmpRoot, manifestFile, modelsAssoc, modelHashes, savedManifest, result},
		tmpRoot = CreateDirectory[];
		CreateDirectory[FileNameJoin[{tmpRoot, "Resources"}]];
		manifestFile = FileNameJoin[{tmpRoot, "Resources", "ModelManifest.wl"}];

		modelsAssoc = <|
			"ModelA" -> <|"a" -> 1|>,
			"ModelB" -> <|"b" -> {1, 2}|>
		|>;

		modelHashes = Map[$getCanonicalHash, modelsAssoc];

		savedManifest = <|
			"PacletVersion" -> "Development",
			"CatalogHash" -> "not-the-real-hash",
			"Models" -> modelHashes,
			"Date" -> "2025-01-01T00:00:00"
		|>;

		Put[savedManifest, manifestFile];

		Block[{FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot},
			FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmpRoot;
			result = checkCatalogChanges[modelsAssoc];
		];

		DeleteDirectory[tmpRoot, DeleteContents -> True];

		AssociationQ[result] &&
			KeyExistsQ[result, "Changed"] &&
			KeyExistsQ[result, "New"] &&
			KeyExistsQ[result, "Removed"] &&
			KeyExistsQ[result, "Validation"] &&
			result["Changed"] === {} &&
			result["New"] === {} &&
			result["Removed"] === {} &&
			AssociationQ[result["Validation"]] &&
			TrueQ[result["Validation"]["Valid"]]
	],
	True,
	{},
	TestID -> "[checkCatalogChanges] Association input returns expected structure"
]


(* ::Subsection:: *)
(* checkCatalogChanges - Change Detection Tests *)


(* Test: checkCatalogChanges detects changed, new, and removed models *)
TestCreate[
	Module[{tmpRoot, manifestFile, modelsAssoc, currentHashes, savedManifest, result},
		tmpRoot = CreateDirectory[];
		CreateDirectory[FileNameJoin[{tmpRoot, "Resources"}]];
		manifestFile = FileNameJoin[{tmpRoot, "Resources", "ModelManifest.wl"}];

		modelsAssoc = <|
			"A" -> <|"x" -> 1|>,
			"B" -> <|"y" -> 2|>
		|>;

		currentHashes = Map[$getCanonicalHash, modelsAssoc];

		savedManifest = <|
			"PacletVersion" -> "Development",
			"CatalogHash" -> "not-the-real-hash",
			"Models" -> <|
				"A" -> "different-hash",
				"Old" -> "old-hash"
			|>,
			"Date" -> "2025-01-01T00:00:00"
		|>;

		Put[savedManifest, manifestFile];

		Block[
			{
				FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot,
				FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog
			},
			FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmpRoot;
			FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog[_] :=
				<|"Valid" -> True, "Results" -> <||>, "InvalidModels" -> {}, "TotalErrors" -> 0|>;
			result = checkCatalogChanges[modelsAssoc];
		];

		DeleteDirectory[tmpRoot, DeleteContents -> True];

		AssociationQ[result] &&
			Sort[result["Changed"]] === {"A"} &&
			Sort[result["New"]] === {"B"} &&
			Sort[result["Removed"]] === {"Old"} &&
			TrueQ[result["Validation"]["Valid"]]
	],
	True,
	{checkCatalogChanges::changed, checkCatalogChanges::newmodels, checkCatalogChanges::removed},
	TestID -> "[checkCatalogChanges] Detects changed, new, and removed models"
]


(* ::Section:: *)
(* reformatCatalog Tests *)


(* ::Subsection:: *)
(* reformatCatalog - Symbol Existence Tests *)


(* Test: reformatCatalog symbol exists *)
TestCreate[
	Head[reformatCatalog],
	Symbol,
	{},
	TestID -> "[reformatCatalog] Symbol exists"
]

(* Test: reformatCatalog has usage message *)
TestCreate[
	StringQ[reformatCatalog::usage],
	True,
	{},
	TestID -> "[reformatCatalog] Has usage message"
]


(* ::Subsection:: *)
(* reformatCatalog - toCatalog Tests *)


(* Test: toCatalog works on full catalog *)
TestCreate[
	Module[{keysToKeep, raw, realModels},
		realModels = models;
		keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
		raw = toCatalog[realModels, keysToKeep];
		AssociationQ[raw] && Length[raw] === Length[realModels]
	],
	True,
	{},
	TestID -> "[reformatCatalog] toCatalog works on full catalog"
]


(* ::Subsection:: *)
(* reformatCatalog - formatModels Tests *)


(* Test: formatModels produces BoxData *)
TestCreate[
	Module[{keysToKeep, raw, formatted, realModels},
		realModels = models;
		keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
		raw = toCatalog[realModels, keysToKeep];
		formatted = formatModels[raw];
		Head[formatted] === BoxData
	],
	True,
	{},
	TestID -> "[reformatCatalog] formatModels produces BoxData"
]

(* Test: All models appear in formatted output *)
TestCreate[
	Module[{keysToKeep, raw, formatted, strings, modelNames, realModels},
		realModels = models;
		keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
		raw = toCatalog[realModels, keysToKeep];
		formatted = formatModels[raw];
		strings = Cases[formatted, _String, Infinity];
		modelNames = Values[#["shortname"]& /@ raw];
		AllTrue[modelNames, MemberQ[strings, s_String /; StringContainsQ[s, #]]&]
	],
	True,
	{},
	TestID -> "[reformatCatalog] All models appear in formatted output"
]

(* Test: Enabled field appears in formatted output *)
TestCreate[
	Module[{keysToKeep, raw, formatted, strings, realModels},
		realModels = models;
		keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
		raw = toCatalog[realModels, keysToKeep];
		formatted = formatModels[raw];
		strings = Cases[formatted, _String, Infinity];
		MemberQ[strings, s_String /; StringContainsQ[s, "enabled"]]
	],
	True,
	{},
	TestID -> "[reformatCatalog] Enabled field appears in formatted output"
]


(* ::Subsection:: *)
(* reformatCatalog - Idempotence Tests *)


(* Test: String formatting is idempotent *)
TestCreate[
	Module[{desc, results},
		desc = "Bansal and Yaron (2004) long-run risk model with stochastic volatility of consumption growth.";
		results = NestList[$stringFormattingTemplate, desc, 3];
		(* First application changes input; subsequent applications are stable *)
		results[[2]] === results[[3]] && results[[3]] === results[[4]]
	],
	True,
	{},
	TestID -> "[reformatCatalog] String formatting is idempotent"
]


(* ::Section:: *)
(* updateModelManifest Tests *)


(* ::Subsection:: *)
(* updateModelManifest - Hash Determinism Tests *)


(* Test: Hash is key order invariant *)
TestCreate[
	$getCanonicalHash[<|"b" -> 1, "a" -> 2|>] === $getCanonicalHash[<|"a" -> 2, "b" -> 1|>],
	True,
	{},
	TestID -> "[updateModelManifest] Hash is key order invariant"
]

(* Test: Hash is nested key order invariant *)
TestCreate[
	$getCanonicalHash[<|"x" -> <|"b" -> 1, "a" -> 2|>|>] === $getCanonicalHash[<|"x" -> <|"a" -> 2, "b" -> 1|>|>],
	True,
	{},
	TestID -> "[updateModelManifest] Hash is nested key order invariant"
]

(* Test: Hash handles list of associations *)
TestCreate[
	$getCanonicalHash[<|"z" -> {<|"b" -> 1|>, <|"a" -> 2|>}|>] === $getCanonicalHash[<|"z" -> {<|"b" -> 1|>, <|"a" -> 2|>}|>],
	True,
	{},
	TestID -> "[updateModelManifest] Hash handles list of associations"
]

(* Test: Different values produce different hashes *)
TestCreate[
	$getCanonicalHash[<|"a" -> 1|>] =!= $getCanonicalHash[<|"a" -> 2|>],
	True,
	{},
	TestID -> "[updateModelManifest] Different values produce different hashes"
]

(* Test: Complex permutation produces same hash *)
TestCreate[
	Module[{catalog1, catalog2},
		catalog1 = <|
			"ModelB" -> <|"params" -> <|"gamma" -> 2, "beta" -> 1|>, "name" -> "B"|>,
			"ModelA" -> <|"name" -> "A", "params" -> <|"alpha" -> 0|>|>
		|>;
		catalog2 = <|
			"ModelA" -> <|"params" -> <|"alpha" -> 0|>, "name" -> "A"|>,
			"ModelB" -> <|"name" -> "B", "params" -> <|"beta" -> 1, "gamma" -> 2|>|>
		|>;
		$getCanonicalHash[catalog1] === $getCanonicalHash[catalog2]
	],
	True,
	{},
	TestID -> "[updateModelManifest] Complex permutation produces same hash"
]


(* ::Subsection:: *)
(* updateModelManifest - canonicalize Tests *)


(* Test: canonicalize sorts nested keys *)
TestCreate[
	$canonicalize[<|"b" -> <|"d" -> 1, "c" -> 2|>, "a" -> 3|>],
	<|"a" -> 3, "b" -> <|"c" -> 2, "d" -> 1|>|>,
	{},
	TestID -> "[updateModelManifest] canonicalize sorts nested keys"
]


(* ::Subsection:: *)
(* updateModelManifest - Error Handling Tests *)


(* Test: Fails when root not found *)
TestCreate[
	Block[
		{FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot},
		FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := $Failed;
		updateModelManifest[]
	] === $Failed,
	True,
	{updateModelManifest::noroot},
	TestID -> "[updateModelManifest] Fails when root not found"
]

(* Test: Rejects non-association catalog *)
TestCreate[
	Module[{tmp, manifestFile, result, fileExists},
		tmp = CreateDirectory[FileNameJoin[{$TemporaryDirectory, "tmp-" <> CreateUUID[]}]];
		manifestFile = FileNameJoin[{tmp, "Resources", "ModelManifest.wl"}];
		Block[
			{
				FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot,
				FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels
			},
			FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmp;
			FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := 42;
			result = updateModelManifest[];
			fileExists = FileExistsQ[manifestFile];
		];
		If[DirectoryQ[tmp], DeleteDirectory[tmp, DeleteContents -> True]];
		result === $Failed && fileExists === False
	],
	True,
	{updateModelManifest::nocat},
	TestID -> "[updateModelManifest] Rejects non-association catalog"
]


(* ::Subsection:: *)
(* updateModelManifest - File Writing Tests *)


(* Test: Writes manifest with expected content *)
TestCreate[
	Module[
		{tmp, manifestFile, catalogOverride, result, fileData, dropDate, dateOK, versionOK, hashesOK},
		tmp = CreateDirectory[FileNameJoin[{$TemporaryDirectory, "tmp-" <> CreateUUID[]}]];
		manifestFile = FileNameJoin[{tmp, "Resources", "ModelManifest.wl"}];
		catalogOverride = <|"ModelA" -> <|"a" -> 1|>, "ModelB" -> <|"b" -> {1, 2}|>|>;
		dropDate = KeyDrop[#, "Date"] &;
		Block[
			{
				FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot,
				FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels
			},
			FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmp;
			FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := catalogOverride;
			result = updateModelManifest[];
			fileData = Get[manifestFile];
		];
		If[DirectoryQ[tmp], DeleteDirectory[tmp, DeleteContents -> True]];
		dateOK = StringQ[result["Date"]];
		With[
			{
				baseResult = dropDate[result],
				baseFile = dropDate[fileData],
				expectedCatalogHash = $getCanonicalHash[catalogOverride],
				expectedModelHashes = Map[$getCanonicalHash, catalogOverride]
			},
			versionOK = StringQ[baseResult["PacletVersion"]];
			hashesOK = baseResult["CatalogHash"] === expectedCatalogHash && baseResult["Models"] === expectedModelHashes;
			baseResult === baseFile && versionOK && hashesOK && dateOK
		]
	],
	True,
	{},
	TestID -> "[updateModelManifest] Writes manifest with expected content"
]


End[]
EndTestSection[]
