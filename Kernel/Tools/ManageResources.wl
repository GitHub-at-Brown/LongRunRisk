(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];

updateModelManifest::usage = "updateModelManifest[] generates and saves the ModelManifest.wl file.
updateModelManifest[modelsAssoc] computes manifest data from the given models association without writing to disk.";
updateModelManifest::noroot = "Could not locate paclet root directory.";
updateModelManifest::nocat = "Catalog models not found or invalid.";
updateModelManifest::versionmismatch = "PacletInfo.wl version `1` differs from installed paclet version `2`; using PacletInfo.wl version.";

checkCatalogChanges::usage = "checkCatalogChanges[] compares the current Catalog to the saved manifest and reports which models have changed.
checkCatalogChanges[modelsAssoc] compares the given models association against the saved manifest, validates changes, but does not reformat.";
checkCatalogChanges::noroot = "Could not locate paclet root directory.";
checkCatalogChanges::nocat = "Catalog models not found or invalid.";
checkCatalogChanges::nomanifest = "ModelManifest.wl not found. Run updateModelManifest[] first.";
checkCatalogChanges::changed = "The following models have changed and need updating: `1`.";
checkCatalogChanges::newmodels = "New models added to catalog: `1`.";
checkCatalogChanges::removed = "Models removed from catalog: `1`.";

reformatCatalog::usage = "reformatCatalog[] reformats the models section of Catalog.wl using standard formatting, preserving modelsExtraInfo unchanged.";
reformatCatalog::noroot = "Could not locate paclet root directory.";
reformatCatalog::nocat = "Could not locate Catalog.wl or parse its structure.";
reformatCatalog::convfail = "Catalog reformatting failed: `1`";
reformatCatalog::success = "Catalog.wl reformatted successfully.";

buildModels::usage = "buildModels[] processes enabled models, compiles functions, computes numerical solutions, and creates moments database.";
buildModels::noroot = "Could not locate paclet root directory.";
buildModels::nocat = "Catalog models not found or invalid.";
buildModels::start = "starting build for `1` model(s).";
buildModels::processing = "processing model `1`.";
buildModels::compiling = "compiling model `1`.";
buildModels::numerical = "computing numerical solutions for `1`.";
buildModels::moments = "creating moments database for `1`.";
buildModels::done = "build completed for `1` model(s).";
buildModels::uptodate = "all enabled models are up to date.";
buildModels::skipped = "skipped `1` (not enabled).";
buildModels::kernels = "launching `1` parallel kernel(s) for moments computation.";
buildModels::kernelwarmup = "warming up parallel kernels with PacletizedResourceFunctions...";
buildModels::momentscache = "moments database for `1` is up to date (cache hit).";
buildModels::momentscomputing = "computing moments database for `1`...";

Begin["`Private`"];

(* Live catalog loading - tracks file modification time *)
$catalogFile = None;
$catalogMTime = None;
$packageRoot = If[StringQ[$InputFileName], DirectoryName[$InputFileName, 3], None];
$pacletLoaded = False;

getCatalogModels[] := Module[{mtime, root},
  (* Find file path once *)
  If[!StringQ[$catalogFile],
    $catalogFile = FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"];
    If[!StringQ[$catalogFile],
      With[{root = findPacletRoot[]},
        If[StringQ[root],
          $catalogFile = FileNameJoin[{root, "Kernel", "Model", "Catalog.wl"}]
        ]
      ]
    ]
  ];
  root = If[StringQ[$catalogFile], DirectoryName[$catalogFile, 3], None];
  If[StringQ[root], ensurePacletLoaded[root]];

  If[!StringQ[$catalogFile] || !FileExistsQ[$catalogFile], Return[$Failed]];

  (* Check modification time *)
  mtime = FileDate[$catalogFile, "Modification"];

  If[mtime =!= $catalogMTime,
    Get[$catalogFile];
    $catalogMTime = mtime
  ];

  FernandoDuarte`LongRunRisk`Model`Catalog`models
];

(* Simple root finder - uses FindFile on THIS package *)
findPacletRoot[] := Module[{file, root},
  file = Quiet@FindFile["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];

  (* Primary: locate via FindFile (installed paclet or $Path) *)
  root = If[StringQ[file], DirectoryName[file, 3], None];  (* Kernel/Tools/file.wl -> root *)

  (* Fallback: use the path of the currently loaded package file *)
  If[!StringQ[root] && StringQ[$packageRoot], root = $packageRoot];

  (* Fallback: if running from repo root, detect PacletInfo.wl in cwd *)
  If[!StringQ[root],
    With[{cwd = Directory[]},
      If[FileExistsQ[FileNameJoin[{cwd, "PacletInfo.wl"}]],
        root = cwd
      ]
    ]
  ];

  If[StringQ[root] && FileExistsQ[FileNameJoin[{root, "PacletInfo.wl"}]],
    root,
    $Failed
  ]
];

ensurePacletLoaded[root_String] := Module[{},
  If[TrueQ[$pacletLoaded], Return[root]];
  Quiet@Check[PacletDirectoryLoad[root], Null];
  $pacletLoaded = True;
  root
];

(* Simple version getter *)
getVersion[root_String] := Module[
  {infoPath, repoVersion, found, match, matchVersion},

  infoPath = FileNameJoin[{root, "PacletInfo.wl"}];
  repoVersion = Quiet@Check[
    With[{info = Get[infoPath]},
      With[{v = info["Version"]},
        If[StringQ[v], v, None]
      ]
    ],
    None
  ];

  found = PacletFind["FernandoDuarte/LongRunRisk"];
  match = SelectFirst[found,
    Quiet@Check[#["Location"] === root, False] &,
    Missing["NotFound"]
  ];
  matchVersion = Quiet@Check[match["Version"], None];

  If[StringQ[repoVersion] && StringQ[matchVersion] && repoVersion =!= matchVersion,
    Message[updateModelManifest::versionmismatch, repoVersion, matchVersion];
  ];

  Which[
    StringQ[repoVersion], repoVersion,
    StringQ[matchVersion], matchVersion,
    True, "Development"
  ]
];

canonicalize[expr_Association] := KeySort[Map[canonicalize, expr]];
canonicalize[expr_List] := Map[canonicalize, expr];
canonicalize[expr_] := expr;

getCanonicalHash[expr_] := Hash[ExportString[canonicalize[expr], "WL"], "SHA256", "HexString"];

loadManifestSafe[file_] := Module[{held, data},
  (* Parse without evaluation, then validate shape before releasing *)
  held = Check[ToExpression[Import[file, "Text"], StandardForm, HoldComplete], Return[$Failed]];
  If[!MatchQ[held, HoldComplete[_Association]], Return[$Failed]];
  If[!MatchQ[held, HoldComplete[<|
      "PacletVersion" -> _String,
      "CatalogHash"   -> _String,
      "Models"        -> _Association,
      "Date"          -> _String
    |>]], Return[$Failed]];
  data = held /. HoldComplete[x_] :> x;
  If[!VectorQ[Values[data["Models"]], StringQ], Return[$Failed]];
  data
];

(* No-argument version: reads from catalog, writes to disk *)
updateModelManifest[] := Module[
  {root, manifestFile, catalogModels, catalogHash, modelHashes, version, manifestData},

  (* Find root *)
  root = findPacletRoot[];
  If[root === $Failed, Message[updateModelManifest::noroot]; Return[$Failed]];

  (* Build manifest path *)
  manifestFile = FileNameJoin[{root, "Resources", "ModelManifest.wl"}];
  Quiet[CreateDirectory[DirectoryName[manifestFile]], {CreateDirectory::filex, CreateDirectory::eexist}];

  (* Get catalog (live reload if file changed) *)
  catalogModels = getCatalogModels[];
  If[!AssociationQ[catalogModels], Message[updateModelManifest::nocat]; Return[$Failed]];

  (* Compute hashes *)
  catalogHash = getCanonicalHash[catalogModels];
  modelHashes = Map[getCanonicalHash, catalogModels];

  (* Get version *)
  version = getVersion[root];

  (* Build and save *)
  manifestData = <|
    "PacletVersion" -> version,
    "CatalogHash" -> catalogHash,
    "Models" -> modelHashes,
    "Date" -> DateString["ISODateTime"]
  |>;

  Put[manifestData, manifestFile];
  manifestData
];

(* Association argument version: computes manifest from provided models, does not write to disk *)
updateModelManifest[modelsAssoc_Association] := Module[
  {root, catalogHash, modelHashes, version, manifestData},

  (* Find root for version info *)
  root = findPacletRoot[];
  version = If[root === $Failed, "Unknown", getVersion[root]];

  (* Compute hashes from provided association *)
  catalogHash = getCanonicalHash[modelsAssoc];
  modelHashes = Map[getCanonicalHash, modelsAssoc];

  (* Build manifest data (no file writes) *)
  manifestData = <|
    "PacletVersion" -> version,
    "CatalogHash" -> catalogHash,
    "Models" -> modelHashes,
    "Date" -> DateString["ISODateTime"]
  |>;

  manifestData
];

checkCatalogChanges[] := Module[
  {root, manifestFile, savedManifest, catalogModels, currentCatalogHash,
   savedCatalogHash, savedModelHashes, currentModelHashes,
   changedModels, newModels, removedModels, modelsToValidate, validationResult},

  (* Find root *)
  root = findPacletRoot[];
  If[root === $Failed, Message[checkCatalogChanges::noroot]; Return[$Failed]];

  (* Load manifest *)
  manifestFile = FileNameJoin[{root, "Resources", "ModelManifest.wl"}];
  If[!FileExistsQ[manifestFile],
    Message[checkCatalogChanges::nomanifest];
    Return[$Failed]
  ];
  savedManifest = loadManifestSafe[manifestFile];
  If[savedManifest === $Failed,
    Message[checkCatalogChanges::nomanifest];
    Return[$Failed]
  ];

  (* Get catalog (live reload if file changed) *)
  catalogModels = getCatalogModels[];
  If[!AssociationQ[catalogModels], Message[checkCatalogChanges::nocat]; Return[$Failed]];

  (* Quick check: compare catalog hash *)
  currentCatalogHash = getCanonicalHash[catalogModels];
  savedCatalogHash = savedManifest["CatalogHash"];

  If[currentCatalogHash === savedCatalogHash,
    (* No changes - return silently *)
    Return[Null]
  ];

  (* Catalog has changed - identify which models *)
  savedModelHashes = savedManifest["Models"];
  currentModelHashes = Map[getCanonicalHash, catalogModels];

  (* Find changed models (exist in both, hash differs) *)
  changedModels = Select[
    Keys[KeyTake[currentModelHashes, Keys[savedModelHashes]]],
    currentModelHashes[#] =!= savedModelHashes[#] &
  ];

  (* Find new models (in current but not saved) *)
  newModels = Complement[Keys[currentModelHashes], Keys[savedModelHashes]];

  (* Find removed models (in saved but not current) *)
  removedModels = Complement[Keys[savedModelHashes], Keys[currentModelHashes]];

  If[changedModels =!= {},
    Message[checkCatalogChanges::changed, StringRiffle[changedModels, ", "]]
  ];

  If[newModels =!= {},
    Message[checkCatalogChanges::newmodels, StringRiffle[newModels, ", "]]
  ];

  If[removedModels =!= {},
    Message[checkCatalogChanges::removed, StringRiffle[removedModels, ", "]]
  ];

  (* Validate changed and new models *)
  modelsToValidate = Join[changedModels, newModels];
  validationResult = If[modelsToValidate =!= {},
    Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
    FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog[
      KeyTake[catalogModels, modelsToValidate]
    ],
    <|"Valid" -> True, "Results" -> <||>, "InvalidModels" -> {}, "TotalErrors" -> 0|>
  ];

  (* auto-reformat only if there were valid changes *)
  If[(changedModels =!= {} || newModels =!= {}) && TrueQ[validationResult["Valid"]],
    reformatCatalog[]
  ];

  <|
    "Changed" -> changedModels,
    "New" -> newModels,
    "Removed" -> removedModels,
    "Validation" -> validationResult
  |>
];

(* Association argument version: compares provided models against manifest on disk, no reformatting *)
checkCatalogChanges[modelsAssoc_Association] := Module[
  {root, manifestFile, savedManifest, currentCatalogHash,
   savedCatalogHash, savedModelHashes, currentModelHashes,
   changedModels, newModels, removedModels, modelsToValidate, validationResult},

  (* Find root *)
  root = findPacletRoot[];
  If[root === $Failed, Message[checkCatalogChanges::noroot]; Return[$Failed]];

  (* Load manifest *)
  manifestFile = FileNameJoin[{root, "Resources", "ModelManifest.wl"}];
  If[!FileExistsQ[manifestFile],
    Message[checkCatalogChanges::nomanifest];
    Return[$Failed]
  ];
  savedManifest = loadManifestSafe[manifestFile];
  If[savedManifest === $Failed,
    Message[checkCatalogChanges::nomanifest];
    Return[$Failed]
  ];

  (* Quick check: compare catalog hash *)
  currentCatalogHash = getCanonicalHash[modelsAssoc];
  savedCatalogHash = savedManifest["CatalogHash"];

  If[currentCatalogHash === savedCatalogHash,
    (* No changes - return silently *)
    Return[Null]
  ];

  (* Catalog has changed - identify which models *)
  savedModelHashes = savedManifest["Models"];
  currentModelHashes = Map[getCanonicalHash, modelsAssoc];

  (* Find changed models (exist in both, hash differs) *)
  changedModels = Select[
    Keys[KeyTake[currentModelHashes, Keys[savedModelHashes]]],
    currentModelHashes[#] =!= savedModelHashes[#] &
  ];

  (* Find new models (in current but not saved) *)
  newModels = Complement[Keys[currentModelHashes], Keys[savedModelHashes]];

  (* Find removed models (in saved but not current) *)
  removedModels = Complement[Keys[savedModelHashes], Keys[currentModelHashes]];

  If[changedModels =!= {},
    Message[checkCatalogChanges::changed, StringRiffle[changedModels, ", "]]
  ];

  If[newModels =!= {},
    Message[checkCatalogChanges::newmodels, StringRiffle[newModels, ", "]]
  ];

  If[removedModels =!= {},
    Message[checkCatalogChanges::removed, StringRiffle[removedModels, ", "]]
  ];

  (* Validate changed and new models *)
  modelsToValidate = Join[changedModels, newModels];
  validationResult = If[modelsToValidate =!= {},
    Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
    FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog[
      KeyTake[modelsAssoc, modelsToValidate]
    ],
    <|"Valid" -> True, "Results" -> <||>, "InvalidModels" -> {}, "TotalErrors" -> 0|>
  ];

  (* No auto-reformat for association input - no file to reformat *)

  <|
    "Changed" -> changedModels,
    "New" -> newModels,
    "Removed" -> removedModels,
    "Validation" -> validationResult
  |>
];

(* === BoxData Conversion Functions === *)

(* Option A: Front end conversion using FrontEndToken SaveRename *)
convertWithFrontEnd[boxData_, outputPath_String] := Module[
  {nb, result = $Failed},

  UsingFrontEnd[
    (* Create notebook in memory with formatted content *)
    nb = NotebookPut[Notebook[{Cell[boxData, "Input"]}]];

    If[nb =!= $Failed,
      (* Save as .wl Package using front end's native mechanism *)
      FrontEndExecute[
        FrontEndToken[nb, "SaveRename", {outputPath, "Package"}]
      ];
      NotebookClose[nb];
      result = Import[outputPath, "Text"]
    ]
  ];
  result
];

(* Option B: Manual recursive flattening (fallback for headless mode) *)
boxToString[RowBox[items_List]] := StringJoin[boxToString /@ items];
boxToString[BoxData[content_]] := boxToString[content];
boxToString[Cell[BoxData[content_], ___]] := boxToString[content];
boxToString[s_String] := s;
boxToString[n_Integer] := ToString[n];
boxToString[n_Real] := ToString[n];
boxToString[items_List] := StringJoin[boxToString /@ items]; (* Handle bare lists *)

(* Mathematical box types *)
boxToString[SuperscriptBox[base_, exp_]] := StringJoin["Power[", boxToString[base], ", ", boxToString[exp], "]"];
boxToString[SubscriptBox[base_, sub_]] := StringJoin["Subscript[", boxToString[base], ", ", boxToString[sub], "]"];
boxToString[SubsuperscriptBox[base_, sub_, sup_]] := StringJoin["Subsuperscript[", boxToString[base], ", ", boxToString[sub], ", ", boxToString[sup], "]"];
boxToString[FractionBox[num_, denom_]] := StringJoin["(", boxToString[num], ")/(", boxToString[denom], ")"];
boxToString[SqrtBox[content_]] := StringJoin["Sqrt[", boxToString[content], "]"];
boxToString[RadicalBox[content_, n_]] := StringJoin["Power[", boxToString[content], ", 1/", boxToString[n], "]"];
boxToString[OverscriptBox[base_, over_]] := StringJoin["Overscript[", boxToString[base], ", ", boxToString[over], "]"];
boxToString[UnderscriptBox[base_, under_]] := StringJoin["Underscript[", boxToString[base], ", ", boxToString[under], "]"];

(* Catch-all for unknown boxes - try to convert content recursively *)
boxToString[box_[args___]] /; StringEndsQ[SymbolName[box], "Box"] :=
  StringJoin["(*UnhandledBox:", SymbolName[box], "*)", StringRiffle[boxToString /@ {args}, " "]];

(* Final fallback *)
boxToString[x_] := ToString[x, InputForm];

(* Main converter: uses boxToString for plain text output *)
(* Note: convertWithFrontEnd produces notebook format with cell markers, *)
(* which is undesirable for plain .wl files. Always use boxToString. *)
(* Safety: ensure result is always a string *)
boxDataToText[boxData_] := Module[{result},
  result = boxToString[boxData];
  If[StringQ[result], result, ToString[result, InputForm]]
];

(* === Catalog Section Parser === *)

(* Parse Catalog.wl and identify section boundaries *)
parseCatalogSections[filePath_String] := Module[
  {content, modelsStart, modelsEnd},

  content = Import[filePath, "Text"];

  (* Find "models = <|" position *)
  modelsStart = First[StringPosition[content, "models = <|"], {-1, -1}][[1]];

  (* Find "|>;(*end models*)" position *)
  modelsEnd = First[StringPosition[content, "|>;(*end models*)"], {-1, -1}][[2]];

  <|
    "Content" -> content,
    "ModelsStart" -> modelsStart,
    "ModelsEnd" -> modelsEnd
  |>
];

(* === Catalog Reformatter === *)

reformatCatalog[] := Module[
  {root, catalogFile, catalogModels, sections,
   formattedBoxData, formattedText, newContent,
   footerRaw, footerTrimmed, headerText},

  (* Find root and catalog file *)
  root = findPacletRoot[];
  If[root === $Failed, Message[reformatCatalog::noroot]; Return[$Failed]];

  catalogFile = FileNameJoin[{root, "Kernel", "Model", "Catalog.wl"}];
  If[!FileExistsQ[catalogFile], Message[reformatCatalog::nocat]; Return[$Failed]];

  (* Load NiceOutput *)
  Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];
  If[!NameQ["FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog"],
    Quiet@Get[FileNameJoin[{root, "Kernel", "Tools", "NiceOutput.wl"}]]
  ];

  (* Get current catalog models *)
  catalogModels = getCatalogModels[];
  If[!AssociationQ[catalogModels], Message[reformatCatalog::nocat]; Return[$Failed]];

  (* Parse file to identify sections *)
  sections = parseCatalogSections[catalogFile];
  If[sections["ModelsStart"] < 0 || sections["ModelsEnd"] < 0,
    Message[reformatCatalog::nocat]; Return[$Failed]
  ];

  (* Generate formatted BoxData using NiceOutput infrastructure *)
  formattedBoxData = FernandoDuarte`LongRunRisk`Tools`NiceOutput`formatModels[
    FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog[
      catalogModels,
      {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"}
    ]
  ];

  (* Convert BoxData to plain text and trim trailing whitespace *)
  formattedText = boxDataToText[formattedBoxData];
  If[!StringQ[formattedText],
    Message[reformatCatalog::convfail, "BoxData conversion failed - formattedText is not a string"];
    Return[$Failed]
  ];
  formattedText = StringTrim[formattedText, WhitespaceCharacter ..];

  (* Get footer and normalize the boundary to prevent whitespace accumulation *)
  footerRaw = StringDrop[sections["Content"], sections["ModelsEnd"]];
  footerTrimmed = StringTrim[footerRaw, WhitespaceCharacter ..];

  (* Get header *)
  headerText = StringTake[sections["Content"], sections["ModelsStart"] - 1];

  (* Validate all parts are strings before joining *)
  If[!StringQ[headerText],
    Message[reformatCatalog::convfail, "Header extraction failed - headerText is not a string"];
    Return[$Failed]
  ];
  If[!StringQ[footerTrimmed],
    Message[reformatCatalog::convfail, "Footer extraction failed - footerTrimmed is not a string"];
    Return[$Failed]
  ];

  (* Reconstruct file: preserve header + new models + separator + footer *)
  (* Use exactly two newlines (one blank line) as separator *)
  newContent = StringJoin[headerText, formattedText, "\n\n\n", footerTrimmed];

  (* Final validation before writing *)
  If[!StringQ[newContent],
    Message[reformatCatalog::convfail, "StringJoin failed to produce a string - check inputs"];
    Return[$Failed]
  ];

  (* Write back *)
  Export[catalogFile, newContent, "Text"];

  (* Reset cache to force reload on next access *)
  $catalogMTime = None;

  Message[reformatCatalog::success];
  catalogFile
];


(* === buildModels orchestrator === *)

buildModels // Options = {
	"FromScratch" -> False,
	"CompileJacobians" -> False,
	"CreateMoments" -> True,
	"NumKernels" -> Automatic,  (* Automatic | n | None *)
	"MaxMaturity" -> 120,
	"Models" -> All  (* All or list of shortnames *)
};


(* helper: select enabled models from catalog *)
selectEnabledModels[catalog_Association] := Select[catalog, TrueQ[#["enabled"]] &];


(* helper: delete all generated outputs for from-scratch builds *)
cleanAllOutputs[root_String] := Module[{resourcesDir, compiledDir, momentsDir},
	resourcesDir = FileNameJoin[{root, "Resources"}];
	compiledDir = FileNameJoin[{resourcesDir, "CompiledFunctions"}];
	momentsDir = FileNameJoin[{resourcesDir, "MomentsLookupTables"}];

	(* delete compiled .mx files *)
	If[DirectoryQ[compiledDir],
		DeleteFile /@ FileNames["*.mx", compiledDir]
	];

	(* delete moments lookup tables *)
	If[DirectoryQ[momentsDir],
		DeleteFile /@ FileNames["covLong*.wl", momentsDir]
	];

	(* delete Models.wl and ModelManifest.wl *)
	Quiet[DeleteFile[FileNameJoin[{resourcesDir, "Models.wl"}]]];
	Quiet[DeleteFile[FileNameJoin[{resourcesDir, "ModelManifest.wl"}]]];
];


(* helper: save processed models to Models.wl using DefinitionData *)
saveModels[models_Association, file_String] := Module[{dataModels},
	Quiet[CreateDirectory[DirectoryName[file]], {CreateDirectory::filex, CreateDirectory::eexist}];
	(* Use DefinitionData to capture all definitions associated with models *)
	dataModels = PacletizedResourceFunctions`DefinitionData[models];
	Put[dataModels, file];
	file
];


(* helper: load models from Models.wl - uses double Get for DefinitionData *)
loadModels[file_String] := If[FileExistsQ[file], Get@Get[file], <||>];


(* helper: compute hash for moments cache *)
getMomentsHash[catalogEntry_Association, model_Association] :=
	getCanonicalHash[<|
		"catalog" -> catalogEntry,
		"exogenousEq" -> model["exogenousEq"],
		"endogenousEq" -> model["endogenousEq"]
	|>];


(* helper: check if moments files are current *)
(* Uses separate metadata file because createDatabase uses DefinitionData format *)
momentsUpToDate[momentsFile_String, metaFile_String, expectedHash_String] := Module[
	{savedMeta, savedHash},
	(* Both files must exist *)
	If[!FileExistsQ[momentsFile] || !FileExistsQ[metaFile], Return[False]];
	savedMeta = Quiet[Get[metaFile]];
	If[!AssociationQ[savedMeta], Return[False]];
	savedHash = savedMeta["Hash"];
	savedHash === expectedHash
];


(* helper: setup parallel kernels *)
setupParallelKernels[numKernels_] := Module[{n},
	n = Switch[numKernels,
		Automatic, $ProcessorCount,
		None, 0,
		_Integer, numKernels,
		_, $ProcessorCount
	];
	If[n <= 0, Return[0]];

	(* Close existing and launch new *)
	CloseKernels[];
	LaunchKernels[n];

	Length[ParallelKernels[]]
];


(* helper: warmup parallel kernels *)
warmupParallelKernels[] := Module[{pacletDir},
	If[Length[ParallelKernels[]] == 0, Return[Null]];

	(* Find paclet root directory *)
	pacletDir = findPacletRoot[];
	If[!StringQ[pacletDir], Return[$Failed]];

	(* Register paclet and load required packages on parallel kernels *)
	ParallelEvaluate[
		PacletDirectoryLoad[#];
		Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
		Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
		Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
		Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
	] &@ pacletDir;
];


buildModels[opts : OptionsPattern[{buildModels, FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels, FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq}]] := With[
	{
		fromScratch = OptionValue["FromScratch"],
		compileJacobians = OptionValue["CompileJacobians"],
		createMoments = OptionValue["CreateMoments"],
		numKernels = OptionValue["NumKernels"],
		maxMaturity = OptionValue["MaxMaturity"],
		modelFilter = OptionValue["Models"]
	},
	Module[
		{
			root, resourcesDir, compiledDir, modelsFile,
			catalogModels, enabledModels, modelsToProcess, changes,
			processedModels, model, shortname, compiledFile
		},

		(* find paclet root *)
		root = findPacletRoot[];
		If[root === $Failed, Message[buildModels::noroot]; Return[$Failed]];

		resourcesDir = FileNameJoin[{root, "Resources"}];
		compiledDir = FileNameJoin[{resourcesDir, "CompiledFunctions"}];
		modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}];

		(* ensure directories exist *)
		Quiet[CreateDirectory[compiledDir], {CreateDirectory::filex, CreateDirectory::eexist}];

		(* get catalog and filter enabled models *)
		catalogModels = getCatalogModels[];
		If[!AssociationQ[catalogModels], Message[buildModels::nocat]; Return[$Failed]];

		enabledModels = selectEnabledModels[catalogModels];

		(* apply model filter if specified *)
		enabledModels = If[modelFilter === All,
			enabledModels,
			KeyTake[enabledModels,
				Select[Keys[enabledModels], MemberQ[Flatten@{modelFilter}, catalogModels[#]["shortname"]] &]
			]
		];

		If[Length[enabledModels] == 0,
			Message[buildModels::uptodate];
			Return[<||>]
		];

		(* determine which models need processing *)
		If[fromScratch,
			cleanAllOutputs[root];
			modelsToProcess = Keys[enabledModels];
			,
			(* check for changes *)
			changes = checkCatalogChanges[];
			modelsToProcess = If[changes === Null || changes === $Failed,
				{},
				Join[changes["Changed"], changes["New"]]
			];
			(* filter to only enabled models *)
			modelsToProcess = Select[modelsToProcess, KeyExistsQ[enabledModels, #] &];
		];

		If[Length[modelsToProcess] == 0,
			Message[buildModels::uptodate];
			Return[<||>]
		];

		Message[buildModels::start, Length[modelsToProcess]];

		(* load dependencies *)
		Needs["PacletizedResourceFunctions`"];
		Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"];
		Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
		Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];

		(* process each model *)
		processedModels = <||>;

		(* Phase 1: symbolic processing and compile functions *)
		Do[
			shortname = catalogModels[modelKey]["shortname"];
			Message[buildModels::processing, shortname];

			(* run symbolic processing *)
			model = First @ Values @ FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[
				KeyTake[catalogModels, {modelKey}]
			];

			(* compile functions *)
			Message[buildModels::compiling, shortname];
			compiledFile = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq[
				model,
				compiledDir
			];

			processedModels[shortname] = model;

			, {modelKey, modelsToProcess}
		];

		(* Phase 2: compile jacobians if requested *)
		If[compileJacobians,
			Do[
				shortname = catalogModels[modelKey]["shortname"];
				Message[buildModels::compiling, shortname <> " jacobians"];
				FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq[
					processedModels[shortname],
					compiledDir,
					"CompileMode" -> "JacobianOnly"
				];
				, {modelKey, modelsToProcess}
			]
		];

		(* Phase 3: compute numerical solutions - can use jacobians if available *)
		Do[
			shortname = catalogModels[modelKey]["shortname"];
			Message[buildModels::numerical, shortname];
			processedModels[shortname] = Append[
				processedModels[shortname],
				"coeffsSolutionN" -> FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`addCoeffsSolutionN[
					processedModels[shortname]
				]
			];
			, {modelKey, modelsToProcess}
		];

		(* Phase 4: create moments database if requested *)
		If[createMoments,
			Module[{momentsDir, numLaunched, momentsFile, metaFile, currentHash, needsComputation},
				momentsDir = FileNameJoin[{resourcesDir, "MomentsLookupTables"}];
				Quiet[CreateDirectory[momentsDir], {CreateDirectory::filex, CreateDirectory::eexist}];

				(* Setup parallel kernels *)
				numLaunched = setupParallelKernels[numKernels];
				If[numLaunched > 0,
					Message[buildModels::kernels, numLaunched];
					Message[buildModels::kernelwarmup];
					warmupParallelKernels[];
				];

				(* Load createDatabase *)
				Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`"];

				(* Process each model *)
				Do[
					shortname = catalogModels[modelKey]["shortname"];
					momentsFile = FileNameJoin[{momentsDir, "covLong" <> shortname <> ".wl"}];
					metaFile = FileNameJoin[{momentsDir, "covLong" <> shortname <> "_meta.wl"}];

					(* Compute hash from catalog entry and equations *)
					currentHash = getMomentsHash[
						catalogModels[modelKey],
						processedModels[shortname]
					];

					(* Check cache - uses separate meta file *)
					needsComputation = !momentsUpToDate[momentsFile, metaFile, currentHash];

					If[needsComputation,
						Message[buildModels::momentscomputing, shortname];

						(* Create moments database *)
						FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`createDatabase[
							processedModels[shortname],
							momentsFile
						];

						(* Save metadata to separate file *)
						Put[
							<|
								"Hash" -> currentHash,
								"Date" -> DateString["ISODateTime"],
								"Version" -> $Version,
								"SystemID" -> $SystemID
							|>,
							metaFile
						];
						,
						(* Cache hit *)
						Message[buildModels::momentscache, shortname]
					];

					, {modelKey, modelsToProcess}
				];

				(* Cleanup parallel kernels *)
				If[numLaunched > 0, CloseKernels[]];
			]
		];

		(* save processed models *)
		saveModels[processedModels, modelsFile];

		(* update manifest *)
		updateModelManifest[];

		Message[buildModels::done, Length[modelsToProcess]];

		processedModels
	]
];

End[];
EndPackage[];
